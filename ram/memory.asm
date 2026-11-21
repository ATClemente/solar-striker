; Named RAM addresses used by the game, objects, sprites, input, and audio engine.
; Definitions are ordered by address; aliases share the same storage.
; Object-record field offsets remain in constants/objects.asm.

; Shadow OAM ($C000)
; ------------------

DEF wShadowOAM                            EQU $C000

; Handler Data Table ($C100–$C4FF)
; -------------------------------

DEF wHandlerDataTable                     EQU $C100

; Handler and object tables ($C700-$C78D)
; -------------------------------------

DEF wHandlerTable                         EQU $C700
DEF wObjectTable                          EQU $C780

; Player aliases within the first object record
DEF wPlayerYPos                           EQU $C781
DEF wPlayerXPos                           EQU $C782
DEF wPlayerGraphicsPointer                EQU $C783 ; two bytes
DEF wPlayerCollisionCenterY               EQU $C786
DEF wPlayerCollisionCenterX               EQU $C787
DEF wPlayerHitboxMinY                     EQU $C788
DEF wPlayerHitboxMinX                     EQU $C789
DEF wPlayerHitboxMaxY                     EQU $C78A
DEF wPlayerHitboxMaxX                     EQU $C78B
;DEF wPlayerDamageThreshold EQU $C78C
;DEF wPlayerAccumulatedDamage EQU $C78D

; Gameplay state ($CA10-$CAFF)
; ---------------------------

; Handler dispatch, movement results, and OAM readiness
DEF wCurrentHandlerIndex                  EQU $CA10
DEF wAllocatedObjectIndex                 EQU $CA11
DEF wCurrentHandlerDataPointer            EQU $CA12
DEF wSelectedObjectPointer                EQU $CA14 ; 2 bytes
DEF wCalculatedYMovement                  EQU $CA16
DEF wCalculatedXMovement                  EQU $CA17
DEF wOAMReady                             EQU $CA18

; Stage, game mode, and scroll state
DEF wCurrentStage                         EQU $CA19
DEF wGameStartRequested                   EQU $CA1A
DEF wCreditsEnded                         EQU $CA1B
DEF wMotherAtenaDeparture                 EQU $CA1C
DEF wScreenShakeRequested                 EQU $CA1D
DEF wScreenShakeOffset                    EQU $CA1E
DEF wPlayerDeathRequested                 EQU $CA20
DEF wWeaponPowerLevel                     EQU $CA21
DEF wSecondStageEventParamMask            EQU $CA22
DEF wPlayerInput                          EQU $CA23
DEF wPlayerShotCooldown                   EQU $CA24
DEF wPlayerDirectionIndex                 EQU $CA25 ; 0-7; $FF for no valid direction
DEF wPendingHorizontalScrollOffset        EQU $CA28 ; Signed object shift awaiting application
DEF wHorizontalScrollOffset               EQU $CA29
DEF wEnemyShotSpeedLevel                  EQU $CA2C
DEF wMotherAtenaSetup                     EQU $CA2D
DEF wGameMode                             EQU $CA2E
DEF wEnableAltProjectileMovement          EQU $CA2F

; Collision and smoke coordinates
DEF wCollisionPointY                      EQU $CA30 ; Shared collision-check point (Y, X)
DEF wCollisionPointX                      EQU $CA31
DEF wPlayerShotDamage                     EQU $CA33
DEF wSmokeSpawnY                          EQU $CA34
DEF wSmokeSpawnX                          EQU $CA35

; Player projectile slots
DEF wWeaponShotSlots                      EQU $CA51
DEF wPlayerShotAllocationIndex            EQU $CA54

; Projectile requests, firing sequences, and player invincibility
DEF wEnemyShotSpawnY                      EQU $CA60 ; Zero means no pending shot request
DEF wEnemyShotSpawnX                      EQU $CA61
DEF wEnemyFiringSequenceSpawnY            EQU $CA63
DEF wEnemyFiringSequenceSpawnX            EQU $CA64
DEF wFiringPatternIndex                   EQU $CA65
DEF wFiringDirectionSequenceIndex         EQU $CA66
DEF wPlayerInvincibilityTimer             EQU $CA68
DEF wPlayerInvincible                     EQU $CA69
DEF wFiringCadenceCounter                 EQU $CA6A
DEF wFiringSpawnAttemptsCounter           EQU $CA6B

; Sprite construction
DEF wOAMWriteOffset                       EQU $CA70
DEF wObjectsProcessed                     EQU $CA71
DEF wSpriteGridDimensions                 EQU $CA72
DEF wSpriteBaseY                          EQU $CA73
DEF wSpriteBaseX                          EQU $CA74
DEF wSpriteDataPointer                    EQU $CA75 ; 2 bytes
DEF wSpriteDrawY                          EQU $CA77
DEF wSpriteDrawX                          EQU $CA78
DEF wSpriteReadPointer                    EQU $CA79 ; 2 bytes
DEF wFirstObjectIndex                     EQU $CA7B

; Background rendering; pointer fields are two bytes each
DEF wBackgroundScrollTimer                EQU $CA80
DEF wDisableBackgroundScroll              EQU $CA81
DEF wStageTickCounter                     EQU $CA82 ; 2 bytes
DEF wCurrentBlockId                       EQU $CA84
DEF wCurrentRowBlockCounter               EQU $CA85
DEF wBackgroundRowComplete                EQU $CA86
DEF wBlockDrawIdle                        EQU $CA87
DEF wBackgroundRowPosition                EQU $CA88 ; 2 bytes
DEF wBackgroundDrawRowPosition            EQU $CA8A ; 2 bytes
DEF wMapBlockPointer                      EQU $CA8C ; 2 bytes
DEF wMapReadPointer                       EQU $CA8E ; 2 bytes
DEF wBlockDrawDestination                 EQU $CA90 ; 2 bytes

; Object initialization and stage events
DEF wInitialObjCollisionFlag              EQU $CAA4
DEF wStageEventPointer                    EQU $CAB2 ; 2 bytes
DEF wStageEventParams                     EQU $CAB5 ; 4 unpacked parameter nibbles
DEF wEnableQuickSoftReset                 EQU $CAB9

; Boss encounters and stage transitions
DEF wNextBossPartIndex                    EQU $CAC0
DEF wBossEncounterEnding                  EQU $CAC1
DEF wBossBackgroundHideTimer              EQU $CAC3
DEF wStageTransitionActive                EQU $CAC5
DEF wPlayerTransitionComplete             EQU $CAC6
DEF wPlayerExitPositionReached            EQU $CAC7
DEF wStageReady                           EQU $CAC9
DEF wBossActive                           EQU $CACA
DEF wPlayerExitAllowed                    EQU $CACB
DEF wNextDestructorOrbDirection           EQU $CACE

; Text, credits, and HUD buffers
DEF wTextCopyPending                      EQU $CAD0
DEF wCreditsWindowSlideCounter            EQU $CAD1
DEF wTextCopySourcePointer                EQU $CAD2
DEF wTextCopyDestinationPointer           EQU $CAD4
DEF wTextCopyLength                       EQU $CAD6
DEF wNextCreditsEntryIndex                EQU $CAD8
DEF wCreditsGroupHoldTimer                EQU $CAD9
DEF wHUDLabelTileBuffer                   EQU $CAE0 ; 6 tile IDs: score/pause label
DEF wFinalScoreTextBuffer                 EQU $CAF0

; Audio state ($CC00-$CD85)
; -------------------------

; Playback slots and software channel state
DEF wAudioUpdateRunning                   EQU $CC00
DEF wCurrentPlaybackSlot                  EQU $CC01
DEF wCurrentAudioSlotRecordPointer        EQU $CC02 ; 2 bytes
DEF wPlaybackSlotActiveTable              EQU $CC04 ; 4 bytes
DEF wPlaybackSlotPriorityTable            EQU $CC08 ; 4 bytes
DEF wCurrentSoftwareChannelId             EQU $CC0C
DEF wCurrentAudioChannelRecordPointer     EQU $CC0D ; 2 bytes
DEF wChannelPlaybackSlotOwnerTable        EQU $CC0F ; 6 bytes
DEF wSoftwareChannelActivity              EQU $CC15 ; 6 bytes
DEF wAudioPanningTable                    EQU $CC1B ; 6 bytes
DEF wSoftwareChannelRegisterUpdatePending EQU $CC21 ; 6 bytes

; Hardware channel lists and current playback record
DEF wHardwareChannel1List                 EQU $CC27 ; 4 software channel IDs; head is the active channel
DEF wHardwareChannel2List                 EQU $CC2B ; 4 bytes
DEF wHardwareChannel3List                 EQU $CC2F ; 4 bytes
DEF wHardwareChannel4List                 EQU $CC33 ; 4 bytes
DEF wAudioPanningAccumulator              EQU $CC37
DEF wCurrentPlaybackRecord                EQU $CC38 ; 3 bytes: repeat count, tick interval, current tick countdown

; Working channel record and aliases for fields within it
DEF wCurrentAudioChannelRecord            EQU $CC47 ; $2B bytes
DEF wCurrentAudioStreamStartPointer       EQU $CC47 ; 2 bytes; aliases working record offsets $00-$01
DEF wCurrentPlaybackHardwareChannel       EQU $CC4B ; Working record offset $04; hardware channel 1-4

; Audio processing scratch and playback requests
DEF wSoftwareChannelBeingProcessed        EQU $CD74
DEF wHardwareChannelBeingSearched         EQU $CD75
DEF wAudioLoopRepeatCountTemp             EQU $CD76
DEF wAudioVolumeTemp                      EQU $CD77
DEF wRequestedPlaybackHardwareChannel     EQU $CD7E ; Hardware channel, 1-4
DEF wRequestedPlaybackRepeatCount         EQU $CD7F ; $FF means indefinite repetition
DEF wRequestedAudioPriority               EQU $CD80
DEF wRequestedAudioPlaybackPointer        EQU $CD81 ; 2 bytes, ROM header address
DEF wAllocatedPlaybackSlot                EQU $CD83 ; Selected slot, not necessarily still free
DEF wCurrentPlaybackSoftwareChannel       EQU $CD84 ; Software record ID, 1-6
DEF wAudioStreamArgument                  EQU $CD85

; Input, scores, flags, and persistent state ($CF00-$CFFF)
; --------------------------------------------------------

; Input, frame synchronization, score, lives, and game-over timers
DEF wJoypadHeld                           EQU $CF80
DEF wJoypadPressed                        EQU $CF81
DEF wVBlankOccurred                       EQU $CF86 ; Set by VBlank; cleared by the main loop
DEF wPlayerScore                          EQU $CF88
DEF wPlayerLives                          EQU $CF95
DEF wScoreExtraLifeReady                  EQU $CF96
DEF wGameOverFadeTimer                    EQU $CF97
DEF wGameOverExitTimer                    EQU $CF98

; Shared storage at $CF99: aliases used by different boss encounters
DEF wUltraCrusherObjectIndex              EQU $CF99
DEF wEpikhanFiringTimer                   EQU $CF99
DEF wBossFiringSequenceIndex              EQU $CF99

; Playback, stage requests, and boss firing state
DEF wCurrentMusicPlaybackSlot             EQU $CF9A
DEF wNextStageRequested                   EQU $CF9B
DEF wGameOverRequested                    EQU $CF9C
DEF wPauseRequested                       EQU $CF9D
DEF wSoundSuppressionTimer                EQU $CFA0
DEF wBossMusicMode                        EQU $CFA1
DEF wBossAlternateFiringPositionCounter   EQU $CFA4 ; Low two bits select a position

; High score and hard-mode unlock
DEF wHighScore                            EQU $CFF1
DEF wStartAlreadyHeld                     EQU $CFFA
DEF wSelectAlreadyHeld                    EQU $CFFB
DEF wHardModeUnlocked                     EQU $CFFC

; High RAM ($FF80)
; ----------------

; OAM DMA routine copied from ROM
DEF hOAMDMARoutine                        EQU $FF80
