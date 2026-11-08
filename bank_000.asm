; Disassembly of "SolarStriker (World).gb"
; This file was created with:
; mgbdis v3.0 - Game Boy ROM disassembler by Matt Currie and contributors.
; https://github.com/mattcurrie/mgbdis

SECTION "ROM Bank $000", ROM0[$0]

RST_00::
    jp Start


    ei
    ei
    xor $ab
    rst $28

RST_08::
    cp [hl]
    rst $38
    cp l
    rst $38
    cp d
    rst $38
    xor d
    rst $38

RST_10::
    xor a
    rst $38

Jump_000_0012:
    cp [hl]
    cp a
    xor e
    rst $38
    xor e
    rst $38

RST_18::
    db $eb
    rst $30
    xor e
    rst $38
    ld [$aeff], a
    rst $38

RST_20::
    cp $ff
    cp [hl]
    rst $38
    cp $bf
    xor d
    rst $38

RST_28::
    xor e
    rst $38
    and e
    rst $38
    xor [hl]
    rst $18
    db $ea
    rst $38

RST_30::
    ld [$aa7f], a
    rst $38
    rst $38
    rst $38
    xor e
    rst $38

RST_38::
    ei
    rst $38
    cp [hl]
    rst $38
    xor d
    rst $38
    ei
    rst $38

VBlankInterrupt::
    jp Jump_000_02e5


    cp a
    xor $ff
    cp d
    rst $38

LCDCInterrupt::
    jp Jump_000_030c


    cp $ff
    ei
    rst $28
    rst $38

TimerOverflowInterrupt::
    jp Jump_000_0315


    cp a
    xor $ff
    db $ea
    ld a, a

SerialTransferCompleteInterrupt::
    reti


    rst $38
    xor a
    or $fb
    rst $38
    cp e
    rst $38

JoypadTransitionInterrupt::
    reti


    rst $38
    xor e
    rst $38
    xor e
    rst $38
    or $fb

    cp [hl]
    rst $38
    cp e
    rst $30
    xor d
    rst $38
    cp d
    rst $38
    ei
    rst $38
    ei
    rst $38
    ld a, [$eafe]
    rst $38
    db $eb
    rst $38
    xor d
    rst $38
    xor d
    rst $38
    ld [$feff], a
    rst $38
    ld a, [bc]
    rst $38
    cp a
    rst $38
    ld [$baff], a
    rst $38
    ld l, [hl]
    rst $38
    ld a, $ff
    rst $38
    rst $38
    db $eb
    ld sp, hl
    xor d
    cp a
    ld [$aafb], a
    rst $38
    and e
    rst $38
    ld [$3afb], a
    rst $38
    ld [$aeff], a
    rst $38
    xor e
    rst $38
    rst $18
    rst $38
    ld a, [$afbf]
    rst $38
    db $eb
    rst $38
    cp e
    rst $38
    xor $ff
    xor $ff
    ld [$aaff], a
    rst $38
    xor [hl]
    rst $38
    db $eb
    rst $28
    db $eb
    rst $38
    ei
    rst $38
    sbc a
    rst $38
    xor $ff
    xor a
    rst $38
    ld a, [hl-]
    rst $18
    ld [$feff], a
    rst $38
    xor d
    rst $38
    cp d
    rst $38
    db $eb
    rst $38
    db $eb
    db $fd
    xor [hl]
    rst $38
    cp d
    rst $38
    xor e
    rst $38
    jp hl


    rst $38
    rst $28
    rst $38

Call_000_00dc:
    xor e
    rst $38
    xor a
    db $fd
    cp e
    rst $38
    rst $28
    db $fd
    xor $ff
    xor a
    rst $38
    ld a, [$aaf7]
    db $fd
    ld a, [$bbff]
    rst $38

Call_000_00f0:
    db $eb
    ld a, a
    ld a, [$aaff]
    rst $38
    cp [hl]
    ei
    cp [hl]
    rst $38
    rst $28
    ei
    xor $f5
    xor $ff

Boot::
    nop
    jp Start


HeaderLogo::
    db $ce, $ed, $66, $66, $cc, $0d, $00, $0b, $03, $73, $00, $83, $00, $0c, $00, $0d
    db $00, $08, $11, $1f, $88, $89, $00, $0e, $dc, $cc, $6e, $e6, $dd, $dd, $d9, $99
    db $bb, $bb, $67, $63, $6e, $0e, $ec, $cc, $dd, $dc, $99, $9f, $bb, $b9, $33, $3e

HeaderTitle::
    db "SOLARSTRIKER", $00, $00, $00, $00

HeaderNewLicenseeCode::
    db $00, $00

HeaderSGBFlag::
    db $00

HeaderCartridgeType::
    db $01

HeaderROMSize::
    db $01

HeaderRAMSize::
    db $00

HeaderDestinationCode::
    db $00

HeaderOldLicenseeCode::
    db $01

HeaderMaskROMVersion::
    db $00

HeaderComplementCheck::
    db $3f

HeaderGlobalChecksum::
    db $26, $06

Start:
    ld a, $01 ; $0150
    ld [$2100], a ; Set ROM bank 1
    call DisableLCD
    di
    call CopyDMARoutineToHRAMLoopSetup
    call InitAudio ; Rom Bank 1
    ; Clear memory, including high score bytes
    ld bc, $0010 ; 16 bytes
    ld hl, $cff0 ; Starting address to zero
    call ZeroMemory
    ; Initialize High score
    ld a, $02
    ld [wHighScore + 2], a ; Default high score to 20000

InitTitleScreen:
    ld a, $02
    ld [$2100], a ; Set ROM bank 2
    ; Copy $1000 bytes of image_002_4000.2bpp into VRAM
    ld hl, $4000
    ld de, $8000
    ld bc, $1000
    call CopyMemory
    ; Copy gfx/image_002_6730.2bpp and
    ; gfx/image_002_6d30.2bpp into VRAM
    ld hl, $6730
    ld de, $9000
    ld bc, $0630
    call CopyMemory
    ld a, $03
    ld [$2100], a ; Set ROM bank 3
    ld hl, Data_003_58b0
    ld de, $d000 ; WRAM
    ld bc, $0080
    call CopyMemory
    ld hl, Data_003_5930
    ld de, $d200 ; WRAM
    ld bc, $0090
    call CopyMemory
    ld a, $01
    ld [$2100], a ; Set ROM bank 1
    call ClearTileMap9800
    ; Clear the first 4080 bytes of WRAM
    ld bc, $0ff0
    ld hl, wShadowOAM
    call ZeroMemory
    ; Store $9AA2 to $CA88–$CA89,
    ; $9AA2 is in the first tilemap
    ld hl, $ca88
    ld a, $a2
    ld [hl+], a
    ld a, $9a
    ld [hl], a
    call DrawInitialBackground
    xor a
    ldh [rSCY], a
    ldh [rSB], a
    ldh [rSC], a
    ld [wVBlankOccurred], a
    ld [wCurrentStage], a
    ld a, $20
    ldh [rSCX], a
    ld a, $20
    ldh [rSCY], a
    ld a, [wHardModeUnlocked]
    or a
    jr nz, DrawPushSelectButton

    ; Draw Push Start Button
    ld de, $3e9b
    call DrawBackgroundTilePackets
    jr DrawHighScoreSetup

DrawPushSelectButton:
    ld de, $3ec7
    call DrawBackgroundTilePackets

DrawHighScoreSetup:
    ld hl, $9a4c ; High Score Display Start
    ld de, wHighScore
    ld b, $07 ; digits in High Score

DrawHighScore:
    ld a, [de]
    or $f0 ; convert to tile id
    ld [hl+], a
    inc de
    dec b
    jr nz, DrawHighScore

FinishTitleScreenSetup:
    ; Set up palettes and scanline interrupt at 136
    ; Also set timer reload and clear all pending interrupts
    ld a, $e4
    ldh [rBGP], a
    ldh [rOBP0], a
    ld a, $40
    ldh [rOBP1], a
    ld a, $88
    ldh [rLYC], a
    ld a, $40
    ldh [rSTAT], a
    xor a
    ldh [rTMA], a
    ldh [rIF], a
    ld de, $04f5
    call StoreAddressInFreeWramSlot
    ld hl, $5ddb
    xor a
    call SetupAudioPlayback
    ld [$cf9a], a
    ld a, $07
    ldh [rTAC], a
    ld a, $07
    ldh [rIE], a
    ld a, $87
    ldh [rLCDC], a
    ei

TitleScreenLoop:
    ld a, [wVBlankOccurred]
    and a
    jr z, TitleScreenLoop

    ld a, $07
    ldh [rIE], a
    ei
    xor a
    ld [wOAMReady], a
    ld a, [wGameStartRequested]
    or a
    jp nz, InitializeNewGame

    call ReadJoypad
    call RunWramHandlers
    call BuildShadowOAM
    xor a
    ld [wVBlankOccurred], a
    inc a
    ld [wOAMReady], a
    call CheckForSoftReset
    or a
    jp nz, ReturnToTitleScreen

    jr TitleScreenLoop

GameLoop:
    ld a, [wVBlankOccurred]
    or a
    jr z, GameLoop

    xor a
    ld [wOAMReady], a
    ld a, $07
    ldh [rIE], a
    ei
    call ScrollBackground
    call ReadJoypad
    call RunWramHandlers
    call BuildShadowOAM
    ld hl, wNextStageRequested
    ld a, [hl+]
    or a
    jp nz, RunStageTransition

    ld a, [hl+]
    or a
    jp nz, SetupGameOverScreen

    ld a, [hl+]
    or a
    jp nz, SetupPauseScreen

    call CheckForSoftReset
    or a
    jp nz, ReturnToTitleScreen

    ld a, [wScreenShakeRequested]
    or a
    call nz, ShakeScreen
    xor a
    ld [wVBlankOccurred], a
    jr GameLoop

Jump_000_02a2:
jr_000_02a2:
    ld a, [wVBlankOccurred]
    or a
    jr z, jr_000_02a2

    ld a, $07
    ldh [rIE], a
    ei
    call ReadJoypad
    call RunWramHandlers
    ld a, $01
    ld [wOAMReady], a
    xor a
    ld [wVBlankOccurred], a
    ld hl, $cf98
    ld a, [hl]
    or a
    jr z, jr_000_02a2

    inc [hl]
    cp $04
    jr c, jr_000_02a2

    ld a, [$cf9a]
    call StopAudioPlayback

ReturnToTitleScreen:
    ldh a, [rLY]
    cp $90
    jr c, ReturnToTitleScreen

    cp $96
    jr nc, ReturnToTitleScreen

    ldh a, [rLCDC]
    and $7f
    ldh [rLCDC], a
    ld hl, $ffff
    ld sp, hl
    jp InitTitleScreen


Jump_000_02e5:
    di
    push af
    push bc
    push de
    push hl
    di
    ld a, $03
    ldh [rIE], a
    ld a, [wOAMReady]
    and a
    call nz, $ff80
    ld a, $01
    ld [wVBlankOccurred], a
    ldh a, [rLCDC]
    or $02
    ldh [rLCDC], a
    call DrawMapBlock
    call Call_000_048d
    pop hl
    pop de
    pop bc
    pop af
    reti


Jump_000_030c:
    push af
    ldh a, [rLCDC]
    and $fd
    ldh [rLCDC], a
    pop af
    reti


Jump_000_0315:
    push af
    di
    ld a, $03
    ldh [rIE], a
    ei
    call $4c97
    ld a, $07
    ldh [rIE], a
    pop af
    reti

CheckForSoftReset:
    ld a, [$cab9]
    or a
    jr nz, CheckQuickSoftReset

    ld a, [wJoypadHeld]
    and $0f
    cp $0f
    jr z, StopAudioForSoftReset

    xor a
    ret

StopAudioForSoftReset:
    ld a, [$cf9a]
    call StopAudioPlayback

WaitForSRButtonsRelease:
    ld a, [wVBlankOccurred]
    or a
    jr z, WaitForSRButtonsRelease

    call ReadJoypad
    xor a
    ld [wVBlankOccurred], a
    ld a, [wJoypadHeld]
    and $0f
    jr nz, WaitForSRButtonsRelease

    xor a
    ldh [rTAC], a
    ldh [rTMA], a
    inc a
    ret

CheckQuickSoftReset:
    ld a, [wJoypadHeld]
    and $08
    jr nz, StopAudioForQuickSoftReset

    xor a
    ret

StopAudioForQuickSoftReset:
    ld a, [$cf9a]
    call StopAudioPlayback

WaitForStartButtonRelease:
    ld a, [wVBlankOccurred]
    or a
    jr z, WaitForStartButtonRelease

    call ReadJoypad
    xor a
    ld [wVBlankOccurred], a
    ld a, [wJoypadHeld]
    and $08
    jr nz, WaitForStartButtonRelease

    xor a
    ldh [rTAC], a
    ldh [rTMA], a
    inc a
    ret


SetupPauseScreen:
    ld a, [$cf9a]
    call StopAudioPlayback
    ld a, $01
    ld hl, $5d8a
    call SetupAudioPlayback
    ld [$cf9a], a
    xor a
    ld [wPauseRequested], a
    call CopyPauseTilesToBuffer

jr_000_0399:
    ld a, [wVBlankOccurred]
    or a
    jr z, jr_000_0399

    xor a
    ld [wOAMReady], a
    call Call_000_048d
    call ReadJoypad
    call BuildShadowOAM
    call $4c97
    call Call_000_0c04
    or a
    jp nz, Jump_000_03f6

    call CheckForSoftReset
    or a
    jp nz, ReturnToTitleScreen

    ld hl, wPauseRequested
    ld a, [hl+]
    or a
    jr z, jr_000_03d5

    ld a, [hl+]
    or a
    jr z, jr_000_03e1

    ld a, [hl+]
    or a
    jr z, jr_000_03ec

    ld a, [wJoypadHeld]
    and $08
    jr z, jr_000_03fc

    jr jr_000_03f6

jr_000_03d5:
    ld a, [wJoypadHeld]
    and $08
    jr nz, jr_000_03f6

    inc a
    dec hl
    ld [hl], a
    jr jr_000_03f6

jr_000_03e1:
    ld a, [wJoypadHeld]
    and $08
    jr z, jr_000_03f6

    dec hl
    ld [hl], a
    jr jr_000_03f6

jr_000_03ec:
    ld a, [wJoypadHeld]
    and $08
    jr nz, jr_000_03f6

    inc a
    dec hl
    ld [hl], a

Jump_000_03f6:
jr_000_03f6:
    xor a
    ld [wVBlankOccurred], a
    jr jr_000_0399

jr_000_03fc:
    ld hl, wPauseRequested
    ld [hl+], a
    ld [hl+], a
    ld [hl], a
    ld [wVBlankOccurred], a
    ld [$cfa2], a
    call Call_000_0446
    ld a, [$cfa1]
    or a
    jr z, jr_000_041f

    ld hl, $5eb0
    ld a, [$cfa1]
    dec a
    jr z, jr_000_042d

    ld hl, $5f23
    jr jr_000_042d

jr_000_041f:
    ld a, [wCurrentStage]
    add a
    ld l, a
    ld h, $00
    ld de, StageMusicPointerTable
    add hl, de
    ld a, [hl+]
    ld h, [hl]
    ld l, a

jr_000_042d:
    xor a
    call SetupAudioPlayback
    ld [$cf9a], a
    jp GameLoop


; Only copy P A U S, E from SCORE remains on screen
CopyPauseTilesToBuffer:
    ld de, $080e
    ld hl, $cae0
    ld b, $04

jr_000_043f:
    ld a, [de]
    ld [hl+], a
    inc de
    dec b
    jr nz, jr_000_043f

    ret


Call_000_0446:
    ld hl, $cae0
    ld de, $0814
    ld b, $06
    ld a, [de]
    ld [hl+], a
    inc de
    dec b
    jr nz, jr_000_043f

    ret

RunWramHandlers:
    ld hl, wHandlerTable
    ld bc, wCurrentHandlerIndex

DispatchCurrentHandler:
    push hl
    ld a, [hl+]
    ld e, a
    ld d, [hl]
    or d
    jp z, AdvanceToNextHandler

    ld a, [bc]
    rlca
    swap a
    ld b, a
    and $0f
    ld h, a
    ld a, b
    and $f0
    ld l, a
    ld bc, $c100
    add hl, bc
    ld c, l
    ld b, h
    ld hl, wCurrentHandlerDataPointer
    ld a, c
    ld [hl+], a
    ld [hl], b
    ld l, e
    ld h, d
    jp hl

AdvanceToNextHandler:
    pop hl
    inc hl
    inc hl
    ld bc, wCurrentHandlerIndex
    ld a, [bc]
    inc a
    and $1f
    ld [bc], a
    jp nz, DispatchCurrentHandler

    ret


Call_000_048d:
    ld a, [wCurrentStage]
    cp $07
    jr nc, jr_000_04b3

    ld c, $0d
    ld hl, $9c06
    ld de, wPlayerScore

Call_000_049c:
jr_000_049c:
    ld a, [de]
    or $f0
    ld [hl+], a
    inc de
    dec c
    jr nz, jr_000_049c

    ld c, $06
    ld hl, $9c00
    ld de, $cae0

jr_000_04ac:
    ld a, [de]
    ld [hl+], a
    inc de
    dec c
    jr nz, jr_000_04ac

    ret


jr_000_04b3:
    ld a, [$cad0]
    or a
    ret z

    ld a, [$cad6]
    ld b, a
    ld hl, $cad4
    ld a, [hl+]
    ld d, [hl]
    ld e, a
    ld hl, $cad2
    ld a, [hl+]
    ld h, [hl]
    ld l, a

jr_000_04c8:
    ld a, [hl+]
    ld [de], a
    inc de
    dec b
    jr nz, jr_000_04c8

    ld a, b
    ld [$cad0], a
    ret

ShakeScreen:
    ld hl, rSCY
    ld de, wScreenShakeOffset
    ld a, [de]
    or a
    jr nz, UndoScreenShakeOffset

    ldh a, [rDIV]
    and $07
    or $01
    ld [de], a
    inc [hl]
    inc hl
    add [hl]
    ld [hl], a
    ret

UndoScreenShakeOffset:
    dec [hl]
    inc hl
    ld b, a
    xor a
    sub b
    add [hl]
    ld [hl], a
    xor a
    ld [de], a
    dec de
    ld [de], a
    ret

HandleTitleScreenInput:
CheckStartButtonHeld:
    ld a, [wJoypadHeld]
    ld b, a
    and BUTTON_START
    jr z, CheckSelectButtonHeld

    ld a, [wStartAlreadyHeld]
    or a
    jp nz, AdvanceToNextHandler

    ld a, $01
    ld [wGameStartRequested], a
    ld a, $01
    ld [wCurrentStage], a
    ld a, $0f
    ld [$ca22], a
    jp RemoveCurrentHandler

CheckSelectButtonHeld:
    ld [wStartAlreadyHeld], a
    ld a, b
    and BUTTON_SELECT
    jp nz, HandleSelectButtonHeld

    ld [wSelectAlreadyHeld], a
    jp AdvanceToNextHandler

HandleSelectButtonHeld:
    ld a, [wSelectAlreadyHeld]
    or a
    jp nz, AdvanceToNextHandler

    ld a, [wHardModeUnlocked]
    or a
    jp z, AdvanceToNextHandler

    ld a, $01
    ld [wGameStartRequested], a
    ld a, $01
    ld [wCurrentStage], a
    ld a, $0f
    ld [$ca22], a
    ld a, $01
    ld [wGameMode], a
    jp RemoveCurrentHandler

InitializeNewGame:
    call DisableLCD
    di
    call ClearTileMap9800
    ld bc, $0020
    ld hl, $9c00
    call ZeroMemory
    ld de, StageTileGraphicsTable
    call CopyStageTileGraphicsToVram
    ld de, StageBackgroundDataTable
    call LoadStageDataToWram
    ld hl, $ca88
    ld de, $9b82
    ld a, e
    ld [hl+], a
    ld [hl], d
    call DrawInitialBackground
    ld de, $3ef4
    call DrawBackgroundTilePackets
    ld de, $cae0
    ld hl, $0814
    ld b, $05

CopyScoreLabelLoop:
    ld a, [hl+]
    ld [de], a
    inc de
    dec b
    jr nz, CopyScoreLabelLoop

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
RegisterNewGameHandlers:
    ld de, InitPlayerObject
    call StoreAddressInFreeWramSlot
    ld de, HandleShotRequest
    call StoreAddressInFreeWramSlot
    ld de, UpdatePlayerStatus
    call StoreAddressInFreeWramSlot
    ld de, InitializeStageEventReader
    call StoreAddressInFreeWramSlot
    ld b, PLAYER_SHOT_SLOT_COUNT

RegisterPlayerShotInitHandlers:
    push bc
    ld de, InitializePlayerShot
    call StoreAddressInFreeWramSlot
    pop bc
    dec b
    jr nz, RegisterPlayerShotInitHandlers

    xor a
    ld [wPlayerInput], a
    ld [wVBlankOccurred], a
    ld [$ca54], a
    ld a, $e7
    ldh [rLCDC], a
    ld a, $07
    ldh [rTAC], a
    ld a, $02
    ld [wPlayerLives], a
    ei
    jp StartStageMusic

; seems to be called when moving to the next stage
RunStageTransition:
    ld a, [$cf9a]
    call StopAudioPlayback
    di
    xor a
    ldh [rTAC], a
    ldh [rTMA], a
    ld [wNextStageRequested], a
    ld [wOAMReady], a
    call DisableLCD
    ld a, [wCurrentStage]
    cp $08
    jr nz, SetupNextStage

    ld a, $02
    ld [$2100], a
    ld hl, $7950
    ld de, $8000
    ld bc, $0800
    call CopyMemory

SetupNextStage:
    call ClearTileMap9800
    ld de, StageTileGraphicsTable
    call CopyStageTileGraphicsToVram
    ld de, StageBackgroundDataTable
    call LoadStageDataToWram
    call ClearTileMap9800
    ld hl, $ca88
    ld de, $9b82
    ld a, e
    ld [hl+], a
    ld [hl], d
    call DrawInitialBackground
    ld hl, wStageTickCounter
    xor a
    ld [hl+], a
    ld [hl], a
    ld hl, $ca28
    ld [hl+], a
    ld [hl], a
    ld [wGameOverRequested], a
    ld [wPlayerDeathRequested], a
    ld [$ca81], a
    ld [wVBlankOccurred], a
    ld [wStageTransitionActive], a
    ld [wBackgroundScrollTimer], a
    ld [$cfa1], a
    ld [$cad8], a
    ld [$cad0], a
    ld [wScreenShakeRequested], a
    ld [wScreenShakeOffset], a
    ld a, [wCurrentStage]
    cp $07
    jr nc, jr_000_067b

    ld a, $30
    ldh [rSCX], a
    ld a, $60
    ldh [rSCY], a
    ld de, $8807
    ld hl, rWY
    ld a, d
    ld [hl+], a
    ld [hl], e
    ld a, $e4
    ldh [rBGP], a
    ld de, InitializeStageEventReader
    call StoreAddressInFreeWramSlot
    ld a, $07
    ldh [rTAC], a
    ld a, $e7
    ldh [rLCDC], a
    jr StartStageMusic

jr_000_067b:
    ld a, $50
    ldh [rSCX], a
    ld a, $60
    ldh [rSCY], a
    ld d, $88
    ld a, [wCurrentStage]
    cp $07
    jr z, jr_000_0691

    call ClearTileMap9C00
    ld d, $68

jr_000_0691:
    ld hl, rWY
    ld a, d
    ld [hl+], a
    ld a, $07
    ld [hl], a
    ld a, $e4
    ldh [rBGP], a
    ld de, InitializeStageEventReader
    call StoreAddressInFreeWramSlot
    ld a, [wCurrentStage]
    cp $08
    jr z, jr_000_06b2

    ld de, $2d09
    call StoreAddressInFreeWramSlot
    jr jr_000_06c2

jr_000_06b2:
    xor a
    ld hl, $9c00
    ld b, $1f

jr_000_06b8:
    ld [hl+], a
    dec b
    jr nz, jr_000_06b8

    ld de, $2ec9
    call StoreAddressInFreeWramSlot

jr_000_06c2:
    ld a, $07
    ldh [rTAC], a
    ld [$ca81], a
    ld a, $e7
    ldh [rLCDC], a

StartStageMusic:
    ei
    ld b, $00
    ld a, [wCurrentStage]
    cp $07
    jp z, GameLoop ; current stage is 7

    jr c, GetMusicIndexAndSetupAudio ; current stage is less than 7

    ; Stage is greater than 7
    inc b

GetMusicIndexAndSetupAudio:
    add a
    ld l, a
    ld h, $00
    ld de, StageMusicPointerTable
    add hl, de
    ld a, [hl+]
    ld h, [hl]
    ld l, a
    ld a, b
    call SetupAudioPlayback
    ld [$cf9a], a
    ei
    jp GameLoop


    ld hl, $cf97
    ld a, [hl]
    inc [hl]
    cp $20
    jr nc, jr_000_0705

    ld a, $90
    ldh [rBGP], a
    ldh [rOBP0], a
    ldh [rOBP1], a

Call_000_0702:
    jp AdvanceToNextHandler


jr_000_0705:
    cp $30
    jr nc, jr_000_0714

    ld a, $40
    ldh [rBGP], a
    ldh [rOBP0], a
    ldh [rOBP1], a
    jp AdvanceToNextHandler


jr_000_0714:
    cp $40
    jr nc, jr_000_0722

    xor a
    ldh [rBGP], a
    ldh [rOBP0], a
    ldh [rOBP1], a
    jp AdvanceToNextHandler


jr_000_0722:
    ld a, $e4
    ldh [rOBP0], a
    ldh [rOBP1], a
    ld a, $01
    ld [wGameOverRequested], a
    jp RemoveCurrentHandler

SetupGameOverScreen:
    ld a, [$cf9a]
    call StopAudioPlayback
    di
    xor a
    ldh [rTAC], a
    ldh [rTMA], a
    ld [wOAMReady], a
    call DisableLCD
    ld a, $02
    ld [$2100], a
    ld hl, $6230
    ld de, $9000
    ld bc, $0360
    call CopyMemory
    ld a, $03
    ld [$2100], a
    ld hl, $59c0
    ld de, $d000
    ld bc, $0200
    call CopyMemory
    ld hl, $5a20
    ld de, $d200
    ld bc, $0090
    call CopyMemory
    ld a, $01
    ld [$2100], a
    call ClearTileMap9800
    ld hl, wShadowOAM
    ld bc, $0c00
    call ZeroMemory
    ld hl, $ca88
    ld a, $82
    ld [hl+], a
    ld a, $9b
    ld [hl], a
    call DrawInitialBackground
    ld de, $2c9b
    call DrawBackgroundTilePackets
    ld de, $2ca8
    call DrawBackgroundTilePackets
    ld de, $2cb5
    call DrawBackgroundTilePackets
    call Call_000_2c79
    ld c, $07
    ld hl, $9a30
    ld de, wHighScore
    call Call_000_049c
    ld c, $07
    ld hl, $9a90
    ld de, wPlayerScore
    call Call_000_049c
    ld hl, $9c00
    xor a
    ld c, $14

jr_000_07be:
    ld [hl+], a
    dec c
    jr nz, jr_000_07be

    ld a, $50
    ldh [rSCY], a
    ld a, $50
    ldh [rSCX], a
    ld a, $e4
    ldh [rBGP], a
    ldh [rOBP0], a
    ldh [rOBP1], a
    ld de, $2c63
    call StoreAddressInFreeWramSlot
    xor a
    ld [$cf98], a
    ld [wVBlankOccurred], a
    ld hl, $5541
    call SetupAudioPlayback
    ld [$cf9a], a
    ld a, $07
    ldh [rTAC], a
    ld a, $05
    ldh [rIE], a
    ld a, $c7
    ldh [rLCDC], a
    ei
    jp Jump_000_02a2


StageMusicPointerTable: ; $07F8-$0809
    ; Audio definition pointers in ROM bank 1, indexed by stage.
    dw $6210 ; Stage 0
    dw $6210 ; Stage 1
    dw $6210 ; Stage 2
    dw $6B60 ; Stage 3
    dw $651D ; Stage 4
    dw $6FCF ; Stage 5
    dw $70F8 ; Stage 6
    dw $5603 ; Stage 7 (skipped by StartStageMusic)
    dw $5603 ; Stage 8

    ld b, c
    ld d, l
    or b
    ld e, [hl]

    db $d2, $b4, $dc, $d8

    cp h
    cp a

    db $d8, $b8, $d0, $d6, $bc, $bf

INCLUDE "engine/joypad.asm"


CopyDMARoutineToHRAMLoopSetup:
    ld c, $80 ; 128
    ld b, $0a ; 10
    ld hl, $085c 

; Copy $085C–$0865 to $FF80–$FF89, opcodes
; Copied routine starts OAM DMA and then waits
; https://gbdev.io/pandocs/OAM_DMA_Transfer.html
CopyDMARoutineToHRAM:
    ld a, [hl+]
    ldh [c], a
    inc c
    dec b
    jr nz, CopyDMARoutineToHRAM

    ret

    ; $085c
    db $3e, $c0, $e0, $46, $3e, $28, $3d, $20, $fd, $c9

DisableLCD:
    ldh a, [rLY] ; Read the current scanline into A
    cp $91
    jr c, DisableLCD ; Jump if A (rLY) < 145

    cp $96
    jr nc, DisableLCD ; Jump if rLY >= 150

    ; Wait for scanlines 145–149, safely within VBlank.
    ldh a, [rLCDC] ; LCD Control
    and $7f ; Clear highest bit, turning off if on basically
    ldh [rLCDC], a
    ret


ClearTileMap9800:
    ld hl, $9bff
    ld bc, $0400

ClearSetTileMap:
    ld a, $00
    ld [hl-], a
    dec bc
    ld a, b
    or c
    jr nz, ClearSetTileMap

    ret

ClearTileMap9C00:
    ld hl, $9fff
    ld bc, $0400
    jr ClearSetTileMap

; copies BC bytes from HL to DE.
CopyMemory:
    ld a, [hl+]
    ld [de], a
    inc de
    dec bc
    ld a, b
    or c
    jr nz, CopyMemory

    ret

GetPacketDestinationAndMode:
    inc de
    ld h, a
    ld a, [de]
    ld l, a
    inc de
    ld a, [de]
    inc de
    call WriteTilePacket

DrawBackgroundTilePackets:
    ld a, [de]
    cp $00
    jr nz, GetPacketDestinationAndMode

    ret

;Mode	Behavior
;00	    Copy successive bytes across the tile map
;01	    Repeat one byte across the tile map
;10	    Copy successive bytes down the tile map
;11	    Repeat one byte down the tile map
WriteTilePacket:
    push af
    and $3f
    ld b, a
    pop af
    rlca
    rlca
    and $03
    jr z, CopyBytesAcross

    dec a
    jr z, CopyOneByteAcrossSetup

    dec a
    jr z, CopyBytesDown

    jr CopyOneByteDown

; Mode 0
CopyBytesAcross:
    ld a, [de]
    ld [hl+], a
    inc de
    dec b
    jr nz, CopyBytesAcross

    ret

; Mode 1
CopyOneByteAcrossSetup:
    ld a, [de]
    inc de

CopyOneByteAcross:
    ld [hl+], a
    dec b
    jr nz, CopyOneByteAcross

    ret

; Mode 2
CopyBytesDown:
    ld a, [de]
    ld [hl], a
    inc de
    ld a, b
    ld bc, $0020
    add hl, bc
    ld b, a
    dec b
    jr nz, CopyBytesDown

    ret

; Mode 3
CopyOneByteDown:
    ld a, [de]
    ld [hl], a
    ld a, b
    ld bc, $0020
    add hl, bc
    ld b, a
    dec b
    jr nz, CopyOneByteDown

    inc de
    ret

; DE points to a Y/X coordinate pair. Returns A = direction, clockwise from 0 (up).
; Uses a 24-pixel band to choose cardinal versus diagonal directions.
GetDirectionToPlayer:
    ld hl, $c781
    ld a, [hl+]
    ld c, [hl]
    ld b, a ; B = player Y, C = player X
    ld a, [de]
    ld h, a
    inc de
    ld a, [de]
    ld d, h
    ld e, a ; D = source Y, E = source X
    add $18
    sub c
    jr c, jr_000_0902 ; Player X > source X + 24

    ld a, e
    sub $18
    sub c
    jr nc, jr_000_0917 ; Player X <= source X - 24

    ld a, d
    sub b
    jr c, jr_000_08ff ; Player is below the source

    xor a ; Up
    ret

jr_000_08ff:
    ld a, $04 ; Down
    ret

; Player is right of the horizontal band.
jr_000_0902:
    ld a, d
    add $18
    sub b
    jr c, jr_000_0911

    ld a, d
    sub $18
    sub b
    jr nc, jr_000_0914

    ld a, $02 ; Right
    ret

jr_000_0911:
    ld a, $03 ; Down-right
    ret

jr_000_0914:
    ld a, $01 ; Up-right
    ret

; Player is at or left of the horizontal band's left edge.
jr_000_0917:
    ld a, d
    add $18
    sub b
    jr c, jr_000_0926

    ld a, d
    sub $18
    sub b
    jr nc, jr_000_0929

    ld a, $06 ; Left
    ret

jr_000_0926:
    ld a, $05 ; Down-left
    ret

jr_000_0929:
    ld a, $07 ; Up-left
    ret

InitializeMovementScriptFromTable:
    ld hl, $0011
    add hl, bc
    ld a, [hl]     ; index from handler data offset $11
    add a          ; Two bytes per pointer
    ld l, a
    ld h, $00
    add hl, de     ; HL = table address + index * 2
    ld a, [hl+]    ; read pointer's low byte
    ld d, [hl]     ; read pointer's high byte
    ld e, a        ; DE = selected pointer

; Save DE at handler offsets $0A-$0B and its first two bytes at $0C-$0D.
InitializeMovementScript:
    ld hl, $000a
    add hl, bc
    ld a, e
    ld [hl+], a
    ld a, d
    ld [hl+], a
    ld a, [de]
    ld [hl+], a
    inc de
    ld a, [de]
    ld [hl+], a
    ret

TryInitializeObjectInFreeSlot:
    ld a, [wStageEventParams]
    ld hl, EnemySpawnXCoords
    call GetStartingXCoord
    xor a
    ld [$caa4], a
    call FindFreeObjectSlot
    jp c, ObjectInitializationFailed ; couldn't find an open slot

    ld hl, wCurrentHandlerDataPointer
    ld a, [hl+]
    ld h, [hl]
    ld l, a
    ld a, [wAllocatedObjectIndex]
    ld [hl], a ; save object index in handler data
    push hl
    call InitializeHandlerDataPair
    pop hl
    ld de, $0010
    add hl, de
    ld b, $04
    ld de, wStageEventParams + 1

CopyStageEventParamsToHandlerData:
    ld a, [de]
    ld [hl+], a
    inc de
    dec b
    jr nz, CopyStageEventParamsToHandlerData

    ld a, b
    dec a
    ret

ObjectInitializationFailed:
    xor a
    ret


; Apply scripted movement plus a 1/4-pixel downward drift.
; Returns object byte $0C in A, with HL pointing to byte $0D.
UpdateScriptedEnemyMovement:
    ld a, [bc]
    call SetObjectPointer
    ld a, $04
    call CalculateYMovement
    call ReadMovementScriptCommand
    ld a, [$ca16]
    add d
    ld d, a
    call MoveObject
    ld hl, wSelectedObjectPointer
    ld a, [hl+]
    ld h, [hl]
    ld l, a
    ld de, $000c
    add hl, de
    ld a, [hl+]
    ret

TryScheduleEnemyShot:
    ld a, [bc]
    call SetObjectPointer
    call CheckEnemyShotTimer
    or a
    ret nz

    ld de, wEnemyShotSpawnY
    ld a, [de]
    or a
    ret nz

    ld bc, $0804
    call StoreOffsetObjectPosition
    ld de, TrySpawnEnemyProjectile
    jp StoreAddressInFreeWramSlot

; BC = handler data. Advance counter $07; $08 is the trigger, $09 the reset value.
; Returns A = 0 at the trigger, $FF on reset, otherwise the current counter.
CheckEnemyShotTimer:
    ld hl, $0007
    add hl, bc
    inc [hl]
    ld a, [hl+]
    cp [hl]
    jr z, .returnZero

    ret c ; Counter < trigger

    inc hl
    cp [hl]
    ret nz

    dec hl
    dec hl
    xor a
    ld [hl], a
    dec a
    ret

.returnZero:
    xor a
    ret

CheckEnemyCollisionWithPlayer:
    ld a, [bc]
    call SetObjectPointer
    ld de, $0006
    add hl, de
    ld de, wCollisionPointY
    ld a, [hl+]
    ld [de], a
    inc de
    ld a, [hl]
    ld [de], a
    ld hl, $c788 ; Player hitbox minimum Y
    call CheckPointInHitbox
    ld a, c
    or a
    ret z

    ld a, $01
    ld [wPlayerDeathRequested], a
    ret


CheckPlayerCenterInEnemyHitbox:
    ld a, [bc]
    call SetObjectPointer
    ld bc, $c786
    ld de, wCollisionPointY
    ld a, [bc]
    ld [de], a
    inc de
    inc bc
    ld a, [bc]
    ld [de], a
    ld de, $0008
    add hl, de
    call CheckPointInHitbox
    ld a, c
    or a
    ret z

    ld a, $01
    ld [wPlayerDeathRequested], a
    ret


Call_000_0a0c:
    ld a, [bc]
    call SetObjectPointer
    ld de, $000d
    add hl, de
    ld d, [hl]
    ld hl, $0016
    add hl, bc
    ld a, [hl]
    ld [hl], d
    xor d
    or a
    ret z

    ld a, [$cfa0]
    or a
    ret nz

    ld hl, $7311
    ld a, $01
    call SetupAudioPlayback
    ld a, $01
    ret


; Store selected object Y + B and X + C at DE; advance DE by two bytes.
StoreOffsetObjectPosition:
    ld hl, wSelectedObjectPointer
    ld a, [hl+]
    ld h, [hl]
    ld l, a
    inc hl
    ld a, [hl+]
    add b
    ld [de], a
    inc de
    ld a, [hl]
    add c
    ld [de], a
    inc de
    ret


StoreAddressInFreeWramSlot:
    ld b, $00 ; start b at 0
    ld hl, wHandlerTable

FindFreeTwoByteSlotInWram:
    inc b
    ld a, $1f
    cp b
    ret c ; ret if b is > 31

    ld a, [hl+]
    ld c, a
    ld a, [hl+]
    or c
    jr nz, FindFreeTwoByteSlotInWram

    ; Store the address in DE in the WRAM slots we found
    dec hl
    ld a, d
    ld [hl-], a
    ld [hl], e
    ret


SetCurrentHandlerAddress:
    ld a, [wCurrentHandlerIndex]
    rlca
    ld h, $00
    ld l, a
    ld bc, wHandlerTable
    add hl, bc
    ld a, e
    ld [hl+], a
    ld [hl], d
    jp AdvanceToNextHandler

FreeObjectAndRemoveHandler:
    call ClearSelectedObject

RemoveCurrentHandler:
    ld a, [wCurrentHandlerIndex]
    rlca
    ld l, a
    ld h, $00
    ld de, wHandlerTable
    add hl, de
    xor a
    ld [hl+], a
    ld [hl], a
    call ClearCurrentHandlerData
    jp AdvanceToNextHandler

ClearCurrentHandlerData:
    ld hl, wCurrentHandlerDataPointer
    ld a, [hl+]
    ld h, [hl]
    ld l, a
    ld bc, $0020
    jp ZeroMemory

; Clear BC bytes starting at HL
; Sets A to 0
ZeroMemory:
    xor a
    ld [hl+], a
    dec bc
    ld a, b
    or c
    jr nz, ZeroMemory

    ret

; A = object slot index in object table
; BC = Pointer to init template
; DE = Starting coordinate pair
; [$CAA4] = initial value for object field $05
; return: C set = init failed
; C clear and A = 0, init succeeded
; wAllocatedObjectIndex contains requested object index
TryInitializeObjectAtIndex:
    ld [wAllocatedObjectIndex], a
    push de
    push bc
    ld c, a
    swap a
    ld l, a
    ld h, $00
    ld de, wObjectTable
    add hl, de
    ld a, [hl+]
    or [hl]
    jp z, InitializeObjectHeader

    pop bc
    pop de
    scf
    ret


; Find a free slot among indices $04–$0F.
; Success continues into RecordObjectIndex and InitializeObjectHeader.
; Failure returns with carry set.
FindFreeObjectSlot:
    ld hl, (wObjectTable + $10 + ($10 * PLAYER_SHOT_SLOT_COUNT))
    push de
    push bc
    ld c, PLAYER_SHOT_SLOT_COUNT + 1

CheckCurrentObjectSlot:
    ld a, [hl+]
    or [hl]
    jr z, RecordObjectIndex ; jump if the first two bytes in the object row are empty

    ld de, $000f
    add hl, de ; move to next row in table
    inc c
    ld a, $10
    cp c ; see if c is 16
    jr nz, CheckCurrentObjectSlot ; if we haven't hit that limit, check the next row 

    pop bc
    pop de
    scf
    ret


TryInitializeEnemyProjectile:
    ld hl, $c880
    push de
    push bc
    ld c, $10

FindOpenProjectileSlot:
    ld a, [hl+]
    or [hl]
    jr z, RecordObjectIndex ; Both dimensions and Y are zero: slot is free

    ld de, $000f
    add hl, de
    inc c
    ld a, $26
    cp c
    jr nz, FindOpenProjectileSlot ; Search slots 16-37

    pop bc
    pop de
    scf
    ret


RecordObjectIndex:
    ld a, c
    ld [wAllocatedObjectIndex], a ; store index of object we are initializing

InitializeObjectHeader:
    dec hl
    pop bc
    ld a, [bc]
    inc bc
    ld [hl+], a
    pop de
    ld a, d
    ld [hl+], a
    ld a, e
    ld [hl+], a
    inc hl
    inc hl
    ld a, [$caa4]
    ld [hl+], a

InitializeObjectAttributes:
    call CopyCoordinatePairWithOffset
    call CopyCoordinatePairWithOffset
    call CopyCoordinatePairWithOffset
    ld a, [bc]
    ld [hl], a
    xor a
    ret

CopyCoordinatePairWithOffset:
    ld a, [bc]
    add d
    ld [hl+], a
    inc bc
    ld a, [bc]
    add e
    ld [hl+], a
    inc bc
    ret


SetObjectGraphicsPointer:
    ld hl, wSelectedObjectPointer
    ld a, [hl+]
    ld h, [hl]
    ld l, a
    inc hl
    inc hl
    inc hl
    ld a, e
    ld [hl+], a
    ld [hl], d
    ret


ClearSelectedObject:
    ld hl, wSelectedObjectPointer
    ld a, [hl+]
    ld h, [hl]
    ld l, a
    ld b, $10
    xor a

jr_000_0b19:
    ld [hl+], a
    dec b
    jr nz, jr_000_0b19

    ret


MoveObject:
    ld hl, wSelectedObjectPointer
    ld a, [hl+]
    ld h, [hl]
    ld l, a
    inc hl ; get y coord of selected object
    call ApplyMovementOffsets ; update main position
    inc hl
    inc hl
    inc hl
    call ApplyMovementOffsets ; update collision center
    call ApplyMovementOffsets ; update hitbox minimum

ApplyMovementOffsets: ; fall through and update hitbox maximum
    ld a, d
    add [hl]
    ld [hl+], a ; add offset to y coord
    ld a, e
    add [hl]
    ld [hl+], a ; add offset to x coord
    ret


ResetObjectAttributes:
    ld hl, wSelectedObjectPointer
    ld a, [hl+]
    ld h, [hl]
    ld l, a
    inc hl ; point to Y coordinate
    ld a, d
    ld [hl+], a ; set y coordinate
    ld a, e
    ld [hl+], a ; set x coordinate
    inc hl
    inc hl
    inc hl ; move HL to object attributes (past the empty three bytes)
    inc bc ; move bc to next address
    jp InitializeObjectAttributes


SetObjectPointer:
    swap a
    ld l, a
    and $0f
    ld h, a
    ld a, l
    and $f0
    ld l, a
    ld de, wObjectTable
    add hl, de
    ld de, wSelectedObjectPointer
    ld a, l
    ld [de], a
    inc de
    ld a, h
    ld [de], a
    ret


; A = signed movement in 1/16 pixels; BC = handler data.
; Returns whole-pixel displacement in A and $CA16, retaining fractional movement.
CalculateYMovement:
    bit 7, a
    jr z, jr_000_0b72 ; jump if bit 7 (top bit) in a is zero

    ld hl, $0003 ; Handler data: negative Y fractional remainder
    add hl, bc
    cpl
    inc a ; turn the number positive
    call AccumulateFractionalMovement
    cpl
    inc a
    jr jr_000_0b79

; A is nonnegative.
jr_000_0b72:
    ld hl, $0004 ; Handler data: positive Y fractional remainder
    add hl, bc
    call AccumulateFractionalMovement

jr_000_0b79:
    ld [$ca16], a
    ret


CalculateXMovement:
    bit 7, a
    jr z, jr_000_0b8e ; jump if bit 7 is 0

    ld hl, $0005
    add hl, bc
    cpl
    inc a
    call AccumulateFractionalMovement
    cpl
    inc a
    jr jr_000_0b95

jr_000_0b8e:
    ld hl, $0006
    add hl, bc
    call AccumulateFractionalMovement

jr_000_0b95:
    ld [$ca17], a
    ret


; Calulates fractional movement and saves remainder in [hl]
; returns with A = whole pixel amount for that turn
AccumulateFractionalMovement:
    add [hl] ; add whatever is at that object byte to A
    ld d, a ; put a in d
    and $0f ; mask off top 4 bits of a 
    ld [hl], a ; load back into that object slot
    swap d
    ld a, d ; put back into a and mask off top bits again,
    and $0f
    ret


; HL points to minimum Y/X followed by maximum Y/X.
; Test the shared collision point; minimum edges included, maximum edges excluded.
; Returns C = $FF inside, $00 outside.
CheckPointInHitbox:
    ld c, $00
    ld a, [wCollisionPointY]
    cp [hl]
    ret c ; Y < top

    inc hl
    inc hl
    cp [hl]
    ret nc ; Y >= bottom

    dec hl
    ld a, [wCollisionPointX]
    cp [hl]
    ret c ; X < left

    inc hl
    inc hl
    cp [hl]
    ret nc ; X >= right

    dec c ; C = $FF: collision
    ret


Jump_000_0bbb:
    ld a, d
    call AddPlayerScore
    ld hl, wSelectedObjectPointer
    ld a, [hl+]
    ld h, [hl]
    ld l, a
    ld de, $0005
    add hl, de
    inc [hl]
    ld a, [$cfa0]
    or a
    jr nz, jr_000_0bed

    ld hl, wCurrentHandlerDataPointer
    ld a, [hl+]
    ld h, [hl]
    ld l, a
    ld de, $0012
    add hl, de
    ld a, [hl]
    and $03
    add a
    ld l, a
    ld h, $00
    ld de, $0c11
    add hl, de
    ld a, [hl+]
    ld h, [hl]
    ld l, a
    ld a, $01
    call SetupAudioPlayback

jr_000_0bed:
    ld de, AssignSmokeGraphics
    jp SetCurrentHandlerAddress


Call_000_0bf3:
    ld a, d
    call CalculateYMovement
    ld a, e
    call CalculateXMovement
    ld hl, $ca16
    ld a, [hl+]
    ld e, [hl]
    ld d, a
    jp MoveObject


Call_000_0c04:
    ld a, [$cf9a]
    dec a
    ld l, a
    ld h, $00
    ld de, $cc04
    add hl, de
    ld a, [hl]
    ret


    db $2d, $73, $d8, $73, $00, $74

    ld c, d
    ld [hl], h

UpdatePlayerStatus:
    call UpdatePlayerLivesHUD
    ld hl, $cfa0
    ld a, [hl]
    or a
    jr z, jr_000_0c27

    ; Increment counter; wrap from 63 to 0
    inc a
    and $3f
    ld [hl], a

jr_000_0c27:
    ld a, [$ca2a]
    or a
    jr z, UpdatePlayerInvincibilityTimer

    ld [wPlayerInvincible], a
    jp AdvanceToNextHandler

UpdatePlayerInvincibilityTimer:
    ld hl, $ca68
    ld de, wPlayerDeathRequested
    ld a, [hl]
    or a
    jr nz, UpdateInvincibilityTimer

    dec hl
    ld a, [de]
    or a
    jr z, CheckPendingInvincibility

    ld [hl], a
    jp AdvanceToNextHandler

; Timer inactive and player death is NOT requested
CheckPendingInvincibility:
    ld a, [hl+]
    or a
    jp z, AdvanceToNextHandler ; jump if ca67 is zero

; Start or advance the invincibility timer
UpdateInvincibilityTimer:
    inc [hl]
    ld a, [hl+]
    and $7f
    ld [hl-], a
    ld [hl-], a
    ld [hl-], a
    xor a
    ld [de], a
    jp AdvanceToNextHandler

AddPlayerScore:
    ld b, a
    and $0f
    ld hl, $cf8f
    dec hl

.selectScoreDigit:
    dec hl
    dec a
    jr nz, .selectScoreDigit

    swap b
    ld a, b
    and $0f

.addToDigit:
    add [hl]
    cp $0a
    jr nc, .carryToNextDigit

    ld [hl], a
    ret


.carryToNextDigit:
    sub $0a
    ld [hl-], a
    ld a, $01
    jr .addToDigit

UpdatePlayerLivesHUD:
    call CheckPlayerScoreForExtraLife
    ld hl, $cf8f
    ld a, $0b
    ld [hl+], a ; empty space tile
    ld [hl+], a ; empty space tile
    dec a
    ld [hl+], a ; ship icon tile
    ld a, [wPlayerLives]
    ld b, a
    swap a
    and $0f
    ld [hl+], a ; lives tens digit
    ld a, b
    and $0f
    ld [hl+], a ; lives ones digit
    ld a, $0b
    ld [hl], a ; empty tile
    ret


CheckPlayerScoreForExtraLife:
    ld hl, wPlayerScore - 1
    ld de, $0003
    add hl, de ; point at the 10000 place of the score
    ld a, [hl]
    or a
    jr z, TryAwardExtraLife ; if its 0, jump

    cp $05
    jr z, TryAwardExtraLife ; otherwise check if its 5, if so, jump

    ld a, $01
    ld [wScoreExtraLifeReady], a ; not 0 or 5, set a flag
    ret

TryAwardExtraLife:
    ld a, [wScoreExtraLifeReady]
    or a
    ret z

    call IncrementPlayerLives
    xor a
    ld [wScoreExtraLifeReady], a
    inc a
    ld hl, $5d41
    call SetupAudioPlayback
    ld [$cfa0], a
    ret

IncrementPlayerLives:
    ld hl, wPlayerLives
    ld a, [hl]
    cp $99
    ret z

    inc [hl]
    ld a, [hl]
    and $0f
    cp $0a
    ret c

    ld a, [hl]
    and $f0
    add $10
    ld [hl], a
    ret

DecrementPlayerLives:
    ld hl, wPlayerLives
    dec [hl]
    ld a, [hl]
    and $0f
    cp $0a
    ret c

    ld a, [hl]
    and $f0
    add $09
    ld [hl], a
    ret


; BC = handler data. Read the script cursor at $0C-$0D and advance or redirect it.
; Returns signed pixel offsets in D (Y) and E (X).
ReadMovementScriptCommand:
    ld hl, $000c
    add hl, bc
    ld a, [hl+]
    ld b, [hl]
    ld c, a
    ld a, [bc]
    inc bc
    ld de, $0000
    rlca
    jr nc, jr_000_0cf5

    ld d, $fd

jr_000_0cf5:
    rlca
    jr nc, jr_000_0cfa

    ld d, $03

jr_000_0cfa:
    rlca
    jr nc, jr_000_0cff

    ld e, $fd

jr_000_0cff:
    rlca
    jr nc, jr_000_0d04

    ld e, $03

jr_000_0d04:
    rlca
    jr c, jr_000_0d0b

    ld a, b
    ld [hl-], a
    ld [hl], c
    ret


jr_000_0d0b:
    dec hl
    dec hl
    ld a, [hl-]
    ld c, [hl]
    ld b, a
    inc bc
    inc bc
    ld a, c
    ld [hl+], a
    ld [hl], b
    inc hl
    ld a, [bc]
    ld [hl+], a
    inc bc
    ld a, [bc]
    ld [hl+], a
    ret


InitializeStageEventReader:
    xor a
    ld hl, wStageEventPointer
    ld [hl+], a
    ld a, $d8
    ld [hl], a
    ld de, ScheduleStageEvents
    jp SetCurrentHandlerAddress


ScheduleStageEvents:
    ld hl, wStageEventPointer
    ld a, [hl+]
    ld b, [hl]
    ld c, a ; Load event reader pointer into BC
    ld hl, wStageTickCounter
    ld a, [bc]
    cp [hl]
    jp nz, AdvanceToNextHandler

    inc hl
    inc bc
    ld a, [bc]
    cp [hl]
    jp nz, AdvanceToNextHandler

    ; Event time matched current stage time/tick
    ; Next process event type
    ; 0 ends the handler
    ; 1 requests the next stage
    ; others select a pointer and add another handler
    inc bc
    ld a, [bc]
    or a
    jp z, RemoveCurrentHandler

    dec a
    jp z, RequestNextStage

    inc a
    push bc
    add a ; A = entry index * 2
    ld l, a
    ld h, $00
    ld de, StageEventHandlerTable
    add hl, de
    ld a, [hl+]
    ld d, [hl]
    ld e, a ; DE = pointer stored in selected table entry
    call StoreAddressInFreeWramSlot
    pop bc
    ld hl, wStageEventParams
    inc bc
    ld e, $02

; event offset + 3, high nibble -> wStageEventParams
; event offset + 3, low nibble -> wStageEventParams + 1
; event offset + 4, high nibble -> wStageEventParams + 2
; event offset + 4, low nibble -> wStageEventParams + 3
UnpackStageEventParameters:
    ld a, [bc]
    ld d, a
    swap a
    and $0f
    ld [hl+], a
    ld a, d
    and $0f
    ld [hl+], a
    inc bc
    dec e
    jr nz, UnpackStageEventParameters

    ld hl, wStageEventPointer
    ld a, c
    ld [hl+], a
    ld [hl], b
    ld hl, wStageEventParams + 1
    ld b, [hl]
    ld a, [$ca22]
    and b
    ld [hl], a
    jp AdvanceToNextHandler


IncreaseScrollSpeed:
    ld a, [$cac1]
    or a
    jp nz, RemoveCurrentHandler

    ld hl, rSCY
    dec [hl]
    jp AdvanceToNextHandler


    ld a, $01
    ld [$ca81], a
    jp RemoveCurrentHandler


    xor a
    ld [$ca81], a
    jp RemoveCurrentHandler


    ld a, $01
    ld [$cac8], a
    jp RemoveCurrentHandler


    ld a, $01
    ld [$caca], a
    jp RemoveCurrentHandler

SetStageReady:
    ld a, $01
    ld [wStageReady], a
    xor a
    ld [$cac1], a
    jp RemoveCurrentHandler


    ld hl, $cfa1
    inc [hl]
    ld hl, $5f23
    xor a
    call SetupAudioPlayback
    ld [$cf9a], a
    jp RemoveCurrentHandler


StartBossAudio:
    ld hl, $5eb0
    xor a
    call SetupAudioPlayback
    ld [$cf9a], a
    ld a, $01
    ld [$cfa1], a
    jp RemoveCurrentHandler

StopStageAudio:
    ld a, [$cf9a]
    call StopAudioPlayback
    jp RemoveCurrentHandler


RequestNextStage:
    ld a, $01
    ld [wNextStageRequested], a
    ld hl, wCurrentStage
    inc [hl]
    ld hl, $cc40
    ld bc, $0200
    call ZeroMemory
    jp RemoveCurrentHandler

CopyStageTileGraphicsToVram:
    ; DE points to the table at $0E81: each stage has two little-endian
    ; words, a byte count (BC) followed by a source address (HL) in bank 2.
    ; Stage 0/1/2: $5000-$534F, $0350 bytes (53 tiles).
    ; Stage 3/4:   $5400-$5A3F, $0640 bytes (100 tiles).
    ; Stage 5/6:   $5A40-$60EF, $06B0 bytes (107 tiles).
    ; Stage 7:     $6D70-$727F, $0510 bytes (81 tiles).
    ; Stage 8:     $6590-$672F, $01A0 bytes (26 tiles).
    ; All copies start at VRAM $9000;
    ld a, $02
    ld [$2100], a ; switch to rom bank 2
    ld a, [wCurrentStage]
    add a
    add a
    ld l, a
    ld h, $00
    add hl, de
    ld a, [hl+]
    ld c, a
    ld a, [hl+]
    ld b, a
    ld a, [hl+]
    ld h, [hl]
    ld l, a
    ld de, $9000
    ; For stages 0/1/2, $5000 is offset $1000 in image_002_4000.2bpp.
    jp CopyMemory

LoadStageDataToWram:
    ld a, $03
    ld [$2100], a
    ld a, [wCurrentStage]
    add a
    add a
    ld l, a
    ld h, $00
    add hl, de
    push hl
    ld a, [hl+]
    ld h, [hl]
    ld l, a
    ld de, $d000
    ld bc, $0200
    call CopyMemory
    pop hl
    inc hl
    inc hl
    ld a, [hl+]
    ld h, [hl]
    ld l, a
    ld de, $d200
    ld bc, $0550
    call CopyMemory
    ld a, [wCurrentStage]
    ld de, $0ea5
    add a
    ld l, a
    ld h, $00
    add hl, de
    ld a, [hl+]
    ld h, [hl]
    ld l, a
    ld de, $d800
    ld bc, $0400
    call CopyMemory
    ld a, $01
    ld [$2100], a
    ret

StageBackgroundDataTable:
    ; ROM bank 3 source pointers: block definitions, background map.
    ; Copied to $D000 ($0200 bytes) and $D200 ($0550 bytes), respectively.
    dw $4000, $41B0 ; Stage 0
    dw $4000, $42A0 ; Stage 1
    dw $4000, $4390 ; Stage 2
    dw $4480, $4530 ; Stage 3
    dw $4480, $4620 ; Stage 4
    dw $4B70, $4D50 ; Stage 5
    dw $4B70, $52A0 ; Stage 6
    dw $5AD0, $5B50 ; Stage 7
    dw $57F0, $5820 ; Stage 8

StageTileGraphicsTable:
    ; Bytes to copy, source address
    ; Stage 0
    dw $0350, $5000
    ; Stage 1
    dw $0350, $5000 
    ; Stage 2
    dw $0350, $5000
    ; Stage 3
    dw $0640, $5400
    ; Stage 4
    dw $0640, $5400
    ; Stage 5
    dw $06B0, $5A40
    ; Stage 6
    dw $06B0, $5A40
    ; Stage 7
    dw $0510, $6D70
    ; Stage 8
    dw $01A0, $6590


    nop
    ld h, b

    db $20, $60, $20, $64

    jr nz, @+$6a

    jr nz, @+$6e

    jr nz, @+$72

    jr nz, jr_000_0f27

    jr nz, jr_000_0f2d

    ld b, b
    ld a, b

StageEventHandlerTable:
    ; Indexed by event type; each entry is a little-endian handler address.
    dw RemoveCurrentHandler ; event type $00 (handled directly by ScheduleStageEvents)
    dw RequestNextStage ; event type $01 (handled directly by ScheduleStageEvents)
    dw $0d8f ; event type $02
    dw $0d9e ; event type $03
    dw InitializeStageAnnouncement ; event type $04
    dw InitializeProtodroid ; event type $05
    dw InitializeCruiser ; event type $06
    dw InitializeRotomech ; event type $07
    dw InitializePincher ; event type $08
    dw InitializeArrowhead ; event type $09
    dw InitializeHarrier ; event type $0a
    dw InitializePowerUpContainer ; event type $0b
    dw InitializeDestructor ; event type $0c
    dw $20c7 ; event type $0d
    dw InitializeEpikhan ; event type $0e
    dw $42b5 ; event type $0f
    dw $43cf ; event type $10
    dw $44e6 ; event type $11
    dw $0da6 ; event type $12
    dw SetStageReady ; event type $13
    dw InitializeTerraCannon ; event type $14
    dw $0d97 ; event type $15
    dw InitializeSkimbot ; event type $16
    dw $2322 ; event type $17
    dw $2457 ; event type $18
    dw $24ff ; event type $19
    dw $2d09 ; event type $1a
    dw RemoveCurrentHandler ; event type $1b
    dw StartBossAudio ; event type $1c
    dw StopStageAudio ; event type $1d
    dw $0dba ; event type $1e
    dw $2ec9 ; event type $1f
    dw InitializeBatwing ; event type $20
    dw InitializeZigzag ; event type $21
    dw $1ba8 ; event type $22
    dw $1ca9 ; event type $23
    dw $1fa6 ; event type $24
    dw IncreaseScrollSpeed ; event type $25
    dw $2123 ; event type $26
    dw $214f ; event type $27
    dw InitializeMack ; event type $28
    dw InitializeVexor ; event type $29
    dw $2245 ; event type $2a
    dw InitializeUltraCrusher ; event type $2b

; Preserve addresses referenced by disassembled data below.
DEF jr_000_0efc EQU StageEventHandlerTable + $45
DEF jr_000_0f0c EQU StageEventHandlerTable + $55

; A = index, HL = X coordinate table
; Returns A and E = table[index] + wHorizontalScrollOffset
GetStartingXCoord:
    ld e, a
    ld d, $00
    add hl, de
    ld a, [wHorizontalScrollOffset]
    add [hl]
    ld e, a
    ret


EnemySpawnXCoords:
    db $08, $18, $20, $28, $30, $38, $48, $50, $58, $68, $70, $78, $80, $88

jr_000_0f27:
    sbc b
    and b
    ld c, b
    ld d, b
    ld e, b
    ld h, b

jr_000_0f2d:
    ld c, b
    ld e, b

Call_000_0f2f:
    add a
    ld e, a
    ld d, $00
    add hl, de
    ld a, [hl+]
    ld d, a
    ld a, [wHorizontalScrollOffset]
    add [hl]
    ld e, a
    ret


    db $10
    ld d, b
    jr nz, jr_000_0f90

    db $10
    ld b, b
    db $10
    ld h, b
    nop
    ld d, b
    jr nz, jr_000_0f90

    jr @+$3a

    jr jr_000_0fa4

    jr nc, jr_000_0f9e

    jr c, jr_000_0f98

    jr z, jr_000_0f8a

    jr z, @+$5a

    jr c, jr_000_0f6e

    jr c, GetCurrentGameMode

    ld h, b
    ld b, b
    ld h, b
    ld e, b
    ld e, b
    jr nc, @+$5a

    ld l, b
    ld d, b
    jr SetupDataPairOffset

    add b
    ld c, b
    ld [$9048], sp
    jr nc, jr_000_0f72

    jr nc, jr_000_0efc

    jr z, @+$1a

jr_000_0f6e:
    jr z, @-$7e

    jr nz, jr_000_0fa2

jr_000_0f72:
    jr nz, @+$6a

    jr WriteDataPairBytes

    jr @+$5a

    jr @+$52

    jr z, jr_000_0f98

    ld b, b
    ld d, h
    jr z, jr_000_0f0c

    inc e
    ld [$101c], sp
    inc [hl]
    jr nc, SetupDataPairOffset

    ld b, b
    inc l
    ld c, b

jr_000_0f8a:
    inc l
    ld h, b
    inc l
    ld l, b
    inc [hl]
    ld a, b

jr_000_0f90:
    inc e
    sbc b
    inc e
    and b
    inc [hl]
    jr nc, TryApplyHardModeOverrides

    ld b, b

jr_000_0f98:
    inc l
    ld c, b
    inc l
    ld h, b
    inc l
    ld l, b

jr_000_0f9e:
    inc [hl]
    ld a, b
    jr jr_000_0ff2

jr_000_0fa2:
    jr c, @+$2e

jr_000_0fa4:
    jr c, @+$7e

    adc b
    inc e
    adc b
    adc h

InitializeHandlerDataPair:
    ld de, $0008
    add hl, de
    push hl
    ld a, [wStageEventParams + 1]
    add a

SetupDataPairOffset:
    ld l, a
    ld h, $00

WriteDataPairBytes:
    ld de, $0fd5
    add hl, de
    pop de
    ld a, [hl+]
    ld [de], a
    inc de
    ld a, [hl+]
    ld [de], a

GetCurrentGameMode:
    ld a, [wGameMode]

TryApplyHardModeOverrides:
    or a
    ret z

    ldh a, [rDIV]
    and $3f
    or $0f
    ld [de], a
    dec de
    ldh a, [rDIV]
    and $07
    or $01
    ld [de], a
    ret


    ; $0FD5: two-byte entries indexed by wStageEventParams + 1.
    db $e0, $f0 ; index $00
    db $1c, $40 ; index $01
    db $1c, $38 ; index $02
    db $18, $38 ; index $03
    db $18, $30 ; index $04
    db $16, $30 ; index $05
    db $16, $2c ; index $06
    db $14, $2c ; index $07
    db $14, $28 ; index $08
    db $12, $28 ; index $09
    db $10, $24 ; index $0a
    db $0c, $24 ; index $0b
    db $0a, $20 ; index $0c
    db $08, $1c ; index $0d
    db $04, $18 ; index $0e
    db $04, $10 ; index $0f

; Preserve the address referenced by disassembled data above.
DEF jr_000_0ff2 EQU $0ff2

; Allocate a separate smoke object at the coordinates in $CA34-$CA35.
InitializeSmokeObject:
    ld bc, SmokePuffInitTemplate

    ld hl, $ca34
    ld a, [hl+]
    ld e, [hl]
    ld d, a
    ld a, $01
    ld [$caa4], a
    call FindFreeObjectSlot
    jp c, RemoveCurrentHandler

    ld hl, wCurrentHandlerDataPointer
    ld a, [hl+]
    ld h, [hl]
    ld l, a
    ld a, [wAllocatedObjectIndex]
    ld [hl], a
    ld de, AssignSmokeGraphics
    jp SetCurrentHandlerAddress

AssignSmokeGraphics:
    ld a, [bc]
    call SetObjectPointer
    ld a, $12
    ld [hl], a
    ld de, SmokePuffGraphicsFrame0
    call SetObjectGraphicsPointer

UpdateSmokeMovement:
    ld a, [bc]
    call SetObjectPointer
    ld a, $08
    call CalculateYMovement
    ld d, a
    ld e, $00
    call MoveObject
    ld de, UpdateSmokeAnimation
    jp SetCurrentHandlerAddress

UpdateSmokeAnimation:
    ld a, [bc]
    call SetObjectPointer
    inc bc
    ld a, [bc]
    xor $01
    ld [bc], a
    jr nz, ScheduleSmokeMovement

    inc bc
    ld a, [bc]
    add a
    ld e, a
    ld d, $00
    ld hl, SmokePuffAnimationTable
    add hl, de
    ld a, [hl+]
    ld d, [hl]
    ld e, a
    call SetObjectGraphicsPointer
    ld a, [bc]
    inc a
    and $03
    ld [bc], a
    jp z, FreeObjectAndRemoveHandler

ScheduleSmokeMovement:
    ld de, ResumeSmokeMovement
    jp SetCurrentHandlerAddress

ResumeSmokeMovement:
    ld de, UpdateSmokeMovement
    jp SetCurrentHandlerAddress


; Provisional smoke-puff identification based on the observed collision effect.
SmokePuffAnimationTable: ; $106A
    dw SmokePuffGraphicsFrame0
    dw SmokePuffGraphicsFrame1
    dw SmokePuffGraphicsFrame2
    dw SmokePuffGraphicsFrame0

; Eight-byte template; its last three bytes overlap the first graphics frame.
SmokePuffInitTemplate: ; $1072
    db $12      ; Sprite grid: one row, two columns
    db $00, $00 ; Collision center Y/X offsets
    db $00, $00 ; Hitbox minimum Y/X offsets

; Each frame contains two (tile, attributes) pairs, left sprite then right sprite.
SmokePuffGraphicsFrame0: ; $1077
    db $22, $00 ; Also template hitbox maximum Y/X offsets
    db $24      ; Also the template's final object attribute
    db $00

SmokePuffGraphicsFrame1: ; $107B
    db $26, $00,  $28, $00

SmokePuffGraphicsFrame2: ; $107F
    db $2a, $00,  $2c, $00

TrySpawnEnemyProjectile:
    ld bc, EnemyProjectileObjectTemplate
    ld hl, wEnemyShotSpawnY
    ld a, [hl+]
    ld e, [hl]
    ld d, a
    call TryInitializeEnemyProjectile
    jp c, FailedProjectileSpawn

    ld hl, wCurrentHandlerDataPointer
    ld a, [hl+]
    ld h, [hl]
    ld l, a
    ld a, [wAllocatedObjectIndex]
    ld [hl], a
    ld de, SetEnemyProjectileDirection
    jp SetCurrentHandlerAddress

SetEnemyProjectileDirection:
    push bc
    ld de, wEnemyShotSpawnY
    call GetDirectionToPlayer
    pop bc
    ld hl, $000e
    add hl, bc
    ld [hl], a
    xor a
    ld hl, wEnemyShotSpawnY
    ld [hl+], a
    ld [hl+], a
    ld de, ConfigureEnemyProjectileMovement
    jp SetCurrentHandlerAddress

ConfigureEnemyProjectileMovement:
    ld a, [bc]
    call SetObjectPointer
    ld de, EnemyShotAlternateMovementTable
    ld a, [$ca2f]
    or a
    jr nz, SetProjectileVelocityAndStartUpdateCycle ; Use the alternate projectile movement table

    ld a, [$ca2c]
    ld l, a
    ld h, $00
    ld de, EnemyShotMovementIndexByPowerLevel
    add hl, de
    ld a, [hl]
    add a
    ld l, a
    ld h, $00
    ld de, EnemyShotMovementTablePointers
    add hl, de
    ld a, [hl+]
    ld d, [hl]
    ld e, a

SetProjectileVelocityAndStartUpdateCycle:
    ld hl, $000e
    add hl, bc
    ld a, [hl]
    add a
    ld l, a
    ld h, $00
    add hl, de
    ld a, [hl+]
    ld e, [hl]
    ld hl, $0008
    add hl, bc
    ld [hl+], a
    ld [hl], e
    ld de, EnemyProjectileGraphics
    call SetObjectGraphicsPointer
    ld a, [wCurrentHandlerIndex]
    or a
    jr z, SetUpdateProjectileStatusHandler

    ld de, UpdateProjectilePosition
    jp SetCurrentHandlerAddress

SetUpdateProjectileStatusHandler:
    ld de, UpdateProjectileStatus
    jp SetCurrentHandlerAddress

UpdateProjectilePosition:
    ld a, [bc]
    call SetObjectPointer
    ld hl, $0008
    add hl, bc
    ld a, [hl+]
    ld e, [hl]
    call CalculateYMovement
    ld a, e
    call CalculateXMovement
    ld hl, $ca16
    ld a, [hl+]
    ld e, [hl]
    ld d, a
    call MoveObject
    ld de, UpdateProjectileStatus
    jp SetCurrentHandlerAddress

UpdateProjectileStatus:
    call CheckObjectOutOfBounds
    or a
    jp nz, FreeObjectAndRemoveHandler

    call CheckEnemyCollisionWithPlayer
    ld de, UpdateProjectilePosition
    jp SetCurrentHandlerAddress

FailedProjectileSpawn:
    ld hl, $ca63
    xor a
    ld [hl+], a
    ld [hl], a
    jp RemoveCurrentHandler


TrySpawnAlternateEnemyProjectile:
    ld bc, AlternateEnemyProjectileObjectTemplate
    ld hl, wEnemyShotSpawnY
    ld a, [hl+]
    ld e, [hl]
    ld d, a
    call TryInitializeEnemyProjectile
    jp c, FailedProjectileSpawn

    ld hl, wCurrentHandlerDataPointer
    ld a, [hl+]
    ld h, [hl]
    ld l, a
    ld a, [wAllocatedObjectIndex]
    ld [hl], a
    xor a
    ld hl, wEnemyShotSpawnY
    ld [hl+], a
    ld [hl+], a
    ld de, ConfigureAlternateEnemyProjectile
    jp SetCurrentHandlerAddress

ConfigureAlternateEnemyProjectile:
    ld a, [bc]
    call SetObjectPointer
    ld de, AlternateEnemyProjectileGraphics
    call SetObjectGraphicsPointer
    ld de, UpdateAlternateProjectilePosition
    jp SetCurrentHandlerAddress

UpdateAlternateProjectilePosition:
    ld a, [bc]
    call SetObjectPointer
    ld d, $05
    ld e, $00
    call MoveObject
    ld de, UpdateAlternateProjectileStatus
    jp SetCurrentHandlerAddress

UpdateAlternateProjectileStatus:
    ld a, [bc]
    call SetObjectPointer
    inc hl
    ld a, [hl]
    cp $98
    jp nc, FreeObjectAndRemoveHandler

    ld de, CheckAlternateProjectileCollision
    jp SetCurrentHandlerAddress

CheckAlternateProjectileCollision:
    call CheckEnemyCollisionWithPlayer
    ld de, UpdateAlternateProjectilePosition
    jp SetCurrentHandlerAddress


UpdateEnemyFiringSequence:
    ld hl, $ca6a
    inc [hl]
    ld a, [hl]
    and $01
    jp nz, AdvanceToNextHandler

    ld [hl], a
    ld de, TrySpawnFiringSequenceProjectile
    call StoreAddressInFreeWramSlot
    ld a, [$ca65]
    ld e, a
    ld d, $00
    ld hl, FiringSequenceSpawnCounts
    add hl, de
    ld b, [hl]
    ld hl, $ca6b
    inc [hl]
    ld a, [hl]
    cp b
    jp nz, AdvanceToNextHandler

    xor a
    ld [$ca6b], a
    jp RemoveCurrentHandler

TrySpawnFiringSequenceProjectile:
    ld bc, EnemyProjectileObjectTemplate
    ld hl, $ca63
    ld a, [hl+]
    ld e, [hl]
    ld d, a
    call TryInitializeEnemyProjectile
    jp c, FailedProjectileSpawn

    ld hl, wCurrentHandlerDataPointer
    ld a, [hl+]
    ld h, [hl]
    ld l, a
    ld a, [wAllocatedObjectIndex]
    ld [hl], a
    ld de, GetFiringSequenceDirection
    jp SetCurrentHandlerAddress

GetFiringSequenceDirection:
    ld a, [bc]
    call SetObjectPointer
    ld hl, $000e
    add hl, bc
    push hl
    ld bc, $ca65
    ld a, [bc]
    ld h, $00
    ld l, a
    add hl, hl
    add hl, hl
    add hl, hl
    ld de, FiringSequenceDirectionTable
    add hl, de
    inc bc
    ld a, [bc]
    ld e, a
    ld d, $00
    add hl, de
    pop de
    ld a, [hl]
    ld [de], a
    ld a, [bc]
    inc a
    and $0f
    ld [bc], a
    ld de, GetFiringSequenceMovement
    jp SetCurrentHandlerAddress

GetFiringSequenceMovement:
    ld a, [bc]
    call SetObjectPointer
    ld a, [$ca2c]
    ld l, a
    ld h, $00
    ld de, EnemyShotMovementIndexByPowerLevel
    add hl, de
    ld a, [hl]
    add a
    ld l, a
    ld h, $00
    ld de, EnemyShotMovementTablePointers
    add hl, de
    ld a, [hl+]
    ld d, [hl]
    ld e, a
    jp SetProjectileVelocityAndStartUpdateCycle


    ld de, $1364
    ld a, [$ca2f]
    or a
    jp nz, SetProjectileVelocityAndStartUpdateCycle

    ld de, $134e
    jp SetProjectileVelocityAndStartUpdateCycle


; Each eight-byte object template shares its final byte with its graphics data.
EnemyProjectileObjectTemplate: ; $1244
    db $11      ; Sprite grid: one row, one column
    db $08, $04 ; Collision center Y/X offsets
    db $06, $02 ; Hitbox minimum Y/X offsets
    db $0a, $06 ; Hitbox maximum Y/X offsets
EnemyProjectileGraphics: ; $124B
    db $0a      ; Final object attribute and sprite tile number
    db $00      ; Sprite attributes

AlternateEnemyProjectileObjectTemplate: ; $124D
    db $11      ; Sprite grid: one row, one column
    db $08, $04 ; Collision center Y/X offsets
    db $00, $00 ; Hitbox minimum Y/X offsets
    db $10, $08 ; Hitbox maximum Y/X offsets
AlternateEnemyProjectileGraphics: ; $1254
    db $10      ; Final object attribute and sprite tile number
    db $00      ; Sprite attributes

EnemyShotMovementIndexByPowerLevel:
    db $00, $01, $01, $02, $02, $03, $03, $03

EnemyShotMovementTablePointers: ; $125E
    dw EnemyShotMovementTable0 ; Movement index 0
    dw EnemyShotMovementTable1 ; Movement index 1
    dw EnemyShotMovementTable2 ; Movement index 2
    dw EnemyShotMovementTable3 ; Movement index 3
    dw EnemyShotMovementTable4 ; Movement index 4
    dw EnemyShotMovementTable4 ; Movement index 5
    dw EnemyShotMovementTable4 ; Movement index 6
    dw EnemyShotMovementTable4 ; Movement index 7

; Number of projectile spawn attempts for each firing-pattern index.
FiringSequenceSpawnCounts: ; $126E
    db $01, $02, $02, $03, $03, $04, $05, $05
    db $05, $05, $05, $05, $05, $05, $05, $05

; Lookup: pattern index * 8 + sequence position.
; First four rows shown as data; the table continues below.
FiringSequenceDirectionTable: ; $127E
    db $04, $04, $04, $04, $04, $04, $04, $04 ; Pattern $00
    db $02, $06, $02, $06, $02, $06, $02, $06 ; Pattern $01
    db $00, $04, $00, $04, $00, $04, $00, $04 ; Pattern $02
    db $03, $04, $05, $03, $04, $05, $05, $07 ; Pattern $03 (Epikhan and Vexor)

    ld bc, $0503
    rlca
    ld bc, $0503
    rlca
    nop
    ld [bc], a
    inc b
    ld b, $00
    ld [bc], a
    inc b
    ld b, $02
    inc bc
    inc b
    dec b
    ld b, $04
    inc b
    inc b
    ld b, $07
    nop
    ld bc, $0302
    inc b
    dec b
    nop
    ld bc, $0905
    ld a, [bc]
    inc b
    inc b
    inc b
    ld [bc], a
    inc b
    dec b
    ld b, $08
    inc b
    inc b
    inc b
    ld bc, $0503
    rlca
    add hl, bc
    inc b
    inc b
    inc b
    inc bc
    inc b
    dec b
    ld b, $07
    inc b
    inc b
    inc b

; Eight (Y, X) movement pairs per table, clockwise from up.
; Values are signed 1/16-pixel units passed to CalculateYMovement/CalculateXMovement.
EnemyShotMovementTable0: ; $12DE
    db $dc, $00 ; Up: Y=-36, X=0
    db $e7, $19 ; Up-right: Y=-25, X=25
    db $00, $24 ; Right: Y=0, X=36
    db $19, $19 ; Down-right: Y=25, X=25
    db $24, $00 ; Down: Y=36, X=0
    db $19, $e7 ; Down-left: Y=25, X=-25
    db $00, $dc ; Left: Y=0, X=-36
    db $e7, $e7 ; Up-left: Y=-25, X=-25

EnemyShotMovementTable1: ; $12EE
    db $d8, $00 ; Up: Y=-40, X=0
    db $e4, $1c ; Up-right: Y=-28, X=28
    db $00, $28 ; Right: Y=0, X=40
    db $1c, $1c ; Down-right: Y=28, X=28
    db $28, $00 ; Down: Y=40, X=0
    db $1c, $e4 ; Down-left: Y=28, X=-28
    db $00, $d8 ; Left: Y=0, X=-40
    db $e4, $e4 ; Up-left: Y=-28, X=-28

EnemyShotMovementTable2: ; $12FE
    db $d0, $00 ; Up: Y=-48, X=0
    db $de, $22 ; Up-right: Y=-34, X=34
    db $00, $30 ; Right: Y=0, X=48
    db $22, $22 ; Down-right: Y=34, X=34
    db $30, $00 ; Down: Y=48, X=0
    db $22, $de ; Down-left: Y=34, X=-34
    db $00, $d0 ; Left: Y=0, X=-48
    db $de, $de ; Up-left: Y=-34, X=-34

EnemyShotMovementTable3: ; $130E
    db $c8, $00 ; Up: Y=-56, X=0
    db $d8, $28 ; Up-right: Y=-40, X=40
    db $00, $38 ; Right: Y=0, X=56
    db $28, $28 ; Down-right: Y=40, X=40
    db $38, $00 ; Down: Y=56, X=0
    db $28, $d8 ; Down-left: Y=40, X=-40
    db $00, $c8 ; Left: Y=0, X=-56
    db $d8, $d8 ; Up-left: Y=-40, X=-40

EnemyShotMovementTable4: ; $131E
    db $c0, $00 ; Up: Y=-64, X=0
    db $d3, $2d ; Up-right: Y=-45, X=45
    db $00, $40 ; Right: Y=0, X=64
    db $2d, $2d ; Down-right: Y=45, X=45
    db $40, $00 ; Down: Y=64, X=0
    db $2d, $d3 ; Down-left: Y=45, X=-45
    db $00, $c0 ; Left: Y=0, X=-64
    db $d3, $d3 ; Up-left: Y=-45, X=-45

EnemyShotMovementTable5: ; $132E
    db $b0, $00 ; Up: Y=-80, X=0
    db $c7, $39 ; Up-right: Y=-57, X=57
    db $00, $50 ; Right: Y=0, X=80
    db $39, $39 ; Down-right: Y=57, X=57
    db $50, $00 ; Down: Y=80, X=0
    db $39, $c7 ; Down-left: Y=57, X=-57
    db $00, $b0 ; Left: Y=0, X=-80
    db $c7, $c7 ; Up-left: Y=-57, X=-57

EnemyShotAlternateMovementTable: ; $133E
    db $a0, $00 ; Up: Y=-96, X=0
    db $bc, $44 ; Up-right: Y=-68, X=68
    db $00, $60 ; Right: Y=0, X=96
    db $44, $44 ; Down-right: Y=68, X=68
    db $60, $00 ; Down: Y=96, X=0
    db $44, $bc ; Down-left: Y=68, X=-68
    db $00, $a0 ; Left: Y=0, X=-96
    db $bc, $bc ; Up-left: Y=-68, X=-68

    nop
    ld b, b
    dec l
    dec l
    dec sp
    jr @+$40

    inc c
    ccf
    ld b, $40
    nop
    ccf
    ld a, [$f43e]
    dec sp
    add sp, $2d
    db $d3
    nop
    ret nz

    nop
    ld h, b
    ld b, h
    ld b, h
    ld e, c
    dec h
    ld e, l
    inc de
    ld e, a
    add hl, bc
    ld h, b
    nop
    ld e, a
    rst $30
    ld e, l
    db $ed
    ld e, c
    db $db
    ld b, h
    cp h
    nop
    and b

ScrollBackground:
    ld hl, wBackgroundScrollTimer
    inc [hl]
    ld a, [hl]
    cp wBackgroundScrollDelay
    ret nz

    xor a
    ld [hl], a ; reset counter to 0
    ld hl, wStageTickCounter
    inc [hl]
    ld a, [hl+] ; store in a and move hl to ca83
    or a
    jr nz, jr_000_138d ; if a not zero

    inc [hl] ; inc ca83 byte by 1

jr_000_138d:
    ld a, $01
    ld [$ca87], a ; set ca87 to 1
    ld a, [$ca81] ; check if ca81 is 0
    or a
    ret nz ; return if not zero

    ld hl, rSCY
    dec [hl] ; move rSCY down (Y scroll)
    ld de, $ca84 
    ld a, [de]
    cp $ff
    ret z ; return if ca84 is equal to FF

    inc de 
    inc de ; move de to ca86
    ld a, [hl] 
    and $0f 
    jr nz, jr_000_13ba ; jump if bottom 4 bits are not zero, or when scy is not a multiple of 16

    ; scy was a multiple of 16
    ld [de], a ; store 0 in ca86 
    ld hl, $ca8a
    ld bc, $ca90
    ld a, [hl+] ; story ca8a byte in a, move hl to ca8b
    and $f0 
    or $02 ; keep top four bits and set second bit
    ld [bc], a ; store at ca90
    inc bc ; move bc to ca91
    ld a, [hl+] ; store ca8b byte in a
    ld [bc], a ; put that byte at ca91
    ret

; scy was not a multiple of 16
jr_000_13ba:
    ld a, [de]
    or a
    ret nz ; check if ca86 is 0, return if NOT zero

    ld a, [$ca87]
    or a
    ret z ; return if ca87 is 0

    call ReadNextMapBlock
    ld hl, $ca85 
    inc [hl]
    ld a, [hl+]
    cp $0e
    ret nz ; increment the value at ca85 and compare to 14, return if NOT 14

    inc a
    ld [hl-], a ; inc a and store in ca86
    xor a
    ld [hl], a ; zero out ca85
    jp MoveMapPositionUpOneBlockRow


; Draw the initial background as 14 columns by 11 rows of 2x2 tile blocks.
; Initialize the drawing position ($CA8A–$CA8B) from $CA88–$CA89.
; Set the map read pointer ($CA8E–$CA8F) to the block IDs at $D200.
DrawInitialBackground:
    ld de, $ca88
    ld hl, $ca8a
    ld a, [de]
    ld [hl+], a
    inc de
    ld a, [de]
    ld [hl], a
    ld hl, $ca8e
    xor a
    ld [hl+], a
    ld a, $d2
    ld [hl], a
    ld b, $0b ; 11

CopyBlockRow:
    ld hl, $ca8a
    ld de, $ca90
    ld a, [hl+]
    ld [de], a
    inc de
    ld a, [hl+]
    ld [de], a
    ld c, $0e ; 14

ProcessBackgroundBlock:
    push bc
    call ReadNextMapBlock ; Read next block ID; find its four tile bytes
    call DrawMapBlock ; Draw the block; advance destination two tiles
    pop bc
    dec c
    jr nz, ProcessBackgroundBlock ; Loop 14 times

    push bc
    call MoveMapPositionUpOneBlockRow
    pop bc
    dec b
    jr nz, CopyBlockRow ; Loop 11 times

    ld hl, $ca8a
    ld de, $ca90
    ld a, [hl+]
    ld [de], a
    inc de
    ld a, [hl+]
    ld [de], a
    ld a, $01
    ld [$ca87], a
    xor a
    ld [$ca85], a
    ret

ReadNextMapBlock:
    ld hl, $ca8e
    ld a, [hl+]
    ld e, a
    ld a, [hl-]
    ld d, a
    ld bc, $ca84
    ld a, [de]
    ld [bc], a
    cp $ff
    ret z

    inc de
    ld a, e
    ld [hl+], a
    ld [hl], d
    ld a, [bc]
    ld h, $00
    ld l, a
    ld de, $d000
    add hl, hl
    add hl, hl
    add hl, de
    ld d, h
    ld a, l
    ld hl, $ca8c
    ld [hl+], a
    ld [hl], d
    xor a
    ld [$ca87], a
    ret

DrawMapBlock:
    ld a, [$ca87]
    or a
    ret nz

    ld hl, $ca8c
    ld a, [hl+]
    ld d, [hl]
    ld e, a
    ld hl, $ca90
    ld a, [hl+]
    ld h, [hl]
    ld l, a
    ld a, [de]
    ld [hl+], a
    inc de
    ld a, [de]
    ld [hl+], a
    inc de
    ld bc, $001e
    add hl, bc
    ld a, [de]
    ld [hl+], a
    inc de
    ld a, [de]
    ld [hl+], a
    ld hl, $ca90
    inc [hl]
    inc [hl]
    ld a, $01
    ld [$ca87], a
    ret


MoveMapPositionUpOneBlockRow:
    ld hl, $ca88
    ld d, h
    ld e, l
    ld a, [hl+]
    ld h, [hl]
    ld l, a
    ld bc, $ffc0
    add hl, bc
    ld a, l
    ld b, a
    ld [de], a
    ld a, h
    cp $97
    jr nz, StoreMapRowPosition

    ld a, $9b

StoreMapRowPosition:
    ld hl, $ca8b
    inc de
    ld [de], a
    ld [hl-], a
    ld [hl], b
    ret


ApplyScrollOffsetToNonPlayerObjects:
    ld a, [$ca28]
    or a
    ret z ; no opposite shift

    ld c, a
    ld hl, wObjectTable + $10 ;$c790 ; start at objects after the player
    ld b, $27

ApplyScrollOffsetLoop:
    ld a, [hl+]
    or a
    jr z, SkipObjectBytes ; no object at slot

    inc hl
    ld a, [hl]
    add c
    ld [hl+], a
    ld de, $0004
    add hl, de
    ld a, [hl]
    add c
    ld [hl+], a
    inc hl
    ld a, [hl]
    add c
    ld [hl+], a
    inc hl
    ld a, [hl]
    add c
    ld [hl+], a
    jr MoveToNextObject

SkipObjectBytes: ; skip most of object
    ld de, $000b
    add hl, de

MoveToNextObject:
    ld de, $0004 ; skip rest of object
    add hl, de
    dec b
    jr nz, ApplyScrollOffsetLoop

    ld a, b
    ld [$ca28], a
    ret

BuildShadowOAM:
    ; Choose starting object, each is 16 bytes
    ld a, [wFirstObjectIndex]
    swap a
    ld l, a
    and $0f
    ld h, a
    ld a, l
    and $f0
    ld l, a
    ld de, wObjectTable 
    add hl, de
    ; Reset the output offset and object counter
    xor a
    ld [wOAMWriteOffset], a
    ld [wObjectsProcessed], a

.nextObject
    ; if first byte is zero skip,
    ; otherwise copy first five bytes into a workspace
    ; starting at wSpriteGridDimensions
    push hl
    ld a, [hl]
    or a
    jp z, .advanceObject

    ld de, wSpriteGridDimensions
    ld bc, $0005
    call CopyMemory
    ld hl, wSpriteDataPointer
    ld a, [hl+]
    or [hl]
    jp z, .advanceObject

    ld de, wSpriteDrawY
    ld hl, wSpriteBaseY
    ld bc, $0004
    call CopyMemory
    ld a, [wSpriteGridDimensions]
    ld c, a
    and $0f
    ld b, a
    swap c
    ld a, c
    and $0f
    ld c, a
    ld a, [wOAMWriteOffset]
    ld e, a
    ld d, HIGH(wShadowOAM)

.writeSprite
    ; Write sprites 4 bytes to buffer at DE
    push bc
    ld hl, wSpriteDrawY
    ld a, [hl+]
    ld [de], a
    inc de
    ld a, [hl+]
    ld [de], a
    inc de
    ld a, [hl+]
    ld c, a
    ld b, [hl]
    ld a, [bc]
    ld [de], a
    inc bc
    inc de
    ld a, [bc]
    ld [de], a
    inc bc
    inc de
    ld a, b
    ld [hl-], a
    ld [hl], c
    ld hl, wSpriteDrawX
    ld a, [hl]
    add $08 ; add 8 to the x pos
    ld [hl-], a
    pop bc
    dec b ; controls whether we repeat for another sprite in the row
    jp nz, .writeSprite

    ; Advance y and check c for another row
    ld a, [hl]
    add $10
    ld [hl+], a
    ld a, [wSpriteBaseX]
    ld [hl], a
    ld a, [wSpriteGridDimensions]
    and $0f
    ld b, a
    dec c
    jp nz, .writeSprite

    ld a, e
    ld [wOAMWriteOffset], a

;Increment wObjectsProcessed, advance the object pointer by 16,
; and wrap from $CA00 back to wObjectTable. Stop after 40 object entries.
.advanceObject
    ld hl, wObjectsProcessed
    ld a, [hl]
    inc a
    ld [hl], a
    cp $28
    jr z, .finishObjects

    pop hl
    ld de, $0010
    add hl, de
    ld a, h
    cp $ca
    jp nz, .nextObject

    ld hl, wObjectTable
    jp .nextObject

.finishObjects
    pop hl
    ld a, [wOAMWriteOffset]
    ld l, a
    ld h, HIGH(wShadowOAM)

; Zero remaining buffer bytes up to C0EF increment wFirstObjectIndex,
; reset when it reaches $27
.clearUnusedBuffer
    xor a
    ld [hl+], a
    ld a, l
    cp $f0
    jr c, .clearUnusedBuffer

    ld hl, wFirstObjectIndex
    ld a, [hl]
    inc a
    ld [hl], a
    cp $27
    jr nz, .setOAMFlag

    xor a
    ld [hl], a

.setOAMFlag
    ld a, $01
    ld [wOAMReady], a
    ret


ScrollBackgroundHorizontal:
    ld a, [hl] ; direction number 0-7 
    and $03
    ret z ; return if number is 0, 4 (up or down)

    ld a, [hl+] 
    cp $04
    jr c, AccumulateRightwardScroll ; jump if less than 4

    ; greater than 4
    ld a, [$ca17] ; get the whole pixel x movement
    cpl
    inc a ; turn it positive again
    add [hl] ; Add saved remainder at $CA26
    ld b, a ; save that in b
    and $03 ; Remainder after division by 4 (0–3)
    ld [hl+], a ; Save remainder at $CA26; HL becomes $CA27
    srl b
    srl b ; divide by 4 rounded down
    xor a
    sub b ; Negate the scroll amount
    ld b, a
    inc hl ; HL becomes $CA28
    jr ApplyHorizontalScroll

AccumulateRightwardScroll:
    inc hl
    ld a, [$ca17]
    add [hl]
    ld b, a
    and $03
    ld [hl+], a
    srl b
    srl b

ApplyHorizontalScroll:
    ldh a, [rSCX]
    add b
    ldh [rSCX], a
    xor a
    sub b
    ld [hl+], a
    add [hl]
    ld [hl], a
    jp ApplyScrollOffsetToNonPlayerObjects


ClampPlayerMovement:
    ld hl, $c781
    ld a, [hl+]
    cp PLAYER_UP_MOVEMENT_LIMIT
    jr nc, ClampDownwardMovement

    res 6, b
    jr ClampRightwardMovement

ClampDownwardMovement:
    cp PLAYER_DOWN_MOVEMENT_LIMIT
    jr c, ClampRightwardMovement

    res 7, b

ClampRightwardMovement:
    ld a, [hl]
    cp PLAYER_RIGHT_MOVEMENT_LIMIT
    jr c, ClampLeftwardMovement

    res 4, b
    jr FinishMovementClamp

ClampLeftwardMovement:
    cp PLAYER_LEFT_MOVEMENT_LIMIT
    jr nc, FinishMovementClamp

    res 5, b

FinishMovementClamp:
    ld hl, wPlayerInput
    ld a, [hl]
    and $0f
    or b ; clear any bad inputs
    ld [hl], a
    ret


Jump_000_15e8:
    ld hl, $739b
    ld a, $01
    call SetupAudioPlayback
    xor a
    ld [wPlayerShotCooldown], a
    ld de, $15fa
    jp SetCurrentHandlerAddress


    ; 15fa
    ld a, [bc]
    call SetObjectPointer
    inc hl
    ld b, [hl]
    ld a, $c0
    ld [hl+], a
    ld c, [hl]
    ld hl, $ca34
    ld [hl], b
    inc hl
    ld [hl], c
    ld de, InitializeSmokeObject
    call StoreAddressInFreeWramSlot
    ld de, $1616
    jp SetCurrentHandlerAddress


    ld hl, $000e
    add hl, bc
    inc [hl]
    ld a, [hl]
    and $3f
    jp nz, AdvanceToNextHandler

    xor a
    ld [hl], a
    ld a, [bc]
    call SetObjectPointer
    inc hl
    inc hl
    ld e, [hl]
    ld d, $a0
    ld bc, PlayerInitTemplate
    call ResetObjectAttributes
    ld de, PlayerSpriteData
    call SetObjectGraphicsPointer
    ld a, [wWeaponPowerLevel]
    ld l, a
    ld h, $00
    ld de, $168c
    add hl, de
    ld a, [hl]
    ld [wWeaponPowerLevel], a
    ld [$ca2c], a
    ld a, [wPlayerLives]
    or a
    jr z, jr_000_1658

    call DecrementPlayerLives
    ld de, $165e
    jp SetCurrentHandlerAddress


jr_000_1658:
    ld de, $2c49
    jp SetCurrentHandlerAddress


    ld a, [bc]
    call SetObjectPointer
    inc hl
    ld a, [hl]
    cp $60
    jp c, Jump_000_1672

    ld de, $ff00
    call MoveObject
    jp AdvanceToNextHandler


Jump_000_1672:
    xor a
    ld [wPlayerDeathRequested], a
    ld de, PlayerMovementHandler
    jp SetCurrentHandlerAddress

; 167C
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

Jump_000_168a:
    db $ff ; $E: Down + Up + Left
    db $ff ; $F: All four directions

    db $00, $00

    nop
    db $01

    db $01

    inc bc
    inc bc
    inc bc

PlayerInitTemplate:
    db $12, $08, $08, $02, $02, $0e, $0e

; First byte is also the final byte of PlayerInitTemplate.
PlayerSpriteData:
    db $02, $00, $02, $20

PlayerBlinkSpriteData:
    db $00, $00, $00, $00
    
    ; 16a3
    db $d0, $00, $de, $22, $00, $30, $22, $22, $30, $00, $22, $de, $00, $d0, $de, $de

InitPlayerObject:
    ld bc, PlayerInitTemplate
    ld de, $603a
    xor a
    call TryInitializeObjectAtIndex
    jp c, RemoveCurrentHandler

    ld hl, wCurrentHandlerDataPointer
    ld a, [hl+]
    ld d, [hl]
    ld e, a
    xor a
    ld [de], a
    ld de, $293a
    jp SetCurrentHandlerAddress


PlayerMovementHandler:
    ld a, [bc]
    call SetObjectPointer
    ld a, [wJoypadHeld]
    ld [wPlayerInput], a
    and $f0
    jp z, SchedulePlayerStateUpdate ; jump if no movement

    ; Player requesting movement
    push bc
    ld b, a
    call ClampPlayerMovement
    swap a
    and $0f
    ld l, a
    ld h, $00
    ld de, $167c
    add hl, de
    ld a, [hl]
    ld [$ca25], a ; store the movement input calculated
    pop bc
    cp $ff ; check if movement input cancels out
    jr z, SchedulePlayerStateUpdate

    add a
    ld e, a
    ld d, $00
    ld hl, $16a3
    add hl, de
    ld a, [hl+] ; load the y movement amount in a, point hl at x
    push hl
    call CalculateYMovement
    pop hl
    ld a, [hl] ; load the x movement amount in a 
    call CalculateXMovement
    ld hl, $ca25
    call ScrollBackgroundHorizontal
    ld hl, $ca16
    ld a, [hl+]
    ld e, [hl]
    ld d, a
    call MoveObject

SchedulePlayerStateUpdate:
    ld de, UpdatePlayerState
    jp SetCurrentHandlerAddress

UpdatePlayerState:
    ld a, [bc]
    call SetObjectPointer
    ld a, [wStageTransitionActive]
    or a
    jr nz, jr_000_1774

    ld a, [wPlayerInvincible]
    or a
    jr nz, HandleFireInput

    ld a, [wPlayerDeathRequested]
    or a
    jp nz, Jump_000_15e8

HandleFireInput:
    ld bc, wPlayerInput
    ld a, [bc]
    and BUTTON_START
    ld [wPauseRequested], a
    ld hl, wPlayerShotCooldown
    ld a, [bc]
    and BUTTON_A | BUTTON_B
    jr z, SetPlayerSpriteGraphics

    ld a, [hl]
    or a
    jr nz, SetPlayerSpriteGraphics

    inc a
    ld [hl], a

; continue after fire input handling
SetPlayerSpriteGraphics:
    ld a, [wPlayerInvincible]
    or a
    jr z, SetNormalPlayerSpriteGraphics

    ld hl, $cfa3
    ld a, [hl]
    xor $01
    ld [hl], a
    jr nz, SetNormalPlayerSpriteGraphics

    ld a, [wPauseRequested]
    or a
    jr nz, SetNormalPlayerSpriteGraphics

    ld de, PlayerBlinkSpriteData
    call SetObjectGraphicsPointer
    jr SetPlayerMovementHandler

SetNormalPlayerSpriteGraphics:
    ld de, PlayerSpriteData
    call SetObjectGraphicsPointer

SetPlayerMovementHandler:
    ld de, PlayerMovementHandler
    jp SetCurrentHandlerAddress


jr_000_1774:
    ld de, PlayerSpriteData
    call SetObjectGraphicsPointer
    ld de, $1780
    jp SetCurrentHandlerAddress

    ; $1780
    ld a, [wCurrentStage]
    cp $06
    jr z, jr_000_1792

    ld hl, $600e
    ld a, $01
    call SetupAudioPlayback
    ld [$cf9a], a

jr_000_1792:
    ld de, $1798
    jp SetCurrentHandlerAddress


    ld a, [bc]
    call SetObjectPointer
    ld de, $0000
    inc hl
    ld a, [hl+]
    cp $80
    jr z, jr_000_17ab

    ld d, $08
    jr c, jr_000_17ab

    ld d, $f8

jr_000_17ab:
    ld a, [hl]
    cp $28
    jr z, jr_000_17b6

    ld e, $08
    jr c, jr_000_17b6

    ld e, $f8

jr_000_17b6:
    ld a, d
    or e
    jr z, jr_000_17c0

    call Call_000_0bf3
    jp AdvanceToNextHandler


jr_000_17c0:
    ld a, $01
    ld [$cac7], a
    ld de, $17cb
    jp SetCurrentHandlerAddress


    ld a, [$cacb]
    or a
    jp z, AdvanceToNextHandler

    ld a, [bc]
    ld hl, $000f
    add hl, bc
    xor a
    ld [hl+], a
    ld [hl], a
    ld [wPlayerInvincible], a
    ld de, $28f0
    jp SetCurrentHandlerAddress


HandleShotRequest:
    ld bc, wPlayerShotCooldown
    ld a, [bc]
    or a
    jp z, AdvanceToNextHandler

    cp $01
    jr z, jr_000_17f6

    inc a
    and $07
    ld [bc], a
    jp AdvanceToNextHandler


jr_000_17f6:
    inc a
    ld [bc], a
    ld a, [wWeaponPowerLevel]
    ld de, FindEmptyShotSlot
    jp SetCurrentHandlerAddress

InitializePlayerShot:
    ld bc, $18cb
    ld de, $0000
    ld a, [$ca54]
    inc a
    ld [$ca54], a
    call TryInitializeObjectAtIndex
    jp c, RemoveCurrentHandler

    ld hl, wCurrentHandlerDataPointer
    ld a, [hl+]
    ld h, [hl]
    ld l, a
    ld a, [wAllocatedObjectIndex]
    ld [hl], a
    ld de, $1930
    jp SetCurrentHandlerAddress


Call_000_1824:
    ld a, [wWeaponPowerLevel]
    or a
    jr z, jr_000_1835

    ld a, [hl+]
    ld d, a
    ld e, [hl]
    ld a, $12
    ld [bc], a
    ld bc, $18d2
    jr jr_000_183e

jr_000_1835:
    ld a, [hl+]
    ld d, a
    ld a, [hl]
    add $06
    ld e, a
    ld bc, $18cb

jr_000_183e:
    jp ResetObjectAttributes


; Returns A = $FF outside Y < $90 and wrapped X range -32..175, otherwise zero.
CheckObjectOutOfBounds:
    ld a, [bc]
    call SetObjectPointer
    inc hl
    ld a, [hl+]
    cp $90
    jr nc, .markForRemoval

    ld a, [hl]
    add $20
    cp $d0
    jr nc, .markForRemoval

    xor a
    ret

.markForRemoval:
    ld a, $ff
    ret


Call_000_1857:
    ld hl, wSelectedObjectPointer
    ld a, [hl+]
    ld h, [hl]
    ld l, a
    ld bc, $0006
    add hl, bc
    ld bc, wCollisionPointY
    ld a, [hl+]
    ld [bc], a
    inc bc
    ld a, [hl]
    ld [bc], a
    jr jr_000_1895

Call_000_186b:
    ld hl, wSelectedObjectPointer
    ld a, [hl+]
    ld h, [hl]
    ld l, a
    ld bc, $0006
    add hl, bc
    ld bc, wCollisionPointY
    ld a, [hl+]
    ld [bc], a
    inc bc
    ld a, [hl]
    sub $04
    ld [bc], a
    jr jr_000_1895

Call_000_1881:
    ld hl, wSelectedObjectPointer
    ld a, [hl+]
    ld h, [hl]
    ld l, a
    ld bc, $0006
    add hl, bc
    ld bc, wCollisionPointY
    ld a, [hl+]
    ld [bc], a
    inc bc
    ld a, [hl]
    add $04
    ld [bc], a

jr_000_1895:
    ld hl, $c7c0
    ld b, $0c

Jump_000_189a:
    push hl
    ld a, [hl]
    or a
    jp z, Jump_000_18c0

    ld de, $0005
    add hl, de
    ld a, [hl+]
    or a
    jr nz, jr_000_18c0

    inc hl
    inc hl
    push hl
    call CheckPointInHitbox
    pop hl
    ld a, c
    or a
    jr z, jr_000_18c0

    ld de, $0005
    add hl, de
    ld a, [$ca33]
    add [hl]
    ld [hl], a
    pop hl
    ld a, $01
    ret


Jump_000_18c0:
jr_000_18c0:
    pop hl
    ld de, $0010
    add hl, de
    dec b
    jp nz, Jump_000_189a

    ld a, b
    ret

; 18cb
    db $11, $08, $04, $00, $01, $10, $07, $12, $08, $08, $00, $fe, $10, $12, $01, $02
    db $02, $03, $03

    inc b

    db $eb, $18, $ed, $18, $ed, $18, $f1, $18, $f1, $18

    push af
    db $18

    db $0c, $00, $0c, $00, $0c, $20, $0e, $00, $0e, $20

    inc e
    nop
    ld e, $00

FindEmptyShotSlot:
    ld bc, wWeaponShotSlots
    ld a, [bc]
    or a
    jr z, QueuePlayerShot

    inc bc
    ld a, [bc]
    or a
    jr z, QueuePlayerShot

    inc bc
    ld a, [bc]
    or a
    jr z, QueuePlayerShot

    jr ScheduleShotRequestHandler

QueuePlayerShot:
    ld a, [wWeaponPowerLevel]
    inc a
    ld [bc], a
    ld a, [$cfa0]
    or a
    call z, ChoosePlayerFiringSound

ScheduleShotRequestHandler:
    ld de, HandleShotRequest
    jp SetCurrentHandlerAddress


ChoosePlayerFiringSound:
    ld hl, $72d1
    ld a, [wWeaponPowerLevel]
    cp MAX_WEAPON_POWER_LEVEL
    jr nz, PlayPlayerFiringSound

    ld hl, $72ef ; max power sound

PlayPlayerFiringSound:
    ld a, $01
    jp SetupAudioPlayback


    ld a, [bc]
    ld l, a
    ld h, $00
    ld de, $ca50
    add hl, de
    ld a, [hl]
    or a
    jp z, AdvanceToNextHandler

    ld de, $1943
    jp SetCurrentHandlerAddress


    ld a, [bc]
    call SetObjectPointer
    ld b, h
    ld c, l
    ld hl, $c781
    call Call_000_1824
    ld a, [wWeaponPowerLevel]
    add a
    ld l, a
    ld h, $00
    ld de, $18df
    add hl, de
    ld a, [hl+]
    ld d, [hl]
    ld e, a
    call SetObjectGraphicsPointer
    ld de, $1966
    jp SetCurrentHandlerAddress


    ld a, [bc]
    call SetObjectPointer
    inc hl
    ld a, [hl+]
    cp $e0
    jr nc, jr_000_1984

    ld a, [hl]
    add $20
    cp $d0
    jr nc, jr_000_1984

    ld d, $f8
    ld e, $00
    call MoveObject
    ld de, $198a
    jp SetCurrentHandlerAddress


jr_000_1984:
    ld de, $19c1
    jp SetCurrentHandlerAddress


    ld a, [bc]
    call SetObjectPointer
    ld a, [wWeaponPowerLevel]
    ld l, a
    ld h, $00
    ld de, $18d9
    add hl, de
    ld a, [hl]
    ld [$ca33], a
    ld a, [wWeaponPowerLevel]
    or a
    jr z, jr_000_19af

    call Call_000_186b
    or a
    jr nz, jr_000_19b5

    call Call_000_1881
    jr z, jr_000_19bb

    jr jr_000_19b5

jr_000_19af:
    call Call_000_1857
    or a
    jr z, jr_000_19bb

jr_000_19b5:
    ld de, $19c1
    jp SetCurrentHandlerAddress


jr_000_19bb:
    ld de, $1966
    jp SetCurrentHandlerAddress


    ld a, [bc]
    ld l, a
    ld h, $00
    ld de, $ca50
    add hl, de
    xor a
    ld [hl], a
    ld a, [bc]
    call SetObjectPointer
    ld a, $11
    ld [hl], a
    inc hl
    xor a
    ld [hl], a
    ld de, $1930
    jp SetCurrentHandlerAddress


InitializeProtodroid:
    ld bc, ProtodroidInitTemplate
    call TryInitializeObjectInFreeSlot
    or a
    jp z, RemoveCurrentHandler

    ld de, ConfigureProtodroid
    jp SetCurrentHandlerAddress

ConfigureProtodroid:
    ld a, [bc]
    call SetObjectPointer
    ld de, ProtodroidMovementScriptTable
    call InitializeMovementScriptFromTable
    ld de, ProtodroidGraphics
    jp SetEnemyGraphicsAndStartUpdateCycle


SetEnemyGraphicsAndStartUpdateCycle:
    call SetObjectGraphicsPointer
    ld de, UpdateScriptedEnemyMovementHandler
    ld a, [wCurrentHandlerIndex]
    and $01
    jp nz, SetCurrentHandlerAddress

    ld de, CheckScriptedEnemyCollision
    jp SetCurrentHandlerAddress


UpdateScriptedEnemyMovementHandler:
    call CheckObjectOutOfBounds
    or a
    jp nz, FreeObjectAndRemoveHandler

    call UpdateScriptedEnemyMovement
    ld d, $22
    cp [hl]
    jp c, Jump_000_0bbb

    ld de, TryFireScriptedEnemyShot
    jp SetCurrentHandlerAddress

TryFireScriptedEnemyShot:
    call TryScheduleEnemyShot
    ld de, CheckScriptedEnemyCollision
    jp SetCurrentHandlerAddress


CheckScriptedEnemyCollision:
    call CheckEnemyCollisionWithPlayer
    ld de, UpdateScriptedEnemyMovementHandler
    jp SetCurrentHandlerAddress


    ; $1A37: movement script pointers
ProtodroidMovementScriptTable:
    dw ProtodroidMovementScriptA, ProtodroidMovementScriptB

    ; $1A3B: object template (one row, two sprites)
ProtodroidInitTemplate:
    db $12, $08, $08, $00, $fe, $10, $12, $00

    ; $1A43: two (tile, attributes) pairs, left sprite then right sprite
ProtodroidGraphics:
    db $2e, $00,  $2e, $20

InitializeCruiser:
    ld bc, CruiserInitTemplate
    call TryInitializeObjectInFreeSlot
    or a
    jp z, RemoveCurrentHandler

    ld de, ConfigureCruiser
    jp SetCurrentHandlerAddress

ConfigureCruiser:
    ld a, [bc]
    call SetObjectPointer
    ld de, CruiserMovementScriptTable
    call InitializeMovementScriptFromTable
    ld de, CruiserGraphics
    jp SetEnemyGraphicsAndStartUpdateCycle


CruiserMovementScriptTable:
    dw CruiserMovementScriptA, CruiserMovementScriptB

CruiserInitTemplate:
    db $12, $08, $08, $00, $fe, $10, $12, $00

CruiserGraphics:
    db $30, $00,  $30, $20

InitializeRotomech:
    ld bc, RotomechInitTemplate
    call TryInitializeObjectInFreeSlot
    or a
    jp z, RemoveCurrentHandler

    ld de, ConfigureRotomech
    jp SetCurrentHandlerAddress

ConfigureRotomech:
    ld a, [bc]
    call SetObjectPointer
    ld de, RotomechMovementScriptTable
    call InitializeMovementScriptFromTable
    ld de, RotomechGraphicsFrame0
    call SetObjectGraphicsPointer
    ld a, [wCurrentHandlerIndex]
    and $01
    jr z, SetRotomechMovementHandler

    ; Odd handler slots start with collision/animation; even slots with movement.
    ld de, UpdateRotomechState
    jp SetCurrentHandlerAddress

SetRotomechMovementHandler:
    ld de, UpdateRotomechMovement
    jp SetCurrentHandlerAddress

UpdateRotomechMovement:
    call UpdateScriptedEnemyMovement
    ld d, $22
    cp [hl]
    jp c, Jump_000_0bbb

    ld hl, wSelectedObjectPointer
    ld a, [hl+]
    ld h, [hl]
    ld l, a
    inc hl
    ld a, [hl]
    cp $90 ; Remove at the lower Y cutoff
    jp nc, FreeObjectAndRemoveHandler

    ld de, TryFireRotomechShot
    jp SetCurrentHandlerAddress


TryFireRotomechShot:
    call TryScheduleEnemyShot
    ld de, UpdateRotomechState
    jp SetCurrentHandlerAddress

UpdateRotomechState:
    call CheckEnemyCollisionWithPlayer
    ld hl, wCurrentHandlerDataPointer
    ld a, [hl+]
    ld h, [hl]
    ld l, a
    ld bc, $0014
    add hl, bc
    inc [hl]
    ld a, [hl]
    and $03
    add a
    ld e, a
    ld d, $00
    ld hl, RotomechAnimationTable
    add hl, de
    ld a, [hl+]
    ld d, [hl]
    ld e, a
    call SetObjectGraphicsPointer
    ld de, UpdateRotomechMovement
    jp SetCurrentHandlerAddress


RotomechMovementScriptTable:
    dw RotomechMovementScriptA, RotomechMovementScriptB

RotomechAnimationTable: ; $1AF8
    dw RotomechGraphicsFrame0
    dw RotomechGraphicsFrame1
    dw RotomechGraphicsFrame2
    dw RotomechGraphicsFrame3

RotomechInitTemplate:
    db $12, $08, $08, $00, $fe, $10, $12, $00

; Each frame contains two (tile, attributes) pairs, left sprite then right sprite.
RotomechGraphicsFrame0: ; $1B08
    db $32, $00,  $32, $20

RotomechGraphicsFrame2: ; $1B0C
    db $34, $00,  $34, $20

RotomechGraphicsFrame1: ; $1B10
    db $36, $60,  $36, $00

RotomechGraphicsFrame3: ; $1B14
    db $36, $20,  $36, $40

InitializeBatwing:
    ld bc, BatwingInitTemplate
    call TryInitializeObjectInFreeSlot
    or a
    jp z, RemoveCurrentHandler

    ld de, ConfigureBatwing
    jp SetCurrentHandlerAddress

ConfigureBatwing:
    ld a, [bc]
    call SetObjectPointer
    ld de, BatwingMovementScriptTable
    call InitializeMovementScriptFromTable
    ld de, BatwingGraphics
    jp SetEnemyGraphicsAndStartUpdateCycle

BatwingMovementScriptTable:
    dw $358b, $3595

BatwingInitTemplate:
    db $12, $08, $08, $00, $fe, $10, $12, $01

BatwingGraphics:
    db $42, $00, $42, $20

InitializePincher:
    ld bc, PincherInitTemplate
    call TryInitializeObjectInFreeSlot
    or a
    jp z, RemoveCurrentHandler

    ld de, ConfigurePincher
    jp SetCurrentHandlerAddress

ConfigurePincher:
    ld a, [bc]
    call SetObjectPointer
    ld de, PincherMovementScriptTable
    call InitializeMovementScriptFromTable
    ld de, PincherGraphics
    jp SetEnemyGraphicsAndStartUpdateCycle

PincherMovementScriptTable:
    dw PincherMovementScriptA, PincherMovementScriptB

PincherInitTemplate:
    db $12, $08, $08, $00, $fe, $10, $12, $01

PincherGraphics:
    db $38, $00, $38, $20

InitializeZigzag:
    ld bc, ZigzagInitTemplate
    call TryInitializeObjectInFreeSlot
    or a
    jp z, RemoveCurrentHandler

    ld de, ConfigureZigzag
    jp SetCurrentHandlerAddress

ConfigureZigzag:
    ld a, [bc]
    call SetObjectPointer
    ld de, ZigzagMovementTable
    call InitializeMovementScriptFromTable
    ld de, ZigzagGraphics
    jp SetEnemyGraphicsAndStartUpdateCycle


ZigzagMovementTable:
    dw $35e7, $35e9

ZigzagInitTemplate:
    db $12, $08, $08, $00, $fe, $10, $12, $01

ZigzagGraphics:
    db $4a, $00, $4a, $20

    ; $1BA8: event $22 initializer
    ld bc, $1c12
    call TryInitializeObjectInFreeSlot
    or a
    jp z, RemoveCurrentHandler

    ld de, $1bb8
    jp SetCurrentHandlerAddress


    ld a, [bc]
    call SetObjectPointer
    ld hl, $c782
    ld e, [hl]
    ld d, $00
    ld bc, $1c12
    call ResetObjectAttributes
    ld de, $1c1a
    call SetObjectGraphicsPointer
    ld a, [wCurrentHandlerIndex]
    and $01
    jr z, jr_000_1bdb

    ld de, $1c04
    jp SetCurrentHandlerAddress


jr_000_1bdb:
    ld de, $1be1
    jp SetCurrentHandlerAddress


    ld a, [bc]
    call SetObjectPointer
    inc hl
    ld a, [hl+]
    cp $90
    jp nc, FreeObjectAndRemoveHandler

    ld de, $000a
    add hl, de
    ld d, $53
    ld a, [hl+]
    cp [hl]
    jp c, Jump_000_0bbb

    ld d, $06
    ld e, $00
    call MoveObject
    ld de, $1c04
    jp SetCurrentHandlerAddress


    push bc
    call TryScheduleEnemyShot
    pop bc
    call CheckEnemyCollisionWithPlayer
    ld de, $1be1
    jp SetCurrentHandlerAddress


    ld [de], a
    ld [$0008], sp
    cp $10
    ld [de], a
    ld [de], a
    ld b, h
    nop
    ld b, h
    db $20

InitializeArrowhead:
    ld bc, ArrowheadInitTemplate
    call TryInitializeObjectInFreeSlot
    or a
    jp z, RemoveCurrentHandler

    ld de, ConfigureArrowhead
    jp SetCurrentHandlerAddress

ConfigureArrowhead:
    ld a, [bc]
    call SetObjectPointer
    ld hl, $0010
    add hl, bc
    ld a, $20
    ld [hl], a
    ld de, ArrowheadGraphics
    call SetObjectGraphicsPointer
    ld a, [wCurrentHandlerIndex]
    and $01
    jr z, .arrowheadMovementHandler

    ld de, CheckArrowheadCollision
    jp SetCurrentHandlerAddress


.arrowheadMovementHandler
    ld de, UpdateArrowheadMovement
    jp SetCurrentHandlerAddress


UpdateArrowheadMovement:
    ld a, [bc]
    call SetObjectPointer
    inc hl
    ld a, [hl]
    ld hl, $0010
    add hl, bc
    cp $90
    jp nc, FreeObjectAndRemoveHandler

    cp $30
    jr c, .applyArrowheadMovement

    inc [hl]
    inc [hl]

.applyArrowheadMovement
    ld a, [hl]
    call CalculateYMovement
    ld a, [$ca16]
    ld d, a
    ld e, $00
    call MoveObject
    ld hl, wSelectedObjectPointer
    ld a, [hl+]
    ld h, [hl]
    ld l, a
    ld de, $000c
    add hl, de
    ld d, $22
    ld a, [hl+]
    cp [hl]
    jp c, Jump_000_0bbb

    ld de, TryFireArrowheadShot
    jp SetCurrentHandlerAddress

TryFireArrowheadShot:
    call TryScheduleEnemyShot
    ld de, CheckArrowheadCollision
    jp SetCurrentHandlerAddress


CheckArrowheadCollision:
    call CheckEnemyCollisionWithPlayer
    ld de, UpdateArrowheadMovement
    jp SetCurrentHandlerAddress

ArrowheadInitTemplate:
    db $12, $08, $08, $00, $fe, $14, $12, $00

ArrowheadGraphics:
    db $3a, $00, $3a, $20

    ld bc, $1d28
    call TryInitializeObjectInFreeSlot
    or a
    jp z, RemoveCurrentHandler

    ld de, $1cb9
    jp SetCurrentHandlerAddress


    ld a, [bc]
    call SetObjectPointer
    ld de, $1d24
    call InitializeMovementScriptFromTable
    ld de, $1d30
    call SetObjectGraphicsPointer
    ld a, [wCurrentHandlerIndex]
    and $01
    jr z, jr_000_1cd6

    ld de, $1d1b
    jp SetCurrentHandlerAddress


Jump_000_1cd6:
jr_000_1cd6:
    ld de, $1cdc
    jp SetCurrentHandlerAddress

    ; 1cdc
    call UpdateScriptedEnemyMovement
    ld d, $32
    cp [hl]
    jp c, Jump_000_0bbb

    ld hl, wSelectedObjectPointer
    ld a, [hl+]
    ld h, [hl]
    ld l, a
    inc hl
    ld a, [hl]
    cp $e0
    jp nc, FreeObjectAndRemoveHandler

    ld de, $1cf8
    jp SetCurrentHandlerAddress

    ; 1cf8
    ld a, [bc]
    call SetObjectPointer
    call CheckEnemyShotTimer
    or a
    jr nz, jr_000_1d15

    ld de, wEnemyShotSpawnY
    ld a, [de]
    or a
    jr nz, jr_000_1d15

    ld bc, $0806
    call StoreOffsetObjectPosition
    ld de, TrySpawnAlternateEnemyProjectile
    call StoreAddressInFreeWramSlot

jr_000_1d15:
    ld de, $1d1b
    jp SetCurrentHandlerAddress

    ; 1D1B
    call CheckEnemyCollisionWithPlayer
    ld de, $1cdc
    jp SetCurrentHandlerAddress


    db $fd
    dec [hl]
    inc de
    ld [hl], $12
    ld [$0008], sp
    cp $10
    ld [de], a
    ld [bc], a
    ld c, b
    nop
    ld c, b
    db $20

InitializeHarrier:
    ld bc, HarrierInitTemplate
    call TryInitializeObjectInFreeSlot
    or a
    jp z, RemoveCurrentHandler

    ld de, ConfigureHarrier
    jp SetCurrentHandlerAddress

ConfigureHarrier:
    ld a, [bc]
    call SetObjectPointer
    ld de, HarrierGraphics
    call SetObjectGraphicsPointer
    ld a, [wCurrentHandlerIndex]
    and $01
    jr z, SetUpdateHarrierMovementHandler

    ld de, CheckHarrierCollision
    jp SetCurrentHandlerAddress


SetUpdateHarrierMovementHandler:
    ld de, UpdateHarrierVerticalMovement
    jp SetCurrentHandlerAddress

UpdateHarrierVerticalMovement:
    ld a, [bc]
    call SetObjectPointer
    ld de, $000c
    add hl, de
    ld d, $32
    ld a, [hl+]
    cp [hl]
    jp c, Jump_000_0bbb

    ld a, $28
    call CalculateYMovement
    ld a, [$ca16]
    ld d, a
    ld e, $00
    call MoveObject
    ld de, $c781
    ld hl, wSelectedObjectPointer
    ld a, [hl+]
    ld h, [hl]
    ld l, a
    inc hl
    ld a, [de]
    sub $04
    cp [hl]
    jr nc, SetUpdateHarrierStatusHandler ; playerY - 4 >= enemyY

    inc de
    inc hl
    ld a, [de]
    cp [hl]
    jr c, ActivateHarrierHorizontalMovement

    xor a

ActivateHarrierHorizontalMovement:
    ld hl, $000f
    add hl, bc
    inc [hl]
    ld hl, $0011
    add hl, bc
    ld [hl], a ; zero to move right, non zero for left

SetUpdateHarrierStatusHandler:
    ld de, UpdateHarrierStatus
    jp SetCurrentHandlerAddress


UpdateHarrierHorizontalMovement:
    ld a, [bc]
    call SetObjectPointer
    ld de, $000c
    add hl, de
    ld d, $22
    ld a, [hl+]
    cp [hl]
    jp c, Jump_000_0bbb

    ld d, $60
    ld hl, $0011
    add hl, bc
    ld a, [hl]
    or a
    jr z, .applyHorizontalMovement

    ld d, $a0

.applyHorizontalMovement
    ld a, d
    call CalculateXMovement
    ld a, [$ca17]
    ld e, a
    ld d, $00
    call MoveObject
    ld de, UpdateHarrierStatus
    jp SetCurrentHandlerAddress

UpdateHarrierStatus:
    call TryScheduleEnemyShot
    ld hl, wSelectedObjectPointer
    ld a, [hl+]
    ld h, [hl]
    ld l, a
    inc hl
    ld a, [hl+]
    cp $a0
    jp nc, FreeObjectAndRemoveHandler

    ld a, [hl]
    add $20
    cp $d0
    jp nc, FreeObjectAndRemoveHandler

    ld de, CheckHarrierCollision
    jp SetCurrentHandlerAddress


CheckHarrierCollision:
    call CheckEnemyCollisionWithPlayer
    ld hl, wCurrentHandlerDataPointer
    ld a, [hl+]
    ld h, [hl]
    ld l, a
    ld de, $000f
    add hl, de
    ld a, [hl]
    or a
    jr z, .skipHorizontalMovement

    ld de, UpdateHarrierHorizontalMovement
    jp SetCurrentHandlerAddress

.skipHorizontalMovement
    ld de, UpdateHarrierVerticalMovement
    jp SetCurrentHandlerAddress


HarrierInitTemplate:
    db $12, $08, $08, $00, $fe, $10, $12, $00

HarrierGraphics:
    db $3c, $00, $3c, $20

InitializePowerUpContainer:
    ld bc, PowerUpContainerInitTemplate
    call TryInitializeObjectInFreeSlot
    or a
    jp z, RemoveCurrentHandler

    ld de, ConfigurePowerUpContainer
    jp SetCurrentHandlerAddress

ConfigurePowerUpContainer:
    ld a, [bc]
    call SetObjectPointer
    ld de, PowerUpContainerGraphics
    call SetObjectGraphicsPointer
    ld de, UpdatePowerUpContainerMovement
    jp SetCurrentHandlerAddress

UpdatePowerUpContainerMovement:
    ld a, [bc]
    call SetObjectPointer
    ld d, $02
    ld e, $00
    call MoveObject
    ld de, UpdatePowerUpContainerStatus
    jp SetCurrentHandlerAddress


UpdatePowerUpContainerStatus:
    ld a, [bc]
    call SetObjectPointer
    inc hl
    ld a, [hl+]
    cp $a0
    jp nc, FreeObjectAndRemoveHandler

    ld de, $000b
    add hl, de
    ld a, [hl]
    or a
    jr nz, SchedulePowerUpContainerHit

    ld de, CheckPowerUpContainerCollision
    jp SetCurrentHandlerAddress

SchedulePowerUpContainerHit:
    ld de, HandlePowerUpContainerHit
    jp SetCurrentHandlerAddress


CheckPowerUpContainerCollision:
    call CheckEnemyCollisionWithPlayer
    ld de, UpdatePowerUpContainerMovement
    jp SetCurrentHandlerAddress

HandlePowerUpContainerHit:
    ld a, [bc]
    call SetObjectPointer
    inc hl
    ld de, $ca34
    ld a, [hl+]
    ld [de], a
    inc de
    ld a, [hl]
    ld [de], a
    ld de, $0003
    add hl, de
    inc [hl]
    ld de, InitializeSmokeObject
    call StoreAddressInFreeWramSlot
    ld a, $22
    call AddPlayerScore
    ld hl, $732d
    ld a, $01
    call SetupAudioPlayback
    ld de, PowerUpContainerHiddenGraphics
    call SetObjectGraphicsPointer
    ld de, InitializePowerUpReveal
    jp SetCurrentHandlerAddress

InitializePowerUpReveal:
    ld a, [bc]
    call SetObjectPointer
    ld hl, $000e
    add hl, bc
    xor a
    ld [hl+], a
    ld [hl], a
    ld de, PowerUpContainerHiddenGraphics
    call SetObjectGraphicsPointer
    ld de, CheckPowerUpCollection
    jp SetCurrentHandlerAddress

CheckPowerUpCollection:
    ld a, [bc]
    call SetObjectPointer
    ld hl, $c786
    ld de, wCollisionPointY
    ld a, [hl+]
    ld [de], a
    inc de
    ld a, [hl]
    ld [de], a
    ld hl, wSelectedObjectPointer
    ld a, [hl+]
    ld h, [hl]
    ld l, a
    ld de, $0008
    add hl, de
    call CheckPointInHitbox
    ld a, c
    or a
    jr nz, SchedulePowerUpAward ; Player touching power up

    ld de, UpdatePowerUpStatus
    jp SetCurrentHandlerAddress


SchedulePowerUpAward:
    ld de, AwardPowerUp
    jp SetCurrentHandlerAddress


UpdatePowerUpStatus:
    ld a, [bc]
    call SetObjectPointer
    inc hl
    ld a, [hl]
    cp $a0
    jp nc, FreeObjectAndRemoveHandler

    ld hl, $000e
    add hl, bc
    ld a, [hl+]
    or a
    jr nz, SchedulePowerUpMovementAndAnimation

    inc [hl]
    ld a, [hl]
    and $03
    jr nz, SchedulePowerUpMovementAndAnimation

    dec hl
    inc [hl]
    ld de, PowerUpGraphicsFrame0
    call SetObjectGraphicsPointer

SchedulePowerUpMovementAndAnimation:
    ld de, UpdatePowerUpMovementAndAnimation
    jp SetCurrentHandlerAddress


UpdatePowerUpMovementAndAnimation:
    ld a, [bc]
    call SetObjectPointer
    ld a, $08
    call CalculateYMovement
    ld a, [$ca16]
    ld d, a
    ld e, $00
    call MoveObject
    ld hl, $001e
    add hl, bc
    ld a, [hl]
    inc a
    and $0f
    ld [hl], a
    jr z, SetPowerUpGraphicsFrame0

    cp $08
    jr nz, SchedulePowerUpCollection

    ld de, PowerUpGraphicsFrame1
    call SetObjectGraphicsPointer
    jr SchedulePowerUpCollection

SetPowerUpGraphicsFrame0:
    ld de, PowerUpGraphicsFrame0
    call SetObjectGraphicsPointer

SchedulePowerUpCollection:
    ld de, CheckPowerUpCollection
    jp SetCurrentHandlerAddress

AwardPowerUp:
    ld a, $22
    call AddPlayerScore
    ld hl, $5e5b
    ld a, $01
    call SetupAudioPlayback
    ld [$cfa0], a
    ld hl, wCurrentHandlerDataPointer
    ld a, [hl+]
    ld b, [hl]
    ld c, a
    ld a, [bc]
    call SetObjectPointer
    ld hl, $0013
    add hl, bc
    ld bc, wWeaponPowerLevel
    ld a, [bc]
    cp MAX_WEAPON_POWER_LEVEL
    jr z, AwardMaxPowerBonus

    inc a
    ld [bc], a
    ld [$ca2c], a
    jp FreeObjectAndRemoveHandler

AwardMaxPowerBonus:
    ld a, $82
    call AddPlayerScore
    jp FreeObjectAndRemoveHandler


    ld a, [bc]
    call SetObjectPointer
    ld a, $06
    call CalculateYMovement
    ld a, [$ca16]
    ld d, a
    ld e, $00
    call MoveObject
    jp AdvanceToNextHandler


; $1F8E: one row, two sprites
PowerUpContainerInitTemplate:
    db $12, $08, $08, $00, $fe, $10, $12, $00

PowerUpContainerGraphics: ; $1F96: two (tile, attributes) pairs
    db $3e, $00,  $3e, $20

PowerUpContainerHiddenGraphics: ; $1F9A: two blank sprites
    db $00, $00, $00, $00

PowerUpGraphicsFrame0: ; $1F9E
    db $04, $00, $06, $00

PowerUpGraphicsFrame1: ; $1FA2
    db $16, $00, $18, $00

    ld bc, $2022
    call TryInitializeObjectInFreeSlot
    or a
    jp z, RemoveCurrentHandler

    ld de, $1fb6
    jp SetCurrentHandlerAddress


    ld a, [bc]
    call SetObjectPointer
    ld de, $201e
    call InitializeMovementScriptFromTable
    ld de, $202a
    call SetObjectGraphicsPointer
    ld a, [wCurrentHandlerIndex]
    and $01
    jr z, jr_000_1fd3

    ld de, $2015
    jp SetCurrentHandlerAddress


jr_000_1fd3:
    ld de, $1fd9
    jp SetCurrentHandlerAddress


    call UpdateScriptedEnemyMovement
    ld d, $52
    cp [hl]
    jp c, Jump_000_0bbb

    ld hl, wSelectedObjectPointer
    ld a, [hl+]
    ld h, [hl]
    ld l, a
    inc hl
    ld a, [hl]
    cp $e0
    jp nc, FreeObjectAndRemoveHandler

    ld de, $1ff5
    jp SetCurrentHandlerAddress


    ld a, [bc]
    call SetObjectPointer
    call CheckEnemyShotTimer
    or a
    jr nz, jr_000_200f

jr_000_1fff:
    ld de, wEnemyShotSpawnY
    ld a, [de]

Call_000_2003:
    or a
    jr nz, jr_000_200f

    ld bc, $0800
    call StoreOffsetObjectPosition
    call $2288

jr_000_200f:
    ld de, $2015
    jp SetCurrentHandlerAddress


    call CheckEnemyCollisionWithPlayer
    ld de, $1fd9
    jp SetCurrentHandlerAddress


    ; $201E: movement script pointers
    dw $3629, $363f

    ; $2022: initialization template
    db $12, $08, $08, $00, $fe, $10, $12, $01

    ; $202A: graphics (tile, attributes)
    db $46, $00, $46, $20

InitializeTerraCannon:
    ld bc, TerraCannonInitTemplate
    call TryInitializeObjectInFreeSlot
    or a
    jp z, RemoveCurrentHandler

    ld de, ConfigureTerraCannon
    jp SetCurrentHandlerAddress

ConfigureTerraCannon:
    ld a, [bc]
    call SetObjectPointer
    ld de, TerraCannonGraphics
    call SetObjectGraphicsPointer
    ld a, [wCurrentHandlerIndex]
    and $01
    jr z, .setPositionHandler

    ld de, UpdateTerraCannonStatus
    jp SetCurrentHandlerAddress


.setPositionHandler
    ld de, UpdateTerraCannonPosition
    jp SetCurrentHandlerAddress


UpdateTerraCannonPosition:
    ld a, [bc]
    call SetObjectPointer
    ld a, [$ca81]
    or a
    jr nz, .stopMovement

    ld a, $08
    call CalculateYMovement
    ld a, [$ca16]
    jr .applyMovement

.stopMovement
    xor a

.applyMovement
    ld d, a
    ld e, $00
    call MoveObject
    ld de, TryFireTerraCannonShot
    jp SetCurrentHandlerAddress


TryFireTerraCannonShot:
    ld a, [bc]
    call SetObjectPointer
    call CheckEnemyShotTimer
    or a
    jr nz, .setStatusUpdateHandler

    ld de, wEnemyShotSpawnY
    ld a, [de]
    or a
    jr nz, .setStatusUpdateHandler

    ld bc, $0804
    call StoreOffsetObjectPosition
    ld de, TrySpawnEnemyProjectile
    call StoreAddressInFreeWramSlot

.setStatusUpdateHandler
    ld de, UpdateTerraCannonStatus
    jp SetCurrentHandlerAddress


UpdateTerraCannonStatus:
    ld a, [bc]
    call SetObjectPointer
    inc hl
    ld a, [hl+]
    cp $90
    jp nc, FreeObjectAndRemoveHandler

    ld de, $000a
    add hl, de
    ld d, $13
    ld a, [hl+]
    cp [hl]
    jp c, Jump_000_0bbb

    ld de, UpdateTerraCannonPosition
    jp SetCurrentHandlerAddress


TerraCannonInitTemplate:
    db $12, $08, $08, $00, $fe, $10, $12, $18

TerraCannonGraphics:
    db $50, $00, $50, $20

    ; $20C7: event $0D initializer
    ld bc, $20eb
    call TryInitializeObjectInFreeSlot
    or a
    jp z, RemoveCurrentHandler

    ld de, $20d7
    jp SetCurrentHandlerAddress


    ld a, [bc]
    call SetObjectPointer
    ld de, $20e7
    call InitializeMovementScriptFromTable
    ld de, $20f3
    jp SetEnemyGraphicsAndStartUpdateCycle


    ; $20E7: movement script pointers
    dw $3655, $3669

    ; $20EB: initialization template
    db $12, $08, $08, $00, $fe, $10, $12, $01

    ; $20F3: graphics (tile, attributes)
    db $52, $00, $52, $20

InitializeSkimbot:
    ld bc, SkimbotInitTemplate
    call TryInitializeObjectInFreeSlot
    or a
    jp z, RemoveCurrentHandler

    ld de, ConfigureSkimbot
    jp SetCurrentHandlerAddress

ConfigureSkimbot:
    ld a, [bc]
    call SetObjectPointer
    ld de, SkimbotMovementScript
    call InitializeMovementScript
    ld de, SkimbotGraphics

jr_000_2114:
    jp SetEnemyGraphicsAndStartUpdateCycle


SkimbotInitTemplate:
    db $12, $08, $08, $00, $fe, $10, $12, $01

SkimbotGraphics:
    db $54, $00, $54, $20

    ; $2123: event $26 initializer
    ld bc, $2143
    call TryInitializeObjectInFreeSlot
    or a
    jp z, RemoveCurrentHandler

    ld de, $2133
    jp SetCurrentHandlerAddress


    ld a, [bc]
    call SetObjectPointer
    ld de, $3687
    call InitializeMovementScript
    ld de, $214b
    jp SetEnemyGraphicsAndStartUpdateCycle


    ld [de], a
    ld [$0008], sp
    cp $10
    ld [de], a
    ld bc, $0040
    ld b, b
    jr nz, jr_000_2151

    ld [hl], e

jr_000_2151:
    ld hl, $47cd
    add hl, bc
    or a
    jp z, RemoveCurrentHandler

    ld de, $215f
    jp SetCurrentHandlerAddress


    ld a, [bc]
    call SetObjectPointer
    ld de, $216f
    call InitializeMovementScriptFromTable
    ld de, $217b
    jp SetEnemyGraphicsAndStartUpdateCycle


    ; $216F: movement script pointers
    dw $36a5, $36bd

    ; $2173: initialization template
    db $12, $08, $08, $00, $fe, $10, $12, $01

    ; $217B: graphics (tile, attributes)
    db $4c, $00, $4c, $20

InitializeMack:
    ld bc, MackInitTemplate
    call TryInitializeObjectInFreeSlot
    or a
    jp z, RemoveCurrentHandler

    ld de, ConfigureMack
    jp SetCurrentHandlerAddress

ConfigureMack:
    ld a, [bc]
    call SetObjectPointer
    ld de, MackMovementScript
    call InitializeMovementScript
    ld de, MackGraphics
    call SetObjectGraphicsPointer
    jp Jump_000_1cd6


MackInitTemplate:
    db $22, $10, $08, $00, $fe, $20, $12, $04

MackGraphics:
    db $4e, $00, $4e, $20, $62, $00, $62, $20

InitializeVexor:
    ld bc, VexorInitTemplate
    call TryInitializeObjectInFreeSlot
    or a
    jp z, RemoveCurrentHandler

    ld de, ConfigureVexor
    jp SetCurrentHandlerAddress


ConfigureVexor:
    ld a, [bc]
    call SetObjectPointer
    ld de, VexorMovementScriptTable
    call InitializeMovementScriptFromTable
    ld de, VexorGraphics
    call SetObjectGraphicsPointer
    ld a, [wCurrentHandlerIndex]
    and $01
    jr z, .setMovementHandler

    ld de, CheckVexorCollision
    jp SetCurrentHandlerAddress

.setMovementHandler
    ld de, UpdateVexorMovement
    jp SetCurrentHandlerAddress


UpdateVexorMovement:
    call UpdateScriptedEnemyMovement
    ld d, $32
    cp [hl]
    jp c, Jump_000_0bbb

    ld hl, wSelectedObjectPointer
    ld a, [hl+]
    ld h, [hl]
    ld l, a
    inc hl
    ld a, [hl]
    cp $90
    jp nc, FreeObjectAndRemoveHandler

    ld de, TryFireVexorShot
    jp SetCurrentHandlerAddress

TryFireVexorShot:
    ld a, [bc]
    call SetObjectPointer
    call CheckEnemyShotTimer
    or a
    jr nz, .setCollisionHandler

    ld a, [$ca6b]
    or a
    jr nz, .setCollisionHandler

    ld de, $ca63
    ld bc, $0804
    call StoreOffsetObjectPosition
    ld a, $03
    ld [de], a
    inc de
    xor a
    ld [de], a
    ld de, UpdateEnemyFiringSequence
    call StoreAddressInFreeWramSlot

.setCollisionHandler
    ld de, CheckVexorCollision
    jp SetCurrentHandlerAddress

CheckVexorCollision:
    call CheckEnemyCollisionWithPlayer
    ld de, UpdateVexorMovement
    jp SetCurrentHandlerAddress


VexorMovementScriptTable:
    dw VexorMovementScriptA, VexorMovementScriptB

VexorInitTemplate:
    db $12, $08, $08, $00, $fe, $10, $12, $02

VexorGraphics:
    db $56, $00, $56, $20

    ; $2245: event $2A initializer
    ld bc, $227c
    call TryInitializeObjectInFreeSlot
    or a
    jp z, RemoveCurrentHandler

    ld de, $2255
    jp SetCurrentHandlerAddress


    ld a, [bc]
    call SetObjectPointer
    ld de, $2278
    call InitializeMovementScriptFromTable
    ld de, $2284
    call SetObjectGraphicsPointer
    ld a, [wCurrentHandlerIndex]
    and $01
    jr z, jr_000_2272

    ld de, $1d1b
    jp SetCurrentHandlerAddress


jr_000_2272:
    ld de, $1cdc
    jp SetCurrentHandlerAddress


    dec c
    scf
    dec h
    scf
    ld [de], a
    ld [$0008], sp
    cp $10
    ld [de], a
    ld [bc], a
    ld e, b
    nop
    ld e, b
    jr nz, @+$13

    adc a
    ld [hl+], a
    call StoreAddressInFreeWramSlot
    ret


    ld bc, $2316
    ld hl, wEnemyShotSpawnY
    ld a, [hl+]
    ld e, [hl]
    ld d, a
    xor a
    ld [$caa4], a
    call FindFreeObjectSlot
    jp c, RemoveCurrentHandler

    ld hl, wCurrentHandlerDataPointer
    ld a, [hl+]
    ld d, [hl]
    ld e, a
    ld a, [wAllocatedObjectIndex]
    ld [de], a
    xor a
    ld hl, wEnemyShotSpawnY
    ld [hl+], a
    ld [hl+], a
    ld de, $22b8
    jp SetCurrentHandlerAddress


    ld a, [bc]
    call SetObjectPointer
    ld de, $231e
    call SetObjectGraphicsPointer
    ld a, [wCurrentHandlerIndex]
    and $01
    jr z, jr_000_22cf

    ld de, $230d
    jp SetCurrentHandlerAddress


jr_000_22cf:
    ld de, $22d5

jr_000_22d2:
    jp SetCurrentHandlerAddress


    ld a, [bc]
    call SetObjectPointer
    push hl
    ld d, $08
    ld e, $00
    call MoveObject
    pop hl
    ld de, $000c
    add hl, de
    ld d, $52
    ld a, [hl+]
    cp [hl]
    jp c, Jump_000_0bbb

    ld de, $22f3
    jp SetCurrentHandlerAddress


    call CheckObjectOutOfBounds
    or a
    jp nz, FreeObjectAndRemoveHandler

    ld de, $2300
    jp SetCurrentHandlerAddress


    call TryScheduleEnemyShot
    or a
    jp z, FreeObjectAndRemoveHandler

    ld de, $230d
    jp SetCurrentHandlerAddress


    call CheckEnemyCollisionWithPlayer
    ld de, $22d5
    jp SetCurrentHandlerAddress


    ld [de], a
    ld [$0008], sp
    nop
    db $10
    db $10
    ld [bc], a
    ld [de], a
    nop
    ld [de], a
    jr nz, jr_000_22d2

    ld hl, $cac0
    ld b, $10

jr_000_2328:
    ld [hl+], a
    dec b
    jr nz, jr_000_2328

    ld de, $2352
    call StoreAddressInFreeWramSlot
    ld b, $02

jr_000_2334:
    push bc
    ld de, $235e
    call StoreAddressInFreeWramSlot
    pop bc
    dec b
    jr nz, jr_000_2334

    ld b, $02

jr_000_2341:
    push bc
    ld de, $236a
    call StoreAddressInFreeWramSlot
    pop bc
    dec b
    jr nz, jr_000_2341

    ld de, $2700
    jp SetCurrentHandlerAddress


    ld bc, $2431
    call TryInitializeObjectInFreeSlot
    or a
    jp z, RemoveCurrentHandler

    jr jr_000_2374

    ld bc, $2439
    call TryInitializeObjectInFreeSlot
    or a
    jp z, RemoveCurrentHandler

    jr jr_000_2374

    ld bc, $2441
    call TryInitializeObjectInFreeSlot
    or a
    jp z, RemoveCurrentHandler

jr_000_2374:
    call $4690
    ld de, $237d
    jp SetCurrentHandlerAddress


    ld a, [bc]
    call SetObjectPointer
    ld hl, $0011
    add hl, bc
    ld a, [hl]
    push af
    ld hl, $0f4e
    call Call_000_0f2f
    pop af
    ld bc, $2431
    or a
    jr z, jr_000_239e

    ld bc, $2439
    cp $03
    jr c, jr_000_239e

    ld bc, $2441

jr_000_239e:
    call ResetObjectAttributes
    ld de, $23a7
    jp SetCurrentHandlerAddress


    ld a, [$caca]
    or a
    jp z, AdvanceToNextHandler

    ld a, [bc]
    call SetObjectPointer
    ld de, $000d
    add hl, de
    xor a
    ld [hl], a
    ld hl, $0011
    add hl, bc
    ld a, [hl]
    or a
    jr nz, jr_000_23c6

    ld de, $23cc
    jp SetCurrentHandlerAddress


jr_000_23c6:
    ld de, $46ad
    jp SetCurrentHandlerAddress


    ld a, [bc]
    call SetObjectPointer
    ld de, $000c
    add hl, de
    ld a, [hl+]
    cp [hl]
    jr c, jr_000_23e4

    ld de, $0000
    call MoveObject
    ld de, $23fd
    jp SetCurrentHandlerAddress


Jump_000_23e4:
jr_000_23e4:
    ld a, $01
    ld [$cac1], a
    ld [wPlayerInvincible], a
    ld de, DelayThenHideBackground
    call StoreAddressInFreeWramSlot
    ld a, $14
    call AddPlayerScore
    ld de, $2415
    jp SetCurrentHandlerAddress


    call CheckPlayerCenterInEnemyHitbox
    ld de, $2406
    jp SetCurrentHandlerAddress


    call Call_000_0a0c
    or a
    jr z, jr_000_240f

    ld [wScreenShakeRequested], a

jr_000_240f:
    ld de, $23cc
    jp SetCurrentHandlerAddress


    ld hl, $0018
    add hl, bc
    ld a, [hl]
    inc [hl]
    and $07
    jp nz, AdvanceToNextHandler

    call $46a2
    cp $07
    jp z, $46ea

    ld hl, $2449
    call $465d
    jp AdvanceToNextHandler


    ld [de], a
    ld [$fe08], sp
    cp $12
    inc d
    ld h, b

jr_000_2439:
    ld [hl-], a
    jr @+$0a

    nop
    nop
    jr nc, jr_000_2450

    ldh a, [rNR14]
    ld [$0010], sp
    nop
    db $10
    jr nz, jr_000_2439

    nop
    nop
    db $10
    db $10
    db $10
    ldh a, [$fff0]

jr_000_2450:
    db $10
    ldh a, [$fff0]
    nop
    jr nz, jr_000_2456

jr_000_2456:
    ldh [$ffaf], a
    ld hl, $cac0
    ld b, $10

jr_000_245d:
    ld [hl+], a
    dec b
    jr nz, jr_000_245d

    ld de, $2473
    call StoreAddressInFreeWramSlot
    ld de, $2700
    call StoreAddressInFreeWramSlot
    ld de, $27ad
    jp SetCurrentHandlerAddress


    ld bc, $24f7
    call TryInitializeObjectInFreeSlot
    or a
    jp z, RemoveCurrentHandler

    call $4690
    ld de, $2486
    jp SetCurrentHandlerAddress


    ld a, [bc]
    call SetObjectPointer
    xor a
    ld hl, $0f78
    call Call_000_0f2f
    ld bc, $24f7
    call ResetObjectAttributes
    ld de, $249d
    jp SetCurrentHandlerAddress


    ld a, [$caca]
    or a
    jp z, AdvanceToNextHandler

    ld a, [bc]
    call SetObjectPointer
    ld de, $000d
    add hl, de
    xor a
    ld [hl], a
    ld de, $24b4
    jp SetCurrentHandlerAddress


    ld a, [bc]
    call SetObjectPointer
    ld de, $000c
    add hl, de
    ld a, [hl+]
    cp [hl]
    jp c, Jump_000_23e4

    ld de, $0000
    call MoveObject
    ld a, $05
    ld [$ca2c], a
    ld de, $24d2
    jp SetCurrentHandlerAddress


    call CheckPlayerCenterInEnemyHitbox
    ld de, $24db
    jp SetCurrentHandlerAddress


    call Call_000_0a0c
    or a
    jr z, jr_000_24e4

    ld [wScreenShakeRequested], a

jr_000_24e4:
    ld hl, $c781
    ld a, [hl]
    cp $34
    jr nc, jr_000_24f1

    ld a, $01
    ld [wPlayerDeathRequested], a

jr_000_24f1:
    ld de, $24b4
    jp SetCurrentHandlerAddress


    ld [de], a
    ld [$0008], sp
    nop
    db $10
    db $10
    ld [hl], b
    xor a
    ld hl, $cac0
    ld b, $10

jr_000_2505:
    ld [hl+], a
    dec b
    jr nz, jr_000_2505

    ld [$cf99], a
    ld de, $251b
    call StoreAddressInFreeWramSlot
    ld de, $281c
    call StoreAddressInFreeWramSlot
    jp RemoveCurrentHandler


    ld bc, $25c9
    call TryInitializeObjectInFreeSlot
    or a
    jp z, RemoveCurrentHandler

    call $4690
    ld de, $252e
    jp SetCurrentHandlerAddress


    ld a, [bc]
    call SetObjectPointer
    xor a
    ld hl, $0fa0
    call Call_000_0f2f
    ld bc, $25c9
    call ResetObjectAttributes
    ld de, $2545
    jp SetCurrentHandlerAddress


    ld a, [$caca]
    or a
    jp z, AdvanceToNextHandler

    ld a, [bc]
    call SetObjectPointer
    ld de, $000d
    add hl, de
    xor a
    ld [hl], a
    ld de, $255c
    jp SetCurrentHandlerAddress


    ld a, [bc]
    call SetObjectPointer
    ld de, $000c
    add hl, de
    ld a, [hl+]
    cp [hl]
    jr c, jr_000_2574

    ld de, $0000
    call MoveObject
    ld de, $2590
    jp SetCurrentHandlerAddress


jr_000_2574:
    ld a, $01
    ld [$cac1], a
    ld [wPlayerInvincible], a
    ld de, DelayThenHideBackground
    call StoreAddressInFreeWramSlot
    ld a, $24
    call AddPlayerScore
    call IncrementPlayerLives
    ld de, $2415
    jp SetCurrentHandlerAddress


    push bc
    call CheckPlayerCenterInEnemyHitbox
    pop bc
    call Call_000_0a0c
    or a
    jr z, jr_000_259e

    ld [wScreenShakeRequested], a

jr_000_259e:
    ld de, $25a4
    jp SetCurrentHandlerAddress


    ld a, [bc]
    call SetObjectPointer
    call CheckEnemyShotTimer
    or a
    jr nz, jr_000_25c3

    ld de, $ca63
    ld bc, $0804
    call StoreOffsetObjectPosition
    ld a, $06
    ld [de], a
    inc de
    xor a
    ld [de], a
    ld de, UpdateEnemyFiringSequence
    call StoreAddressInFreeWramSlot

jr_000_25c3:
    ld de, $255c
    jp SetCurrentHandlerAddress


    ld [de], a
    ld [$0008], sp
    nop
    db $10
    db $10
    add b
    inc hl
    db $10
    inc c
    nop
    nop
    jr nz, jr_000_25f0

    ; $25D8: final byte of preceding data
    db $e0

UpdateUltraCrusherShotTimer:
    ld a, [$cac1]
    or a
    jp nz, RemoveCurrentHandler

    ld a, [bc]
    ld hl, $0004
    add hl, bc
    inc [hl]
    ld a, [hl]
    and $0f
    jp nz, AdvanceToNextHandler

    ld [hl], a
    ld de, TryFireUltraCrusherLaser

jr_000_25f0:
    jp SetCurrentHandlerAddress

TryFireUltraCrusherLaser:
    ld a, [$cf99]
    call SetObjectPointer
    inc hl
    inc hl
    ld a, [hl]
    add $10
    ld b, a
    ld de, $c782
    ld a, [de]
    add $10
    cp b
    jr c, .setFireHandler

    ld a, [de]
    sub $10
    cp b
    jr nc, .setFireHandler

    ld c, $18
    ld a, [de]
    add $04
    cp b
    jr nc, .trySpawnShot

    ld c, $00

.trySpawnShot
    ld b, $10
    ld de, wEnemyShotSpawnY
    ld a, [de]
    or a
    jr nz, .setFireHandler

    call StoreOffsetObjectPosition
    ld de, TrySpawnAlternateEnemyProjectile
    call StoreAddressInFreeWramSlot

.setFireHandler
    ld de, UpdateUltraCrusherShotTimer
    jp SetCurrentHandlerAddress


TryFireDestructorOrb:
    ld a, [$cac1]
    or a
    jp nz, RemoveCurrentHandler

    ld hl, $0002
    add hl, bc
    inc [hl]
    ld a, [hl]
    and $0f
    ld [hl], a
    jp nz, AdvanceToNextHandler

    ld de, InitializeDestructorOrb
    call StoreAddressInFreeWramSlot
    jp AdvanceToNextHandler

InitializeDestructorOrb:
    ld bc, DestructorOrbInitTemplate
    xor a
    ld d, a
    ld e, a
    ld [$caa4], a
    call FindFreeObjectSlot
    jp c, RemoveCurrentHandler

    ld hl, wCurrentHandlerDataPointer
    ld a, [hl+]
    ld h, [hl]
    ld l, a
    ld a, [wAllocatedObjectIndex]
    ld [hl], a
    ld de, ConfigureDestructorOrb
    jp SetCurrentHandlerAddress

ConfigureDestructorOrb:
    ld a, [bc]
    call SetObjectPointer
    ld hl, $0004
    add hl, bc
    ld a, [$cace]
    ld [hl], a
    inc a
    and $03
    ld [$cace], a
    ld a, [hl+]
    ld b, h
    ld c, l
    add a
    ld l, a
    ld h, $00
    ld de, DestructorOrbMovementTable
    add hl, de
    ld a, [hl+]
    ld [bc], a
    inc bc
    ld a, [hl]
    ld [bc], a
    ld hl, $ca63
    ld a, [hl+]
    ld e, [hl]
    ld d, a
    ld bc, DestructorOrbInitTemplate
    call ResetObjectAttributes
    ld de, DestructorOrbGraphics
    call SetObjectGraphicsPointer
    ld hl, wSelectedObjectPointer
    ld a, [hl+]
    ld h, [hl]
    ld l, a
    ld de, $000d
    add hl, de
    xor a
    ld [hl], a
    ld de, UpdateDestructorOrbMovement
    jp SetCurrentHandlerAddress

    ; 26b1
UpdateDestructorOrbMovement:
    ld a, [bc]
    call SetObjectPointer
    ld hl, $0005
    add hl, bc
    ld a, [hl+]
    ld e, [hl]
    ld d, a
    call MoveObject
    ld de, UpdateDestructorOrbStatus
    jp SetCurrentHandlerAddress

UpdateDestructorOrbStatus:
    call CheckObjectOutOfBounds
    or a
    jp nz, FreeObjectAndRemoveHandler

    ld hl, wSelectedObjectPointer
    ld a, [hl+]
    ld h, [hl]
    ld l, a
    ld de, $000c
    add hl, de
    ld d, $12
    ld a, [hl+]
    cp [hl]
    jp c, Jump_000_0bbb

    ld de, CheckDestructorOrbCollision
    jp SetCurrentHandlerAddress

CheckDestructorOrbCollision:
    call CheckEnemyCollisionWithPlayer
    ld de, UpdateDestructorOrbMovement
    jp SetCurrentHandlerAddress


DestructorOrbMovementTable:
    db $fc, $fc ; -4, -4: up-left
    db $04, $fc ; +4, -4: down-left
    db $04, $04 ; +4, +4: down-right
    db $fc, $04 ; -4, +4: up-right

    ; $26F4
DestructorOrbInitTemplate:
    db $12, $08, $08, $00, $00, $10, $10, $01

    ; $26FC
DestructorOrbGraphics:
    db $7a, $00, $7a, $20

    ; $2700
    ld a, [$caca]
    or a
    jp z, AdvanceToNextHandler

    ld hl, $0016
    add hl, bc
    xor a
    ld [hl], a
    ld de, $2713
    jp SetCurrentHandlerAddress


    ld hl, $0016
    add hl, bc
    inc [hl]
    ld a, [hl]
    and $07
    jr z, jr_000_2723

    ld de, $275c
    jp SetCurrentHandlerAddress


jr_000_2723:
    xor a
    ld b, a
    ld a, [wCurrentStage]
    cp $05
    jr z, jr_000_272e

    ld b, $03

jr_000_272e:
    ld a, b
    ld [hl], a
    ld de, $2736
    jp SetCurrentHandlerAddress


    ld de, wEnemyShotSpawnY
    ld a, [de]
    or a
    jr nz, jr_000_2756

    ld de, $278d
    ld bc, $0f58
    ld a, [wCurrentStage]
    cp $05
    jr nz, jr_000_274d

    ld bc, $0f80

jr_000_274d:
    call Call_000_2769
    ld de, TrySpawnEnemyProjectile
    call StoreAddressInFreeWramSlot

jr_000_2756:
    ld de, $275c
    jp SetCurrentHandlerAddress


    ld a, [$cac1]
    or a
    jp nz, RemoveCurrentHandler

    ld de, $2713
    jp SetCurrentHandlerAddress


Call_000_2769:
    ld hl, $cf99
    ld a, [hl]
    and $1f
    inc [hl]
    ld l, a
    ld h, $00
    add hl, de
    ld a, [hl]
    and $0f
    ld h, b
    ld l, c
    call Call_000_0f2f
    ld hl, wEnemyShotSpawnY
    ld a, d
    ld [hl+], a
    ld [hl], e
    inc hl
    ld a, [$cacc]
    ld [hl], a
    xor $01
    ld [$cacc], a
    ret


    dec b
    ld b, $03
    inc c
    ld a, [bc]
    ld [bc], a
    rrca
    rlca
    inc c
    inc b
    nop
    ld [bc], a
    ld [$0e0d], sp
    ld [bc], a
    inc bc
    ld [bc], a
    dec b
    ld bc, $0c09
    ld a, [bc]
    inc b
    dec bc
    rrca
    ld bc, $0009
    dec bc
    ld b, $0f
    ld a, [$caca]
    or a
    jp z, AdvanceToNextHandler

    ld hl, $0016
    add hl, bc
    xor a
    ld [hl], a
    ld [$cfa4], a
    ld de, $27c3
    jp SetCurrentHandlerAddress


    ld hl, $0016
    add hl, bc
    inc [hl]
    ld a, [hl]
    cp $0d
    jr z, jr_000_27d3

    ld de, $280b
    jp SetCurrentHandlerAddress


jr_000_27d3:
    xor a
    ld [hl], a
    ld de, $27db
    jp SetCurrentHandlerAddress


    ld de, wEnemyShotSpawnY
    ld a, [de]
    or a
    jr nz, jr_000_2805

    ld hl, $cfa4
    ld a, [hl]
    and $03
    inc [hl]
    ld de, $2818
    ld l, a
    ld h, $00
    add hl, de
    ld a, [hl]
    and $03
    ld hl, $0f7a
    call Call_000_0f2f
    ld hl, wEnemyShotSpawnY
    ld a, d
    ld [hl+], a
    ld [hl], e
    ld de, TrySpawnAlternateEnemyProjectile
    call StoreAddressInFreeWramSlot

jr_000_2805:
    ld de, $280b
    jp SetCurrentHandlerAddress


    ld a, [$cac1]
    or a
    jp nz, RemoveCurrentHandler

    ld de, $27c3
    jp SetCurrentHandlerAddress


    ld bc, $0102
    nop
    ld a, [$caca]
    or a
    jp z, AdvanceToNextHandler

    ld hl, $0016
    add hl, bc
    xor a
    ld [hl], a
    ld [$cf99], a
    ld de, $2832
    jp SetCurrentHandlerAddress


    ld hl, $0016
    add hl, bc
    ld a, [hl]
    inc a
    and $0f
    ld [hl], a
    jr z, jr_000_2843

    ld de, $2865
    jp SetCurrentHandlerAddress


jr_000_2843:
    ld de, $2849
    jp SetCurrentHandlerAddress


    ld de, wEnemyShotSpawnY
    ld a, [de]
    or a
    jr nz, jr_000_285f

    ld de, $2872
    ld bc, $0fa2
    call Call_000_2769
    ld de, TrySpawnEnemyProjectile
    call StoreAddressInFreeWramSlot

jr_000_285f:
    ld de, $2865
    jp SetCurrentHandlerAddress


    ld a, [$cac1]
    or a
    jp nz, RemoveCurrentHandler

    ld de, $2832
    jp SetCurrentHandlerAddress


    inc bc
    ld bc, $0002
    ld bc, $0302
    nop
    inc bc
    ld [bc], a
    nop
    ld bc, $0301
    ld [bc], a
    nop
    ld [bc], a
    nop
    nop
    ld [bc], a
    inc bc
    ld bc, $0103
    ld bc, $0302
    ld [bc], a
    ld bc, $0300
    nop
    ld a, [$cac8]
    or a
    jp z, AdvanceToNextHandler

    ld a, [bc]
    call SetObjectPointer
    ld de, PlayerSpriteData
    call SetObjectGraphicsPointer
    ld de, $28a9
    jp SetCurrentHandlerAddress


    ld a, [bc]
    call SetObjectPointer
    ld de, $f800
    call Call_000_0bf3
    ld hl, wCurrentHandlerDataPointer
    ld a, [hl+]
    ld h, [hl]
    ld l, a
    ld de, $000e
    add hl, de
    inc [hl]
    ld a, [hl]
    cp $60
    jp c, AdvanceToNextHandler

    xor a
    ld [hl], a
    ld de, $28cc
    jp SetCurrentHandlerAddress


    ld a, [bc]
    call SetObjectPointer
    ld de, $08f8
    call Call_000_0bf3
    ld hl, wCurrentHandlerDataPointer
    ld a, [hl+]
    ld h, [hl]
    ld l, a
    ld de, $000e
    add hl, de
    inc [hl]
    ld a, [hl+]
    cp $40
    jp c, AdvanceToNextHandler

    xor a
    ld [hl+], a
    ld [hl+], a
    ld de, $28f0
    jp SetCurrentHandlerAddress


    ld a, [bc]
    call SetObjectPointer
    ld hl, $000f
    add hl, bc
    ld a, [hl]
    xor $01
    ld [hl+], a
    jr nz, jr_000_28ff

    dec [hl]

jr_000_28ff:
    ld a, [hl]
    call CalculateYMovement
    ld hl, $ca16
    ld d, [hl]
    ld e, $00
    call MoveObject
    ld hl, wSelectedObjectPointer
    ld a, [hl+]
    ld h, [hl]
    ld l, a
    inc hl
    ld a, [hl]
    cp $a0
    jp c, AdvanceToNextHandler

    ld a, $01
    ld hl, $cac6
    ld [hl+], a
    ld [hl], a
    ld a, [wCurrentStage]
    cp $06
    jr z, jr_000_292d

jr_000_2927:
    ld de, $293a
    jp SetCurrentHandlerAddress


jr_000_292d:
    ld a, [$ca22]
    cp $0f
    jr nz, jr_000_2927

    ld de, $2983
    jp SetCurrentHandlerAddress


    ; 293a
    ; Wait for player entrance?
    ld a, [wStageReady]
    or a
    jp z, AdvanceToNextHandler

    ; called right before player enters
    ld de, $2947
    jp SetCurrentHandlerAddress


    ; 2947
    ld a, [bc] ; bc is pointing to C100 which is 0
    call SetObjectPointer
    ld de, $000f
    add hl, de 
    xor a
    ld [hl], a ; set last byte of object to 0
    ld bc, PlayerInitTemplate
    ld de, $a050
    call ResetObjectAttributes
    ld de, PlayerSpriteData
    call SetObjectGraphicsPointer
    ld de, $2966
    jp SetCurrentHandlerAddress

    ; 2966
    ld a, [bc]
    call SetObjectPointer
    ld de, $ff00 ; FF is like -1 since adding causes wrap around, 00 is of course, 0
    call MoveObject
    ld hl, wSelectedObjectPointer
    ld a, [hl+]
    ld h, [hl]
    ld l, a
    inc hl
    ld a, [hl]
    cp $60
    jp nz, AdvanceToNextHandler

    ld de, PlayerMovementHandler
    jp SetCurrentHandlerAddress


    ld a, [$ca2d]
    or a
    jp z, AdvanceToNextHandler

    ld de, $2990
    jp SetCurrentHandlerAddress


    ld a, [bc]
    call SetObjectPointer
    ld de, $000f
    add hl, de
    xor a
    ld [hl], a
    ld bc, PlayerInitTemplate
    ld de, $3c98
    call ResetObjectAttributes
    ld de, $2af0
    call SetObjectGraphicsPointer
    ld de, $29af
    jp SetCurrentHandlerAddress


    ld a, [wStageReady]
    or a
    jp z, AdvanceToNextHandler

    ld de, $29bc
    jp SetCurrentHandlerAddress


    ldh a, [rSCX]
    cp $11
    jp nc, AdvanceToNextHandler

    ld de, $29c9
    jp SetCurrentHandlerAddress


    ld a, [bc]
    call SetObjectPointer
    ld a, $f8
    call CalculateXMovement
    ld a, [$ca17]
    ld e, a
    ld d, $00
    call MoveObject
    ld hl, wSelectedObjectPointer
    ld a, [hl+]
    ld h, [hl]
    ld l, a
    inc hl
    inc hl
    ld a, [hl]
    cp $38
    jp nc, AdvanceToNextHandler

    ld de, $3207
    call StoreAddressInFreeWramSlot
    jp FreeObjectAndRemoveHandler


InitializeStageAnnouncement:
    ld bc, StageAnnouncementObjectTemplate
    call TryInitializeObjectInFreeSlot
    or a
    jp z, RemoveCurrentHandler

    ld de, ConfigureStageAnnouncement
    jp SetCurrentHandlerAddress

ConfigureStageAnnouncement:
    ld a, [bc]
    call SetObjectPointer
    ld bc, StageAnnouncementObjectTemplate
    ld de, $3040
    call ResetObjectAttributes
    ld a, [wCurrentStage]
    dec a
    add a
    ld l, a
    ld h, $00
    ld de, StageAnnouncementGraphicsTable
    add hl, de
    ld a, [hl+]
    ld d, [hl]
    ld e, a
    call SetObjectGraphicsPointer
    ld de, WaitForStageAnnouncementDismissal
    jp SetCurrentHandlerAddress


WaitForStageAnnouncementDismissal:
    ld a, [wStageReady]
    or a
    jp z, AdvanceToNextHandler

    ld [wStageReady], a
    jp FreeObjectAndRemoveHandler


StageAnnouncementObjectTemplate:
    db $27, $08, $08, $00, $00, $10, $10, $01,
    
StageAnnouncementGraphicsTable: ; $2A3C
    dw Stage1AnnouncementGraphics ; Stage 1
    dw Stage2AnnouncementGraphics ; Stage 2
    dw Stage3AnnouncementGraphics ; Stage 3
    dw Stage4AnnouncementGraphics ; Stage 4
    dw Stage5AnnouncementGraphics ; Stage 5
    dw Stage6AnnouncementGraphics ; Stage 6

; Each stage: 28 bytes, two rows of seven (tile, attributes) pairs.
Stage1AnnouncementGraphics: ; $2A48
    db $d8, $00,  $da, $00,  $b4, $00,  $c0, $00,  $bc, $00,  $00, $00,  $a2, $00 ; Row 1
    db $00, $00,  $d6, $00,  $bc, $00,  $b4, $00,  $ba, $00,  $e4, $00,  $00, $00 ; Row 2

Stage2AnnouncementGraphics: ; $2A64
    db $d8, $00,  $da, $00,  $b4, $00,  $c0, $00,  $bc, $00,  $00, $00,  $a4, $00 ; Row 1
    db $00, $00,  $d6, $00,  $bc, $00,  $b4, $00,  $ba, $00,  $e4, $00,  $00, $00 ; Row 2

Stage3AnnouncementGraphics: ; $2A80
    db $d8, $00,  $da, $00,  $b4, $00,  $c0, $00,  $bc, $00,  $00, $00,  $a6, $00 ; Row 1
    db $00, $00,  $d6, $00,  $bc, $00,  $b4, $00,  $ba, $00,  $e4, $00,  $00, $00 ; Row 2

Stage4AnnouncementGraphics: ; $2A9C
    db $d8, $00,  $da, $00,  $b4, $00,  $c0, $00,  $bc, $00,  $00, $00,  $a8, $00 ; Row 1
    db $00, $00,  $d6, $00,  $bc, $00,  $b4, $00,  $ba, $00,  $e4, $00,  $00, $00 ; Row 2

Stage5AnnouncementGraphics: ; $2AB8
    db $d8, $00,  $da, $00,  $b4, $00,  $c0, $00,  $bc, $00,  $00, $00,  $aa, $00 ; Row 1
    db $00, $00,  $d6, $00,  $bc, $00,  $b4, $00,  $ba, $00,  $e4, $00,  $00, $00 ; Row 2

Stage6AnnouncementGraphics: ; $2AD4
    db $d8, $00,  $da, $00,  $b4, $00,  $c0, $00,  $bc, $00,  $00, $00,  $ac, $00 ; Row 1
    db $00, $00,  $d6, $00,  $bc, $00,  $b4, $00,  $ba, $00,  $e4, $00,  $00, $00 ; Row 2

    ld [bc], a
    nop
    inc b
    nop

    ld hl, wCurrentHandlerDataPointer
    ld a, [hl+]
    ld h, [hl]
    ld l, a
    inc [hl]
    ld a, [hl]
    cp $40
    jp c, AdvanceToNextHandler

    ld a, $01
    ld [wStageTransitionActive], a
    ld bc, $2b6d
    call TryInitializeObjectInFreeSlot
    or a
    jp z, RemoveCurrentHandler

    ld a, [$cf9a]
    call StopAudioPlayback
    ld a, [wWeaponPowerLevel]
    ld [$ca2c], a
    ld de, $2b22
    jp SetCurrentHandlerAddress


    ld a, [bc]
    call SetObjectPointer
    ld bc, $2b6d
    ld de, $3040
    call ResetObjectAttributes
    ld de, $2b75
    call SetObjectGraphicsPointer
    ld de, $2b3b
    jp SetCurrentHandlerAddress


    ld a, [$cac7]
    or a
    jp z, AdvanceToNextHandler

    call Call_000_0c04
    or a
    jp nz, AdvanceToNextHandler

    inc a
    ld [$cacb], a
    ld de, $2b53
    jp SetCurrentHandlerAddress


    ld a, [$cac6]
    or a
    jp z, AdvanceToNextHandler

    ld hl, wCurrentHandlerDataPointer
    ld a, [hl+]
    ld b, [hl]
    ld c, a
    ld a, [bc]
    call SetObjectPointer
    ld de, $0de6
    call StoreAddressInFreeWramSlot
    jp FreeObjectAndRemoveHandler


    db $25, $08, $08, $00, $00, $10, $10, $01, $ce, $00, $bc, $00, $e2, $00, $da, $00
    db $00, $00, $d8, $00, $da, $00, $b4, $00, $c0, $00, $bc, $00

    adc $00
    cp h
    nop
    ldh [c], a
    nop
    jp c, RST_00

    nop
    nop
    nop
    nop
    nop
    nop
    nop
    ret c

    nop
    jp c, $b400

    nop
    ret nz

    nop
    cp h
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    call z, $b400
    nop
    cp d
    nop
    nop
    nop
    ret c

    nop
    cp h
    nop
    or h
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    ret nz

    nop
    call c, $ce00
    nop
    cp b
    nop
    call nz, $da00
    nop
    db $e4
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    cp d
    nop
    or h
    nop
    sub $00
    ret z

    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    cp b
    nop
    or h
    nop
    sbc $00
    cp h
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    cp [hl]
    nop
    ret nc

    nop
    sub $00
    jp c, $d600

    nop
    cp h
    nop
    ret c

    nop
    ret c

    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    cp [hl]
    nop
    call nz, $ce00
    nop
    or h
    nop
    jp z, RST_00

    nop
    nop
    nop
    nop
    nop
    call z, $c400
    nop
    ret c

    nop
    ret c

    nop
    call nz, $d000
    nop
    adc $00
    nop
    nop

    ld a, [wPlayerLives]
    or a
    jr z, jr_000_2c59

    xor a
    ld [wPlayerLives], a
    ld de, $165e
    jp SetCurrentHandlerAddress


jr_000_2c59:
    xor a
    ld [$cf97], a
    ld de, $06f1
    jp SetCurrentHandlerAddress


    ld a, [wJoypadHeld]
    and $08
    jp z, AdvanceToNextHandler

    ld a, $01
    ld [wStartAlreadyHeld], a
    ld [wSelectAlreadyHeld], a
    ld [$cf98], a
    jp RemoveCurrentHandler


Call_000_2c79:
    ld c, $08
    ld de, wPlayerScore
    ld hl, wHighScore

jr_000_2c81:
    ld a, [de]
    cp [hl]
    ret c

    jr nz, jr_000_2c8c

    inc de
    inc hl
    dec c
    jr nz, jr_000_2c81

    ret


jr_000_2c8c:
    ld c, $08
    ld hl, wPlayerScore
    ld de, wHighScore

jr_000_2c94:
    ld a, [hl+]
    ld [de], a
    inc de
    dec c
    jr nz, jr_000_2c94

    ret


    db $99, $cf, $09, $c0, $b4, $cc, $bc, $00, $d0, $de, $bc, $d6, $00, $9a, $0f, $09
    db $da, $d0, $d2, $00, $d8, $b8, $d0, $d6, $bc, $00, $9a, $71, $05, $d8, $b8, $d0
    db $d6, $bc, $00

    ld hl, wCurrentHandlerDataPointer
    ld a, [hl+]
    ld h, [hl]
    ld l, a
    inc [hl]
    ld a, [hl]
    cp $40
    jp c, AdvanceToNextHandler

    ld a, $01
    ld [wStageTransitionActive], a
    ld a, [$cf9a]
    call StopAudioPlayback
    call Call_000_2c79
    ld de, $2cdf
    jp SetCurrentHandlerAddress


    ld a, [$cac7]
    or a
    jp z, AdvanceToNextHandler

    ld [$cacb], a
    ld de, $2cef
    jp SetCurrentHandlerAddress


    ld a, [$cac6]
    or a
    jp z, AdvanceToNextHandler

    ld hl, wCurrentHandlerDataPointer
    ld a, [hl+]
    ld b, [hl]
    ld c, a
    ld a, [bc]
    call SetObjectPointer
    ld de, $0de6
    call StoreAddressInFreeWramSlot
    jp RemoveCurrentHandler


    ld bc, $2f9b
    call TryInitializeObjectInFreeSlot
    or a
    jp z, RemoveCurrentHandler

    ld de, $2d19
    jp SetCurrentHandlerAddress


    ld a, [bc]
    call SetObjectPointer
    ld bc, $2f9b
    ld de, $6872
    call ResetObjectAttributes
    ld de, $2fa3
    call SetObjectGraphicsPointer
    ld de, $2d32
    jp SetCurrentHandlerAddress


    ld hl, $0010
    add hl, bc
    inc [hl]
    ld a, [hl]
    and $ff
    jp nz, AdvanceToNextHandler

    ld de, $2d43
    jp SetCurrentHandlerAddress


    ld a, [bc]
    call SetObjectPointer
    ld hl, $001c
    add hl, bc
    inc [hl]
    ld a, [hl]
    and $07
    ld [hl+], a
    jp nz, AdvanceToNextHandler

    ld a, [hl]
    inc [hl]
    cp $07
    jp z, FreeObjectAndRemoveHandler

    push hl
    ld hl, $2fc7
    call $465d
    pop hl
    ld a, [hl]
    cp $04
    jp nz, AdvanceToNextHandler

    ld de, $2d71
    call StoreAddressInFreeWramSlot
    jp AdvanceToNextHandler


    ld bc, $2faf
    call TryInitializeObjectInFreeSlot
    or a
    jp z, RemoveCurrentHandler

    ld de, $2d81
    jp SetCurrentHandlerAddress


    ld a, [bc]
    call SetObjectPointer
    ld hl, $0008
    add hl, bc
    xor a
    ld [hl+], a
    ld [hl], a
    ld hl, $0018
    add hl, bc
    ld bc, $2faf
    ld de, $606a
    call ResetObjectAttributes
    ld de, $2fb7
    call SetObjectGraphicsPointer
    ld de, $2da5
    jp SetCurrentHandlerAddress


    ld a, [bc]
    call SetObjectPointer
    inc hl
    ld a, [hl]
    cp $f0
    jr nc, jr_000_2dbf

    ld hl, $0008
    add hl, bc
    ld a, [hl+]
    ld e, [hl]
    ld d, a
    call Call_000_0bf3
    ld de, $2dd5
    jp SetCurrentHandlerAddress


jr_000_2dbf:
    call ClearSelectedObject
    ld a, [$ca22]
    cp $0f
    jr nz, jr_000_2dcf

    ld de, $2ded
    jp SetCurrentHandlerAddress


jr_000_2dcf:
    ld de, $2e5b
    jp SetCurrentHandlerAddress


    ld a, [bc]
    call SetObjectPointer
    ld hl, $0007
    add hl, bc
    ld a, [hl]
    inc a
    and $03
    ld [hl+], a
    jr nz, jr_000_2de7

    dec [hl]
    inc hl
    dec [hl]

jr_000_2de7:
    ld de, $2da5
    jp SetCurrentHandlerAddress


    ld hl, $0018
    add hl, bc
    xor a
    ld [hl], a
    ld a, $0e
    ld [$cad6], a
    ld de, $2fdb
    ld hl, $cad2
    ld a, e
    ld [hl+], a
    ld [hl], d
    ld de, $9a2e
    ld a, e
    ld hl, $cad4
    ld [hl+], a
    ld [hl], d
    ld a, $01
    ld [$cad0], a
    ld [$cad8], a
    ld de, $2e18
    jp SetCurrentHandlerAddress


    ld a, [$cad0]
    or a
    jp nz, AdvanceToNextHandler

    ld a, $0e
    ld [$cad6], a
    ld de, $2fe9
    ld hl, $cad2
    ld a, e
    ld [hl+], a
    ld [hl], d
    ld de, $9a4e
    ld a, e
    ld hl, $cad4
    ld [hl+], a
    ld [hl], d
    ld a, $01
    ld [$cad0], a
    ld [$cad8], a
    ld de, $2e44
    jp SetCurrentHandlerAddress


    ld a, [$cad0]
    or a
    jp nz, AdvanceToNextHandler

    ld hl, $0018
    add hl, bc
    inc [hl]
    ld a, [hl]
    or a
    jp nz, AdvanceToNextHandler

    ld de, $0de6
    jp SetCurrentHandlerAddress


    ld hl, $0018
    add hl, bc
    xor a
    ld [hl], a
    ld a, $0e
    ld [$cad6], a
    ld de, $2ff7
    ld hl, $cad2
    ld a, e
    ld [hl+], a
    ld [hl], d
    ld de, $9a2e
    ld a, e
    ld hl, $cad4
    ld [hl+], a
    ld [hl], d
    ld a, $01
    ld [$cad0], a
    ld [$cad8], a
    ld de, $2e86
    jp SetCurrentHandlerAddress


    ld a, [$cad0]
    or a
    jp nz, AdvanceToNextHandler

    ld a, $0e
    ld [$cad6], a
    ld de, $3005
    ld hl, $cad2
    ld a, e
    ld [hl+], a
    ld [hl], d
    ld de, $9a4e
    ld a, e
    ld hl, $cad4
    ld [hl+], a
    ld [hl], d
    ld a, $01
    ld [$cad0], a
    ld [$cad8], a
    ld de, $2eb2
    jp SetCurrentHandlerAddress


    ld a, [$cad0]
    or a
    jp nz, AdvanceToNextHandler

    ld hl, $0018
    add hl, bc
    inc [hl]
    ld a, [hl]
    or a
    jp nz, AdvanceToNextHandler

    ld de, $0de6
    jp SetCurrentHandlerAddress


    ld de, $3019
    call StoreAddressInFreeWramSlot
    ld de, $2ed5
    jp SetCurrentHandlerAddress


    ld a, [wStageReady]
    or a
    jp z, AdvanceToNextHandler

    ld hl, wBackgroundScrollTimer
    ld a, [hl]
    or a
    jp nz, AdvanceToNextHandler

    ld hl, $ff43
    dec [hl]
    ld a, [hl]
    cp $11
    jp nc, AdvanceToNextHandler

    jp RemoveCurrentHandler


    ld bc, $2f8d
    call TryInitializeObjectInFreeSlot
    or a
    jp z, RemoveCurrentHandler

    ld de, $2f01
    jp SetCurrentHandlerAddress


    ld a, [bc]
    call SetObjectPointer
    ld bc, $2f8d
    ld de, $a048
    call ResetObjectAttributes
    ld de, $2f95
    call SetObjectGraphicsPointer
    ld de, $2f1a
    jp SetCurrentHandlerAddress


    ld a, [bc]
    call SetObjectPointer
    inc hl
    ld a, [hl]
    cp $30
    jr c, jr_000_2f37

    ld d, b
    ld e, c
    ld a, $fc
    call CalculateYMovement
    ld a, [$ca16]
    ld d, a
    ld e, $00
    call MoveObject
    jp AdvanceToNextHandler


jr_000_2f37:
    ld de, $2f3d
    jp SetCurrentHandlerAddress


    ld hl, $caf0
    ld de, $3013
    ld b, $06

jr_000_2f45:
    ld a, [de]
    ld [hl+], a
    inc de
    dec b
    jr nz, jr_000_2f45

    ld hl, $caf6
    ld de, wPlayerScore
    ld b, $07

jr_000_2f53:
    ld a, [de]
    or $f0
    ld [hl+], a
    inc de
    dec b
    jr nz, jr_000_2f53

    ld a, $0e
    ld [$cad6], a
    ld de, $caf0
    ld hl, $cad2
    ld a, e
    ld [hl+], a
    ld [hl], d
    ld de, $9a25
    ld a, e
    ld hl, $cad4
    ld [hl+], a
    ld [hl], d
    ld a, $01
    ld [$cad0], a
    ld [$cad8], a
    ld [wHardModeUnlocked], a
    ld [$cab9], a
    ld a, [wGameMode]
    or a
    jp z, RemoveCurrentHandler

    ld [$ca2f], a
    jp RemoveCurrentHandler


    inc de
    ld [$0008], sp
    nop
    db $10
    db $10
    ld bc, $00bc
    adc $00
    cp d
    nop
    inc de
    ld [$0008], sp
    nop
    db $10
    db $10
    ld bc, $0080
    add d
    nop
    add h
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    inc h
    ld [$0008], sp
    nop
    db $10
    db $10
    ld bc, $005a
    ld e, h
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    ld e, [hl]
    nop
    ld h, b
    nop
    inc b
    inc b
    nop
    inc b
    inc b
    nop
    nop
    db $fc
    db $fc
    nop
    nop
    nop
    db $fc
    db $fc
    db $fc
    inc b
    nop
    inc b
    inc b
    db $fc
    cp [hl]
    call nz, $b4ce
    jp z, $ccbf

    call nz, $d8d8
    call nz, $ced0
    cp a
    cp a
    cp a
    cp a
    call nz, $bfd8
    ret nc

    sbc $bc
    sub $bf
    cp a
    cp a
    cp a
    cp [hl]
    call nz, $b4ce
    jp z, $ccbf

    call nz, $d8d8
    call nz, $ced0
    cp a
    call nz, $bfd8
    ret nc

    sbc $bc
    sub $bf
    cp a
    cp a
    cp a
    cp a
    cp a
    cp a
    ret c

    cp b
    ret nc

    sub $bc
    cp a
    ld de, $3040
    call StoreAddressInFreeWramSlot
    ld de, $30d9
    call StoreAddressInFreeWramSlot
    ld a, $01
    ld [$ca2d], a
    ld de, $3030
    jp SetCurrentHandlerAddress


    ld bc, $31ba
    call TryInitializeObjectInFreeSlot
    or a
    jp z, RemoveCurrentHandler

    ld de, $3050
    jp SetCurrentHandlerAddress


    ld bc, $31bb
    call TryInitializeObjectInFreeSlot
    or a
    jp z, RemoveCurrentHandler

    ld de, $3069
    jp SetCurrentHandlerAddress


    ld a, [bc]
    call SetObjectPointer
    ld bc, $31ba
    ld de, $30e1
    call ResetObjectAttributes
    ld de, $31bc
    call SetObjectGraphicsPointer
    ld de, $3082
    jp SetCurrentHandlerAddress


    ld a, [bc]
    call SetObjectPointer
    ld bc, $31bb
    ld de, $4000
    call ResetObjectAttributes
    ld de, $31d4
    call SetObjectGraphicsPointer
    ld de, $3082
    jp SetCurrentHandlerAddress


    ld hl, wBackgroundScrollTimer
    ld a, [hl]
    or a
    jp nz, AdvanceToNextHandler

    ldh a, [rSCX]
    cp $12
    jp c, Jump_000_309e

    ld a, [bc]
    call SetObjectPointer
    ld de, $0001
    call MoveObject
    jp AdvanceToNextHandler


Jump_000_309e:
    ld de, $30a4
    jp SetCurrentHandlerAddress


    ld a, [$ca1c]
    or a
    jp z, AdvanceToNextHandler

    ld de, $30b1
    jp SetCurrentHandlerAddress


    ld a, [bc]
    call SetObjectPointer
    inc hl
    inc hl
    ld a, [hl]
    cp $c0
    jp nc, FreeObjectAndRemoveHandler

    ld hl, $0004
    add hl, bc
    ld a, [hl]
    inc [hl]
    inc hl
    and $07
    jr nz, jr_000_30c9

    inc [hl]

jr_000_30c9:
    ld a, [hl]
    call CalculateXMovement
    ld a, [$ca17]
    ld e, a
    ld d, $00
    call MoveObject
    jp AdvanceToNextHandler


    ld a, [$ca1b]
    or a
    jp z, AdvanceToNextHandler

    ld bc, $31dc
    call TryInitializeObjectInFreeSlot
    or a
    jp z, RemoveCurrentHandler

    ld de, $30f0
    jp SetCurrentHandlerAddress


    ld a, [bc]
    call SetObjectPointer
    ld bc, $31dc
    ld de, $4012
    call ResetObjectAttributes
    ld de, $3103
    jp SetCurrentHandlerAddress


    ld a, [bc]
    call SetObjectPointer
    inc bc
    ld a, [bc]
    inc a
    and $03
    ld [bc], a
    jp nz, AdvanceToNextHandler

    inc bc
    ld l, c
    ld h, b
    ld a, [hl]
    inc [hl]
    cp $04
    jr z, jr_000_312c

    and $01
    add a
    ld l, a
    ld h, $00
    ld de, $31dd
    add hl, de
    ld a, [hl+]
    ld d, [hl]
    ld e, a
    call SetObjectGraphicsPointer
    jp AdvanceToNextHandler


jr_000_312c:
    xor a
    ld [bc], a
    ld de, $3134
    jp SetCurrentHandlerAddress


    ld a, [bc]
    call SetObjectPointer
    inc bc
    ld a, [bc]
    inc a
    and $03
    ld [bc], a
    jp nz, AdvanceToNextHandler

    inc bc
    ld l, c
    ld h, b
    ld a, [hl]
    inc [hl]
    cp $03
    jr z, jr_000_315b

    add a
    ld l, a
    ld h, $00
    ld de, $31e1
    add hl, de
    ld a, [hl+]
    ld d, [hl]
    ld e, a
    call SetObjectGraphicsPointer
    jp AdvanceToNextHandler


jr_000_315b:
    xor a
    ld [bc], a
    inc a
    ld [$ca1c], a
    ld de, $3167
    jp SetCurrentHandlerAddress


    ld a, [bc]
    call SetObjectPointer
    inc hl
    inc hl
    ld a, [hl]
    cp $c0
    jp nc, Jump_000_31ad

    ld hl, $0004
    add hl, bc
    ld a, [hl]
    inc [hl]
    inc hl
    and $07
    jr nz, jr_000_317f

    inc [hl]

jr_000_317f:
    ld a, [hl]
    call CalculateXMovement
    ld a, [$ca17]
    ld e, a
    ld d, $00
    call MoveObject
    inc bc
    ld a, [bc]
    inc a
    and $03
    ld [bc], a
    jp nz, AdvanceToNextHandler

    inc bc
    ld l, c
    ld h, b
    ld a, [hl]
    xor $01
    ld [hl], a
    add a
    ld l, a
    ld h, $00
    ld de, $31e7
    add hl, de
    ld a, [hl+]
    ld d, [hl]
    ld e, a
    call SetObjectGraphicsPointer
    jp AdvanceToNextHandler


Jump_000_31ad:
    ld a, [bc]
    call SetObjectPointer
    ld de, $2ef1
    call StoreAddressInFreeWramSlot
    jp FreeObjectAndRemoveHandler


    inc [hl]
    inc d
    ld b, $00
    ld [$0a00], sp
    nop
    inc c
    nop
    ld c, $00
    stop
    ld [de], a
    nop
    inc d
    nop
    ld d, $00
    jr jr_000_31d0

jr_000_31d0:
    ld a, [de]
    nop
    inc e
    nop
    ld e, $00
    jr nz, jr_000_31d8

jr_000_31d8:
    ld [hl+], a
    nop
    inc h
    nop
    ld [de], a
    db $eb
    ld sp, $31ef
    di
    ld sp, $31f7
    ei
    ld sp, $31ff
    inc bc
    ld [hl-], a
    nop
    nop
    ld h, $00
    nop
    nop
    jr z, jr_000_31f3

jr_000_31f3:
    nop
    nop
    ld a, [hl+]
    nop
    nop
    nop
    inc l
    nop
    ld l, $00
    jr nc, jr_000_31ff

jr_000_31ff:
    ld [hl-], a
    nop
    inc [hl]
    nop
    ld [hl], $00
    jr c, jr_000_3207

jr_000_3207:
    ld hl, $0004
    add hl, bc
    inc [hl]
    ld a, [hl]
    or a
    jp nz, AdvanceToNextHandler

    xor a
    ld [$cad8], a
    ld de, $321b
    jp SetCurrentHandlerAddress


    call Call_000_32ab
    ld a, $90
    ldh [rWX], a
    ld de, $3228
    jp SetCurrentHandlerAddress


    ld a, [$cad0]
    or a
    jp nz, AdvanceToNextHandler

    call Call_000_32ab
    ld a, [$cad8]
    cp $02
    jr z, jr_000_3264

    cp $05
    jr z, jr_000_3264

    cp $08
    jr z, jr_000_3264

    cp $0a
    jr z, jr_000_3264

    cp $0d
    jr z, jr_000_3264

    cp $0f
    jr z, jr_000_3264

    cp $12
    jr z, jr_000_3264

    cp $14
    jr z, jr_000_3264

    cp $16
    jr z, jr_000_3264

    cp $18
    jr z, jr_000_3264

    cp $1c
    jr z, jr_000_3264

    jp AdvanceToNextHandler


jr_000_3264:
    ld de, $326a
    jp SetCurrentHandlerAddress


    ld a, [$cad0]
    or a
    jp nz, AdvanceToNextHandler

    ld hl, $cad1
    ld a, [hl]
    inc a
    ld [hl], a
    and $03
    jp nz, AdvanceToNextHandler

    ld hl, $ff4b
    dec [hl]
    ld a, [hl]
    cp $08
    jp nc, AdvanceToNextHandler

    ld de, $328c
    jp SetCurrentHandlerAddress


    ld hl, $cad8
    ld a, [hl+]
    cp $1c
    jr nz, jr_000_329c

    ld a, $01
    ld [$ca1b], a
    jp RemoveCurrentHandler


jr_000_329c:
    inc [hl]
    ld a, [hl]
    cp $e0
    jp nz, AdvanceToNextHandler

    xor a
    ld [hl], a
    ld de, $321b
    jp SetCurrentHandlerAddress


Call_000_32ab:
    ld a, [$cad8]
    ld b, a
    ld a, $11
    ld [$cad6], a
    ld a, b
    add a
    ld l, a
    ld h, $00
    ld de, $3315
    add hl, de
    ld a, [hl+]
    ld e, [hl]
    ld hl, $cad2
    ld [hl+], a
    ld [hl], e
    ld a, b
    add a
    ld l, a
    ld h, $00
    ld de, $32dd
    add hl, de
    ld a, [hl+]
    ld e, [hl]
    ld hl, $cad4
    ld [hl+], a
    ld [hl], e
    ld a, b
    inc a
    ld [$cad0], a
    ld [$cad8], a
    ret


    ld [bc], a
    sbc h
    ld [hl+], a
    sbc h
    ld [bc], a
    sbc h
    ld [hl+], a
    sbc h
    ld b, d
    sbc h
    ld [bc], a
    sbc h
    ld [hl+], a
    sbc h
    ld b, d
    sbc h
    ld [bc], a
    sbc h
    ld [hl+], a
    sbc h
    ld [bc], a
    sbc h
    ld [hl+], a
    sbc h
    ld b, d
    sbc h
    ld [hl+], a
    sbc h
    ld b, d
    sbc h
    ld [bc], a
    sbc h
    ld [hl+], a
    sbc h
    ld b, d
    sbc h
    ld [hl+], a
    sbc h
    ld b, d
    sbc h
    ld [hl+], a
    sbc h
    ld b, d
    sbc h
    ld [hl+], a
    sbc h
    ld b, d
    sbc h
    ld [bc], a
    sbc h
    ld [hl+], a
    sbc h
    ld b, d
    sbc h
    ld h, d
    sbc h
    ld c, l
    inc sp
    ld e, [hl]
    inc sp
    ld l, a
    inc sp
    add b
    inc sp
    sub c
    inc sp
    and d
    inc sp
    or e
    inc sp
    call nz, $d533
    inc sp
    and $33
    rst $30
    inc sp
    ld [$1934], sp
    inc [hl]
    ld a, [hl+]
    inc [hl]
    dec sp
    inc [hl]
    ld c, h
    inc [hl]
    ld e, l
    inc [hl]
    ld l, [hl]
    inc [hl]
    ld a, a
    inc [hl]
    sub b
    inc [hl]
    and c
    inc [hl]
    or d
    inc [hl]
    jp $d434


    inc [hl]
    push hl
    inc [hl]
    or $34
    rlca
    dec [hl]
    jr @+$37

    jp nc, $d0d6

    cp d
    call c, $bcb8
    sub $bf
    cp a
    cp a
    cp a
    cp a
    cp a
    cp a
    cp a
    cp a
    ret nz

    add sp, -$1c
    ret nc

    ret z

    ret nc

    call nz, $bfbf
    cp a
    cp a
    cp a
    cp a
    cp a
    cp a
    cp a
    cp a
    cp d
    call nz, $bcd6
    cp b
    jp c, $d6d0

    cp a
    cp a
    cp a
    cp a
    cp a
    cp a
    cp a
    cp a
    cp a
    ret c

    add sp, -$30
    ret z

    or h
    cp d
    or h
    cp a
    cp a
    cp a
    cp a
    cp a
    cp a
    cp a
    cp a
    cp a
    cp a
    ret z

    add sp, -$26
    cp h
    sub $b4
    ret c

    or h
    ret z

    call nz, $bfbf
    cp a
    cp a
    cp a
    cp a
    cp a
    jp nc, $d0d6

    ret nz

    sub $b4
    call z, $bccc
    sub $bf
    cp a
    cp a
    cp a
    cp a
    cp a
    cp a
    ret z

    add sp, -$28
    call c, $c4c0
    call z, $dad0
    ret nc

    cp a
    cp a
    cp a
    cp a
    cp a
    cp a
    cp a
    cp a
    cp a
    cp a
    cp a
    cp a
    cp a
    cp a
    cp a
    cp a
    cp a
    cp a
    cp a
    cp a
    cp a
    cp a
    cp a
    cp a
    call z, $d8dc
    call nz, $bfb8
    ret c

    ret nc

    call c, $bace
    cp a
    cp a
    cp a
    cp a
    cp a
    cp a
    jp c, $d0e8

    ret c

    or h
    cp d
    or h
    cp a
    cp a
    cp a
    cp a
    cp a
    cp a
    cp a
    cp a
    cp a
    cp a
    cp d
    cp h
    ret c

    call nz, $cec0
    cp a
    cp a
    cp a
    cp a
    cp a
    cp a
    cp a
    cp a
    cp a
    cp a
    cp a
    or h
    add sp, -$3e
    call nz, $b4c0
    ret c

    jp nz, $e4c4

    or h
    cp a
    cp a
    cp a
    cp a
    cp a
    cp a
    ret z

    add sp, -$1c
    or h
    call z, $c0b4
    or h
    call z, $bfc4
    cp a
    cp a
    cp a
    cp a
    cp a
    cp a
    ret z

    add sp, -$38
    or h
    jp c, $dcd8

    db $e4
    or h
    call z, $bfb4
    cp a
    cp a
    cp a
    cp a
    cp a
    ret z

    add sp, -$3e
    or h
    db $e4
    or h
    ret c

    jp nz, $bfc4

    cp a
    cp a
    cp a
    cp a
    cp a
    cp a
    cp a
    ret c

    jp nc, $b8bc

    call nz, $cab4
    ei
    jp c, $b4c2

    adc $c8
    ret c

    ei
    jp c, $c2d0

    add sp, -$3e
    call nz, $b4d6
    db $e4
    or h
    call z, $bfb4
    cp a
    cp a
    cp a
    cp a
    cp a
    cp a
    db $e4
    add sp, -$42
    call c, $c4c6
    call nz, $bfbf
    cp a
    cp a
    cp a
    cp a
    cp a
    cp a
    cp a
    cp a
    ret z

    add sp, -$26
    or h
    ret z

    cp h
    call c, $c2b8
    call nz, $bfbf
    cp a
    cp a
    cp a
    cp a
    cp a
    jp nz, $b4e8

    db $e4
    sub $da
    ret nc

    adc $e8
    ldh [$ffb4], a
    cp d
    or h
    cp a
    cp a
    cp a
    cp a
    db $e4
    add sp, -$38
    or h
    ldh [$ffb4], a
    ret z

    or h
    call z, $bfc4
    cp a
    cp a
    cp a
    cp a
    cp a
    cp a
    call z, $cee8
    or h
    ret z

    or h
    jp c, $ceb4

    call nz, $bfbf
    cp a
    cp a
    cp a
    cp a
    cp a
    jp nz, $cee8

    or h
    ret z

    or h
    and $b4
    ldh [$ffb4], a
    cp a
    cp a
    cp a
    cp a
    cp a
    cp a
    cp a
    db $e4
    add sp, -$4c
    sub $b4
    ret c

    jp nz, $b6c4

    or h
    cp a
    cp a
    cp a
    cp a
    cp a
    cp a
    cp a
    cp a
    ret c

    ret nc

    jp z, $d6b4

    ret c

    jp c, $c4d6

    ret z

    cp h
    sub $bf
    cp a
    cp a
    cp a
    cp a
    cp a
    cp a
    cp a
    cp a
    cp a
    cp a
    cp a
    cp a
    cp a
    cp a
    cp a
    cp a
    cp a
    cp a
    cp a
    cp a
    cp a
    cp a
    cp a
    cp a
    cp a
    cp a
    cp a
    cp a
    cp a
    cp a
    cp a
    cp a
    cp a
    cp a
    cp a
    cp a
    cp a
    cp a
    db $fc
    and d
    or d
    or b
    or d
    cp a
    ld [$eceb], a
    db $ed
    xor $ef
    cp a
    cp a
    cp a
    cp a

; Each pointer selects a movement command sequence, read in order.
ProtodroidMovementScriptB: ; $3529
    dw $3e43
    dw $3e4e
    dw $3d45
    dw $3ca1

ProtodroidMovementScriptA: ; $3531
    dw $3e6f
    dw $3e7a
    dw $3d3d
    dw $3c91

    db $43, $3e, $4e, $3e, $45, $3d, $a1, $3c, $6f, $3e, $7a, $3e

    dec a
    dec a
    dec b
    nop
    sub c
    inc a
    ld b, e
    ld a, $4e
    db $3e

; Each pointer selects a movement command sequence, read in order.
CruiserMovementScriptA: ; $354F
    dw $3cb1
    dw $3e01
    dw $3e0c
    dw $3c91
    dw $3c91
    dw $3c91
    dw $3c91
    dw $3c91
    dw $3c91

CruiserMovementScriptB: ; $3561
    dw $3cb1
    dw $3da9
    dw $3db4
    dw $3ca1
    dw $3ca1
    dw $3ca1
    dw $3ca1
    dw $3ca1
    dw $3ca1

; Each pointer selects a movement command sequence, read in order.
RotomechMovementScriptA: ; $3573
    dw $3da9
    dw $3d65
    dw $3df6
    dw $3e01
    dw $3d5d
    dw $3d9e

RotomechMovementScriptB: ; $357F
    dw $3e01
    dw $3d5d
    dw $3d9e
    dw $3da9
    dw $3d65
    dw $3df6

    or c
    inc a
    or c
    inc a
    pop af
    inc a
    or c
    inc a
    or c
    inc a
    or c
    inc a
    or c
    inc a
    ld bc, $b13d
    inc a
    or c
    inc a

; Each pointer selects a movement command sequence, read in order.
PincherMovementScriptA: ; $359F
    dw $3d4d
    dw $3c89
    dw $3d3d
    dw $3d4d
    dw $3c89
    dw $3d3d
    dw $3d4d
    dw $3c89
    dw $3d3d
    dw $3d4d
    dw $3c89
    dw $3d3d
    dw $3d4d
    dw $3c89
    dw $3d3d
    dw $3d4d
    dw $3c89
    dw $3d3d

PincherMovementScriptB: ; $35C3
    dw $3cb1
    dw $3c89
    dw $3ca1
    dw $3cb1
    dw $3c89
    dw $3ca1
    dw $3cb1
    dw $3c89
    dw $3ca1
    dw $3cb1
    dw $3c89
    dw $3ca1
    dw $3cb1
    dw $3c89
    dw $3ca1
    dw $3cb1
    dw $3c89
    dw $3ca1

    pop de
    inc a
    pop hl
    inc a
    pop de
    inc a
    pop hl
    inc a
    pop de
    inc a
    pop hl
    inc a
    pop hl
    inc a
    pop de
    inc a
    pop hl
    inc a
    pop de
    inc a
    pop hl
    inc a
    ld c, l
    dec a
    ld c, l
    dec a
    dec a
    dec a
    dec a
    dec a
    dec a
    dec a
    pop bc
    inc a
    pop bc
    inc a
    pop bc
    inc a
    pop bc
    inc a
    pop bc
    inc a
    pop bc
    inc a
    ld c, l
    dec a
    ld c, l
    dec a
    ld b, l
    dec a
    ld b, l
    dec a
    ld b, l
    dec a
    pop bc
    inc a
    pop bc
    inc a
    pop bc
    inc a
    pop bc
    inc a
    pop bc
    inc a
    pop bc
    inc a
    ld c, l
    dec a
    ld e, l
    dec a
    ld l, l
    dec a
    ld e, l
    dec a
    ld l, l
    dec a
    pop bc
    inc a
    pop bc
    inc a
    pop bc
    inc a
    pop bc
    inc a
    pop bc
    inc a
    pop bc
    inc a
    ld c, l
    dec a
    ld h, l
    dec a
    ld [hl], l
    dec a
    ld h, l
    dec a
    ld [hl], l
    dec a
    pop bc
    inc a
    pop bc
    inc a
    pop bc
    inc a
    pop bc
    inc a
    pop bc
    inc a
    pop bc
    inc a
    or c
    inc a
    ld c, l
    dec a
    ld a, d
    ld a, $85
    ld a, $90
    ld a, $6f
    ld a, $b1
    inc a
    or c
    inc a
    or c
    inc a
    or c
    inc a
    or c
    inc a
    ld c, l
    dec a
    ld c, [hl]
    ld a, $59
    ld a, $64
    ld a, $43
    ld a, $b1
    inc a
    or c
    inc a
    or c
    inc a
    or c
    inc a

SkimbotMovementScript: ; $367D
    dw $3cb1, $3cb1, $3cb1, $3cb1, $3cb1

    ld c, [hl]
    ld a, $43
    ld a, $64
    ld a, $59
    ld a, $b1
    inc a
    ld c, [hl]
    ld a, $43
    ld a, $64
    ld a, $59
    ld a, $b1
    inc a
    ld c, [hl]
    ld a, $43
    ld a, $64
    ld a, $59
    ld a, $b1
    inc a
    ld bc, $0c3e
    ld a, $eb
    dec a
    or $3d
    ld bc, $0c3e
    ld a, $eb
    dec a
    or $3d
    ld bc, $0c3e
    ld a, $eb
    dec a
    or $3d
    xor c
    dec a
    or h
    dec a
    sub e
    dec a
    sbc [hl]
    dec a
    xor c
    dec a
    or h
    dec a
    sub e
    dec a
    sbc [hl]
    dec a
    xor c
    dec a
    or h
    dec a
    sub e
    dec a
    sbc [hl]
    dec a

MackMovementScript: ; $36D5
    dw $3d4d, $3c89
    dw $3d4d, $3c89
    dw $3d4d, $3c89
    dw $3d4d, $3c89
    dw $3d4d, $3c89
    dw $3d4d, $3c89

VexorMovementScriptA: ; $36ED
    dw $3cb1, $3d3d, $3d93, $3d9e
    dw $3cb1, $3cb1, $3cb1, $3cb1

VexorMovementScriptB: ; $36FD
    dw $3cb1, $3d45, $3deb, $3df6
    dw $3cb1, $3cb1, $3cb1, $3cb1

    or c
    inc a
    sub c
    inc a
    or c
    inc a
    and c
    inc a
    or c
    inc a
    sub c
    inc a
    or c
    inc a
    and c
    inc a
    or c
    inc a
    sub c
    inc a
    or c
    inc a
    and c
    inc a
    or c
    inc a
    and c
    inc a
    or c
    inc a
    sub c
    inc a
    or c
    inc a
    and c
    inc a
    or c
    inc a
    sub c
    inc a
    or c
    inc a
    and c
    inc a
    or c
    inc a
    sub c
    inc a
DestructorMovementScript: ; $373D
    dw $3d4d, $3d45, $3e6f, $3e7a, $3c91, $3e43
    dw $3e4e, $3ca1, $3e59, $3e64, $3c91, $3e85
    dw $3e90, $3ca1, $3e6f, $3e7a, $3c91, $3e43
    dw $3e4e, $3ca1, $3e59, $3e64, $3c91, $3e85
    dw $3e90, $3ca1, $3e6f, $3e7a, $3c91, $3e43
    dw $3e4e, $3ca1, $3e59, $3e64, $3c91, $3e85
    dw $3e90, $3ca1, $3e6f, $3e7a, $3c91, $3e43
    dw $3e4e, $3ca1, $3e59, $3e64, $3c91, $3e85
    dw $3e90, $3ca1, $3e6f, $3e7a, $3c91, $3e43
    dw $3e4e, $3ca1, $3e59, $3e64, $3c91, $3e85
    dw $3e90, $3d45, $3cb1, $3cb1, $3cb1

UltraCrusherMovementScript: ; $37BF
    dw $3d4d
    dw $3cb1, $3cb1, $3cc1, $3cc1, $3ca1, $3c91, $3c91, $3ca1
    dw $3cb1, $3cb1, $3cc1, $3cc1, $3ca1, $3c91, $3c91, $3ca1
    dw $3cb1, $3cb1, $3cc1, $3cc1, $3ca1, $3c91, $3c91, $3ca1
    dw $3cb1, $3cb1, $3cc1, $3cc1, $3ca1, $3c91, $3c91, $3ca1
    dw $3cb1, $3cb1, $3cc1, $3cc1, $3ca1, $3c91, $3c91, $3ca1
    dw $3cb1, $3cb1, $3cc1, $3cc1, $3ca1, $3c91, $3c91, $3ca1
    dw $3cb1, $3cb1, $3cc1, $3cc1, $3ca1, $3c91, $3c91, $3ca1
    dw $3cb1, $3cb1, $3cc1, $3cc1, $3ca1, $3c91, $3c91, $3ca1
    dw $3cb1, $3cb1, $3cc1, $3cc1, $3ca1, $3c91, $3c91, $3ca1
    dw $3cb1, $3cb1, $3cc1, $3cc1, $3ca1, $3c91, $3c91, $3ca1
    dw $3cb1, $3cb1, $3cc1, $3cc1, $3ca1, $3c91, $3c91, $3ca1
    dw $3cb1, $3cb1, $3cc1, $3cc1, $3ca1, $3c91, $3c91, $3ca1
    dw $3cb1, $3cb1, $3cc1, $3cc1, $3ca1, $3c91, $3c91, $3ca1
    dw $3cb1, $3cb1, $3cc1, $3cc1, $3ca1, $3c91, $3c91, $3ca1
    dw $3cb1, $3cb1, $3cc1, $3cc1, $3ca1, $3c91, $3c91, $3ca1
    dw $3cb1, $3cb1, $3cc1, $3cc1, $3ca1, $3c91, $3c91, $3ca1
    dw $3cb1, $3cb1, $3cb1, $3cb1

EpikhanMovementScript: ; $38C9
    ; Enter: move down 24 pixels, then pause for 8 movement updates.
    dw $3d4d, $3c89
    ; Sweep horizontally with pauses: $3CA1 = left, $3C91 = right, $3C89 = pause.
    dw $3ca1, $3c89, $3c91, $3c91, $3c89, $3ca1
    dw $3ca1, $3c89, $3c91, $3c91, $3c89, $3ca1
    dw $3ca1, $3c89, $3c91, $3c91, $3c89, $3ca1
    dw $3ca1, $3c89, $3c91, $3c91, $3c89, $3ca1
    dw $3ca1, $3c89, $3c91, $3c91, $3c89, $3ca1
    dw $3ca1, $3c89, $3c91, $3c91, $3c89, $3ca1
    dw $3ca1, $3c89, $3c91, $3c91, $3c89, $3ca1
    dw $3ca1, $3c89, $3c91, $3c91, $3c89, $3ca1
    dw $3ca1, $3c89, $3c91, $3c91, $3c89, $3ca1
    dw $3ca1, $3c89, $3c91, $3c91, $3c89, $3ca1
    ; $3945: exit downward, 24 pixels per sequence over 16 movement updates.
    dw $3d83, $3d83, $3d83, $3d83
    dw $3d83, $3d83, $3d83, $3d83

    or c
    inc a
    sub b
    ld a, $6f
    ld a, $7a
    ld a, $85
    ld a, $64
    ld a, $43
    ld a, $4e
    ld a, $59
    ld a, $90
    ld a, $6f
    ld a, $7a
    ld a, $85
    ld a, $64
    ld a, $43
    ld a, $4e
    ld a, $59
    ld a, $89
    inc a
    adc c
    inc a
    adc c
    inc a
    adc c
    inc a
    adc c
    inc a
    adc c
    inc a
    adc c
    inc a
    adc c
    inc a
    ld a, l
    dec a
    sub b
    ld a, $6f
    ld a, $7a
    ld a, $85
    ld a, $64
    ld a, $43
    ld a, $4e
    ld a, $59
    ld a, $89
    inc a
    adc c
    inc a
    adc c
    inc a
    adc c
    inc a
    adc c
    inc a
    adc c
    inc a
    adc c
    inc a
    adc c
    inc a
    ld a, l
    dec a
    add e
    dec a
    add e
    dec a
    add e
    dec a
    add e
    dec a
    add e
    dec a
    add e
    dec a
    or c
    inc a
    sub b
    ld a, $6f
    ld a, $7a
    ld a, $85
    ld a, $64
    ld a, $43
    ld a, $4e
    ld a, $59
    ld a, $90
    ld a, $6f
    ld a, $7a
    ld a, $85
    ld a, $64
    ld a, $43
    ld a, $4e
    ld a, $59
    ld a, $89
    inc a
    daa
    dec a
    adc c
    inc a
    pop af
    inc a
    adc c
    inc a
    inc e
    dec a
    adc c
    inc a
    sub b
    ld a, $6f
    ld a, $7a
    ld a, $85
    ld a, $64
    ld a, $43
    ld a, $4e
    ld a, $59
    ld a, $89
    inc a
    ld de, $893d
    inc a
    ld bc, $893d
    inc a
    daa
    dec a
    adc c
    inc a
    add e
    dec a
    add e
    dec a
    add e
    dec a
    add e
    dec a
    add e
    dec a
    add e
    dec a
    or c
    inc a
    sub b
    ld a, $6f
    ld a, $7a
    ld a, $85
    ld a, $64
    ld a, $43
    ld a, $4e
    ld a, $59
    ld a, $90
    ld a, $6f
    ld a, $7a
    ld a, $85
    ld a, $64
    ld a, $43
    ld a, $4e
    ld a, $59
    ld a, $89
    inc a
    inc e
    dec a
    adc c
    inc a
    pop de
    inc a
    adc c
    inc a
    ld [hl-], a
    dec a
    adc c
    inc a
    sub b
    ld a, $6f
    ld a, $7a
    ld a, $85
    ld a, $64
    ld a, $43
    ld a, $4e
    ld a, $59
    ld a, $89
    inc a
    daa
    dec a
    adc c
    inc a
    pop af
    inc a
    adc c
    inc a
    inc e
    dec a
    adc c
    inc a
    add e
    dec a
    add e
    dec a
    add e
    dec a
    add e
    dec a
    add e
    dec a
    add e
    dec a
    or c
    inc a
    sub b
    ld a, $6f
    ld a, $7a
    ld a, $85
    ld a, $64
    ld a, $43
    ld a, $4e
    ld a, $59
    ld a, $90
    ld a, $6f
    ld a, $7a
    ld a, $85
    ld a, $64
    ld a, $43
    ld a, $4e
    ld a, $59
    ld a, $89
    inc a
    ld de, $893d
    inc a
    ld bc, $893d
    inc a
    daa
    dec a
    adc c
    inc a
    sub b
    ld a, $6f
    ld a, $7a
    ld a, $85
    ld a, $64
    ld a, $43
    ld a, $4e
    ld a, $59
    ld a, $89
    inc a
    ld [hl-], a
    dec a
    adc c
    inc a
    pop hl
    inc a
    adc c
    inc a
    ld de, $893d
    inc a
    add e
    dec a
    add e
    dec a
    add e
    dec a
    add e
    dec a
    add e
    dec a
    add e
    dec a
    or c
    inc a
    sub b
    ld a, $6f
    ld a, $7a
    ld a, $85
    ld a, $64
    ld a, $43
    ld a, $4e
    ld a, $59
    ld a, $90
    ld a, $6f
    ld a, $7a
    ld a, $85
    ld a, $64
    ld a, $43
    ld a, $4e
    ld a, $59
    ld a, $89
    inc a
    ld [hl-], a
    dec a
    adc c
    inc a
    pop hl
    inc a
    adc c
    inc a
    ld de, $893d
    inc a
    sub b
    ld a, $6f
    ld a, $7a
    ld a, $85
    ld a, $64
    ld a, $43
    ld a, $4e
    ld a, $59
    ld a, $89
    inc a
    inc e
    dec a
    adc c
    inc a
    pop de
    inc a
    adc c
    inc a
    ld [hl-], a
    dec a
    adc c
    inc a
    add e
    dec a
    add e
    dec a
    add e
    dec a
    add e
    dec a
    add e
    dec a
    add e
    dec a
    ld c, l
    dec a
    adc c
    inc a
    dec a
    dec a
    ld b, e
    ld a, $4e
    ld a, $45
    dec a
    ld b, l
    dec a
    ld e, c
    ld a, $64
    ld a, $3d
    dec a
    and c
    inc a
    adc c
    inc a
    adc c
    inc a
    adc c
    inc a
    adc c
    inc a
    adc c
    inc a
    adc c
    inc a
    adc c
    inc a
    adc c
    inc a
    adc c
    inc a
    adc c
    inc a
    adc c
    inc a
    adc c
    inc a
    sub c
    inc a
    sub c
    inc a
    adc c
    inc a
    ld c, [hl]
    ld a, $59
    ld a, $89
    inc a
    and c
    inc a
    adc c
    inc a
    adc c
    inc a
    pop de
    inc a
    adc c
    inc a
    pop de
    inc a
    pop de
    inc a
    ld c, l
    dec a
    adc c
    inc a
    dec a
    dec a
    ld b, e
    ld a, $4e
    ld a, $45
    dec a
    ld b, l
    dec a
    ld e, c
    ld a, $64
    ld a, $3d
    dec a
    ld b, l
    dec a
    adc c
    inc a
    adc c
    inc a
    adc c
    inc a
    ld b, l
    dec a
    adc c
    inc a
    adc c
    inc a
    adc c
    inc a
    adc c
    inc a
    dec a
    dec a
    adc c
    inc a
    adc c
    inc a
    adc c
    inc a
    adc c
    inc a
    sub c
    inc a
    dec a
    dec a
    adc c
    inc a
    adc c
    inc a
    ld c, [hl]
    ld a, $59
    ld a, $89
    inc a
    ld b, l
    dec a
    adc c
    inc a
    adc c
    inc a
    adc c
    inc a
    pop de
    inc a
    adc c
    inc a
    pop de
    inc a
    pop de
    inc a
    ld c, l
    dec a
    adc c
    inc a
    dec a
    dec a
    ld b, e
    ld a, $4e
    ld a, $45
    dec a
    ld b, l
    dec a
    ld e, c
    ld a, $64
    ld a, $3d
    dec a
    dec a
    dec a
    adc c
    inc a
    adc c
    inc a
    adc c
    inc a
    and c
    inc a
    ld b, l
    dec a
    adc c
    inc a
    adc c
    inc a
    sub c
    inc a
    dec a
    dec a
    adc c
    inc a
    adc c
    inc a
    dec a
    dec a
    adc c
    inc a
    adc c
    inc a
    adc c
    inc a
    adc c
    inc a
    ld c, [hl]
    ld a, $59
    ld a, $89
    inc a
    dec a
    dec a
    adc c
    inc a
    adc c
    inc a
    adc c
    inc a
    pop hl
    inc a
    adc c
    inc a
    pop hl
    inc a
    pop hl
    inc a
    ld c, l
    dec a
    adc c
    inc a
    dec a
    dec a
    ld b, e
    ld a, $4e
    ld a, $45
    dec a
    ld b, l
    dec a
    ld e, c

Call_000_3c10:
    ld a, $64
    ld a, $3d
    dec a
    sub c
    inc a
    adc c
    inc a
    adc c
    inc a
    and c
    inc a
    and c
    inc a
    adc c
    inc a
    sub c
    inc a
    sub c
    inc a
    adc c
    inc a
    adc c
    inc a
    adc c
    inc a
    adc c
    inc a
    adc c
    inc a
    adc c
    inc a
    ld c, [hl]
    ld a, $59
    ld a, $89
    inc a
    sub c
    inc a
    adc c
    inc a
    adc c
    inc a
    pop hl
    inc a
    adc c
    inc a
    pop hl
    inc a
    pop hl
    inc a
    or c
    inc a
    and c
    inc a
    ld d, l
    dec a
    sub c
    inc a
    and c
    inc a
    or c
    inc a
    sub c
    inc a
    ld d, l
    dec a
    and c
    inc a
    sub c
    inc a
    ld c, l
    dec a
    and c
    inc a
    ld d, l
    dec a
    sub c
    inc a
    or c
    inc a
    or c
    inc a
    or c
    inc a
    or c
    inc a
    sub c
    inc a
    ld d, l
    dec a
    and c
    inc a
    sub c
    inc a
    or c
    inc a
    and c
    inc a
    ld d, l
    dec a
    sub c
    inc a
    and c
    inc a
    ld c, l
    dec a
    sub c
    inc a
    ld d, l
    dec a
    and c
    inc a
    or c
    inc a
    or c
    inc a
    or c
    inc a

    db $00, $00, $00, $00, $00, $00, $00, $08, $10, $10, $10, $10, $10, $10, $10, $10
    db $10, $10, $10, $10, $10, $10, $10, $18, $20, $20, $20, $20, $20, $20, $20, $20
    db $20, $20, $20, $20, $20, $20, $20, $28, $40, $40, $40, $40, $40, $40, $40, $40
    db $40, $40, $40, $40, $40, $40, $40, $48

    add b
    add b
    add b
    add b
    add b
    add b
    add b
    add b
    add b
    add b
    add b
    add b
    add b
    add b
    add b
    adc b
    ld d, b
    ld d, b
    ld d, b
    ld d, b
    ld d, b
    ld d, b
    ld d, b
    ld d, b
    ld d, b
    ld d, b
    ld d, b
    ld d, b
    ld d, b
    ld d, b
    ld d, b
    ld e, b
    ld h, b
    ld h, b
    ld h, b
    ld h, b
    ld h, b
    ld h, b
    ld h, b
    ld h, b
    ld h, b
    ld h, b
    ld h, b
    ld h, b
    ld h, b
    ld h, b
    ld h, b
    ld l, b
    sub b
    sub b
    sub b
    sub b
    sub b
    sub b
    sub b
    sub b
    sub b
    sub b
    sub b
    sub b
    sub b
    sub b
    sub b
    sbc b
    and b
    and b
    and b
    and b
    and b
    and b
    and b
    and b
    and b
    and b
    and b
    and b
    and b
    and b
    and b
    xor b
    db $10
    db $10
    db $10
    db $10
    db $10
    db $10
    db $10
    db $10
    db $10
    db $10
    jr @+$22

    jr nz, @+$22

    jr nz, @+$22

    jr nz, @+$22

    jr nz, @+$22

    jr nz, @+$2a

    ld b, b
    ld b, b
    ld b, b
    ld b, b
    ld b, b
    ld b, b
    ld b, b
    ld b, b
    ld b, b
    ld b, b
    ld c, b
    add b
    add b
    add b
    add b
    add b
    add b
    add b
    add b
    add b
    add b
    adc b

    db $10, $10, $10, $10, $10, $10, $10, $18, $20, $20, $20, $20, $20, $20, $20, $28
    db $40, $40, $40, $40, $40, $40, $40, $48

    add b
    add b
    add b
    add b
    add b
    add b
    add b
    adc b

    db $50, $50, $50, $50, $50, $50, $50, $58, $60, $60, $60, $60, $60, $60, $60, $68

    sub b
    sub b

jr_000_3d6f:
    sub b
    sub b
    sub b
    sub b
    sub b
    sbc b
    and b
    and b
    and b
    and b
    and b
    and b
    and b
    xor b
    nop
    nop
    nop
    nop
    nop
    ld [$0040], sp
    ld b, b
    nop
    ld b, b
    nop
    ld b, b
    nop
    ld b, b
    nop
    ld b, b
    nop
    ld b, b
    nop
    ld b, b
    ld [$1010], sp
    db $10
    ld d, b
    db $10
    db $10
    ld d, b
    db $10
    ld d, b
    ld d, b
    ld e, b

    db $50, $50, $50, $40, $50, $40, $40, $50, $40, $40, $48, $40, $40, $40, $60, $40
    db $40, $60, $40, $60, $60, $68, $60, $60, $60, $20, $60, $20, $20, $60, $20, $20
    db $28

    jr nz, jr_000_3de1

    jr nz, @-$5e

    jr nz, jr_000_3de5

    and b
    jr nz, @-$5e

    and b
    xor b
    and b
    and b
    and b
    jr nz, jr_000_3d6f

    add b
    add b
    and b
    add b
    add b
    adc b
    add b
    add b
    add b
    sub b
    add b
    add b
    sub b
    add b

jr_000_3ddd:
    sub b
    sub b
    sbc b
    sub b

jr_000_3de1:
    sub b
    sub b
    db $10
    sub b

jr_000_3de5:
    db $10
    db $10
    sub b
    db $10
    db $10
    jr @+$22

    jr nz, @+$22

    ld h, b
    jr nz, @+$22

    ld h, b
    jr nz, @+$62

    ld h, b
    ld l, b

    db $60, $60, $60, $40, $60, $40, $40, $60, $40, $40, $48, $40, $40, $40, $50, $40
    db $40, $50, $40, $50, $50, $58, $50, $50, $50, $10, $50, $10, $10, $50, $10, $10
    db $18

    db $10
    db $10
    db $10
    sub b
    db $10
    db $10
    sub b
    db $10
    sub b
    sub b
    sbc b
    sub b
    sub b
    sub b
    add b
    sub b
    add b
    add b
    sub b
    add b
    add b
    adc b
    add b
    add b
    add b
    and b
    add b
    add b
    and b
    add b
    and b
    and b
    xor b
    and b

jr_000_3e39:
    and b
    and b
    jr nz, jr_000_3ddd

    jr nz, jr_000_3e5f

    and b
    jr nz, jr_000_3e62

    db $28

    db $10, $10, $50, $10, $50, $50, $50, $40, $50, $40, $48, $40, $40, $60, $40, $60
    db $60, $60, $20, $60, $20, $28

    jr nz, @+$22

    and b
    jr nz, @-$5e

    and b

jr_000_3e5f:
    and b
    add b
    and b

jr_000_3e62:
    add b
    adc b
    add b
    add b
    sub b
    add b
    sub b
    sub b
    sub b
    db $10
    sub b
    db $10
    db $18

    db $20, $20, $60, $20, $60, $60, $60, $40, $60, $40, $48, $40, $40, $50, $40, $50
    db $50, $50, $10, $50, $10, $18

    db $10
    db $10
    sub b
    db $10
    sub b
    sub b
    sub b
    add b
    sub b
    add b
    adc b

jr_000_3e90:
    add b
    add b
    and b
    add b
    and b
    and b
    and b
    jr nz, jr_000_3e39

    jr nz, @+$2a

    ; Packet format: destination high byte, destination low byte, control, data.
    ; These destinations are in VRAM (the background tile map).
    ; All controls below have mode 0: copy the following bytes to the destination.
    ; wHardModeUnlocked = 0 selects the sequence at ROM $3E9B.
    ; ROM $3E9B: HL = $99EB, copy 4 bytes to $99EB-$99EE.
    db $99, $eb, $04, $d2, $dc, $d8, $c2
    ; ROM $3EA2: HL = $9A08, copy 12 bytes to $9A08-$9A13.
    db $9a, $08, $0c, $d8, $da, $b4, $d6, $da, $ff, $b6, $dc, $da, $da, $d0, $ce
    ; ROM $3EB1: HL = $9A48, copy 3 bytes to $9A48-$9A4A.
    db $9a, $48, $03, $da, $d0, $d2
    ; ROM $3EB7: HL = $9A88, copy 12 bytes to $9A88-$9A93.
    db $9a, $88, $0c, $fc, $a2, $b2, $b0, $b2, $ff, $ea, $eb, $ec, $ed, $ee, $ef
    db $00 ; ROM $3EC6: end of sequence.

    ; wHardModeUnlocked != 0 selects the sequence at ROM $3EC7.
    ; ROM $3EC7: HL = $99EB, copy 4 bytes to $99EB-$99EE.
    db $99, $eb, $04, $d2, $dc, $d8, $c2
    ; ROM $3ECE: HL = $9A07, copy 13 bytes to $9A07-$9A13.
    db $9a, $07, $0d, $d8, $bc, $ca, $bc, $b8, $da, $bf, $b6, $dc, $da, $da, $d0, $ce
    ; ROM $3EDE: HL = $9A48, copy 3 bytes to $9A48-$9A4A.
    db $9a, $48, $03, $da, $d0, $d2
    ; ROM $3EE4: HL = $9A88, copy 12 bytes to $9A88-$9A93.
    db $9a, $88, $0c, $fc, $a2, $b2, $b0, $b2, $ff, $ea, $eb, $ec, $ed, $ee, $ef
    db $00 ; ROM $3EF3: end of sequence.

    db $9c, $00, $13, $d8, $b8, $d0, $d6, $bc, $00, $f0, $f0, $f0, $f0, $f0, $f0, $f0
    db $f0, $00, $00, $fa, $f0, $f3, $00

    ldh a, [$fff0]
    ldh a, [$fff0]
    ldh a, [$fff0]
    ldh a, [rP1]
    nop
    ld a, [$f3f0]
    nop
    nop
    nop
    ld d, h
    ld bc, $0000
    nop
    db $10
    stop
    db $10
    inc b
    nop
    nop
    jr nz, jr_000_3f28

jr_000_3f28:
    nop
    nop
    ld b, d
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    add d
    ld b, b
    nop
    nop
    nop
    nop
    nop
    nop
    inc b
    db $10
    ld bc, $0000
    nop
    ld [$0010], sp
    nop
    nop
    nop
    ld c, b
    nop
    ld [bc], a
    nop
    nop
    nop
    nop
    db $10
    ld b, b
    nop
    nop
    nop
    nop
    nop
    jr nz, jr_000_3f58

jr_000_3f58:
    nop
    ld b, b
    nop
    ld bc, $0000
    nop
    nop
    nop
    nop
    nop
    nop
    add b
    nop
    ld bc, $4200
    nop
    stop
    jr z, jr_000_3f6e

jr_000_3f6e:
    nop
    nop
    ld b, c
    nop
    nop
    nop
    jr nc, jr_000_3f87

    db $10
    stop
    inc b
    nop
    inc b
    ld b, c
    nop
    nop
    nop
    add d
    nop
    nop
    nop
    ld [bc], a
    nop
    nop

jr_000_3f87:
    nop
    nop
    nop
    stop
    jr nz, jr_000_3f8e

jr_000_3f8e:
    ld bc, $4000
    nop
    inc b
    inc b
    inc hl
    nop
    nop
    nop
    nop
    inc b
    nop
    nop
    db $10
    inc d
    ld [hl+], a
    nop
    nop
    nop
    ld [bc], a
    nop
    nop
    nop
    nop
    nop
    ld b, h
    nop
    inc b
    nop
    inc b
    nop
    nop
    nop
    nop
    inc b
    ld [bc], a
    nop
    add hl, bc
    ld bc, $0008
    nop
    nop
    ld hl, $4401
    nop
    nop
    stop
    nop
    nop
    nop
    nop
    inc b
    ld b, $00
    nop
    nop
    nop
    inc b
    nop
    ld bc, $0004
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    add b
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    ld bc, $8001
    nop
    stop
    nop
    nop
    nop
    stop
    nop
    jr nz, jr_000_3fee

jr_000_3fee:
    stop
    ld b, b
    nop
    nop
    nop
    db $10
    dec b
    and b
    nop
    nop
    nop
    ld b, h
    inc b
    jr nz, jr_000_3ffe

jr_000_3ffe:
    nop
    nop
