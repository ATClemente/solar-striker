DEF wHandlerTable EQU $C700
DEF wCurrentHandlerIndex EQU $CA10
DEF wAllocatedObjectIndex EQU $CA11
DEF wCurrentHandlerDataPointer EQU $CA12

DEF wCurrentStage EQU $CA19
DEF wGameStartRequested EQU $CA1A
DEF wScreenShakeRequested EQU $CA1D
DEF wScreenShakeOffset EQU $CA1E

DEF wGameMode     EQU $CA2E
DEF wEnableAltProjectileMovement EQU $CA2F

DEF wPlayerDeathRequested EQU $CA20

DEF wHorizontalScrollOffset EQU $CA29

DEF wCreditsEnded EQU $CA1B
DEF wMotherAtenaDeparture EQU $CA1C

DEF wEnemyShotSpeedLevel EQU $CA2C

DEF wMotherAtenaSetup EQU $CA2D

; Shared point for player, enemy, projectile, and pickup collision checks.
DEF wCollisionPointY EQU $CA30
DEF wCollisionPointX EQU $CA31

DEF wPlayerShotDamage EQU $CA33

DEF wEnemyShotSpawnY EQU $CA60 ; Zero means no pending shot request
DEF wEnemyShotSpawnX EQU $CA61

; Shared state for enemy firing sequences
DEF wEnemyFiringSequenceSpawnY EQU $CA63
DEF wEnemyFiringSequenceSpawnX EQU $CA64
DEF wFiringPatternIndex EQU $CA65
DEF wFiringDirectionSequenceIndex EQU $CA66
DEF wFiringCadenceCounter EQU $CA6A
DEF wFiringSpawnAttemptsCounter EQU $CA6B

DEF wBackgroundScrollTimer EQU $CA80
DEF wBackgroundScrollDelay EQU $06

DEF wStageTickCounter EQU $CA82

DEF wDisableBackgroundScroll EQU $CA81
DEF wCurrentBlockId EQU $CA84
DEF wCurrentRowBlockCounter EQU $CA85
DEF wBackgroundRowComplete EQU $CA86
DEF wBlockDrawIdle         EQU $CA87

; All pointers/addresses below are two bytes.
DEF wBackgroundRowPosition       EQU $CA88
DEF wBackgroundDrawRowPosition   EQU $CA8A
DEF wMapBlockPointer             EQU $CA8C
DEF wMapReadPointer              EQU $CA8E
DEF wBlockDrawDestination        EQU $CA90

DEF wStageEventPointer EQU $CAB2
DEF wStageEventParams EQU $CAB5

DEF wEnableQuickSoftReset EQU $CAB9

DEF wNextBossPartIndex EQU $CAC0
DEF wBossEncounterEnding EQU $CAC1

DEF wStageTransitionActive EQU $CAC5
DEF wPlayerTransitionComplete EQU $CAC6
DEF wPlayerExitPositionReached EQU $CAC7
DEF wStageReady EQU $CAC9

DEF wBossActive EQU $CACA
DEF wPlayerExitAllowed EQU $CACB

DEF wNextDestructorOrbDirection EQU $CACE

DEF wTextCopyPending EQU $CAD0
DEF wTextCopySourcePointer EQU $CAD2
DEF wTextCopyDestinationPointer EQU $CAD4
DEF wTextCopyLength EQU $CAD6

DEF wCreditsWindowSlideCounter EQU $CAD1
DEF wNextCreditsEntryIndex EQU $CAD8
DEF wCreditsGroupHoldTimer EQU $CAD9

DEF wFinalScoreTextBuffer EQU $CAF0

DEF wVBlankOccurred EQU $CF86 ; Set by VBlank; cleared by the main loop
DEF wScoreExtraLifeReady EQU $CF96
DEF wNextStageRequested EQU $CF9B
DEF wGameOverRequested EQU $CF9C
DEF wPauseRequested EQU $CF9D

DEF wPlayerScore EQU $CF88
DEF wHighScore   EQU $CFF1

DEF wSoundSuppressionTimer EQU $CFA0

DEF wHardModeUnlocked EQU $CFFC

DEF wGameOverFadeTimer EQU $CF97
DEF wGameOverExitTimer EQU $CF98



DEF hOAMDMARoutine EQU $FF80



; Audio:

DEF wRequestedAudioPlaybackPointer EQU $CD81 ; 2 bytes, ROM header address

DEF wCurrentAudioChannelRecordPointer EQU $CC0D ; 2 bytes

DEF wChannelPlaybackSlotOwnerTable EQU $CC0F ; 6 bytes

DEF wCurrentAudioSlotRecordPointer EQU $CC02 ; 2 bytes

DEF wPlaybackSlotActiveTable EQU $CC04 ; 4 bytes

DEF wPlaybackSlotPriorityTable EQU $CC08 ; 4 bytes

DEF wSoftwareChannelActivity EQU $CC15 ; 6 bytes

DEF wSoftwareChannelRegisterUpdatePending EQU $CC21 ; 6 bytes

DEF wCurrentPlaybackRecord EQU $CC38 ; 3 bytes: repeat count, tick interval, current tick countdown

DEF wCurrentAudioStreamStartPointer EQU $CC47 ; 2 bytes within working channel record
DEF wCurrentAudioChannelRecord EQU $CC47 ; $2B bytes

DEF wHardwareChannelBeingSearched EQU $CD75

DEF wRequestedAudioPriority EQU $CD80

DEF wAllocatedPlaybackSlot EQU $CD83 ; Selected slot, not necessarily still free

DEF wCurrentPlaybackSoftwareChannel EQU $CD84 ; Software record ID, 1–6
DEF wRequestedPlaybackHardwareChannel EQU $CD7E ; Hardware channel, 1–4
DEF wCurrentPlaybackHardwareChannel EQU $CC4B ; Hardware channel in working record

DEF wRequestedPlaybackRepeatCount EQU $CD7F ; $FF means indefinite repetition

DEF wHardwareChannel1List EQU $CC27
DEF wHardwareChannel2List EQU $CC2B
DEF wHardwareChannel3List EQU $CC2F
DEF wHardwareChannel4List EQU $CC33


DEF wAudioUpdateRunning EQU $CC00

DEF wCurrentSoftwareChannelId EQU $CC0C

DEF wAudioPanningTable EQU $CC1B

DEF wAudioVolumeTemp EQU $CD77
DEF wAudioStreamArgument EQU $CD85