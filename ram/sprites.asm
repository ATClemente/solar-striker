DEF wShadowOAM            EQU $C000
DEF wOAMReady             EQU $CA18

DEF wOAMWriteOffset       EQU $CA70
DEF wObjectsProcessed     EQU $CA71
DEF wSpriteGridDimensions EQU $CA72
DEF wSpriteBaseY          EQU $CA73
DEF wSpriteBaseX          EQU $CA74
DEF wSpriteDataPointer    EQU $CA75 ; 2 bytes
DEF wSpriteDrawY          EQU $CA77
DEF wSpriteDrawX          EQU $CA78
DEF wSpriteReadPointer    EQU $CA79 ; 2 bytes
DEF wFirstObjectIndex     EQU $CA7B