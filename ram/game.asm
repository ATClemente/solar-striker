DEF wHandlerTable EQU $C700
DEF wCurrentHandlerIndex EQU $CA10
DEF wCurrentHandlerDataPointer EQU $CA12

DEF wCurrentStage EQU $CA19
DEF wGameStartRequested EQU $CA1A
DEF wGameMode     EQU $CA2E

DEF wVBlankOccurred EQU $CF86 ; Set by VBlank; cleared by the main loop

DEF wPlayerScore EQU $CF88
DEF wHighScore   EQU $CFF1

DEF wHardModeUnlocked EQU $CFFC