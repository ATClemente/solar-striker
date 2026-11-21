## Introduction

Objects in SolarStriker are the player, projectiles and enemies that are rendered on top of the background. Similar to handlers, there is a table that tracks objects and data associated with them. This information is then used by the game to determine collisions, screen location, and more.

# Initialization

All objects in SolarStriker have a defined template that is used to initialize the object with the correct information. It also specifies how graphics data should be interpreted to display the object. An object template generally has the following structure:

| Template offset | Size | Meaning |
|---|---:|---|
| `$00` | 1 byte | Sprite grid: high nibble = rows, low nibble = columns |
| `$01–$02` | 2 bytes | Collision-center offsets: Y, X |
| `$03–$04` | 2 bytes | Hitbox minimum offsets: Y, X |
| `$05–$06` | 2 bytes | Hitbox maximum offsets: Y, X |
| `$07` | 1 byte | Damage threshold |

For example the Protodroid enemy's template is this:

`db $12, $08, $08, $00, $fe, $10, $12, $00`

This tells later handlers that process the data that the sprite consists of 1 row of tiles and 2 columns of tiles. Tiles are each 8x8 pixels on the Game Boy. Its collision center is offset by 8 pixels in each direction and its hitbox minimum is offset by 0/FE and the maximum by 10/12. Remember all values are in hex. The protodroid also has a damage threshold of 0, meaning any player shot of any strength will destroy it. 

This data is copied into the `wObjectTable` in an open slot. Each object gets 16 bytes of memory and there is enough memory for 40 objects total spanning addresses `C780 – C9FF`. Initialization is handled by different routines depending on the situation. `TryInitializeObjectAtIndex` is used for the player and the players projectiles which alway occupy indices 0-3 of the table.  `TryInitializeObjectInFreeSlot` which first finds a free slot before storing the object. If a free slot is not found the initialization fails. This is often used for stage events like spawning an enemy. Enemy projectiles use `TryInitializeEnemyProjectile` and smoke objects use `FindFreeObjectSlot` which then "falls through" to other code that sets up the object. Handlers and objects can often be coupled together, such as a handler that is updating an enemy movement. In these cases the `wAllocatedObjectIndex` is written to the handler data for later use. A `wSelectedObjectPointer` tracks whatever object is currently being processed.

The `wObjectTable` offsets are defined in [/constants/objects.asm](/constants/objects.asm). This is where the game keeps track of the current position, and collision locations of all objects. It also tracks the current graphics pointer and the accumulated damage and damage threshold of the object if applicable.

# Configuration

Most objects then have a handler that runs a "configuration" step. This step usually assigns graphics among other things. Looking back at the protodroid example its graphics are defined as:

`db $2e, $00, $2e, $20`

Because the object header is `$12` this graphics data tells the game to build a sprite that is 1 row tall and 2 columns wide. Sprites in SolarStriker are defined as 8x16 pixels since the game sets bit 2 to 1 (https://gbdev.io/pandocs/OAM.html#byte-2--tile-index). The `$20` sets tile attributes. This value means to flip the sprite horizontally (https://gbdev.io/pandocs/OAM.html#byte-3--attributesflags). All of this results in the following configuration (values are tile numbers):

```text
$2e -- $2e (h-flip)
 |      |
$2f -- $2f (h-flip)
```

The header specifies 1 row of 2 sprites, producing a 16x16 pixel object. The game reads two tile/attribute pairs from the graphics data. Both select tile `2e` and `2f` is automatically the lower half in 8x16 mode. The second pair applies the horizontal flip creating a mirror image. 

Many object configuration handlers also set up a movement script for enemies that don't just move in one defined way.

# Movement

Movement of objects is managed by a handler that runs usually every frame or every other frame depending on the enemy. There is generally two types of movement: set movement and scripted movement. Set movement is used by enemies like the Arrowhead which always flys straight down, accelerating after a certain point. Scripted movement is used by enemies that can move in any direction and whose movement depends on where it has been spawned. Examples would include the Rotomech and the Protodroid, among others. The Protodroid can once again serve as an example of scripted movement. Those who have played SolarStriker will have observed that the Protodroid can spawn on either the left or right side of the screen, before starting to move down and then straight across the screen to the opposite side. To allow for this, the Protodroid has two movement "scripts" defined. The script used depends on its starting position. How the initial script is chosen is explained in more detail in the documentation about stage events. 

During configuration a pointer to the movement script is stored in handler data offset `0A-0B` (HANDLER_MOVEMENT_SCRIPT_TABLE_CURSOR_OFFSET). A movement table it self holds pointers so the first pointer is stored in offset `0C-0D` (HANDLER_MOVEMENT_COMMAND_POINTER_OFFSET). For the Protodroid this looks like this:

```text
ProtodroidMovementScriptTable:
    dw ProtodroidMovementScriptA, ProtodroidMovementScriptB
```

```text
ProtodroidMovementScriptA:
    dw MovementLeftToDownCommands
    dw MovementDownToRightCommands
    dw MovementRight8Commands
    dw MovementRight16Commands
```

And then the first command sequence:

```text
MovementLeftToDownCommands:
    db $20, $20, $60, $20, $60, $60, $60, $40, $60, $40, $48
```

So at set up for a Protodroid enemy running script A the handler data holds:

| Handler Data Offset | Contents |
|---|---|
| `0A` | ProtodroidMovementScriptA low byte |
| `0B` | ProtodroidMovementScriptA high byte |
| `0C` | MovementLeftToDownCommands low byte |
| `0D` | MovementLeftToDownCommands high byte |

The handler that runs movement uses a routine called `UpdateScriptedEnemyMovement`. This routine reads the current command pointer and applies the defined movement to the object. It also applies a downward drift to account for background scrolling. Boss enemies that use scripted movement while the background is not scrolling use another routine `UpdateScriptedEnemyMovementNoDrift`. Both routines otherwise work in roughly the same way. They call another routine called `ReadMovementScriptCommand` which checks the next movement command and returns pixel offsets in register D (Y) and E (X). A movement script command has its bits read in order to determine the final pixel offsets that will be applied to the object. The following table shows the bits and their purpose when set.

| Bit | Instruction |
|---|---|
| `3` | Advance to next script pointer |
| `4` | X + 3 |
| `5` | X - 3 |
| `6` | Y + 3 |
| `7` | Y - 3 |

So in the case of `$20` this means move left 3 pixels since bit 5 is set. All other bits are zero. After reading this command the command pointer would move to the next byte for the next update which in this case is also a `$20`. Remember a higher Y value on the Game Boy screen is actually lower. So for Y + 3 instructions this is moving the enemy downward. Eventually the last byte `$48` is read. Since its bit pattern is: `01001000` this command will both move the Protodroid down and will signal the end of this sequence. This will cause the routine to advance the table pointer to the next sequence. And the command pointer will be set to the start of this new sequence. So the data will then look like this:

| Handler Data Offset | Contents |
|---|---|
| `0A` | (ProtodroidMovementScriptA + 2) low byte |
| `0B` | (ProtodroidMovementScriptA + 2) high byte |
| `0C` | MovementDownToRightCommands low byte |
| `0D` | MovementDownToRightCommands high byte |

Notice that the value at `0B` would only change if there is a carry. An address of `1000` being incremented by two is `1002`, leaving the high byte the same.

Actually movement is then handled by the routine `MoveObject`. This routine uses another routine `ApplyMovementOffsets` which applies the offsets calculated to the objects position and collision offsets. Later when the object is drawn to the screen these values are used to specify its position on screen.

Objects with set movement typically use `MoveObject` directly to move an enemy straight down like in the case of enemies like the Arrowhead, Harrier, and Mack. 

As a last point on object movement, it should be known that the routines `CalculateYMovement` and `CalculateXMovement` actually account for and track fractional movement in the associated handlers data region. This allow for non whole number pixel offsets to be applied that accumulate over time. This is the case of the drift added to account for packgrouond scrolling. The game applies a 1/4 pixel drift each frame which is another way of saying to move down 1 pixel every 4 frames, but without the need to track a separate timer.

# Collision

Enemies and enemy projectiles use a routine called `CheckEnemyCollisionWithPlayer` to detect if they have hit the player in a given frame. `CheckPointInHitbox` is used to find if the enemies are within the players hitbox. Hitbox min is the minimum Y/X point (top left) and max is the max Y/X point (bottom right) of the imaginary box around the player. Some collision checks, like those against bosses do the opposite: they check if the players center point is within the bosses hitbox (`CheckPlayerCenterInEnemyHitbox`). If a collision is detected a flag is set for the player `wPlayerDeathRequested` and later code detects this and starts the player death sequence.

Player shots need to work slightly differently since they can collide with any enemy on potentially any frame. Depending on if the players shot is currently narrow or wide, it checks 1 or 2 different collision points against active objects using `CheckActiveObjectsForShotCollision`. It starts looping after the player and the player projectiles so they can not collide with themselves. It then checks the next 12 slots. Slots higher than that are reserved for enemy projectile objects which also need to avoid collision. Objects that might be in this range like smoke have a flag set in their handler data: OBJECT_SHOT_COLLISION_DISABLED_OFFSET, which causes this check to move to the next object, avoiding collision with smoke.


# Damage

When a collision is detected between a player projectile and an enemy two things happen. The players current shot damage is added to a handler data offset that tracks accumulated damage: OBJECT_DAMAGE_ACCUMULATED_OFFSET. This value is typically returned from the movement script and compared with the previous offset position OBJECT_DAMAGE_THRESHOLD_OFFSET, to determine if the enemy has taken enough damage to be destroyed. The player shot damage is set per shot level using this table:

```code
PlayerShotDamageByPowerLevel: ; damage for weapon power levels 0-5.
    db $01, $02, $02, $03, $03, $04
```

The second thing that happens is that the player shot marks itself for deativation with the handler `DeactivatePlayerShot` this removes the current shot and then sets the handler `WaitForShotRequest` to wait for another shot request from the player.