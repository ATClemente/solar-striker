# Game Flow

## Introduction

This document attempts to tie the individual systems described in the rest of the documentation into a cohesive explanation of how all of these systems connect to make the game SolarStriker. It should hopefully answer some questions that might still be outstanding about what is actually happening when certain events occur in game.

## Starting a Game

When Start is pressed on the title screen the game jumps to `InitializeNewGame`. The tile map at `$9800` is cleared and the first 32 bytes of the tile map at `$9C00` are also cleared. Clearing the whole map is not necessary since this map is only used for the HUD which only uses a small amount of the memory. Routines described in the rest of the documentation like `LoadStageDataToWram`, `DrawInitialBackground` and `DrawBackgroundTilePackets` are used to load the stage tile data, its event data, and to draw its background and HUD.

Then hardware registers are set to assign the window position and starting scroll position:

```asm
    ld de, $8807
    ld hl, rWY
    ld a, d
    ld [hl+], a
    ld [hl], e
    ld de, $6030
    ld hl, rSCY
    ld a, d
    ld [hl+], a
    ld [hl], e ; rSCX
```

Note that `$8807` and `$6030` are not addresses here. The high and low bytes are each separate values for different registers. They can be loaded together into the 16-bit register pair at the same time and then used individually to set the hardware registers.

Next some handlers required for a new game are registered:

```asm
RegisterNewGameHandlers:
    ld de, InitPlayerObject
    call StoreAddressInFreeWramSlot
    ld de, HandleShotRequest
    call StoreAddressInFreeWramSlot
    ld de, UpdatePlayerStatus
    call StoreAddressInFreeWramSlot
    ld de, InitializeStageEventReader
    call StoreAddressInFreeWramSlot
    ld b, PLAYER_SHOT_SLOT_COUNT ; 3

RegisterPlayerShotInitHandlers:
    push bc
    ld de, InitializePlayerShot
    call StoreAddressInFreeWramSlot
    pop bc
    dec b
    jr nz, RegisterPlayerShotInitHandlers
```

`InitPlayerObject` starts a chain of handlers that ultimately result in a "handler loop" that manages the player during gameplay:

```text
InitPlayerObject
    ↓
WaitForStageReady ← stays here until wStageReady is set
    ↓
ConfigurePlayerForNextStage
    ↓
MovePlayerToStageStartPosition ← repeats until Y reaches $60
    ↓
PlayerMovementHandler
    ↓
UpdatePlayerState
    ↓        ↑   
PlayerMovementHandler
```

This means that during normal gameplay movement runs every other frame, alternating with player state processing. `HandleShotRequest` coordinates firing requests and cooldown and `UpdatePlayerStatus` is responsible for status work such as invincibility timing. Then `InitializePlayerShot` is registered three times to create the three player projectile objects.

Some more flags and hardware registers are set before stage music is set up. After this, the game jumps to the `GameLoop`.

## GameLoop

As discussed in [Stage Events](../docs/stage-events.md), after a stage starts the event scheduler is responsible for the "action" of a stage. Enemy, power-up, and boss spawns, among a few others. The other handlers running are the ones registered in relation to the player. As previously discussed for the player two handlers run on alternate frames: `PlayerMovementHandler` and `UpdatePlayerState`.

The `PlayerMovementHandler` checks `wJoypadHeld` which is set by input when `ReadJoypad` runs earlier in the frame. If there is no directional input, `UpdatePlayerState` is scheduled. Otherwise, `ClampPlayerMovement` runs and removes any inputs that would result in the player leaving the set boundaries. SolarStriker supports "eight-way" movement so a table is used based on the results of the player input minus any movement removed by the previous routine.

```asm
PlayerDirectionLookupTable:
    db $ff ; $0: None
    db $02 ; $1: Right
    db $06 ; $2: Left
    db $ff ; $3: Right + Left
    db $00 ; $4: Up
    db $01 ; $5: Up + Right
    db $07 ; $6: Up + Left
    db $ff ; $7: Up + Right + Left
    db $04 ; $8: Down
    db $03 ; $9: Down + Right
    db $05 ; $A: Down + Left
    db $ff ; $B: Down + Right + Left
    db $ff ; $C: Down + Up
    db $ff ; $D: Down + Up + Right
    db $ff ; $E: Down + Up + Left
    db $ff ; $F: All four directions
```

`$FF` marks no direction or a combination containing opposing directions. Such combinations suppress all movement, including any remaining unopposed direction. If movement is valid another table is used to find the actual movement values for the given input:

```asm
PlayerMovementTable:
    db $d0, $00 ; Up
    db $de, $22 ; Up-Right
    db $00, $30 ; Right
    db $22, $22 ; Down-Right
    db $30, $00 ; Down
    db $22, $de ; Down-Left
    db $00, $d0 ; Left
    db $de, $de ; Up-left
```

Movement is applied and if required a horizontal scroll is applied based on if the player is moving left or right by `ScrollBackgroundHorizontal`.

`UpdatePlayerState` listens for various conditions before ultimately scheduling the movement handler again.

```asm
UpdatePlayerState:
    ld a, [bc]
    call SetObjectPointer
    ld a, [wStageTransitionActive]
    or a
    jr nz, StartMovePlayerToNextStage

    ld a, [wPlayerInvincible]
    or a
    jr nz, HandlePlayerActionInput

    ld a, [wPlayerDeathRequested]
    or a
    jp nz, StartPlayerDeathSequence
```

`HandlePlayerActionInput` is where the game checks if Start has been pressed, requesting a pause, or whether A or B is held which results in firing. If `wPlayerShotCooldown` is 0, it is incremented and execution continues. Shots are not actually created by this handler. `HandleShotRequest` checks `wPlayerShotCooldown`. Zero means no request; one starts shot scheduling. Other values advance the cooldown, wrapping from seven to zero. This is what creates a brief delay between shots even when holding A or B.

There are three shot slots (`wWeaponShotSlots`) allowing for three projectiles to be present at once. `HandleShotRequest` schedules `FindEmptyShotSlot` which searches for an open slot and schedules `QueuePlayerShot`. `QueuePlayerShot` writes the current weapon power plus one into the selected shot-request slot. Adding one reserves zero to mean that no shot is requested. Yet another handler `WaitForShotRequest` which is originally registered after `InitializePlayerShot` watches its designated `wWeaponShotSlots` entry and if the value is nonzero it starts the process of configuring the projectile and scheduling its movement update handler. 

The movement handler for the projectile then schedules a handler that checks collision which, when complete, reschedules the movement handler creating another loop that persists until the shot collides with an enemy or it is determined to be off screen.

`StartPlayerDeathSequence` runs when a player death is requested and starts audio. The next handler scheduled moves the player off screen and spawns a smoke object where the player was. There is a 64-update respawn delay. It then adjusts the player's weapon power based on a table and checks if the player has more than 0 lives. If so it decrements the player's lives and sets up a handler that starts to move the player back to the stage. Otherwise the game over flow is entered. This does a background fade which eventually results in `wGameOverRequested` being set. The main game loop is watching for this and jumps to `SetupGameOverScreen`. Setting up the game over screen is similar to setting up a stage. Tile data is loaded and a background is drawn. The game then draws the score labels, current score, and high score. The game then enters a loop which waits for a Start button press which eventually results in `InitTitleScreen` being run.

Back in the stage, assuming the player does not lose all their lives eventually they reach the end of the stage. Stages schedule bosses via stage events just like any other enemy. Once defeated the game moves to transition to the next stage. Using the stage 1 boss Epikhan as an example, after a destruction sequence is animated the game schedules the `FinishBossExitAndStartStageTransition` handler. This handler schedules `SetupStageTransition` which waits 64 handler updates and then sets the `wStageTransitionActive` flag. This flag triggers the `UpdatePlayerState` handler to schedule another handler that will move the player to their exit position for the stage. The player's `PlayStageTransitionAudio` handler starts transition music. Meanwhile `SetupStageTransition` sets up the "NEXT STAGE" object that displays. The transition waits until the player reaches its exit position and the transition music finishes. It then permits the player to leave the screen. Once that movement completes, `RequestNextStage` sets `wNextStageRequested` and increments the stage number. The main game loop detects the request and loads the next stage. Stage six uses a special transition path that omits the "NEXT STAGE" object as well as the normal transition music.

It should be noted that stage transitions preserve the handler table. Persistent player and shot handlers remain registered, while temporary handlers remove or replace themselves as their work finishes.

## Game End

The ending cutscene is stage 7, and the credits are stage 8. Both use short event streams for initial coordination, while dedicated handlers manage the cutscene and credits. The game loop is still running throughout these stages so at the end of stage 8 (credits) the `wEnableQuickSoftReset` flag is set which allows for just the Start button to trigger a soft reset which returns to the title screen. `wHardModeUnlocked` is also set which is used by the title screen to allow for Select to start a "hard mode" game. This flow sets `wGameMode` which is used by other parts of the game to change things like enemy firing timing and patterns, increasing difficulty.

Very interestingly at the end of the credits if game mode is set, meaning hard mode was just cleared, an additional flag is set:

```asm
    ld a, [wGameMode]
    or a
    jp z, RemoveCurrentHandler

    ld [wEnableAltProjectileMovement], a
    jp RemoveCurrentHandler
```

`wEnableAltProjectileMovement` selects alternate movement during enemy-projectile initialization. This is the only identified explicit assignment that enables it. However, returning to the title screen clears the flag, so its intended effect on subsequent playthroughs is unclear.