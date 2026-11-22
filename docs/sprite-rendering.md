## Introduction

As discussed in [objects.md](/docs/objects.md) SolarStriker maintains an object table with information about all active objects. However for these objects to be rendered to the screen as sprites, information must be copied into Object Attribute Memory or OAM (https://gbdev.io/pandocs/OAM.html). To do this SolarStriker uses a very standard practice in Game Boy development where a routine is copied to HRAM (high ram) and run during VBlank. The copy routine and the actual transfer routine are shown here: 

```code
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

Importantly these insructions indicate where to copy from:

```code
    ld a, $c0
    ldh [rDMA], a
```

This means to start copying from `C000` which is where the game builds its `wShadowOAM` every frame in preparation for the transfer to OAM.

# Shadow OAM

The shadow OAM is constructed by `BuildShadowOAM` which runs every frame during the game loop. Essentially the object table is processed and turned into the 4 byte entries that OAM ultimately expects. The first 5 bytes of a runtime object record are: 

| Offset | Contents |
|---|---|
| `$00` | Sprite grid dimensions (header) |
| `$01` | Y position |
| `$02` | X position |
| `$03` | Graphics pointer, low byte |
| `$04` | Graphics pointer, high byte |

Using the object header, the routine determines how many sprites for the given object need to be written. Columns are tracked in register B and rows are tracked in register C. Y and X position are copied directly and then the graphics pointer is used to copy the tile ids and the tile attributes.

Due to Game Boy hardware limitations the shadow OAM can only holds 40 sprite entries (160 bytes total). Not that this does not mean 40 game objects since an object can consist of multiple sprites. For example the player object and many enemies use a $12 header meaning 1 row and 2 columns. This results in 2 sprites to represent 1 object.

Interestingly the shadow OAM routine tracks the first object to be written to the buffer with `wFirstObjectIndex`. This counter is NOT reset to the first object in the table every frame but rather wraps when reaching the end of the table resulting in the starting index moving forward by 1 each frame. Because the order of sprites in OAM determines their priority in drawing this feature potentially spreads out missing sprites across frames rather than consistently hiding the same sprites. The Game Boy could not display more that 10 sprites per scanline, so any additional sprites would instead be hidden. This method instead would allow for these sprites to flicker instead of becoming completely invisible. The player would likely appreciate this because a sprite not displaying would not change its object record that the game checks for things like collision, meaning the player could easily lose a life to an invisible enemy or projectile if too many sprites were on screen at once.