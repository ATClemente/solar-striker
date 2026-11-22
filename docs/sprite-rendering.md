# Sprite Rendering

## Introduction

As discussed in [objects.md](../docs/objects.md), SolarStriker maintains an object table with information about all active objects. However, for these objects to be rendered to the screen as sprites, information must be copied into Object Attribute Memory or OAM (https://gbdev.io/pandocs/OAM.html). To do this, SolarStriker uses a very standard practice in Game Boy development where a routine is copied to HRAM (High RAM) and run during VBlank. The copy routine, [`CopyDMARoutineToHRAMLoopSetup`](../bank_000.asm#L1200), and the actual transfer routine, [`OAMDMARoutine`](../bank_000.asm#L1217), are shown here: 

```asm
CopyDMARoutineToHRAMLoopSetup:
    ld c, $80
    ld b, $0a
    ld hl, OAMDMARoutine

CopyDMARoutineToHRAM:
    ld a, [hl+]
    ldh [c], a
    inc c
    dec b
    jr nz, CopyDMARoutineToHRAM

    ret

OAMDMARoutine:
    ld a, $c0
    ldh [rDMA], a
    ld a, $28
.wait
    dec a
    jr nz, .wait
    ret
```

Importantly, these instructions indicate where to copy from:

```asm
    ld a, $c0
    ldh [rDMA], a
```

This means to start copying from `C000` which is where the game builds its `wShadowOAM` every frame in preparation for the transfer to OAM in the address range `$FE00–$FE9F`.

`HRAM` is required because during OAM DMA on the Game Boy, CPU memory access is restricted to `HRAM`. The delay loop waits for the transfer to finish.

## Shadow OAM

The shadow OAM is constructed by [`BuildShadowOAM`](../bank_000.asm#L3618) which runs every frame during the game loop. It sets `wOAMReady` when completed and [`HandleVBlank`](../bank_000.asm#L341) checks that flag before calling the `HRAM` routine. Essentially the object table is processed and turned into the four-byte entries that OAM ultimately expects. The first 5 bytes of a runtime object record are: 

| Offset | Contents |
|---|---|
| `$00` | Sprite grid dimensions (header) |
| `$01` | Y position |
| `$02` | X position |
| `$03` | Graphics pointer, low byte |
| `$04` | Graphics pointer, high byte |

The header’s low nibble specifies the number of columns, and its high nibble specifies the number of rows. For example, `$12` describes one row of two sprites. The routine writes sprites across each row, advancing X by 8 pixels, then advances Y by 16 pixels for the next row.

The graphics pointer identifies a sequence of tile-index and attribute pairs, one pair per sprite. The object’s X and Y values already use OAM coordinates, so the renderer copies them directly before applying the grid offsets.

Output to the OAM looks like this. Each hardware OAM entry is four bytes long:

| Byte Offset | Contents | Description |
|---|---|---|
| `$00` | Y position | Vertical position plus 16; an on-screen Y coordinate of 0 is stored as 16. |
| `$01` | X position | Horizontal position plus 8; an on-screen X coordinate of 0 is stored as 8. |
| `$02` | Tile index | Selects the sprite graphics. In SolarStriker's 8×16 mode, the low bit is ignored and an adjacent pair of tiles is used. |
| `$03` | Attributes | Controls palette selection, horizontal and vertical flipping, and priority relative to the background and window. |


Hardware OAM holds 40 sprite entries, each four bytes long. The DMA transfer copies the first 160 bytes of shadow OAM, at `C000–C09F`, into OAM. This limits the transferred sprite list to 40 sprites, rather than 40 game objects, because one game object can use multiple sprites.

Interestingly the shadow OAM routine tracks the first object to be written to the buffer with `wFirstObjectIndex`. This counter is NOT reset to the first object in the table every frame but rather wraps when reaching `$27` resulting in the starting index moving forward by 1 each frame (0-38). Each entry is still processed. Changing the order of entries changes which sprites are selected when more than ten overlap a scanline. This can spread sprite omissions across frames, producing flicker rather than consistently hiding the same sprites. A sprite omitted from rendering can still participate in collision checks, so distributing omissions across frames helps the player notice enemies and projectiles that would otherwise remain invisible.