## Introduction

Background drawing in SolarStriker, and every Game Boy game really, involves drawing 8x8 pixel tiles to the screen to create environments. In SolarStriker stages also need to scroll so background drawing needs to continuously be managed and updated properly especially in later levels where the background changes as the level progresses. SolarStriker uses addresses at `D000` and `D200` to hold the information needed to draw the given background.

# Setup and Definitions

The Game Boy supports two tile maps that can each be used in different ways. These maps occupy the following locations in VRAM: 

| Tile map | Address range | Size |
|---|---|---|
| Map 0 | `$9800–$9BFF` | 1,024 bytes |
| Map 1 | `$9C00–$9FFF` | 1,024 bytes |

In SolarStriker map 0 can be thought of as the "main" map or the true background. This is where tiles are drawn that create the starfield for stage 1, or the highway setting for stage 3. Map 1 on the other hand is used as a "window". This is controlled by the LCDC register (`$FF40`):

| Bit | Controls | `0` | `1` |
|---|---|---|---|
| **3** | Background tile map | `$9800–$9BFF` | `$9C00–$9FFF` |
| **6** | Window tile map | `$9800–$9BFF` | `$9C00–$9FFF` |

The window is used as a fixed tilemap that does not move even if scroll is applied to the main tile map. This is what serves as the HUD which displays the player's current score and lives. It also is updated to write the word "PAUSE" when the game is paused. In addition to the tile maps, the actual tiles themselves are placed in VRAM by the game at start up and in between stages. "Shared" tiles like those of enemies that can remain consistent between most stages starts at address `$8000`. Text, numbers, and symbols like the player's ship icon used in the HUD start at address `$8A00`. Tiles that need to change based on the stage start at address `$9000`. Tile data is copied to these locations in VRAM from bank 2. Once the data is safely in VRAM the bank can be switched back to bank 1 for gameplay.

The tiles themselves are only part of the system, the game also needs instruction that specify what tiles should be placed where in the tile map. During stage setup additional data is copied from bank 3 to addresses `D000` and `D200`.

It is important to understand that while the Game Boy supports 8x8 pixel tiles, SolarStriker defines its maps in terms of "blocks" which are defined as 2x2 tiles, for a total of 16x16 pixels. Backgrounds are originally drawn as 14 columns by 11 rows of these 2x2 blocks or 28x22 tiles by the routine `DrawInitialBackground`. The instructions to build a background consist of the block definitions at address `D000` and the background map or block ids that are copied to `D200`. The block definitions are 4 byte entries specifying the top left, top right, bottom left, and bottom right tiles in that order to be used for a block. The block ids are read as indices selecting one of these block definitions.

# Drawing

`DrawInitialBackground` takes a starting `wBackgroundRowPosition` to indicate where to start drawing. This is immediately stored in in another address: `wBackgroundDrawRowPosition` which tracks where in a given row a block is currently being drawn. A `wMapReadPointer` is set to `D200` (the block ids). A nested loop then starts drawing 11 rows each with 14 columns. Drawing consists of `ReadNextMapBlock` and `DrawMapBlock`. 

`ReadNextMapBlock` uses the map read pointer to check the next byte and store it in register BC. If $FF it returns, other wise the map read pointer is moved to the next address, for the next iteration. Using the byte a pointer is created to an address in the table at `D000`. The address is stored in `wMapBlockPointer`.

`DrawMapBlock` then uses the `wMapBlockPointer` and the `wBlockDrawDestination` pointer and reads the first two bytes drawing them in adjacent locations, then the rest of the row is skipped so the next two tiles end up under the other tiles, creating the 2x2 block. `wBlockDrawDestination` is then moved to where the next block drawing will start.

After a row is completed `MoveMapPositionUpOneBlockRow` does exactly what it says and moves the drawing location up two rows, ready for the next row. This process continues until all map blocks have been drawn.

# Tile Packets

SolarStriker also has an alternative way of drawing to the background that uses tile "packets" which specify what tiles, where, and how the copy should be processed. This mode of drawing is mostly used after an initial background has been drawn and a potentially variable piece of text needs to be written. For example the title screen uses this method to draw either the "PUSH START BUTTON" or "PUSH SELECT BUTTON" text. Since its variable it can't be part of the background map, so the background is drawn first and then certain tiles are replaced as needed.

Tile packets are formatted as follows, using the title screen start text as an example:

```code
    ; ROM $3E9B: HL = $99EB, copy 4 bytes to $99EB-$99EE.
TitleScreenStartPromptTilePackets:
    db $99, $eb, $04, $d2, $dc, $d8, $c2
    ; ROM $3EA2: HL = $9A08, copy 12 bytes to $9A08-$9A13.
    db $9a, $08, $0c, $d8, $da, $b4, $d6, $da, $ff, $b6, $dc, $da, $da, $d0, $ce
    ; ROM $3EB1: HL = $9A48, copy 3 bytes to $9A48-$9A4A.
    db $9a, $48, $03, $da, $d0, $d2
    ; ROM $3EB7: HL = $9A88, copy 12 bytes to $9A88-$9A93.
    db $9a, $88, $0c, $fc, $a2, $b2, $b0, $b2, $ff, $ea, $eb, $ec, $ed, $ee, $ef
    db $00 ; ROM $3EC6: end of sequence.
```

The first two bytes of a row form the destination address in VRAM, the next byte then serves as both a control and how many bytes to copy. The remaining bytes are the actual tile ids. The control is the top two bits. In this example it is zero so the final byte just happens to also equal the number of bytes to copy.

| Mode | Behavior |
|---|---|
| `00` | Copy successive bytes across the tile map |
| `01` | Repeat one byte across the tile map |
| `10` | Copy successive bytes down the tile map |
| `11` | Repeat one byte down the tile map |

# Scrolling

During gameplay the background scrolls by writing to the scroll register `SCY`. By default the Game Boy automatically wraps the background to allow for an intial background to appear to go on forever. SolarStriker however keeps writing blocks to the background as the stage progresses. In fact bosses past stage 3 are not sprites but are background tiles. The game then uses objects with no graphics to serve as collision points. Continued drawing is managed by `ScrollBackground`. Whenever `SCY` reaches a multiple of 16 (or one block height) a new row needs to be drawn. The current row is marked as incomplete and on subsequent scroll updates it calls `ReadNextMapBlock` until 14 blocks have been read. Drawing is actually not handled by this routine but ocurrs during the VBlank interrupt. This ocurrs after the display has finished 144 scanlines when LY becomes 144, about once per frame. The `HandleVBlank` routine runs the `hOAMDMARoutine` as well as calling `DrawMapBlock` and `UpdateHUDTilemap`. `UpdateHUDTilemap` writes the players score and lives to the HUD every update.