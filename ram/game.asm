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

DEF wMotherAtenaSetup EQU $CA2D

; Shared point for player, enemy, projectile, and pickup collision checks.
DEF wCollisionPointY EQU $CA30
DEF wCollisionPointX EQU $CA31

DEF wEnemyShotSpawnY EQU $CA60 ; Zero means no pending shot request
DEF wEnemyShotSpawnX EQU $CA61

DEF wBackgroundScrollTimer EQU $CA80
DEF wBackgroundScrollDelay EQU $06

DEF wStageTickCounter EQU $CA82

DEF wStageEventPointer EQU $CAB2
DEF wStageEventParams EQU $CAB5

DEF wEnableQuickSoftReset EQU $CAB9

DEF wStageTransitionActive EQU $CAC5
DEF wStageReady EQU $CAC9

DEF wBossActive EQU $CACA

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

DEF wHardModeUnlocked EQU $CFFC
