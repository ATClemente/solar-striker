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
    jp HandleVBlank


    cp a
    xor $ff
    cp d
    rst $38

LCDCInterrupt::
    jp HandleLCDInterrupt


    cp $ff
    ei
    rst $28
    rst $38

TimerOverflowInterrupt::
    jp HandleTimerOverflow


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
    NINTENDO_LOGO

HeaderTitle::
    db "SOLARSTRIKER", $00, $00, $00, $00

HeaderNewLicenseeCode::
    db $00, $00

HeaderSGBFlag::
    db CART_INDICATOR_GB

HeaderCartridgeType::
    db CART_ROM_MBC1

HeaderROMSize::
    db CART_ROM_64KB

HeaderRAMSize::
    db CART_SRAM_NONE

HeaderDestinationCode::
    db CART_DEST_JAPANESE

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
    ld hl, TitleScreenBlockDefinitions
    ld de, $d000 ; WRAM
    ld bc, $0080
    call CopyMemory
    ld hl, TitleScreenBackgroundMap
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
    ; Store $9AA2 to wBackgroundRowPosition,
    ; $9AA2 is in the first tilemap
    ld hl, wBackgroundRowPosition
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
    ld de, TitleScreenStartPromptTilePackets
    call DrawBackgroundTilePackets
    jr DrawHighScoreSetup

DrawPushSelectButton:
    ld de, TitleScreenStartSelectPromptTilePackets
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
    ldh [rLYC], a ; target scanline 136
    ld a, $40
    ldh [rSTAT], a ; enable LY=LYC interrupt
    xor a
    ldh [rTMA], a
    ldh [rIF], a
    ld de, HandleTitleScreenInput
    call StoreAddressInFreeWramSlot
    ld hl, TitleScreenMusic
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

GameOverScreenLoop:
    ld a, [wVBlankOccurred]
    or a
    jr z, GameOverScreenLoop

    ld a, $07
    ldh [rIE], a
    ei
    call ReadJoypad
    call RunWramHandlers
    ld a, $01
    ld [wOAMReady], a
    xor a
    ld [wVBlankOccurred], a
    ld hl, wGameOverExitTimer
    ld a, [hl]
    or a
    jr z, GameOverScreenLoop

    inc [hl]
    cp $04
    jr c, GameOverScreenLoop

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


HandleVBlank:
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
    call nz, hOAMDMARoutine
    ld a, $01
    ld [wVBlankOccurred], a
    ldh a, [rLCDC]
    or $02
    ldh [rLCDC], a
    call DrawMapBlock
    call UpdateHUDTilemap
    pop hl
    pop de
    pop bc
    pop af
    reti

; Runs on scanline 136
; Disables sprites to keep sprites out of bottom
; eight scanlines where the HUD appears
HandleLCDInterrupt:
    push af
    ldh a, [rLCDC]
    and $fd
    ldh [rLCDC], a
    pop af
    reti


HandleTimerOverflow:
    push af
    di
    ld a, $03
    ldh [rIE], a
    ei
    call UpdateAudio
    ld a, $07
    ldh [rIE], a
    pop af
    reti

CheckForSoftReset:
    ld a, [wEnableQuickSoftReset]
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
    ld hl, PauseScreenSound
    call SetupAudioPlayback
    ld [$cf9a], a
    xor a
    ld [wPauseRequested], a
    call CopyPauseTilesToBuffer

PauseScreenLoop:
    ld a, [wVBlankOccurred]
    or a
    jr z, PauseScreenLoop

    xor a
    ld [wOAMReady], a
    call UpdateHUDTilemap
    call ReadJoypad
    call BuildShadowOAM
    call UpdateAudio
    call GetCurrentPlaybackStatus
    or a
    jp nz, .nextLoop

    call CheckForSoftReset
    or a
    jp nz, ReturnToTitleScreen

    ld hl, wPauseRequested
    ld a, [hl+]
    or a
    jr z, .waitForInitialStartRelease

    ld a, [hl+]
    or a
    jr z, .waitForResumePress

    ld a, [hl+]
    or a
    jr z, .waitForResumeRelease

    ld a, [wJoypadHeld]
    and $08
    jr z, .resumeGame

    jr .nextLoop

.waitForInitialStartRelease
    ld a, [wJoypadHeld]
    and $08
    jr nz, .nextLoop

    inc a
    dec hl
    ld [hl], a
    jr .nextLoop

.waitForResumePress
    ld a, [wJoypadHeld]
    and $08
    jr z, .nextLoop

    dec hl
    ld [hl], a
    jr .nextLoop

.waitForResumeRelease
    ld a, [wJoypadHeld]
    and $08
    jr nz, .nextLoop

    inc a
    dec hl
    ld [hl], a

.nextLoop
    xor a
    ld [wVBlankOccurred], a
    jr PauseScreenLoop

.resumeGame
    ld hl, wPauseRequested
    ld [hl+], a
    ld [hl+], a
    ld [hl], a
    ld [wVBlankOccurred], a
    ld [$cfa2], a
    call CopyScoreTilesToBuffer
    ld a, [$cfa1]
    or a
    jr z, .selectStageMusic

    ld hl, BossMusic
    ld a, [$cfa1]
    dec a
    jr z, .startMusicAndResume

    ld hl, AlternateBossMusic
    jr .startMusicAndResume

.selectStageMusic
    ld a, [wCurrentStage]
    add a
    ld l, a
    ld h, $00
    ld de, StageMusicPointerTable
    add hl, de
    ld a, [hl+]
    ld h, [hl]
    ld l, a

.startMusicAndResume
    xor a
    call SetupAudioPlayback
    ld [$cf9a], a
    jp GameLoop


; Only copy P A U S, E from SCORE remains on screen
CopyPauseTilesToBuffer:
    ld de, PauseLabelTiles
    ld hl, $cae0
    ld b, $04

TileBufferLoop:
    ld a, [de]
    ld [hl+], a
    inc de
    dec b
    jr nz, TileBufferLoop

    ret

CopyScoreTilesToBuffer:
    ld hl, $cae0
    ld de, ScoreLabelTiles
    ld b, $06
    ld a, [de]
    ld [hl+], a
    inc de
    dec b
    jr nz, TileBufferLoop

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


UpdateHUDTilemap:
    ld a, [wCurrentStage]
    cp $07
    jr nc, CopyQueuedTextToTilemap ; stage 7 and 8

    ld c, $0d
    ld hl, $9c06
    ld de, wPlayerScore

CopyHUDScoreDigitsAndLabels:
    ld a, [de]
    or $f0
    ld [hl+], a
    inc de
    dec c
    jr nz, CopyHUDScoreDigitsAndLabels

    ld c, $06
    ld hl, $9c00
    ld de, $cae0

.copyBuffer:
    ld a, [de]
    ld [hl+], a
    inc de
    dec c
    jr nz, .copyBuffer

    ret


CopyQueuedTextToTilemap:
    ld a, [wTextCopyPending]
    or a
    ret z

    ld a, [wTextCopyLength]
    ld b, a
    ld hl, wTextCopyDestinationPointer
    ld a, [hl+]
    ld d, [hl]
    ld e, a
    ld hl, wTextCopySourcePointer
    ld a, [hl+]
    ld h, [hl]
    ld l, a

.copyBytes:
    ld a, [hl+]
    ld [de], a
    inc de
    dec b
    jr nz, .copyBytes

    ld a, b
    ld [wTextCopyPending], a
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
    ld hl, wBackgroundRowPosition
    ld de, $9b82
    ld a, e
    ld [hl+], a
    ld [hl], d
    call DrawInitialBackground
    ld de, InitialHUDTilePackets
    call DrawBackgroundTilePackets
    ld de, $cae0
    ld hl, ScoreLabelTiles
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
    ld [wPlayerShotAllocationIndex], a
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

    ; This runs for stage 8
    ld a, $02
    ld [$2100], a
    ld hl, Stage8SpriteTileGraphics
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
    ld hl, wBackgroundRowPosition
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
    ld [wDisableBackgroundScroll], a
    ld [wVBlankOccurred], a
    ld [wStageTransitionActive], a
    ld [wBackgroundScrollTimer], a
    ld [$cfa1], a
    ld [wNextCreditsEntryIndex], a
    ld [wTextCopyPending], a
    ld [wScreenShakeRequested], a
    ld [wScreenShakeOffset], a
    ld a, [wCurrentStage]
    cp $07
    jr nc, .postGame ; stage is >= 7

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

.postGame
    ld a, $50
    ldh [rSCX], a
    ld a, $60
    ldh [rSCY], a
    ld d, $88
    ld a, [wCurrentStage]
    cp $07
    jr z, .setWindowPosition ; stage is 7

    call ClearTileMap9C00
    ld d, $68

.setWindowPosition
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
    jr z, .setupStageEight ; stage is 8

    ld de, InitializeStageSevenCutscene ; stage 7
    call StoreAddressInFreeWramSlot
    jr .finishSetup

.setupStageEight
    xor a
    ld hl, $9c00
    ld b, $1f

.clearWindowMapBytes
    ld [hl+], a
    dec b
    jr nz, .clearWindowMapBytes

    ld de, InitializeStageEightCredits ; stage 8
    call StoreAddressInFreeWramSlot

.finishSetup
    ld a, $07
    ldh [rTAC], a
    ld [wDisableBackgroundScroll], a
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

UpdateGameOverFadeOut:
    ld hl, wGameOverFadeTimer
    ld a, [hl]
    inc [hl]
    cp $20
    jr nc, .fadeSecondPhase ; A >= $20

    ld a, $90
    ldh [rBGP], a
    ldh [rOBP0], a
    ldh [rOBP1], a
    jp AdvanceToNextHandler


.fadeSecondPhase
    cp $30
    jr nc, .fadeLastPhase ; A >= $30

    ld a, $40
    ldh [rBGP], a
    ldh [rOBP0], a
    ldh [rOBP1], a
    jp AdvanceToNextHandler


.fadeLastPhase
    cp $40
    jr nc, .setGameOverRequested

    xor a
    ldh [rBGP], a
    ldh [rOBP0], a
    ldh [rOBP1], a
    jp AdvanceToNextHandler


.setGameOverRequested
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
    ld hl, GameOverBackgroundTileGraphics
    ld de, $9000
    ld bc, $0360
    call CopyMemory
    ld a, $03
    ld [$2100], a
    ld hl, GameOverBlockDefinitions
    ld de, $d000
    ld bc, $0200
    call CopyMemory
    ld hl, GameOverBackgroundMap
    ld de, $d200
    ld bc, $0090
    call CopyMemory
    ld a, $01
    ld [$2100], a
    call ClearTileMap9800
    ld hl, wShadowOAM
    ld bc, $0c00
    call ZeroMemory
    ld hl, wBackgroundRowPosition
    ld a, $82
    ld [hl+], a
    ld a, $9b
    ld [hl], a
    call DrawInitialBackground
    ld de, GameOverTilePackets
    call DrawBackgroundTilePackets
    ld de, TopScoreTilePackets
    call DrawBackgroundTilePackets
    ld de, ScoreTilePackets
    call DrawBackgroundTilePackets
    call UpdateHighScore
    ld c, $07
    ld hl, $9a30
    ld de, wHighScore
    call CopyHUDScoreDigitsAndLabels
    ld c, $07
    ld hl, $9a90
    ld de, wPlayerScore
    call CopyHUDScoreDigitsAndLabels
    ld hl, $9c00
    xor a
    ld c, $14

.clearBytes
    ld [hl+], a
    dec c
    jr nz, .clearBytes

    ld a, $50
    ldh [rSCY], a
    ld a, $50
    ldh [rSCX], a
    ld a, $e4
    ldh [rBGP], a
    ldh [rOBP0], a
    ldh [rOBP1], a
    ld de, WaitForGameOverStartPress
    call StoreAddressInFreeWramSlot
    xor a
    ld [wGameOverExitTimer], a
    ld [wVBlankOccurred], a
    ld hl, GameOverMusic
    call SetupAudioPlayback
    ld [$cf9a], a
    ld a, $07
    ldh [rTAC], a
    ld a, $05
    ldh [rIE], a
    ld a, $c7
    ldh [rLCDC], a
    ei
    jp GameOverScreenLoop


StageMusicPointerTable: ; $07F8-$0809
    ; Audio definition pointers in ROM bank 1, indexed by stage.
    dw Stage1Music ; Stage 0
    dw Stage1Music ; Stage 1
    dw Stage1Music ; Stage 2
    dw Stage3Music ; Stage 3
    dw Stage4Music ; Stage 4
    dw Stage5Music ; Stage 5
    dw Stage6Music ; Stage 6
    dw Stage8Music ; Stage 7 (skipped by StartStageMusic)
    dw Stage8Music ; Stage 8

; Existing ROM bank 1 music definitions; no direct references to these entries found.
; StageMusicPointerTable indices $09/$0A would reach these adjacent words.
AdditionalMusicPointers: ; $080A-$080D
    dw GameOverMusic ; $080A -> $01:$5541
    dw BossMusic ; $080C -> $01:$5EB0

PauseLabelTiles: ; $080E: "PAUSE "; pause copies only "PAUS", retaining the existing "E ".
    db $d2, $b4, $dc, $d8, $bc, $bf

ScoreLabelTiles: ; $0814: "SCORE ".
    db $d8, $b8, $d0, $d6, $bc, $bf

INCLUDE "engine/joypad.asm"


CopyDMARoutineToHRAMLoopSetup:
    ld c, $80
    ld b, $0a
    ld hl, OAMDMARoutine

; Copy OAMDMARoutine to hOAMDMARoutine, opcodes
; Copied routine starts OAM DMA and then waits
; https://gbdev.io/pandocs/OAM_DMA_Transfer.html
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

; DE contains start of packet data
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
    and $3f ; mask off control bits (top two)
    ld b, a ; store number of bytes to copy
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
    ld hl, wPlayerYPos
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
    jr c, .playerRight ; Player X > source X + 24

    ld a, e
    sub $18
    sub c
    jr nc, .playerLeft ; Player X <= source X - 24

    ld a, d
    sub b
    jr c, .playerBelow ; Player is below the source

    xor a ; Up
    ret

.playerBelow
    ld a, $04 ; Down
    ret

; Player is right of the horizontal band.
.playerRight
    ld a, d
    add $18
    sub b
    jr c, .downRight

    ld a, d
    sub $18
    sub b
    jr nc, .upRight

    ld a, $02 ; Right
    ret

.downRight
    ld a, $03 ; Down-right
    ret

.upRight
    ld a, $01 ; Up-right
    ret

; Player is at or left of the horizontal band's left edge.
.playerLeft
    ld a, d
    add $18
    sub b
    jr c, .downLeft

    ld a, d
    sub $18
    sub b
    jr nc, .upLeft

    ld a, $06 ; Left
    ret

.downLeft:
    ld a, $05 ; Down-left
    ret

.upLeft
    ld a, $07 ; Up-left
    ret

InitializeMovementScriptFromTable:
    ld hl, HANDLER_MOVEMENT_SCRIPT_INDEX_OFFSET
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
    ld hl, HANDLER_MOVEMENT_SCRIPT_TABLE_CURSOR_OFFSET
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
    ld de, OBJECT_DAMAGE_THRESHOLD_OFFSET
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
    ld hl, HANDLER_ENEMY_SHOT_COUNTER_OFFSET
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
    ld de, OBJECT_COLLISION_CENTER_Y_OFFSET
    add hl, de
    ld de, wCollisionPointY
    ld a, [hl+]
    ld [de], a
    inc de
    ld a, [hl]
    ld [de], a
    ld hl, wPlayerHitboxMinY ; Player hitbox minimum Y
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
    ld bc, wPlayerCollisionCenterY
    ld de, wCollisionPointY
    ld a, [bc]
    ld [de], a
    inc de
    inc bc
    ld a, [bc]
    ld [de], a
    ld de, OBJECT_HITBOX_MIN_Y_OFFSET
    add hl, de
    call CheckPointInHitbox
    ld a, c
    or a
    ret z

    ld a, $01
    ld [wPlayerDeathRequested], a
    ret

; Returns A = 0 if unchanged, nonzero if damage changed.
CheckForNewEnemyDamage:
    ld a, [bc]
    call SetObjectPointer
    ld de, OBJECT_DAMAGE_ACCUMULATED_OFFSET
    add hl, de
    ld d, [hl] ; put accum damage in D
    ld hl, HANDLER_ENEMY_PREVIOUS_TOTAL_DAMAGE_OFFSET
    add hl, bc
    ld a, [hl]
    ld [hl], d
    xor d ; compare previous and current totals
    or a ; set flags based on results
    ret z

    ld a, [wSoundSuppressionTimer]
    or a
    ret nz

    ld hl, BossDamageSound
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
    ld [hl], a ; store damage threshold
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

.clearBytes
    ld [hl+], a
    dec b
    jr nz, .clearBytes

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
    jr z, .positiveSign ; jump if bit 7 (top bit) in a is zero

    ld hl, HANDLER_NEGATIVE_Y_FRACTIONAL_REMAINDER_OFFSET ; Handler data: negative Y fractional remainder
    add hl, bc
    cpl
    inc a ; turn the number positive
    call AccumulateFractionalMovement
    cpl
    inc a
    jr .return

; A is nonnegative.
.positiveSign
    ld hl, HANDLER_POSITIVE_Y_FRACTIONAL_REMAINDER_OFFSET ; Handler data: positive Y fractional remainder
    add hl, bc
    call AccumulateFractionalMovement

.return
    ld [$ca16], a
    ret


CalculateXMovement:
    bit 7, a
    jr z, .positiveSign ; jump if bit 7 is 0

    ld hl, HANDLER_NEGATIVE_X_FRACTIONAL_REMAINDER_OFFSET
    add hl, bc
    cpl
    inc a
    call AccumulateFractionalMovement
    cpl
    inc a
    jr .return

.positiveSign
    ld hl, HANDLER_POSITIVE_X_FRACTIONAL_REMAINDER_OFFSET
    add hl, bc
    call AccumulateFractionalMovement

.return
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

HandleEnemyDefeat:
    ld a, d
    call AddPlayerScore
    ld hl, wSelectedObjectPointer
    ld a, [hl+]
    ld h, [hl]
    ld l, a
    ld de, OBJECT_SHOT_COLLISION_DISABLED_OFFSET
    add hl, de
    inc [hl]
    ld a, [wSoundSuppressionTimer]
    or a
    jr nz, .setSmokeGraphics

    ld hl, wCurrentHandlerDataPointer
    ld a, [hl+]
    ld h, [hl]
    ld l, a
    ld de, HANDLER_ENEMY_DEFEAT_SOUND_INDEX_OFFSET
    add hl, de
    ld a, [hl]
    and $03
    add a
    ld l, a
    ld h, $00
    ld de, DefeatSoundPointers
    add hl, de
    ld a, [hl+]
    ld h, [hl]
    ld l, a
    ld a, $01
    call SetupAudioPlayback

.setSmokeGraphics
    ld de, AssignSmokeGraphics
    jp SetCurrentHandlerAddress

MoveObjectWithFractionalVelocity:
    ld a, d
    call CalculateYMovement
    ld a, e
    call CalculateXMovement
    ld hl, $ca16
    ld a, [hl+]
    ld e, [hl]
    ld d, a
    jp MoveObject


GetCurrentPlaybackStatus:
    ld a, [$cf9a]
    dec a
    ld l, a
    ld h, $00
    ld de, wPlaybackSlotActiveTable
    add hl, de
    ld a, [hl]
    ret

DefeatSoundPointers:
    dw DefeatSound0, DefeatSound1, DefeatSound2, DefeatSound3

UpdatePlayerStatus:
    call UpdatePlayerLivesHUD
    ld hl, wSoundSuppressionTimer
    ld a, [hl]
    or a
    jr z, .updateInvincibility

    ; Increment counter; wrap from 63 to 0
    inc a
    and $3f
    ld [hl], a

.updateInvincibility
    ld a, [$ca2a]
    or a
    jr z, UpdatePlayerInvincibilityTimer

    ld [wPlayerInvincible], a
    jp AdvanceToNextHandler

UpdatePlayerInvincibilityTimer:
    ld hl, wPlayerInvincibilityTimer
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
    ld hl, ExtraLifeSound
    call SetupAudioPlayback
    ld [wSoundSuppressionTimer], a
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
    ld hl, HANDLER_MOVEMENT_COMMAND_POINTER_OFFSET
    add hl, bc
    ld a, [hl+]
    ld b, [hl] ; HL points at handler offset $0D
    ld c, a
    ld a, [bc] ; get the next byte from the movement sequence into A
    inc bc ; point BC at next movement byte
    ld de, $0000
    rlca
    jr nc, .checkBit6 ; bit 7 was 0

    ld d, $fd ; Y - 3

.checkBit6
    rlca
    jr nc, .checkBit5 ; bit 6 was 0

    ld d, $03 ; Y + 3

.checkBit5:
    rlca
    jr nc, .checkBit4 ; bit 5 was 0

    ld e, $fd ; X - 3

.checkBit4:
    rlca
    jr nc, .checkBit3 ;  bit 4 was 0

    ld e, $03 ; X + 3

.checkBit3:
    rlca
    jr c, AdvanceToNextMovementSequence ; bit 3 was 1

    ; Store pointer to the next movement byte at handler offsets $0C-$0D.
    ld a, b
    ld [hl-], a
    ld [hl], c
    ret


AdvanceToNextMovementSequence:
    dec hl
    dec hl
    ld a, [hl-]
    ld c, [hl]
    ld b, a ; Load pointer to the current script-table entry into BC.
    inc bc
    inc bc ; Advance to the next two-byte script-table entry.
    ld a, c
    ld [hl+], a
    ld [hl], b ; Store pointer to the new script-table entry at $0A-$0B.
    inc hl
    ld a, [bc]
    ld [hl+], a
    inc bc
    ld a, [bc]
    ld [hl+], a ; Store the new sequence's starting address at $0C-$0D.
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
    ld a, [wBossEncounterEnding]
    or a
    jp nz, RemoveCurrentHandler

    ld hl, rSCY
    dec [hl]
    jp AdvanceToNextHandler


DisableBackgroundScroll:
    ld a, $01
    ld [wDisableBackgroundScroll], a
    jp RemoveCurrentHandler


EnableBackgroundScroll:
    xor a
    ld [wDisableBackgroundScroll], a
    jp RemoveCurrentHandler

SetAlternatePlayerExitFlag:
    ld a, $01
    ld [$cac8], a
    jp RemoveCurrentHandler


ActivateBoss:
    ld a, $01
    ld [wBossActive], a
    jp RemoveCurrentHandler

SetStageReady:
    ld a, $01
    ld [wStageReady], a
    xor a
    ld [wBossEncounterEnding], a
    jp RemoveCurrentHandler


StartAlternateBossAudio:
    ld hl, $cfa1
    inc [hl]
    ld hl, AlternateBossMusic
    xor a
    call SetupAudioPlayback
    ld [$cf9a], a
    jp RemoveCurrentHandler


StartBossAudio:
    ld hl, BossMusic
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
    call CopyMemory ;  copy block definitions
    pop hl
    inc hl
    inc hl
    ld a, [hl+]
    ld h, [hl]
    ld l, a
    ld de, $d200
    ld bc, $0550
    call CopyMemory ; copy background map
    ld a, [wCurrentStage]
    ld de, StageEventDataPointerTable
    add a
    ld l, a
    ld h, $00
    add hl, de
    ld a, [hl+]
    ld h, [hl]
    ld l, a
    ld de, $d800
    ld bc, $0400
    call CopyMemory ; copy stages events
    ld a, $01
    ld [$2100], a
    ret

StageBackgroundDataTable:
    ; ROM bank 3 source pointers: block definitions, background map.
    ; Copied to $D000 ($0200 bytes) and $D200 ($0550 bytes), respectively.
    dw BackgroundBlockDefinitions_0, BackgroundMap_0 ; Stage 0
    dw BackgroundBlockDefinitions_0, BackgroundMap_1 ; Stage 1
    dw BackgroundBlockDefinitions_0, BackgroundMap_2 ; Stage 2
    dw BackgroundBlockDefinitions_1, BackgroundMap_3 ; Stage 3
    dw BackgroundBlockDefinitions_1, BackgroundMap_4 ; Stage 4
    dw BackgroundBlockDefinitions_2, BackgroundMap_5 ; Stage 5
    dw BackgroundBlockDefinitions_2, BackgroundMap_6 ; Stage 6
    dw BackgroundBlockDefinitions_3, BackgroundMap_7 ; Stage 7
    dw BackgroundBlockDefinitions_4, BackgroundMap_8 ; Stage 8

StageTileGraphicsTable:
    ; Bytes to copy, source address
    ; Stage 0
    dw $0350, Stage0To2BackgroundTileGraphics
    ; Stage 1
    dw $0350, Stage0To2BackgroundTileGraphics 
    ; Stage 2
    dw $0350, Stage0To2BackgroundTileGraphics
    ; Stage 3
    dw $0640, Stage3And4BackgroundTileGraphics
    ; Stage 4
    dw $0640, Stage3And4BackgroundTileGraphics
    ; Stage 5
    dw $06B0, Stage5And6BackgroundTileGraphics
    ; Stage 6
    dw $06B0, Stage5And6BackgroundTileGraphics
    ; Stage 7
    dw $0510, Stage7BackgroundTileGraphics
    ; Stage 8
    dw $01A0, Stage8BackgroundTileGraphics

StageEventDataPointerTable:
    dw Stage0EventStream ; Stage 0
    dw Stage1EventStream ; Stage 1
    dw Stage2EventStream ; Stage 2
    dw Stage3EventStream ; Stage 3
    dw Stage4EventStream ; Stage 4
    dw Stage5EventStream ; Stage 5
    dw Stage6EventStream ; Stage 6
    dw Stage7EventStream ; Stage 7
    dw Stage8EventStream ; Stage 8

StageEventHandlerTable:
    ; Indexed by event type; each entry is a little-endian handler address.
    dw RemoveCurrentHandler ; event type $00 (handled directly by ScheduleStageEvents)
    dw RequestNextStage ; event type $01 (handled directly by ScheduleStageEvents)
    dw DisableBackgroundScroll ; event type $02
    dw SetAlternatePlayerExitFlag ; event type $03 ; seems unused
    dw InitializeStageAnnouncement ; event type $04
    dw InitializeProtodroid ; event type $05
    dw InitializeCruiser ; event type $06
    dw InitializeRotomech ; event type $07
    dw InitializePincher ; event type $08
    dw InitializeArrowhead ; event type $09
    dw InitializeHarrier ; event type $0a
    dw InitializePowerUpContainer ; event type $0b
    dw InitializeDestructor ; event type $0c
    dw InitializeOctopod ; event type $0d
    dw InitializeEpikhan ; event type $0e
    dw InitializeOmniquad ; event type $0f
    dw InitializeXenocrypt ; event type $10
    dw InitializeQuasiObliterator ; event type $11
    dw ActivateBoss ; event type $12
    dw SetStageReady ; event type $13
    dw InitializeTerraCannon ; event type $14
    dw EnableBackgroundScroll ; event type $15
    dw InitializeSkimbot ; event type $16
    dw InitializeStageFourBoss ; event type $17
    dw InitializeStageFiveBoss ; event type $18
    dw InitializeFinalBoss ; event type $19
    dw InitializeStageSevenCutscene ; event type $1a ; not used via this table
    dw RemoveCurrentHandler ; event type $1b
    dw StartBossAudio ; event type $1c
    dw StopStageAudio ; event type $1d
    dw StartAlternateBossAudio ; event type $1e
    dw InitializeStageEightCredits ; event type $1f ; not used via this table
    dw InitializeBatwing ; event type $20
    dw InitializeZigzag ; event type $21
    dw InitializeBlazer ; event type $22
    dw InitializeMiditron ; event type $23
    dw InitializeAnthrop ; event type $24
    dw IncreaseScrollSpeed ; event type $25
    dw InitializeTwerk ; event type $26
    dw InitializeScarab ; event type $27
    dw InitializeMack ; event type $28
    dw InitializeVexor ; event type $29
    dw InitializeWarhawk ; event type $2a
    dw InitializeUltraCrusher ; event type $2b

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
    db $08, $18, $20, $28, $30, $38, $48, $50, $58, $68, $70, $78, $80, $88, $98, $a0

XenocryptStartingXCoords: ; $0F29
    db $48, $50, $58, $60

QuasiObliteratorStartingXCoords: ; $0F2D, left/right part X coordinates.
    db $48, $58

ApplyHorizontalScrollOffsetToCoordinatePair:
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


OmniquadStartingCoordinates:
    db $10, $50 ; center
    db $20, $50 ; below
    db $10, $40 ; left
    db $10, $60 ; right
    db $00, $50 ; above

    ;Unused?
    db $20, $48
    db $18, $38
    db $18, $58
    db $30, $50

StageFourBossStartingCoordinates:
    db $38, $48 ; center
    db $28, $38 ; left vertical part
    db $28, $58 ; right vertical part
    db $38, $18 ; left horizontal part
    db $38, $68 ; right horizontal part

StageFourBossShotCoordinates: ; $0F58, (Y, X) pairs
    db $60, $40
    db $60, $58
    db $58, $30
    db $58, $68
    db $50, $18
    db $50, $80
    db $48, $08
    db $48, $90
    db $30, $08
    db $30, $90
    db $28, $18
    db $28, $80
    db $20, $30
    db $20, $68
    db $18, $40
    db $18, $58

StageFiveBossStartingCoordinates: ; $0F78, (Y, X)
    db $18, $50

StageFiveBossAlternateShotCoordinates: ; $0F7A, (Y, X) pairs
    db $28, $1c ; index 0
    db $40, $54 ; index 1
    db $28, $8c ; index 2

StageFiveBossShotCoordinates: ; $0F80, (Y, X) pairs
    db $1c, $08
    db $1c, $10
    db $34, $30
    db $2c, $40
    db $2c, $48
    db $2c, $60
    db $2c, $68
    db $34, $78
    db $1c, $98
    db $1c, $a0
    db $34, $30
    db $2c, $40
    db $2c, $48
    db $2c, $60
    db $2c, $68
    db $34, $78

FinalBossStartingCoordinates: ; $0FA0, (Y, X)
    db $18, $50

FinalBossShotCoordinates:
    db $38, $2c
    db $38, $7c
    db $88, $1c
    db $88, $8c

InitializeHandlerDataPair:
    ld de, HANDLER_ENEMY_SHOT_TRIGGER_OFFSET
    add hl, de
    push hl
    ld a, [wStageEventParams + 1]
    add a

SetupDataPairOffset:
    ld l, a
    ld h, $00

WriteDataPairBytes:
    ld de, FiringTimingTable
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


    ; $0FD5: two-byte entries indexed by wStageEventParams + 1 (low nibble of 4th event byte).
    ; stored in handler data offset $08-$09
    ; first byte is when to fire, second byte is when to reset cycle
    ; Example: $1C, $40 attempts firing at count 28 and resets at count 64.
    ; Subsequent firing attempts are 64 timer updates apart.
    ; counter is stored in offset $07
FiringTimingTable:
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
    ld hl, HANDLER_PROJECTILE_DIRECTION_INDEX_OFFSET
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
    ld a, [wEnableAltProjectileMovement]
    or a
    jr nz, SetProjectileVelocityAndStartUpdateCycle ; Use the alternate projectile movement table

    ld a, [wEnemyShotSpeedLevel]
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
    ld hl, HANDLER_PROJECTILE_DIRECTION_INDEX_OFFSET
    add hl, bc
    ld a, [hl]
    add a
    ld l, a
    ld h, $00
    add hl, de
    ld a, [hl+]
    ld e, [hl]
    ld hl, HANDLER_ENEMY_SHOT_Y_VELOCITY_OFFSET
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
    ld hl, HANDLER_ENEMY_SHOT_Y_VELOCITY_OFFSET
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
    ld hl, wEnemyFiringSequenceSpawnY
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
    ld hl, wFiringCadenceCounter
    inc [hl]
    ld a, [hl]
    and $01
    jp nz, AdvanceToNextHandler

    ld [hl], a
    ld de, TrySpawnFiringSequenceProjectile
    call StoreAddressInFreeWramSlot
    ld a, [wFiringPatternIndex]
    ld e, a
    ld d, $00
    ld hl, FiringSequenceSpawnCounts
    add hl, de
    ld b, [hl]
    ld hl, wFiringSpawnAttemptsCounter
    inc [hl]
    ld a, [hl]
    cp b
    jp nz, AdvanceToNextHandler

    xor a
    ld [wFiringSpawnAttemptsCounter], a
    jp RemoveCurrentHandler

TrySpawnFiringSequenceProjectile:
    ld bc, EnemyProjectileObjectTemplate
    ld hl, wEnemyFiringSequenceSpawnY
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
    ld hl, HANDLER_PROJECTILE_DIRECTION_INDEX_OFFSET
    add hl, bc
    push hl
    ld bc, wFiringPatternIndex
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
    ld a, [wEnemyShotSpeedLevel]
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

CheckAltProjectileMovementAndSetHandler: ; unused?
    ld de, EnemyShotAdditionalAlternateMovementTable
    ld a, [wEnableAltProjectileMovement]
    or a
    jp nz, SetProjectileVelocityAndStartUpdateCycle

    ld de, EnemyShotAdditionalMovementTable
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
; Data extends through $12DD, immediately before EnemyShotMovementTable0.
; Rows $04-$0B retain raw values; usage of every row has not been established.
FiringSequenceDirectionTable: ; $127E
    db $04, $04, $04, $04, $04, $04, $04, $04 ; Pattern $00
    db $02, $06, $02, $06, $02, $06, $02, $06 ; Pattern $01
    db $00, $04, $00, $04, $00, $04, $00, $04 ; Pattern $02
    db $03, $04, $05, $03, $04, $05, $05, $07 ; Pattern $03 (Epikhan and Vexor)

    db $01, $03, $05, $07, $01, $03, $05, $07 ; Row $04, ROM $129E
    db $00, $02, $04, $06, $00, $02, $04, $06 ; Row $05, ROM $12A6
    db $02, $03, $04, $05, $06, $04, $04, $04 ; Row $06, ROM $12AE
    db $06, $07, $00, $01, $02, $03, $04, $05 ; Row $07, ROM $12B6
    db $00, $01, $05, $09, $0a, $04, $04, $04 ; Row $08, ROM $12BE
    db $02, $04, $05, $06, $08, $04, $04, $04 ; Row $09, ROM $12C6
    db $01, $03, $05, $07, $09, $04, $04, $04 ; Row $0A, ROM $12CE
    db $03, $04, $05, $06, $07, $04, $04, $04 ; Row $0B, ROM $12D6

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

; Additional projectile velocity tables: 11 (Y, X) pairs each.
; Signed 1/16-pixel units, selected by CheckAltProjectileMovementAndSetHandler.
; That routine appears unused; normal gameplay use of these tables is unconfirmed.

EnemyShotAdditionalMovementTable: ; $134E
    db $00, $40
    db $2d, $2d
    db $3b, $18
    db $3e, $0c
    db $3f, $06
    db $40, $00
    db $3f, $fa
    db $3e, $f4
    db $3b, $e8
    db $2d, $d3
    db $00, $c0

EnemyShotAdditionalAlternateMovementTable: ; $1364
    db $00, $60
    db $44, $44
    db $59, $25
    db $5d, $13
    db $5f, $09
    db $60, $00
    db $5f, $f7
    db $5d, $ed
    db $59, $db
    db $44, $bc
    db $00, $a0

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
    jr nz, .updateScroll ; if a not zero

    inc [hl] ; inc ca83 byte by 1

.updateScroll
    ld a, $01
    ld [wBlockDrawIdle], a
    ld a, [wDisableBackgroundScroll]
    or a
    ret nz ; return if not zero

    ld hl, rSCY
    dec [hl] ; move rSCY down (Y scroll)
    ld de, wCurrentBlockId
    ld a, [de]
    cp $ff
    ret z ; return if wCurrentBlockId is equal to FF

    inc de 
    inc de ; move de to wBackgroundRowComplete
    ld a, [hl] 
    and $0f 
    jr nz, .nextMapBlock ; jump if bottom 4 bits are not zero, or when scy is not a multiple of 16

    ; scy was a multiple of 16
    ld [de], a ; store 0 in wBackgroundRowComplete
    ld hl, wBackgroundDrawRowPosition
    ld bc, wBlockDrawDestination
    ld a, [hl+] ; store wBackgroundDrawRowPosition byte in a, move hl to wBackgroundDrawRowPosition + 1
    and $f0 
    or $02 ; keep top four bits and set second bit
    ld [bc], a ; store at wBlockDrawDestination
    inc bc ; move bc to ca91
    ld a, [hl+] ; store wBackgroundDrawRowPosition + 1 byte in a
    ld [bc], a ; put that byte at ca91
    ret

; scy was not a multiple of 16
.nextMapBlock
    ld a, [de]
    or a
    ret nz ; check if wBackgroundRowComplete is 0, return if NOT zero

    ld a, [wBlockDrawIdle]
    or a
    ret z ; return if wBlockDrawIdle is 0

    call ReadNextMapBlock
    ld hl, wCurrentRowBlockCounter
    inc [hl]
    ld a, [hl+]
    cp $0e
    ret nz ; increment the value at wCurrentRowBlockCounter and compare to 14, return if NOT 14

    inc a
    ld [hl-], a ; inc a and store in wBackgroundRowComplete
    xor a
    ld [hl], a ; zero out wCurrentRowBlockCounter
    jp MoveMapPositionUpOneBlockRow


; Draw the initial background as 14 columns by 11 rows of 2x2 tile blocks.
; Initialize the drawing position (wBackgroundDrawRowPosition) from wBackgroundRowPosition.
; Set the map read pointer (wMapReadPointer) to the block IDs at $D200.
DrawInitialBackground:
    ld de, wBackgroundRowPosition ; caller sets this as starting point in BG map
    ld hl, wBackgroundDrawRowPosition ; put this value in wBackgroundDrawRowPosition
    ld a, [de]
    ld [hl+], a
    inc de
    ld a, [de]
    ld [hl], a
    ld hl, wMapReadPointer
    xor a
    ld [hl+], a
    ld a, $d2
    ld [hl], a
    ld b, $0b ; 11

CopyBlockRow:
    ld hl, wBackgroundDrawRowPosition
    ld de, wBlockDrawDestination
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

    ld hl, wBackgroundDrawRowPosition
    ld de, wBlockDrawDestination
    ld a, [hl+]
    ld [de], a
    inc de
    ld a, [hl+]
    ld [de], a
    ld a, $01
    ld [wBlockDrawIdle], a
    xor a
    ld [wCurrentRowBlockCounter], a
    ret

ReadNextMapBlock:
    ld hl, wMapReadPointer
    ld a, [hl+]
    ld e, a
    ld a, [hl-] ; put HL back to wMapReadPointer
    ld d, a ; sets DE to background map byte address
    ld bc, wCurrentBlockId
    ld a, [de] ; check the byte in the background map
    ld [bc], a ; load to wCurrentBlockId and check if its FF if so return
    cp $ff
    ret z

    inc de ; move DE to the next background map byte
    ld a, e
    ld [hl+], a
    ld [hl], d ; store next background map byte address back in wMapReadPointer
    ld a, [bc] ; put the byte into HL to start creating a pointer
    ld h, $00
    ld l, a
    ld de, $d000
    add hl, hl ; double
    add hl, hl ; double, four byte entries because block is 2x2 tiles
    add hl, de ; point at a byte in D000 (four byte block definition)
    ld d, h
    ld a, l
    ld hl, wMapBlockPointer
    ld [hl+], a
    ld [hl], d ; store the pointer in wMapBlockPointer
    xor a
    ld [wBlockDrawIdle], a
    ret

DrawMapBlock:
    ld a, [wBlockDrawIdle]
    or a
    ret nz

    ld hl, wMapBlockPointer
    ld a, [hl+]
    ld d, [hl]
    ld e, a ; save the pointer we stored in wMapBlockPointer, to DE
    ld hl, wBlockDrawDestination
    ld a, [hl+]
    ld h, [hl]
    ld l, a ; store the address of where the next block goes to HL
    ld a, [de] ; get the tile byte into a
    ld [hl+], a ; write to tile to the address and move to next tile (same row)
    inc de ; move pointer to next byte
    ld a, [de]
    ld [hl+], a ; load the next tile and increment HL
    inc de ; move pointer to next byte
    ld bc, $001e
    add hl, bc ; Add $001e to skip the remaining row and end up at the right spot on the next row
    ld a, [de]
    ld [hl+], a
    inc de
    ld a, [de]
    ld [hl+], a ; load the last two tiles
    ld hl, wBlockDrawDestination
    inc [hl]
    inc [hl] ; increment wBlockDrawDestination to where the next block will start
    ld a, $01
    ld [wBlockDrawIdle], a
    ret


MoveMapPositionUpOneBlockRow:
    ld hl, wBackgroundRowPosition
    ld d, h
    ld e, l ; put wBackgroundRowPosition in DE also
    ld a, [hl+]
    ld h, [hl]
    ld l, a
    ld bc, $ffc0 ; twos compliment of $0040 (2 rows worth of 32 tiles)
    add hl, bc
    ld a, l
    ld b, a ; low part of the result in B
    ld [de], a
    ld a, h
    cp $97 ; if we've gone past the top of the background tilemap wrap back around
    jr nz, StoreMapRowPosition

    ld a, $9b

StoreMapRowPosition:
    ld hl, wBackgroundDrawRowPosition + 1
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
    ld hl, wPlayerYPos
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

StartPlayerDeathSequence:
    ld hl, PlayerDeathSound
    ld a, $01
    call SetupAudioPlayback
    xor a
    ld [wPlayerShotCooldown], a
    ld de, InitializePlayerDeathSmoke
    jp SetCurrentHandlerAddress


InitializePlayerDeathSmoke:
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
    ld de, WaitAndConfigurePlayerRespawn
    jp SetCurrentHandlerAddress

WaitAndConfigurePlayerRespawn:
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
    ld de, WeaponPowerAfterDeathTable
    add hl, de
    ld a, [hl]
    ld [wWeaponPowerLevel], a
    ld [wEnemyShotSpeedLevel], a
    ld a, [wPlayerLives]
    or a
    jr z, .startGameOver

    call DecrementPlayerLives
    ld de, MovePlayerBackToStage
    jp SetCurrentHandlerAddress


.startGameOver
    ld de, StartGameOverSequence
    jp SetCurrentHandlerAddress

MovePlayerBackToStage:
    ld a, [bc]
    call SetObjectPointer
    inc hl
    ld a, [hl]
    cp $60
    jp c, FinishPlayerDeathSequence

    ld de, $ff00
    call MoveObject
    jp AdvanceToNextHandler

FinishPlayerDeathSequence:
    xor a
    ld [wPlayerDeathRequested], a
    ld de, PlayerMovementHandler
    jp SetCurrentHandlerAddress

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

Jump_000_168a:
    db $ff ; $E: Down + Up + Left
    db $ff ; $F: All four directions

WeaponPowerAfterDeathTable: ; $168C: indexed by weapon power level before death.
    db $00, $00, $00, $01, $01, $03 ; Levels 0-5.
    db $03, $03                   ; Unused indices 6-7.

PlayerInitTemplate:
    db $12, $08, $08, $02, $02, $0e, $0e

; First byte is also the final byte of PlayerInitTemplate.
PlayerSpriteData:
    db $02, $00, $02, $20

PlayerBlinkSpriteData:
    db $00, $00, $00, $00
    
PlayerMovementTable:
    db $d0, $00 ; Up
    db $de, $22 ; Up-Right
    db $00, $30 ; Right
    db $22, $22 ; Down-Right
    db $30, $00 ; Down
    db $22, $de ; Down-Left
    db $00, $d0 ; Left
    db $de, $de ; Up-left

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
    ld de, WaitForStageReady
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
    ld de, PlayerDirectionLookupTable
    add hl, de
    ld a, [hl]
    ld [$ca25], a ; store the movement input calculated
    pop bc
    cp $ff ; check if movement input cancels out
    jr z, SchedulePlayerStateUpdate

    add a
    ld e, a
    ld d, $00
    ld hl, PlayerMovementTable
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
    jr nz, StartMovePlayerToNextStage

    ld a, [wPlayerInvincible]
    or a
    jr nz, HandlePlayerActionInput

    ld a, [wPlayerDeathRequested]
    or a
    jp nz, StartPlayerDeathSequence

HandlePlayerActionInput:
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


StartMovePlayerToNextStage:
    ld de, PlayerSpriteData
    call SetObjectGraphicsPointer
    ld de, PlayStageTransitionAudio
    jp SetCurrentHandlerAddress

PlayStageTransitionAudio:
    ld a, [wCurrentStage]
    cp $06
    jr z, .startMoveToExit

    ld hl, StageTransitionMusic
    ld a, $01
    call SetupAudioPlayback
    ld [$cf9a], a

.startMoveToExit
    ld de, MoveToExitPosition
    jp SetCurrentHandlerAddress

MoveToExitPosition:
    ld a, [bc]
    call SetObjectPointer
    ld de, $0000
    inc hl
    ld a, [hl+]
    cp $80
    jr z, .checkXPos ; check Y pos

    ld d, $08
    jr c, .checkXPos

    ld d, $f8 ; set Y movement based on current position

.checkXPos
    ld a, [hl]
    cp $28
    jr z, .checkFinalPos ; check x position

    ld e, $08
    jr c, .checkFinalPos

    ld e, $f8 ; set x movement based on current position

.checkFinalPos
    ld a, d
    or e
    jr z, .positionReached ; if d and e are both zero we have reach target

    ; otherwise move player object
    call MoveObjectWithFractionalVelocity
    jp AdvanceToNextHandler


.positionReached
    ld a, $01
    ld [wPlayerExitPositionReached], a
    ld de, WaitForPlayerExitPermission
    jp SetCurrentHandlerAddress

WaitForPlayerExitPermission:
    ld a, [wPlayerExitAllowed]
    or a
    jp z, AdvanceToNextHandler

    ld a, [bc]
    ld hl, $000f
    add hl, bc
    xor a
    ld [hl+], a
    ld [hl], a
    ld [wPlayerInvincible], a
    ld de, UpdatePlayerStageExitMovement
    jp SetCurrentHandlerAddress


HandleShotRequest:
    ld bc, wPlayerShotCooldown
    ld a, [bc]
    or a
    jp z, AdvanceToNextHandler

    cp $01
    jr z, .tryFirePlayerShot

    inc a
    and $07
    ld [bc], a
    jp AdvanceToNextHandler


.tryFirePlayerShot
    inc a
    ld [bc], a
    ld a, [wWeaponPowerLevel]
    ld de, FindEmptyShotSlot
    jp SetCurrentHandlerAddress

InitializePlayerShot:
    ld bc, PlayerShotNarrowInitTemplate
    ld de, $0000
    ld a, [wPlayerShotAllocationIndex]
    inc a
    ld [wPlayerShotAllocationIndex], a
    call TryInitializeObjectAtIndex
    jp c, RemoveCurrentHandler

    ld hl, wCurrentHandlerDataPointer
    ld a, [hl+]
    ld h, [hl]
    ld l, a
    ld a, [wAllocatedObjectIndex]
    ld [hl], a
    ld de, WaitForShotRequest
    jp SetCurrentHandlerAddress

InitializePlayerShotAttributes:
    ld a, [wWeaponPowerLevel]
    or a
    jr z, .setNarrowTemplate

    ld a, [hl+]
    ld d, a
    ld e, [hl]
    ld a, $12
    ld [bc], a
    ld bc, PlayerShotWideInitTemplate
    jr .resetAttributes

.setNarrowTemplate
    ld a, [hl+]
    ld d, a
    ld a, [hl]
    add $06 ; center narrow shot
    ld e, a
    ld bc, PlayerShotNarrowInitTemplate

.resetAttributes
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

CheckNarrowShotCollision:
    ld hl, wSelectedObjectPointer
    ld a, [hl+]
    ld h, [hl]
    ld l, a
    ld bc, OBJECT_COLLISION_CENTER_Y_OFFSET
    add hl, bc
    ld bc, wCollisionPointY
    ld a, [hl+]
    ld [bc], a
    inc bc
    ld a, [hl]
    ld [bc], a
    jr CheckActiveObjectsForShotCollision

CheckWideShotCollisionLeft:
    ld hl, wSelectedObjectPointer
    ld a, [hl+]
    ld h, [hl]
    ld l, a
    ld bc, OBJECT_COLLISION_CENTER_Y_OFFSET
    add hl, bc
    ld bc, wCollisionPointY
    ld a, [hl+]
    ld [bc], a
    inc bc
    ld a, [hl]
    sub $04
    ld [bc], a
    jr CheckActiveObjectsForShotCollision

CheckWideShotCollisionRight:
    ld hl, wSelectedObjectPointer
    ld a, [hl+]
    ld h, [hl]
    ld l, a
    ld bc, OBJECT_COLLISION_CENTER_Y_OFFSET
    add hl, bc
    ld bc, wCollisionPointY
    ld a, [hl+]
    ld [bc], a
    inc bc
    ld a, [hl]
    add $04
    ld [bc], a

; A = 1 on hit, A = 0 when no object was hit
CheckActiveObjectsForShotCollision:
    ld hl, wObjectTable + ($0010 * 4) ; start after player and player shots
    ld b, $0c ; number of objects to check

CheckCurrentObjectForCollision:
    push hl
    ld a, [hl]
    or a
    jp z, .moveToNextObject

    ld de, OBJECT_SHOT_COLLISION_DISABLED_OFFSET
    add hl, de
    ld a, [hl+]
    or a
    jr nz, .moveToNextObject

    inc hl
    inc hl
    push hl
    call CheckPointInHitbox
    pop hl
    ld a, c
    or a
    jr z, .moveToNextObject

    ld de, OBJECT_DAMAGE_ACCUMULATED_OFFSET - OBJECT_HITBOX_MIN_Y_OFFSET
    add hl, de
    ld a, [wPlayerShotDamage]
    add [hl]
    ld [hl], a
    pop hl
    ld a, $01
    ret


.moveToNextObject
    pop hl
    ld de, $0010
    add hl, de
    dec b
    jp nz, CheckCurrentObjectForCollision

    ld a, b
    ret

PlayerShotNarrowInitTemplate: ; $18CB
    db $11             ; One row, one sprite column.
    db $08, $04        ; Collision center offset (Y, X).
    db $00, $01        ; Hitbox minimum offset (Y, X).
    db $10, $07        ; Hitbox maximum offset (Y, X).
    ; Damage threshold shares the next template's first byte ($12).

PlayerShotWideInitTemplate: ; $18D2
    db $12             ; One row, two sprite columns; also the preceding template's damage threshold.
    db $08, $08        ; Collision center offset (Y, X).
    db $00, $fe        ; Hitbox minimum offset (Y, X).
    db $10, $12        ; Hitbox maximum offset (Y, X).
    ; Damage threshold shares the damage table's first byte ($01).
PlayerShotDamageByPowerLevel: ; $18D9: damage for weapon power levels 0-5.
    db $01, $02, $02, $03, $03, $04

PlayerShotGraphicsByPowerLevel: ; $18DF: one pointer per weapon power level.
    dw PlayerShotGraphicsSingle   ; Level 0.
    dw PlayerShotGraphicsDouble   ; Level 1.
    dw PlayerShotGraphicsDouble   ; Level 2.
    dw PlayerShotGraphicsTriple  ; Level 3.
    dw PlayerShotGraphicsTriple  ; Level 4.
    dw PlayerShotGraphicsMaxPower ; Level 5.

; Player-shot graphics: (tile, attributes) pairs.
PlayerShotGraphicsSingle: ; $18EB: one sprite.
    db $0c, $00

PlayerShotGraphicsDouble: ; $18ED: two sprites; the second is flipped horizontally.
    db $0c, $00, $0c, $20

PlayerShotGraphicsTriple: ; $18F1: two sprites; the second is flipped horizontally.
    db $0e, $00, $0e, $20

PlayerShotGraphicsMaxPower: ; $18F5: two sprites.
    db $1c, $00, $1e, $00

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
    ld a, [wSoundSuppressionTimer]
    or a
    call z, ChoosePlayerFiringSound

ScheduleShotRequestHandler:
    ld de, HandleShotRequest
    jp SetCurrentHandlerAddress


ChoosePlayerFiringSound:
    ld hl, PlayerFiringSound
    ld a, [wWeaponPowerLevel]
    cp MAX_WEAPON_POWER_LEVEL
    jr nz, PlayPlayerFiringSound

    ld hl, MaxPowerFiringSound

PlayPlayerFiringSound:
    ld a, $01
    jp SetupAudioPlayback

WaitForShotRequest:
    ld a, [bc]
    ld l, a
    ld h, $00
    ld de, wWeaponShotSlots - 1
    add hl, de
    ld a, [hl]
    or a
    jp z, AdvanceToNextHandler

    ld de, ConfigurePlayerShot
    jp SetCurrentHandlerAddress

ConfigurePlayerShot:
    ld a, [bc]
    call SetObjectPointer
    ld b, h
    ld c, l
    ld hl, wPlayerYPos
    call InitializePlayerShotAttributes
    ld a, [wWeaponPowerLevel]
    add a
    ld l, a
    ld h, $00
    ld de, PlayerShotGraphicsByPowerLevel
    add hl, de
    ld a, [hl+]
    ld d, [hl]
    ld e, a
    call SetObjectGraphicsPointer
    ld de, UpdateShotPosition
    jp SetCurrentHandlerAddress

UpdateShotPosition:
    ld a, [bc]
    call SetObjectPointer
    inc hl
    ld a, [hl+]
    cp $e0
    jr nc, .deactivateShot ; y pos is >= $e0

    ld a, [hl]
    add $20
    cp $d0
    jr nc, .deactivateShot

    ld d, $f8
    ld e, $00
    call MoveObject
    ld de, CheckPlayerShotCollision
    jp SetCurrentHandlerAddress


.deactivateShot
    ld de, DeactivatePlayerShot
    jp SetCurrentHandlerAddress

CheckPlayerShotCollision:
    ld a, [bc]
    call SetObjectPointer
    ld a, [wWeaponPowerLevel]
    ld l, a
    ld h, $00
    ld de, PlayerShotDamageByPowerLevel
    add hl, de
    ld a, [hl]
    ld [wPlayerShotDamage], a
    ld a, [wWeaponPowerLevel]
    or a
    jr z, .narrowShot

    call CheckWideShotCollisionLeft
    or a
    jr nz, .deactivateShot

    call CheckWideShotCollisionRight
    jr z, .setUpdatePositionHandler

    jr .deactivateShot

.narrowShot
    call CheckNarrowShotCollision
    or a
    jr z, .setUpdatePositionHandler

.deactivateShot
    ld de, DeactivatePlayerShot
    jp SetCurrentHandlerAddress


.setUpdatePositionHandler
    ld de, UpdateShotPosition
    jp SetCurrentHandlerAddress

DeactivatePlayerShot:
    ld a, [bc]
    ld l, a
    ld h, $00
    ld de, wWeaponShotSlots - 1
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
    ld de, WaitForShotRequest
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
    jp c, HandleEnemyDefeat

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
    jp c, HandleEnemyDefeat

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
    ld bc, HANDLER_ROTOMECH_ANIM_FRAME_COUNTER_OFFSET
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
    dw BatwingMovementScriptA, BatwingMovementScriptB

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
    dw ZigzagMovementScriptA, ZigzagMovementScriptB

ZigzagInitTemplate:
    db $12, $08, $08, $00, $fe, $10, $12, $01

ZigzagGraphics:
    db $4a, $00, $4a, $20

InitializeBlazer:
    ld bc, BlazerInitTemplate
    call TryInitializeObjectInFreeSlot
    or a
    jp z, RemoveCurrentHandler

    ld de, ConfigureBlazer
    jp SetCurrentHandlerAddress

ConfigureBlazer:
    ld a, [bc]
    call SetObjectPointer
    ld hl, wPlayerXPos
    ld e, [hl]
    ld d, $00
    ld bc, BlazerInitTemplate
    call ResetObjectAttributes
    ld de, BlazerGraphics
    call SetObjectGraphicsPointer
    ld a, [wCurrentHandlerIndex]
    and $01
    jr z, .setStatusHandler

    ld de, TryFireBlazerShot
    jp SetCurrentHandlerAddress


.setStatusHandler
    ld de, UpdateBlazerStatus
    jp SetCurrentHandlerAddress

UpdateBlazerStatus:
    ld a, [bc]
    call SetObjectPointer
    inc hl
    ld a, [hl+]
    cp $90
    jp nc, FreeObjectAndRemoveHandler

    ld de, OBJECT_DAMAGE_THRESHOLD_OFFSET - OBJECT_X_OFFSET
    add hl, de
    ld d, $53
    ld a, [hl+]
    cp [hl]
    jp c, HandleEnemyDefeat

    ld d, $06
    ld e, $00
    call MoveObject
    ld de, TryFireBlazerShot
    jp SetCurrentHandlerAddress

TryFireBlazerShot:
    push bc
    call TryScheduleEnemyShot
    pop bc
    call CheckEnemyCollisionWithPlayer
    ld de, UpdateBlazerStatus
    jp SetCurrentHandlerAddress


BlazerInitTemplate:
    db $12, $08, $08, $00, $fe, $10, $12, $12

BlazerGraphics:
    db $44, $00, $44, $20

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
    ld hl, HANDLER_ARROWHEAD_Y_VELOCITY_OFFSET
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
    ld hl, HANDLER_ARROWHEAD_Y_VELOCITY_OFFSET
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
    ld de, OBJECT_DAMAGE_THRESHOLD_OFFSET
    add hl, de
    ld d, $22
    ld a, [hl+]
    cp [hl]
    jp c, HandleEnemyDefeat

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

InitializeMiditron:
    ld bc, MiditronInitTemplate
    call TryInitializeObjectInFreeSlot
    or a
    jp z, RemoveCurrentHandler

    ld de, ConfigureMiditron
    jp SetCurrentHandlerAddress

ConfigureMiditron:
    ld a, [bc]
    call SetObjectPointer
    ld de, MiditronMovementScriptTable
    call InitializeMovementScriptFromTable
    ld de, MiditronGraphics
    call SetObjectGraphicsPointer
    ld a, [wCurrentHandlerIndex]
    and $01
    jr z, SetAlternateFireEnemyMovementHandler

    ld de, CheckAlternateFireEnemyCollision
    jp SetCurrentHandlerAddress


SetAlternateFireEnemyMovementHandler:
    ld de, UpdateAlternateFireEnemyMovement
    jp SetCurrentHandlerAddress

UpdateAlternateFireEnemyMovement:
    call UpdateScriptedEnemyMovement
    ld d, $32
    cp [hl]
    jp c, HandleEnemyDefeat

    ld hl, wSelectedObjectPointer
    ld a, [hl+]
    ld h, [hl]
    ld l, a
    inc hl
    ld a, [hl]
    cp $e0
    jp nc, FreeObjectAndRemoveHandler

    ld de, TryFireAlternateShot
    jp SetCurrentHandlerAddress

TryFireAlternateShot:
    ld a, [bc]
    call SetObjectPointer
    call CheckEnemyShotTimer
    or a
    jr nz, .setCollisionHandler

    ld de, wEnemyShotSpawnY
    ld a, [de]
    or a
    jr nz, .setCollisionHandler

    ld bc, $0806
    call StoreOffsetObjectPosition
    ld de, TrySpawnAlternateEnemyProjectile
    call StoreAddressInFreeWramSlot

.setCollisionHandler
    ld de, CheckAlternateFireEnemyCollision
    jp SetCurrentHandlerAddress

CheckAlternateFireEnemyCollision:
    call CheckEnemyCollisionWithPlayer
    ld de, UpdateAlternateFireEnemyMovement
    jp SetCurrentHandlerAddress


MiditronMovementScriptTable:
    dw MiditronMovementScriptA, MiditronMovementScriptB

MiditronInitTemplate:
    db $12, $08, $08, $00, $fe, $10, $12, $02

MiditronGraphics:
    db $48, $00, $48, $20

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
    ld de, OBJECT_DAMAGE_THRESHOLD_OFFSET
    add hl, de
    ld d, $32
    ld a, [hl+]
    cp [hl]
    jp c, HandleEnemyDefeat

    ld a, $28
    call CalculateYMovement
    ld a, [$ca16]
    ld d, a
    ld e, $00
    call MoveObject
    ld de, wPlayerYPos
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
    ld hl, HANDLER_HARRIER_HORIZONTAL_MOVEMENT_ACTIVE_OFFSET
    add hl, bc
    inc [hl]
    ld hl, HANDLER_HARRIER_HORIZONTAL_DIRECTION_OFFSET
    add hl, bc
    ld [hl], a ; zero to move right, non zero for left

SetUpdateHarrierStatusHandler:
    ld de, UpdateHarrierStatus
    jp SetCurrentHandlerAddress


UpdateHarrierHorizontalMovement:
    ld a, [bc]
    call SetObjectPointer
    ld de, OBJECT_DAMAGE_THRESHOLD_OFFSET
    add hl, de
    ld d, $22
    ld a, [hl+]
    cp [hl]
    jp c, HandleEnemyDefeat

    ld d, $60
    ld hl, HANDLER_HARRIER_HORIZONTAL_DIRECTION_OFFSET
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
    ld de, HANDLER_HARRIER_HORIZONTAL_MOVEMENT_ACTIVE_OFFSET
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
    ld hl, DefeatSound0
    ld a, $01
    call SetupAudioPlayback
    ld de, PowerUpContainerHiddenGraphics
    call SetObjectGraphicsPointer
    ld de, InitializePowerUpReveal
    jp SetCurrentHandlerAddress

InitializePowerUpReveal:
    ld a, [bc]
    call SetObjectPointer
    ld hl, HANDLER_POWER_UP_REVEALED_OFFSET
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
    ld hl, wPlayerCollisionCenterY
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
    ld de, OBJECT_HITBOX_MIN_Y_OFFSET
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

    ld hl, HANDLER_POWER_UP_REVEALED_OFFSET
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
    ld hl, HANDLER_POWER_UP_ANIM_FRAME_COUNTER_OFFSET
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
    ld hl, PowerUpAwardSound
    ld a, $01
    call SetupAudioPlayback
    ld [wSoundSuppressionTimer], a
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
    ld [wEnemyShotSpeedLevel], a
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

InitializeAnthrop:
    ld bc, AnthropInitTemplate
    call TryInitializeObjectInFreeSlot
    or a
    jp z, RemoveCurrentHandler

    ld de, ConfigureAnthrop
    jp SetCurrentHandlerAddress

ConfigureAnthrop:
    ld a, [bc]
    call SetObjectPointer
    ld de, AnthropMovementScriptTable
    call InitializeMovementScriptFromTable
    ld de, AnthropGraphics
    call SetObjectGraphicsPointer
    ld a, [wCurrentHandlerIndex]
    and $01
    jr z, .setMovementHandler

    ld de, CheckAnthropCollision
    jp SetCurrentHandlerAddress


.setMovementHandler
    ld de, UpdateAnthropMovement
    jp SetCurrentHandlerAddress

UpdateAnthropMovement:
    call UpdateScriptedEnemyMovement
    ld d, $52
    cp [hl]
    jp c, HandleEnemyDefeat

    ld hl, wSelectedObjectPointer
    ld a, [hl+]
    ld h, [hl]
    ld l, a
    inc hl
    ld a, [hl]
    cp $e0
    jp nc, FreeObjectAndRemoveHandler

    ld de, TryFireAnthropMissile
    jp SetCurrentHandlerAddress

TryFireAnthropMissile:
    ld a, [bc]
    call SetObjectPointer
    call CheckEnemyShotTimer
    or a
    jr nz, .setCollisionHandler

    ld de, wEnemyShotSpawnY
    ld a, [de]
    or a
    jr nz, .setCollisionHandler

    ld bc, $0800
    call StoreOffsetObjectPosition
    call RegisterAnthropMissileHandler

.setCollisionHandler
    ld de, CheckAnthropCollision
    jp SetCurrentHandlerAddress


CheckAnthropCollision:
    call CheckEnemyCollisionWithPlayer
    ld de, UpdateAnthropMovement
    jp SetCurrentHandlerAddress


AnthropMovementScriptTable:
    dw AnthropMovementScriptA, AnthropMovementScriptB

AnthropInitTemplate:
    db $12, $08, $08, $00, $fe, $10, $12, $01

AnthropGraphics:
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
    ld a, [wDisableBackgroundScroll]
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

    ld de, OBJECT_DAMAGE_THRESHOLD_OFFSET - OBJECT_X_OFFSET
    add hl, de
    ld d, $13
    ld a, [hl+]
    cp [hl]
    jp c, HandleEnemyDefeat

    ld de, UpdateTerraCannonPosition
    jp SetCurrentHandlerAddress


TerraCannonInitTemplate:
    db $12, $08, $08, $00, $fe, $10, $12, $18

TerraCannonGraphics:
    db $50, $00, $50, $20

InitializeOctopod:
    ld bc, OctopodInitTemplate
    call TryInitializeObjectInFreeSlot
    or a
    jp z, RemoveCurrentHandler

    ld de, ConfigureOctopod
    jp SetCurrentHandlerAddress

ConfigureOctopod:
    ld a, [bc]
    call SetObjectPointer
    ld de, OctopodMovementScriptTable
    call InitializeMovementScriptFromTable
    ld de, OctopodGraphics
    jp SetEnemyGraphicsAndStartUpdateCycle


OctopodMovementScriptTable:
    dw OctopodMovementScriptA, OctopodMovementScriptB

OctopodInitTemplate:
    db $12, $08, $08, $00, $fe, $10, $12, $01

OctopodGraphics:
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
    jp SetEnemyGraphicsAndStartUpdateCycle


SkimbotInitTemplate:
    db $12, $08, $08, $00, $fe, $10, $12, $01

SkimbotGraphics:
    db $54, $00, $54, $20

InitializeTwerk:
    ld bc, TwerkInitTemplate
    call TryInitializeObjectInFreeSlot
    or a
    jp z, RemoveCurrentHandler

    ld de, ConfigureTwerk
    jp SetCurrentHandlerAddress

ConfigureTwerk:
    ld a, [bc]
    call SetObjectPointer
    ld de, TwerkMovementScript
    call InitializeMovementScript
    ld de, TwerkGraphics
    jp SetEnemyGraphicsAndStartUpdateCycle


TwerkInitTemplate:
    db $12, $08, $08, $00, $fe, $10, $12, $01

TwerkGraphics:
    db $40, $00, $40, $20

InitializeScarab:
    ld bc, ScarabInitTemplate
    call TryInitializeObjectInFreeSlot
    or a
    jp z, RemoveCurrentHandler

    ld de, ConfigureScarab
    jp SetCurrentHandlerAddress

ConfigureScarab:
    ld a, [bc]
    call SetObjectPointer
    ld de, ScarabMovementScriptTable
    call InitializeMovementScriptFromTable
    ld de, ScarabGraphics
    jp SetEnemyGraphicsAndStartUpdateCycle


    ; $216F: movement script pointers
ScarabMovementScriptTable:
    dw ScarabMovementScriptA, ScarabMovementScriptB

ScarabInitTemplate:
    db $12, $08, $08, $00, $fe, $10, $12, $01

ScarabGraphics:
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
    jp SetAlternateFireEnemyMovementHandler


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
    jp c, HandleEnemyDefeat

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

    ld a, [wFiringSpawnAttemptsCounter]
    or a
    jr nz, .setCollisionHandler

    ld de, wEnemyFiringSequenceSpawnY
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

InitializeWarhawk:
    ld bc, WarhawkInitTemplate
    call TryInitializeObjectInFreeSlot
    or a
    jp z, RemoveCurrentHandler

    ld de, ConfigureWarhawk
    jp SetCurrentHandlerAddress

ConfigureWarhawk:
    ld a, [bc]
    call SetObjectPointer
    ld de, WarhawkMovementScriptTable
    call InitializeMovementScriptFromTable
    ld de, WarhawkGraphics
    call SetObjectGraphicsPointer
    ld a, [wCurrentHandlerIndex]
    and $01
    jr z, .setMovementHandler

    ld de, CheckAlternateFireEnemyCollision
    jp SetCurrentHandlerAddress


.setMovementHandler
    ld de, UpdateAlternateFireEnemyMovement
    jp SetCurrentHandlerAddress


WarhawkMovementScriptTable:
    dw WarhawkMovementScriptA, WarhawkMovementScriptB

WarhawkInitTemplate:
    db $12, $08, $08, $00, $fe, $10, $12, $02

WarhawkGraphics:
    db $58, $00, $58, $20

RegisterAnthropMissileHandler:
    ld de, InitializeAnthropMissile
    call StoreAddressInFreeWramSlot
    ret


InitializeAnthropMissile:
    ld bc, AnthropMissileInitTemplate
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
    ld de, ConfigureAnthropMissile
    jp SetCurrentHandlerAddress

ConfigureAnthropMissile:
    ld a, [bc]
    call SetObjectPointer
    ld de, AnthropMissileGraphics
    call SetObjectGraphicsPointer
    ld a, [wCurrentHandlerIndex]
    and $01
    jr z, .setMovementHandler

    ld de, CheckAnthropMissileCollision
    jp SetCurrentHandlerAddress

.setMovementHandler
    ld de, UpdateAnthropMissileMovement
    jp SetCurrentHandlerAddress

UpdateAnthropMissileMovement:
    ld a, [bc]
    call SetObjectPointer
    push hl
    ld d, $08
    ld e, $00
    call MoveObject
    pop hl
    ld de, OBJECT_DAMAGE_THRESHOLD_OFFSET
    add hl, de
    ld d, $52
    ld a, [hl+]
    cp [hl]
    jp c, HandleEnemyDefeat

    ld de, CheckAnthropMissileOutOfBounds
    jp SetCurrentHandlerAddress

CheckAnthropMissileOutOfBounds:
    call CheckObjectOutOfBounds
    or a
    jp nz, FreeObjectAndRemoveHandler

    ld de, TryFireAnthropMissileShot
    jp SetCurrentHandlerAddress

TryFireAnthropMissileShot:
    call TryScheduleEnemyShot
    or a
    jp z, FreeObjectAndRemoveHandler

    ld de, CheckAnthropMissileCollision
    jp SetCurrentHandlerAddress

CheckAnthropMissileCollision:
    call CheckEnemyCollisionWithPlayer
    ld de, UpdateAnthropMissileMovement
    jp SetCurrentHandlerAddress


AnthropMissileInitTemplate:
    db $12, $08, $08, $00, $00, $10, $10, $02

AnthropMissileGraphics:
    db $12, $00, $12, $20

InitializeStageFourBoss:
    xor a
    ld hl, $cac0
    ld b, $10

.clearStateBytes
    ld [hl+], a
    dec b
    jr nz, .clearStateBytes

    ld de, InitializeStageFourBossCenter
    call StoreAddressInFreeWramSlot
    ld b, $02

.verticalInitHandlers
    push bc
    ld de, InitializeStageFourBossVerticalPart
    call StoreAddressInFreeWramSlot
    pop bc
    dec b
    jr nz, .verticalInitHandlers

    ld b, $02

.horizontalInitHandlers
    push bc
    ld de, InitializeStageFourBossHorizontalPart
    call StoreAddressInFreeWramSlot
    pop bc
    dec b
    jr nz, .horizontalInitHandlers

    ld de, WaitForBossFiringStart
    jp SetCurrentHandlerAddress


InitializeStageFourBossCenter:
    ld bc, StageFourBossCenterInitTemplate
    call TryInitializeObjectInFreeSlot
    or a
    jp z, RemoveCurrentHandler

    jr RegisterStageFourBossPart

InitializeStageFourBossVerticalPart:
    ld bc, StageFourBossVerticalInitTemplate
    call TryInitializeObjectInFreeSlot
    or a
    jp z, RemoveCurrentHandler

    jr RegisterStageFourBossPart

InitializeStageFourBossHorizontalPart:
    ld bc, StageFourBossHorizontalInitTemplate
    call TryInitializeObjectInFreeSlot
    or a
    jp z, RemoveCurrentHandler

RegisterStageFourBossPart:
    call AssignBossPartIndex
    ld de, ConfigureStageFourBoss
    jp SetCurrentHandlerAddress

ConfigureStageFourBoss:
    ld a, [bc]
    call SetObjectPointer
    ld hl, HANDLER_BOSS_PART_INDEX_OFFSET
    add hl, bc
    ld a, [hl]
    push af
    ld hl, StageFourBossStartingCoordinates
    call ApplyHorizontalScrollOffsetToCoordinatePair
    pop af
    ld bc, StageFourBossCenterInitTemplate
    or a
    jr z, .applyTemplate

    ld bc, StageFourBossVerticalInitTemplate
    cp $03
    jr c, .applyTemplate

    ld bc, StageFourBossHorizontalInitTemplate

.applyTemplate
    call ResetObjectAttributes
    ld de, CheckStageFourBossPartAndSetupHandler
    jp SetCurrentHandlerAddress

CheckStageFourBossPartAndSetupHandler:
    ld a, [wBossActive]
    or a
    jp z, AdvanceToNextHandler

    ld a, [bc]
    call SetObjectPointer
    ld de, OBJECT_DAMAGE_ACCUMULATED_OFFSET
    add hl, de
    xor a
    ld [hl], a
    ld hl, HANDLER_BOSS_PART_INDEX_OFFSET
    add hl, bc
    ld a, [hl]
    or a
    jr nz, .setPartHandler

    ld de, UpdateStageFourBossStatus
    jp SetCurrentHandlerAddress

.setPartHandler
    ld de, UpdateStageFourBossPartStatus
    jp SetCurrentHandlerAddress

UpdateStageFourBossStatus:
    ld a, [bc]
    call SetObjectPointer
    ld de, OBJECT_DAMAGE_THRESHOLD_OFFSET
    add hl, de
    ld a, [hl+]
    cp [hl]
    jr c, HandleStationaryBossDefeat

    ld de, $0000
    call MoveObject
    ld de, CheckStageFourBossCollision
    jp SetCurrentHandlerAddress


HandleStationaryBossDefeat:
    ld a, $01
    ld [wBossEncounterEnding], a
    ld [wPlayerInvincible], a
    ld de, DelayThenHideBackground
    call StoreAddressInFreeWramSlot
    ld a, $14
    call AddPlayerScore
    ld de, StartStationaryBossDestructionSequence
    jp SetCurrentHandlerAddress

CheckStageFourBossCollision:
    call CheckPlayerCenterInEnemyHitbox
    ld de, CheckForStageFourBossHit
    jp SetCurrentHandlerAddress

CheckForStageFourBossHit:
    call CheckForNewEnemyDamage
    or a
    jr z, .setStatusHandler

    ld [wScreenShakeRequested], a

.setStatusHandler
    ld de, UpdateStageFourBossStatus
    jp SetCurrentHandlerAddress

StartStationaryBossDestructionSequence:
    ld hl, HANDLER_BOSS_SMOKE_DELAY_COUNTER_OFFSET
    add hl, bc
    ld a, [hl]
    inc [hl]
    and $07
    jp nz, AdvanceToNextHandler

    call AdvanceBossDestructionCounter
    cp $07
    jp z, FinishBossExitAndStartStageTransition

    ld hl, SmokeSpawnOffsetTable
    call TriggerSmokeEffect
    jp AdvanceToNextHandler


StageFourBossCenterInitTemplate:
    db $12, $08, $08, $fe, $fe, $12, $14, $60

StageFourBossVerticalInitTemplate:
    db $32, $18, $08, $00, $00, $30, $10, $f0

StageFourBossHorizontalInitTemplate:
    db $14, $08, $10, $00, $00, $10, $20, $f0

    ; Smoke spawn offsets (Y, X)
SmokeSpawnOffsetTable:
    db $00, $00
    db $10, $10
    db $10, $f0
    db $f0, $10
    db $f0, $f0
    db $00, $20
    db $00, $e0

InitializeStageFiveBoss:
    xor a
    ld hl, $cac0
    ld b, $10

.clearStateBytes
    ld [hl+], a
    dec b
    jr nz, .clearStateBytes

    ld de, InitializeStageFiveBossCenter
    call StoreAddressInFreeWramSlot
    ld de, WaitForBossFiringStart
    call StoreAddressInFreeWramSlot
    ld de, WaitForBossAlternateFiringStart
    jp SetCurrentHandlerAddress

InitializeStageFiveBossCenter:
    ld bc, StageFiveBossCenterInitTemplate
    call TryInitializeObjectInFreeSlot
    or a
    jp z, RemoveCurrentHandler

    call AssignBossPartIndex
    ld de, ConfigureStageFiveBossCenter
    jp SetCurrentHandlerAddress

ConfigureStageFiveBossCenter:
    ld a, [bc]
    call SetObjectPointer
    xor a
    ld hl, StageFiveBossStartingCoordinates
    call ApplyHorizontalScrollOffsetToCoordinatePair
    ld bc, StageFiveBossCenterInitTemplate
    call ResetObjectAttributes
    ld de, HandleStageFiveBossActivation
    jp SetCurrentHandlerAddress

HandleStageFiveBossActivation:
    ld a, [wBossActive]
    or a
    jp z, AdvanceToNextHandler

    ld a, [bc]
    call SetObjectPointer
    ld de, OBJECT_DAMAGE_ACCUMULATED_OFFSET
    add hl, de
    xor a
    ld [hl], a
    ld de, UpdateStageFiveBossStatus
    jp SetCurrentHandlerAddress

UpdateStageFiveBossStatus:
    ld a, [bc]
    call SetObjectPointer
    ld de, OBJECT_DAMAGE_THRESHOLD_OFFSET
    add hl, de
    ld a, [hl+]
    cp [hl]
    jp c, HandleStationaryBossDefeat

    ld de, $0000
    call MoveObject
    ld a, $05
    ld [wEnemyShotSpeedLevel], a
    ld de, CheckStageFiveBossCollision
    jp SetCurrentHandlerAddress

CheckStageFiveBossCollision:
    call CheckPlayerCenterInEnemyHitbox
    ld de, CheckForStageFiveBossHit
    jp SetCurrentHandlerAddress

CheckForStageFiveBossHit:
    call CheckForNewEnemyDamage
    or a
    jr z, .checkPlayerAboveBossBoundary

    ld [wScreenShakeRequested], a

.checkPlayerAboveBossBoundary
    ld hl, wPlayerYPos
    ld a, [hl]
    cp $34
    jr nc, .setStatusHandler

    ld a, $01
    ld [wPlayerDeathRequested], a

.setStatusHandler
    ld de, UpdateStageFiveBossStatus
    jp SetCurrentHandlerAddress


    ; $24F7: eight-byte object initialization template.
StageFiveBossCenterInitTemplate:
    db $12, $08, $08, $00, $00, $10, $10, $70

InitializeFinalBoss:
    xor a
    ld hl, $cac0
    ld b, $10

.clearStateBytes:
    ld [hl+], a
    dec b
    jr nz, .clearStateBytes

    ld [$cf99], a
    ld de, InitializeFinalBossCenter
    call StoreAddressInFreeWramSlot
    ld de, WaitForFinalBossFiringStart
    call StoreAddressInFreeWramSlot
    jp RemoveCurrentHandler

InitializeFinalBossCenter:
    ld bc, FinalBossCenterInitTemplate
    call TryInitializeObjectInFreeSlot
    or a
    jp z, RemoveCurrentHandler

    call AssignBossPartIndex
    ld de, ConfigureFinalBossCenter
    jp SetCurrentHandlerAddress

ConfigureFinalBossCenter:
    ld a, [bc]
    call SetObjectPointer
    xor a
    ld hl, FinalBossStartingCoordinates
    call ApplyHorizontalScrollOffsetToCoordinatePair
    ld bc, FinalBossCenterInitTemplate
    call ResetObjectAttributes
    ld de, HandleFinalBossActivation
    jp SetCurrentHandlerAddress

HandleFinalBossActivation:
    ld a, [wBossActive]
    or a
    jp z, AdvanceToNextHandler

    ld a, [bc]
    call SetObjectPointer
    ld de, OBJECT_DAMAGE_ACCUMULATED_OFFSET
    add hl, de
    xor a
    ld [hl], a
    ld de, UpdateFinalBossStatus
    jp SetCurrentHandlerAddress

UpdateFinalBossStatus:
    ld a, [bc]
    call SetObjectPointer
    ld de, OBJECT_DAMAGE_THRESHOLD_OFFSET
    add hl, de
    ld a, [hl+]
    cp [hl]
    jr c, HandleFinalBossDefeat

    ld de, $0000
    call MoveObject
    ld de, CheckFinalBossCollision
    jp SetCurrentHandlerAddress


HandleFinalBossDefeat:
    ld a, $01
    ld [wBossEncounterEnding], a
    ld [wPlayerInvincible], a
    ld de, DelayThenHideBackground
    call StoreAddressInFreeWramSlot
    ld a, $24
    call AddPlayerScore
    call IncrementPlayerLives
    ld de, StartStationaryBossDestructionSequence
    jp SetCurrentHandlerAddress

CheckFinalBossCollision:
    push bc
    call CheckPlayerCenterInEnemyHitbox
    pop bc
    call CheckForNewEnemyDamage
    or a
    jr z, .tryShot

    ld [wScreenShakeRequested], a

.tryShot
    ld de, TryFireFinalBossSpread
    jp SetCurrentHandlerAddress

TryFireFinalBossSpread:
    ld a, [bc]
    call SetObjectPointer
    call CheckEnemyShotTimer
    or a
    jr nz, .setStatusHandler

    ld de, wEnemyFiringSequenceSpawnY
    ld bc, $0804
    call StoreOffsetObjectPosition
    ld a, $06
    ld [de], a
    inc de
    xor a
    ld [de], a
    ld de, UpdateEnemyFiringSequence
    call StoreAddressInFreeWramSlot

.setStatusHandler
    ld de, UpdateFinalBossStatus
    jp SetCurrentHandlerAddress


    ; $25C9: eight-byte object initialization template.
FinalBossCenterInitTemplate:
    db $12, $08, $08, $00, $00, $10, $10, $80

    ; $25D1: eight-byte object initialization template (two rows, three columns).
    db $23, $10, $0c, $00, $00, $20, $18, $e0

UpdateUltraCrusherShotTimer:
    ld a, [wBossEncounterEnding]
    or a
    jp nz, RemoveCurrentHandler

    ld a, [bc]
    ld hl, HANDLER_UC_LASER_TIMER_OFFSET
    add hl, bc
    inc [hl]
    ld a, [hl]
    and $0f
    jp nz, AdvanceToNextHandler

    ld [hl], a
    ld de, TryFireUltraCrusherLaser
    jp SetCurrentHandlerAddress

TryFireUltraCrusherLaser:
    ld a, [$cf99]
    call SetObjectPointer
    inc hl
    inc hl
    ld a, [hl]
    add $10
    ld b, a
    ld de, wPlayerXPos
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
    ld a, [wBossEncounterEnding]
    or a
    jp nz, RemoveCurrentHandler

    ld hl, HANDLER_DESTRUCTOR_ORB_TIMER_OFFSET
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
    ld hl, HANDLER_DESTRUCTOR_ORB_DIRECTION_OFFSET
    add hl, bc
    ld a, [wNextDestructorOrbDirection]
    ld [hl], a
    inc a
    and $03
    ld [wNextDestructorOrbDirection], a
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
    ld hl, wEnemyFiringSequenceSpawnY
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
    ld de, OBJECT_DAMAGE_ACCUMULATED_OFFSET
    add hl, de
    xor a
    ld [hl], a
    ld de, UpdateDestructorOrbMovement
    jp SetCurrentHandlerAddress

    ; 26b1
UpdateDestructorOrbMovement:
    ld a, [bc]
    call SetObjectPointer
    ld hl, HANDLER_DESTRUCTOR_ORB_Y_MOVEMENT_OFFSET
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
    ld de, OBJECT_DAMAGE_THRESHOLD_OFFSET
    add hl, de
    ld d, $12
    ld a, [hl+]
    cp [hl]
    jp c, HandleEnemyDefeat

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

WaitForBossFiringStart:
    ld a, [wBossActive]
    or a
    jp z, AdvanceToNextHandler

    ld hl, HANDLER_SHARED_BOSS_FIRING_TIMER_OFFSET
    add hl, bc
    xor a
    ld [hl], a
    ld de, UpdateBossFiringTimer
    jp SetCurrentHandlerAddress


UpdateBossFiringTimer:
    ld hl, HANDLER_SHARED_BOSS_FIRING_TIMER_OFFSET
    add hl, bc
    inc [hl]
    ld a, [hl]
    and $07
    jr z, .firingTimerComplete

    ld de, CheckBossFiringActive
    jp SetCurrentHandlerAddress


.firingTimerComplete
    xor a
    ld b, a
    ld a, [wCurrentStage]
    cp $05
    jr z, .updateTimer

    ld b, $03 ; not stage 5

.updateTimer
    ld a, b
    ld [hl], a
    ld de, TryFireBossShot
    jp SetCurrentHandlerAddress

TryFireBossShot:
    ld de, wEnemyShotSpawnY
    ld a, [de]
    or a
    jr nz, .setFiringActiveHandler

    ld de, BossFiringPositionSequence
    ld bc, StageFourBossShotCoordinates
    ld a, [wCurrentStage]
    cp $05
    jr nz, .scheduleProjectile

    ld bc, StageFiveBossShotCoordinates

.scheduleProjectile:
    call PrepareBossProjectileSpawn
    ld de, TrySpawnEnemyProjectile
    call StoreAddressInFreeWramSlot

.setFiringActiveHandler
    ld de, CheckBossFiringActive
    jp SetCurrentHandlerAddress

CheckBossFiringActive:
    ld a, [wBossEncounterEnding]
    or a
    jp nz, RemoveCurrentHandler

    ld de, UpdateBossFiringTimer
    jp SetCurrentHandlerAddress

PrepareBossProjectileSpawn:
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
    call ApplyHorizontalScrollOffsetToCoordinatePair
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


BossFiringPositionSequence: ; $278D, 32 coordinate indices
    db $05, $06, $03, $0c, $0a, $02, $0f, $07
    db $0c, $04, $00, $02, $08, $0d, $0e, $02
    db $03, $02, $05, $01, $09, $0c, $0a, $04
    db $0b, $0f, $01, $09, $00, $0b, $06, $0f

WaitForBossAlternateFiringStart:
    ld a, [wBossActive]
    or a
    jp z, AdvanceToNextHandler

    ld hl, HANDLER_SHARED_BOSS_FIRING_TIMER_OFFSET
    add hl, bc
    xor a
    ld [hl], a
    ld [$cfa4], a
    ld de, UpdateBossAlternateFiringTimer
    jp SetCurrentHandlerAddress

UpdateBossAlternateFiringTimer:
    ld hl, HANDLER_SHARED_BOSS_FIRING_TIMER_OFFSET
    add hl, bc
    inc [hl]
    ld a, [hl]
    cp $0d
    jr z, .firingTimerComplete

    ld de, CheckBossAlternateFiringActive
    jp SetCurrentHandlerAddress


.firingTimerComplete
    xor a
    ld [hl], a
    ld de, TryFireBossAlternateShot
    jp SetCurrentHandlerAddress

TryFireBossAlternateShot:
    ld de, wEnemyShotSpawnY
    ld a, [de]
    or a
    jr nz, .setFiringActiveHandler

    ld hl, $cfa4
    ld a, [hl]
    and $03
    inc [hl]
    ld de, BossAlternateShotCoordinateIndices
    ld l, a
    ld h, $00
    add hl, de
    ld a, [hl]
    and $03
    ld hl, StageFiveBossAlternateShotCoordinates
    call ApplyHorizontalScrollOffsetToCoordinatePair
    ld hl, wEnemyShotSpawnY
    ld a, d
    ld [hl+], a
    ld [hl], e
    ld de, TrySpawnAlternateEnemyProjectile
    call StoreAddressInFreeWramSlot

.setFiringActiveHandler
    ld de, CheckBossAlternateFiringActive
    jp SetCurrentHandlerAddress

CheckBossAlternateFiringActive:
    ld a, [wBossEncounterEnding]
    or a
    jp nz, RemoveCurrentHandler

    ld de, UpdateBossAlternateFiringTimer
    jp SetCurrentHandlerAddress


BossAlternateShotCoordinateIndices:
    db $01, $02, $01, $00

WaitForFinalBossFiringStart:
    ld a, [wBossActive]
    or a
    jp z, AdvanceToNextHandler

    ld hl, HANDLER_SHARED_BOSS_FIRING_TIMER_OFFSET
    add hl, bc
    xor a
    ld [hl], a
    ld [$cf99], a
    ld de, UpdateFinalBossFiringTimer
    jp SetCurrentHandlerAddress

UpdateFinalBossFiringTimer:
    ld hl, HANDLER_SHARED_BOSS_FIRING_TIMER_OFFSET
    add hl, bc
    ld a, [hl]
    inc a
    and $0f
    ld [hl], a
    jr z, .tryShot

    ld de, CheckFinalBossFiringActive
    jp SetCurrentHandlerAddress


.tryShot
    ld de, TryFireFinalBossAimedShot
    jp SetCurrentHandlerAddress

TryFireFinalBossAimedShot:
    ld de, wEnemyShotSpawnY
    ld a, [de]
    or a
    jr nz, .setFiringHandler

    ld de, FinalBossFiringPositionSequence
    ld bc, FinalBossShotCoordinates
    call PrepareBossProjectileSpawn
    ld de, TrySpawnEnemyProjectile
    call StoreAddressInFreeWramSlot

.setFiringHandler
    ld de, CheckFinalBossFiringActive
    jp SetCurrentHandlerAddress

CheckFinalBossFiringActive:
    ld a, [wBossEncounterEnding]
    or a
    jp nz, RemoveCurrentHandler

    ld de, UpdateFinalBossFiringTimer
    jp SetCurrentHandlerAddress


FinalBossFiringPositionSequence:
    db $03, $01, $02, $00, $01, $02, $03, $00
    db $03, $02, $00, $01, $01, $03, $02, $00
    db $02, $00, $00, $02, $03, $01, $03, $01
    db $01, $02, $03, $02, $01, $00, $03, $00

StartAlternatePlayerExit: ; unused?
    ld a, [$cac8]
    or a
    jp z, AdvanceToNextHandler

    ld a, [bc]
    call SetObjectPointer
    ld de, PlayerSpriteData
    call SetObjectGraphicsPointer
    ld de, MovePlayerUp
    jp SetCurrentHandlerAddress

MovePlayerUp:
    ld a, [bc]
    call SetObjectPointer
    ld de, $f800
    call MoveObjectWithFractionalVelocity
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
    ld de, MovePlayerDownLeft
    jp SetCurrentHandlerAddress

MovePlayerDownLeft:
    ld a, [bc]
    call SetObjectPointer
    ld de, $08f8
    call MoveObjectWithFractionalVelocity
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
    ld de, UpdatePlayerStageExitMovement
    jp SetCurrentHandlerAddress

UpdatePlayerStageExitMovement:
    ld a, [bc]
    call SetObjectPointer
    ld hl, $000f
    add hl, bc
    ld a, [hl]
    xor $01
    ld [hl+], a
    jr nz, .movePlayer

    dec [hl]

.movePlayer
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
    ld hl, wPlayerTransitionComplete ; mark player offscreen
    ld [hl+], a
    ld [hl], a
    ld a, [wCurrentStage]
    cp $06
    jr z, .stageSevenNext

.setWaitForStageReady:
    ld de, WaitForStageReady
    jp SetCurrentHandlerAddress


.stageSevenNext
    ld a, [$ca22]
    cp $0f
    jr nz, .setWaitForStageReady

    ld de, WaitForMotherAtenaSetup
    jp SetCurrentHandlerAddress


WaitForStageReady:
    ld a, [wStageReady]
    or a
    jp z, AdvanceToNextHandler

    ; called right before player enters
    ld de, ConfigurePlayerForNextStage
    jp SetCurrentHandlerAddress


ConfigurePlayerForNextStage:
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
    ld de, MovePlayerToStageStartPosition
    jp SetCurrentHandlerAddress

MovePlayerToStageStartPosition:
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

WaitForMotherAtenaSetup:
    ld a, [wMotherAtenaSetup]
    or a
    jp z, AdvanceToNextHandler

    ld de, ConfigurePlayerStage8
    jp SetCurrentHandlerAddress

ConfigurePlayerStage8:
    ld a, [bc]
    call SetObjectPointer
    ld de, $000f
    add hl, de
    xor a
    ld [hl], a
    ld bc, PlayerInitTemplate
    ld de, $3c98
    call ResetObjectAttributes
    ld de, Stage8PlayerGraphics
    call SetObjectGraphicsPointer
    ld de, WaitForStage8Ready
    jp SetCurrentHandlerAddress

WaitForStage8Ready:
    ld a, [wStageReady]
    or a
    jp z, AdvanceToNextHandler

    ld de, WaitForStage8LeftScroll
    jp SetCurrentHandlerAddress

WaitForStage8LeftScroll:
    ldh a, [rSCX]
    cp $11
    jp nc, AdvanceToNextHandler

    ld de, MovePlayerShipsStage8Left
    jp SetCurrentHandlerAddress

MovePlayerShipsStage8Left:
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

    ld de, WaitAndClearCreditIndex
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

    ; $2AF0: stage 8 player graphics (tile, attributes).
Stage8PlayerGraphics:
    db $02, $00, $04, $00

    ; 2AF4
    ; stage 1 - 5
SetupStageTransition:
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
    ld bc, NextStageObjInitTemplate
    call TryInitializeObjectInFreeSlot
    or a
    jp z, RemoveCurrentHandler

    ld a, [$cf9a]
    call StopAudioPlayback
    ld a, [wWeaponPowerLevel]
    ld [wEnemyShotSpeedLevel], a
    ld de, ConfigureNextStageObj
    jp SetCurrentHandlerAddress

ConfigureNextStageObj:
    ld a, [bc]
    call SetObjectPointer
    ld bc, NextStageObjInitTemplate
    ld de, $3040
    call ResetObjectAttributes
    ld de, NextStageObjGraphics
    call SetObjectGraphicsPointer
    ld de, WaitForStageTransition
    jp SetCurrentHandlerAddress

WaitForStageTransition:
    ld a, [wPlayerExitPositionReached]
    or a
    jp z, AdvanceToNextHandler

    call GetCurrentPlaybackStatus
    or a
    jp nz, AdvanceToNextHandler

    inc a
    ld [wPlayerExitAllowed], a
    ld de, WaitAndSetRequestNextStageHandler
    jp SetCurrentHandlerAddress

WaitAndSetRequestNextStageHandler:
    ld a, [wPlayerTransitionComplete]
    or a
    jp z, AdvanceToNextHandler

    ld hl, wCurrentHandlerDataPointer
    ld a, [hl+]
    ld b, [hl]
    ld c, a
    ld a, [bc]
    call SetObjectPointer
    ld de, RequestNextStage
    call StoreAddressInFreeWramSlot
    jp FreeObjectAndRemoveHandler


    ; $2B6D: object initialization template.
NextStageObjInitTemplate:
    db $25             ; Two rows, five sprite columns.
    db $08, $08        ; Collision center offset (Y, X).
    db $00, $00        ; Hitbox minimum offset (Y, X).
    db $10, $10        ; Hitbox maximum offset (Y, X).
    db $01             ; Damage threshold.

    ; $2B75: "NEXT" / "STAGE" graphics, five (tile, attributes) pairs per row.
NextStageObjGraphics:
    db $ce, $00, $bc, $00, $e2, $00, $da, $00, $00, $00 ; Row 1: NEXT, blank.
    db $d8, $00, $da, $00, $b4, $00, $c0, $00, $bc, $00 ; Row 2: STAGE.

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

StartGameOverSequence:
    ld a, [wPlayerLives]
    or a
    jr z, .setupForFade

    xor a
    ld [wPlayerLives], a
    ld de, MovePlayerBackToStage
    jp SetCurrentHandlerAddress


.setupForFade
    xor a
    ld [wGameOverFadeTimer], a
    ld de, UpdateGameOverFadeOut
    jp SetCurrentHandlerAddress

WaitForGameOverStartPress:
    ld a, [wJoypadHeld]
    and $08
    jp z, AdvanceToNextHandler

    ld a, $01
    ld [wStartAlreadyHeld], a
    ld [wSelectAlreadyHeld], a
    ld [wGameOverExitTimer], a
    jp RemoveCurrentHandler

UpdateHighScore:
    ld c, $08
    ld de, wPlayerScore
    ld hl, wHighScore

.checkNextDigit:
    ld a, [de]
    cp [hl]
    ret c

    jr nz, .copyPlayerScore

    inc de
    inc hl
    dec c
    jr nz, .checkNextDigit

    ret


.copyPlayerScore
    ld c, $08
    ld hl, wPlayerScore
    ld de, wHighScore

.copyBytes:
    ld a, [hl+]
    ld [de], a
    inc de
    dec c
    jr nz, .copyBytes

    ret


; $2C9B — GAME OVER at $99CF
GameOverTilePackets:
    db $99, $cf, $09, $c0, $b4, $cc, $bc, $00, $d0, $de, $bc, $d6
    db $00

; $2CA8 — TOP SCORE at $9A0F
TopScoreTilePackets:
    db $9a, $0f, $09, $da, $d0, $d2, $00, $d8, $b8, $d0, $d6, $bc
    db $00

; $2CB5 — SCORE at $9A71
ScoreTilePackets:
    db $9a, $71, $05, $d8, $b8, $d0, $d6, $bc
    db $00

SetupStageSixTransition:
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
    call UpdateHighScore
    ld de, WaitForStageSixTransition
    jp SetCurrentHandlerAddress

WaitForStageSixTransition:
    ld a, [wPlayerExitPositionReached]
    or a
    jp z, AdvanceToNextHandler

    ld [wPlayerExitAllowed], a
    ld de, WaitStageSixAndSetRequestNextStageHandler
    jp SetCurrentHandlerAddress

WaitStageSixAndSetRequestNextStageHandler:
    ld a, [wPlayerTransitionComplete]
    or a
    jp z, AdvanceToNextHandler

    ld hl, wCurrentHandlerDataPointer
    ld a, [hl+]
    ld b, [hl]
    ld c, a
    ld a, [bc]
    call SetObjectPointer
    ld de, RequestNextStage
    call StoreAddressInFreeWramSlot
    jp RemoveCurrentHandler


InitializeStageSevenCutscene:
    ld bc, FinalBossCutsceneInitTemplate
    call TryInitializeObjectInFreeSlot
    or a
    jp z, RemoveCurrentHandler

    ld de, ConfigureFinalBossCutsceneObject
    jp SetCurrentHandlerAddress

ConfigureFinalBossCutsceneObject:
    ld a, [bc]
    call SetObjectPointer
    ld bc, FinalBossCutsceneInitTemplate
    ld de, $6872
    call ResetObjectAttributes
    ld de, FinalBossCutsceneGraphics
    call SetObjectGraphicsPointer
    ld de, WaitForFinalBossCutsceneDelay
    jp SetCurrentHandlerAddress

WaitForFinalBossCutsceneDelay:
    ld hl, $0010
    add hl, bc
    inc [hl]
    ld a, [hl]
    and $ff
    jp nz, AdvanceToNextHandler

    ld de, UpdateFinalBossCutsceneDestruction
    jp SetCurrentHandlerAddress

UpdateFinalBossCutsceneDestruction:
    ld a, [bc]
    call SetObjectPointer
    ld hl, HANDLER_SHARED_BOSS_DESTRUCTION_TIMER_OFFSET
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
    ld hl, FinalBossCutsceneDestructionSmokeOffsets
    call TriggerSmokeEffect
    pop hl
    ld a, [hl]
    cp $04
    jp nz, AdvanceToNextHandler

    ld de, InitializeCutscenePlayerObject
    call StoreAddressInFreeWramSlot
    jp AdvanceToNextHandler

InitializeCutscenePlayerObject:
    ld bc, PlayerShipCutsceneInitTemplate
    call TryInitializeObjectInFreeSlot
    or a
    jp z, RemoveCurrentHandler

    ld de, ConfigureCutscenePlayerObject
    jp SetCurrentHandlerAddress

ConfigureCutscenePlayerObject:
    ld a, [bc]
    call SetObjectPointer
    ld hl, $0008
    add hl, bc
    xor a
    ld [hl+], a
    ld [hl], a
    ld hl, $0018
    add hl, bc
    ld bc, PlayerShipCutsceneInitTemplate
    ld de, $606a
    call ResetObjectAttributes
    ld de, PlayerShipCutsceneGraphics
    call SetObjectGraphicsPointer
    ld de, UpdateCutscenePlayerShipMovement
    jp SetCurrentHandlerAddress

UpdateCutscenePlayerShipMovement:
    ld a, [bc]
    call SetObjectPointer
    inc hl
    ld a, [hl]
    cp $f0
    jr nc, .startTextDisplay

    ld hl, $0008
    add hl, bc
    ld a, [hl+]
    ld e, [hl]
    ld d, a
    call MoveObjectWithFractionalVelocity
    ld de, AccelerateCutscenePlayerShip
    jp SetCurrentHandlerAddress


.startTextDisplay
    call ClearSelectedObject
    ld a, [$ca22]
    cp $0f
    jr nz, .alternatePath

    ld de, QueueFinalMissionText
    jp SetCurrentHandlerAddress


.alternatePath
    ld de, QueueFinalMissionTextAlternate
    jp SetCurrentHandlerAddress

AccelerateCutscenePlayerShip:
    ld a, [bc]
    call SetObjectPointer
    ld hl, $0007
    add hl, bc
    ld a, [hl]
    inc a
    and $03
    ld [hl+], a
    jr nz, .setMovementHandler

    dec [hl]
    inc hl
    dec [hl]

.setMovementHandler
    ld de, UpdateCutscenePlayerShipMovement
    jp SetCurrentHandlerAddress

    ; this copies the instructions to display FINAL MISSION
    ; FinalMissionText: tile data
    ; $0e: bytes to copy (14)
    ; $9a2e: start drawing here in tile map
QueueFinalMissionText:
    ld hl, $0018
    add hl, bc
    xor a
    ld [hl], a
    ld a, $0e
    ld [wTextCopyLength], a
    ld de, FinalMissionText
    ld hl, wTextCopySourcePointer
    ld a, e
    ld [hl+], a
    ld [hl], d
    ld de, $9a2e
    ld a, e
    ld hl, wTextCopyDestinationPointer
    ld [hl+], a
    ld [hl], d
    ld a, $01
    ld [wTextCopyPending], a
    ld [wNextCreditsEntryIndex], a
    ld de, QueueIsOverText
    jp SetCurrentHandlerAddress

    ; this copies the instructions to display IS OVER
    ; IsOverText: tile data
    ; $0e: bytes to copy (14)
    ; $9a4e: start drawing here in tile map
QueueIsOverText:
    ld a, [wTextCopyPending]
    or a
    jp nz, AdvanceToNextHandler

    ld a, $0e
    ld [wTextCopyLength], a
    ld de, IsOverText
    ld hl, wTextCopySourcePointer
    ld a, e
    ld [hl+], a
    ld [hl], d
    ld de, $9a4e
    ld a, e
    ld hl, wTextCopyDestinationPointer
    ld [hl+], a
    ld [hl], d
    ld a, $01
    ld [wTextCopyPending], a
    ld [wNextCreditsEntryIndex], a
    ld de, WaitThenEndStageSevenCutscene
    jp SetCurrentHandlerAddress

WaitThenEndStageSevenCutscene:
    ld a, [wTextCopyPending]
    or a
    jp nz, AdvanceToNextHandler

    ld hl, $0018
    add hl, bc
    inc [hl]
    ld a, [hl]
    or a
    jp nz, AdvanceToNextHandler

    ld de, RequestNextStage
    jp SetCurrentHandlerAddress

    ; 2E5B
QueueFinalMissionTextAlternate:
    ld hl, $0018
    add hl, bc
    xor a
    ld [hl], a
    ld a, $0e
    ld [wTextCopyLength], a
    ld de, FinalMissionTextDuplicate
    ld hl, wTextCopySourcePointer
    ld a, e
    ld [hl+], a
    ld [hl], d
    ld de, $9a2e
    ld a, e
    ld hl, wTextCopyDestinationPointer
    ld [hl+], a
    ld [hl], d
    ld a, $01
    ld [wTextCopyPending], a
    ld [wNextCreditsEntryIndex], a
    ld de, QueueIsOverTextAlternate
    jp SetCurrentHandlerAddress

    ; 2E86
QueueIsOverTextAlternate:
    ld a, [wTextCopyPending]
    or a
    jp nz, AdvanceToNextHandler

    ld a, $0e
    ld [wTextCopyLength], a
    ld de, IsOverTextLeftTrimmed
    ld hl, wTextCopySourcePointer
    ld a, e
    ld [hl+], a
    ld [hl], d
    ld de, $9a4e
    ld a, e
    ld hl, wTextCopyDestinationPointer
    ld [hl+], a
    ld [hl], d
    ld a, $01
    ld [wTextCopyPending], a
    ld [wNextCreditsEntryIndex], a
    ld de, WaitThenEndStageSevenCutsceneAlternate
    jp SetCurrentHandlerAddress

    ; 2EB2
WaitThenEndStageSevenCutsceneAlternate:
    ld a, [wTextCopyPending]
    or a
    jp nz, AdvanceToNextHandler

    ld hl, $0018
    add hl, bc
    inc [hl]
    ld a, [hl]
    or a
    jp nz, AdvanceToNextHandler

    ld de, RequestNextStage
    jp SetCurrentHandlerAddress

InitializeStageEightCredits:
    ld de, SetupMotherAtenaInitHandlers
    call StoreAddressInFreeWramSlot
    ld de, WaitThenScrollBackgroundLeft
    jp SetCurrentHandlerAddress

WaitThenScrollBackgroundLeft:
    ld a, [wStageReady]
    or a
    jp z, AdvanceToNextHandler

    ld hl, wBackgroundScrollTimer
    ld a, [hl]
    or a
    jp nz, AdvanceToNextHandler

    ld hl, rSCX
    dec [hl]
    ld a, [hl]
    cp $11
    jp nc, AdvanceToNextHandler

    jp RemoveCurrentHandler

InitializeCreditsEndObject:
    ld bc, CreditsEndObjectInitTemplate
    call TryInitializeObjectInFreeSlot
    or a
    jp z, RemoveCurrentHandler

    ld de, ConfigureCreditsEndObject
    jp SetCurrentHandlerAddress

ConfigureCreditsEndObject:
    ld a, [bc]
    call SetObjectPointer
    ld bc, CreditsEndObjectInitTemplate
    ld de, $a048
    call ResetObjectAttributes
    ld de, CreditsEndObjectGraphics
    call SetObjectGraphicsPointer
    ld de, UpdateCreditsEndObjectMovement
    jp SetCurrentHandlerAddress

UpdateCreditsEndObjectMovement:
    ld a, [bc]
    call SetObjectPointer
    inc hl
    ld a, [hl]
    cp $30
    jr c, .displayScore

    ld d, b
    ld e, c
    ld a, $fc
    call CalculateYMovement
    ld a, [$ca16]
    ld d, a
    ld e, $00
    call MoveObject
    jp AdvanceToNextHandler


.displayScore
    ld de, QueueDisplayScoreAndFinishCredits
    jp SetCurrentHandlerAddress

QueueDisplayScoreAndFinishCredits:
    ld hl, wFinalScoreTextBuffer
    ld de, FinalScoreTextPrefix
    ld b, $06

.copyBytes
    ld a, [de]
    ld [hl+], a
    inc de
    dec b
    jr nz, .copyBytes

    ld hl, wFinalScoreTextBuffer + 6
    ld de, wPlayerScore
    ld b, $07

.copyPlayerScore:
    ld a, [de]
    or $f0
    ld [hl+], a
    inc de
    dec b
    jr nz, .copyPlayerScore

    ld a, $0e
    ld [wTextCopyLength], a
    ld de, wFinalScoreTextBuffer
    ld hl, wTextCopySourcePointer
    ld a, e
    ld [hl+], a
    ld [hl], d
    ld de, $9a25
    ld a, e
    ld hl, wTextCopyDestinationPointer
    ld [hl+], a
    ld [hl], d
    ld a, $01
    ld [wTextCopyPending], a
    ld [wNextCreditsEntryIndex], a
    ld [wHardModeUnlocked], a
    ld [wEnableQuickSoftReset], a
    ld a, [wGameMode]
    or a
    jp z, RemoveCurrentHandler

    ld [wEnableAltProjectileMovement], a
    jp RemoveCurrentHandler


CreditsEndObjectInitTemplate: ; $2F8D
    db $13             ; One row, three sprite columns.
    db $08, $08        ; Collision center offset (Y, X).
    db $00, $00        ; Hitbox minimum offset (Y, X).
    db $10, $10        ; Hitbox maximum offset (Y, X).
    db $01             ; Final object attribute.

CreditsEndObjectGraphics: ; $2F95: (tile, attributes).
    db $bc, $00, $ce, $00, $ba, $00

FinalBossCutsceneInitTemplate:
    db $13, $08, $08, $00, $00, $10, $10, $01

    ; $2FA3: graphics (tile, attributes).
FinalBossCutsceneGraphics:
    db $80, $00, $82, $00, $84, $00
    nop
    nop
    nop
    nop
    nop
    nop

PlayerShipCutsceneInitTemplate:
    db $24, $08, $08, $00, $00, $10, $10, $01

PlayerShipCutsceneGraphics:
    db $5a, $00, $5c, $00, $00, $00, $00, $00
    db $00, $00, $00, $00, $5e, $00, $60, $00

FinalBossCutsceneDestructionSmokeOffsets: ; $2FC7, signed (Y, X) pairs.
    db $04, $04
    db $00, $04
    db $04, $00
    db $00, $fc
    db $fc, $00
    db $00, $00
    db $fc, $fc
    db $fc
    inc b
    nop
    inc b
    inc b
    db $fc
    ; $2FDB: cutscene tile data (14 bytes).
    ; Spells FINAL MISSION
FinalMissionText:
    db $be, $c4, $ce, $b4, $ca, $bf, $cc
    db $c4, $d8, $d8, $c4, $d0, $ce, $bf

    ; $2FE9: cutscene tile data (14 bytes).
    ; Spells IS OVER
IsOverText:
    db $bf, $bf, $bf, $c4, $d8, $bf, $d0
    db $de, $bc, $d6, $bf, $bf, $bf, $bf

    ; $2FF7: alternate-path cutscene tile data (14 bytes), FINAL MISSION.
FinalMissionTextDuplicate:
    db $be, $c4, $ce, $b4, $ca, $bf, $cc
    db $c4, $d8, $d8, $c4, $d0, $ce, $bf

    ; $3005: alternate-path cutscene tile data (14 bytes), IS OVER.
IsOverTextLeftTrimmed:
    db $c4, $d8, $bf, $d0, $de, $bc, $d6
    db $bf, $bf, $bf, $bf, $bf, $bf, $bf

FinalScoreTextPrefix: ; $3013: "SCORE " tile IDs.
    db $d8, $b8, $d0, $d6, $bc, $bf

SetupMotherAtenaInitHandlers:
    ld de, InitializeMotherAtenaBow
    call StoreAddressInFreeWramSlot
    ld de, InitializeMotherAtenaThruster
    call StoreAddressInFreeWramSlot
    ld a, $01
    ld [wMotherAtenaSetup], a
    ld de, InitializeMotherAtenaBody
    jp SetCurrentHandlerAddress

InitializeMotherAtenaBody:
    ld bc, MotherAtenaBodyInitTemplate
    call TryInitializeObjectInFreeSlot
    or a
    jp z, RemoveCurrentHandler

    ld de, ConfigureMotherAtenaBody
    jp SetCurrentHandlerAddress

InitializeMotherAtenaBow:
    ld bc, MotherAtenaBowInitTemplate
    call TryInitializeObjectInFreeSlot
    or a
    jp z, RemoveCurrentHandler

    ld de, ConfigureMotherAtenaBow
    jp SetCurrentHandlerAddress

ConfigureMotherAtenaBody:
    ld a, [bc]
    call SetObjectPointer
    ld bc, MotherAtenaBodyInitTemplate
    ld de, $30e1
    call ResetObjectAttributes
    ld de, MotherAtenaBodyGraphics
    call SetObjectGraphicsPointer
    ld de, MoveAtenaPartsRightDuringScroll
    jp SetCurrentHandlerAddress

ConfigureMotherAtenaBow:
    ld a, [bc]
    call SetObjectPointer
    ld bc, MotherAtenaBowInitTemplate
    ld de, $4000
    call ResetObjectAttributes
    ld de, MotherAtenaBowGraphics
    call SetObjectGraphicsPointer
    ld de, MoveAtenaPartsRightDuringScroll
    jp SetCurrentHandlerAddress

MoveAtenaPartsRightDuringScroll:
    ld hl, wBackgroundScrollTimer
    ld a, [hl]
    or a
    jp nz, AdvanceToNextHandler

    ldh a, [rSCX]
    cp $12
    jp c, .setDepartureHandler

    ld a, [bc]
    call SetObjectPointer
    ld de, $0001
    call MoveObject
    jp AdvanceToNextHandler


.setDepartureHandler
    ld de, WaitForMotherAtenaDeparture
    jp SetCurrentHandlerAddress

WaitForMotherAtenaDeparture:
    ld a, [wMotherAtenaDeparture]
    or a
    jp z, AdvanceToNextHandler

    ld de, UpdateMotherAtenaPartDeparture
    jp SetCurrentHandlerAddress

UpdateMotherAtenaPartDeparture:
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
    jr nz, .moveAtena

    inc [hl]

.moveAtena
    ld a, [hl]
    call CalculateXMovement
    ld a, [$ca17]
    ld e, a
    ld d, $00
    call MoveObject
    jp AdvanceToNextHandler

InitializeMotherAtenaThruster:
    ld a, [wCreditsEnded]
    or a
    jp z, AdvanceToNextHandler

    ld bc, MotherAtenaThrusterInitTemplate
    call TryInitializeObjectInFreeSlot
    or a
    jp z, RemoveCurrentHandler

    ld de, ConfigureMotherAtenaThruster
    jp SetCurrentHandlerAddress

ConfigureMotherAtenaThruster:
    ld a, [bc]
    call SetObjectPointer
    ld bc, MotherAtenaThrusterInitTemplate
    ld de, $4012
    call ResetObjectAttributes
    ld de, AnimateThrusterStartup
    jp SetCurrentHandlerAddress

AnimateThrusterStartup:
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
    jr z, .moveToNextPhase

    and $01
    add a
    ld l, a
    ld h, $00
    ld de, MotherAtenaThrusterStartupFrameTable
    add hl, de
    ld a, [hl+]
    ld d, [hl]
    ld e, a
    call SetObjectGraphicsPointer
    jp AdvanceToNextHandler


.moveToNextPhase
    xor a
    ld [bc], a
    ld de, AnimateThrusterSecondPhase
    jp SetCurrentHandlerAddress

AnimateThrusterSecondPhase:
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
    jr z, .movetoDeparture

    add a
    ld l, a
    ld h, $00
    ld de, MotherAtenaThrusterSecondPhaseFrameTable
    add hl, de
    ld a, [hl+]
    ld d, [hl]
    ld e, a
    call SetObjectGraphicsPointer
    jp AdvanceToNextHandler


.movetoDeparture
    xor a
    ld [bc], a
    inc a
    ld [wMotherAtenaDeparture], a
    ld de, UpdateMotherAtenaThrusterDeparture
    jp SetCurrentHandlerAddress

UpdateMotherAtenaThrusterDeparture:
    ld a, [bc]
    call SetObjectPointer
    inc hl
    inc hl
    ld a, [hl]
    cp $c0
    jp nc, .removeAtena

    ld hl, $0004
    add hl, bc
    ld a, [hl]
    inc [hl]
    inc hl
    and $07
    jr nz, .moveAtena

    inc [hl]

.moveAtena
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
    ld de, MotherAtenaThrusterDepartureFrameTable
    add hl, de
    ld a, [hl+]
    ld d, [hl]
    ld e, a
    call SetObjectGraphicsPointer
    jp AdvanceToNextHandler


.removeAtena
    ld a, [bc]
    call SetObjectPointer
    ld de, InitializeCreditsEndObject
    call StoreAddressInFreeWramSlot
    jp FreeObjectAndRemoveHandler


; Both eight-byte templates overlap each other and the first graphics block.
MotherAtenaBodyInitTemplate: ; $31BA: three rows, four columns.
    db $34
MotherAtenaBowInitTemplate: ; $31BB: one row, four columns.
    db $14

MotherAtenaBodyGraphics: ; $31BC: (tile, attributes), four sprites per row.
    db $06, $00, $08, $00, $0a, $00, $0c, $00
    db $0e, $00, $10, $00, $12, $00, $14, $00
    db $16, $00, $18, $00, $1a, $00, $1c, $00

MotherAtenaBowGraphics: ; $31D4: (tile, attributes).
    db $1e, $00, $20, $00, $22, $00, $24, $00

    ; $31DC: eight-byte initialization template overlapping the pointer data below.
MotherAtenaThrusterInitTemplate:
    db $12

; The initialization template consumes seven bytes of these frame pointers.
MotherAtenaThrusterStartupFrameTable: ; $31DD: alternate these two frames.
    dw MotherAtenaThrusterStartupGraphics0, MotherAtenaThrusterStartupGraphics1

MotherAtenaThrusterSecondPhaseFrameTable: ; $31E1: play these three frames in order.
    dw MotherAtenaThrusterSecondPhaseGraphics0, MotherAtenaThrusterSecondPhaseGraphics1
    dw MotherAtenaThrusterSecondPhaseGraphics2

MotherAtenaThrusterDepartureFrameTable: ; $31E7: alternate these two frames.
    dw MotherAtenaThrusterDepartureGraphics0, MotherAtenaThrusterDepartureGraphics1

; Each frame is two (tile, attributes) pairs; tile $00 is blank.
MotherAtenaThrusterStartupGraphics0: ; $31EB
    db $00, $00, $26, $00
MotherAtenaThrusterStartupGraphics1: ; $31EF
    db $00, $00, $28, $00

MotherAtenaThrusterSecondPhaseGraphics0: ; $31F3
    db $00, $00, $2a, $00
MotherAtenaThrusterSecondPhaseGraphics1: ; $31F7
    db $00, $00, $2c, $00
MotherAtenaThrusterSecondPhaseGraphics2: ; $31FB
    db $2e, $00, $30, $00

MotherAtenaThrusterDepartureGraphics0: ; $31FF
    db $32, $00, $34, $00
MotherAtenaThrusterDepartureGraphics1: ; $3203
    db $36, $00, $38, $00

; 3207
WaitAndClearCreditIndex:
    ld hl, $0004
    add hl, bc
    inc [hl]
    ld a, [hl]
    or a
    jp nz, AdvanceToNextHandler

    xor a
    ld [wNextCreditsEntryIndex], a
    ld de, StartNextCreditsGroup
    jp SetCurrentHandlerAddress

StartNextCreditsGroup:
    call QueueNextCreditsEntryDisplay
    ld a, $90
    ldh [rWX], a
    ld de, WaitAndQueueNextCredits
    jp SetCurrentHandlerAddress

WaitAndQueueNextCredits:
    ld a, [wTextCopyPending]
    or a
    jp nz, AdvanceToNextHandler

    call QueueNextCreditsEntryDisplay
    ld a, [wNextCreditsEntryIndex]
    cp $02
    jr z, .setSlideCreditsLeft

    cp $05
    jr z, .setSlideCreditsLeft

    cp $08
    jr z, .setSlideCreditsLeft

    cp $0a
    jr z, .setSlideCreditsLeft

    cp $0d
    jr z, .setSlideCreditsLeft

    cp $0f
    jr z, .setSlideCreditsLeft

    cp $12
    jr z, .setSlideCreditsLeft

    cp $14
    jr z, .setSlideCreditsLeft

    cp $16
    jr z, .setSlideCreditsLeft

    cp $18
    jr z, .setSlideCreditsLeft

    cp $1c
    jr z, .setSlideCreditsLeft

    jp AdvanceToNextHandler


.setSlideCreditsLeft
    ld de, SlideCreditsWindowLeft
    jp SetCurrentHandlerAddress

SlideCreditsWindowLeft:
    ld a, [wTextCopyPending]
    or a
    jp nz, AdvanceToNextHandler

    ld hl, wCreditsWindowSlideCounter
    ld a, [hl]
    inc a
    ld [hl], a
    and $03
    jp nz, AdvanceToNextHandler

    ld hl, rWX
    dec [hl]
    ld a, [hl]
    cp $08
    jp nc, AdvanceToNextHandler

    ld de, CheckCreditsEnd
    jp SetCurrentHandlerAddress

CheckCreditsEnd:
    ld hl, wNextCreditsEntryIndex
    ld a, [hl+]
    cp $1c
    jr nz, .waitAndMoveToNextCreditsGroup

    ld a, $01
    ld [wCreditsEnded], a
    jp RemoveCurrentHandler

.waitAndMoveToNextCreditsGroup
    inc [hl]
    ld a, [hl] ; wCreditsGroupHoldTimer
    cp $e0
    jp nz, AdvanceToNextHandler

    xor a
    ld [hl], a
    ld de, StartNextCreditsGroup
    jp SetCurrentHandlerAddress

QueueNextCreditsEntryDisplay:
    ld a, [wNextCreditsEntryIndex]
    ld b, a
    ld a, $11
    ld [wTextCopyLength], a
    ld a, b
    add a
    ld l, a
    ld h, $00
    ld de, CreditsTextPointerTable
    add hl, de
    ld a, [hl+]
    ld e, [hl]
    ld hl, wTextCopySourcePointer
    ld [hl+], a
    ld [hl], e
    ld a, b
    add a
    ld l, a
    ld h, $00
    ld de, CreditsWindowDestinationTable
    add hl, de
    ld a, [hl+]
    ld e, [hl]
    ld hl, wTextCopyDestinationPointer
    ld [hl+], a
    ld [hl], e
    ld a, b
    inc a
    ld [wTextCopyPending], a
    ld [wNextCreditsEntryIndex], a
    ret


CreditsWindowDestinationTable: ; $32DD: 28 window tilemap destinations.
    dw $9c02 ; entry $00
    dw $9c22 ; entry $01
    dw $9c02 ; entry $02
    dw $9c22 ; entry $03
    dw $9c42 ; entry $04
    dw $9c02 ; entry $05
    dw $9c22 ; entry $06
    dw $9c42 ; entry $07
    dw $9c02 ; entry $08
    dw $9c22 ; entry $09
    dw $9c02 ; entry $0a
    dw $9c22 ; entry $0b
    dw $9c42 ; entry $0c
    dw $9c22 ; entry $0d
    dw $9c42 ; entry $0e
    dw $9c02 ; entry $0f
    dw $9c22 ; entry $10
    dw $9c42 ; entry $11
    dw $9c22 ; entry $12
    dw $9c42 ; entry $13
    dw $9c22 ; entry $14
    dw $9c42 ; entry $15
    dw $9c22 ; entry $16
    dw $9c42 ; entry $17
    dw $9c02 ; entry $18
    dw $9c22 ; entry $19
    dw $9c42 ; entry $1a
    dw $9c62 ; entry $1b

CreditsTextPointerTable: ; $3315: 28 pointers to 17-byte text entries.
    dw CreditsProducerText ; entry $00
    dw CreditsGYokoiText ; entry $01
    dw CreditsDirectorText ; entry $02
    dw CreditsSOkadaText ; entry $03
    dw CreditsKTerasakiText ; entry $04
    dw CreditsProgrammerText ; entry $05
    dw CreditsKSugimotoText ; entry $06
    dw CreditsProgrammerBlankText ; entry $07
    dw CreditsMusicSoundText ; entry $08
    dw CreditsTOsadaText ; entry $09
    dw CreditsDesignText ; entry $0a
    dw CreditsAHigashiyaText ; entry $0b
    dw CreditsKYamagamiText ; entry $0c
    dw CreditsKKatsuyamaText ; entry $0d
    dw CreditsKHayashiText ; entry $0e
    dw CreditsSpecialThanksText ; entry $0f
    dw CreditsHHirayamaText ; entry $10
    dw CreditsYFujiiText ; entry $11
    dw CreditsKTakeuchiText ; entry $12
    dw CreditsHAyrtonWadaText ; entry $13
    dw CreditsYKawakamiText ; entry $14
    dw CreditsMNakataniText ; entry $15
    dw CreditsHNakazawaText ; entry $16
    dw CreditsYArashibaText ; entry $17
    dw CreditsSolarStrikerText ; entry $18
    dw CreditsCopyrightBlankText0 ; entry $19
    dw CreditsCopyrightBlankText1 ; entry $1a
    dw CreditsCopyrightText ; entry $1b

; Credits tile IDs, with padding retained so every entry is exactly 17 bytes.
; Group boundaries correspond to the next-entry index checks in WaitAndQueueNextCredits.
; $BF and $FB are spaces; $E8 is a period; $FC and $EA-$EF form the copyright symbol and Nintendo logo.

; Group 1: producer.
CreditsProducerText: ; $334D, entry $00: "PRODUCER".
    db $d2, $d6, $d0, $ba, $dc, $b8, $bc, $d6, $bf, $bf, $bf, $bf, $bf, $bf, $bf, $bf, $bf
CreditsGYokoiText: ; $335E, entry $01: "G.YOKOI".
    db $c0, $e8, $e4, $d0, $c8, $d0, $c4, $bf, $bf, $bf, $bf, $bf, $bf, $bf, $bf, $bf, $bf

; Group 2: directors.
CreditsDirectorText: ; $336F, entry $02: "DIRECTOR".
    db $ba, $c4, $d6, $bc, $b8, $da, $d0, $d6, $bf, $bf, $bf, $bf, $bf, $bf, $bf, $bf, $bf
CreditsSOkadaText: ; $3380, entry $03: "S.OKADA".
    db $d8, $e8, $d0, $c8, $b4, $ba, $b4, $bf, $bf, $bf, $bf, $bf, $bf, $bf, $bf, $bf, $bf
CreditsKTerasakiText: ; $3391, entry $04: "K.TERASAKI".
    db $c8, $e8, $da, $bc, $d6, $b4, $d8, $b4, $c8, $c4, $bf, $bf, $bf, $bf, $bf, $bf, $bf

; Group 3: programmer.
CreditsProgrammerText: ; $33A2, entry $05: "PROGRAMMER".
    db $d2, $d6, $d0, $c0, $d6, $b4, $cc, $cc, $bc, $d6, $bf, $bf, $bf, $bf, $bf, $bf, $bf
CreditsKSugimotoText: ; $33B3, entry $06: "K.SUGIMOTO".
    db $c8, $e8, $d8, $dc, $c0, $c4, $cc, $d0, $da, $d0, $bf, $bf, $bf, $bf, $bf, $bf, $bf
CreditsProgrammerBlankText: ; $33C4, entry $07: blank row.
    db $bf, $bf, $bf, $bf, $bf, $bf, $bf, $bf, $bf, $bf, $bf, $bf, $bf, $bf, $bf, $bf, $bf

; Group 4: music / sound.
CreditsMusicSoundText: ; $33D5, entry $08: "MUSIC SOUND".
    db $cc, $dc, $d8, $c4, $b8, $bf, $d8, $d0, $dc, $ce, $ba, $bf, $bf, $bf, $bf, $bf, $bf
CreditsTOsadaText: ; $33E6, entry $09: "T.OSADA".
    db $da, $e8, $d0, $d8, $b4, $ba, $b4, $bf, $bf, $bf, $bf, $bf, $bf, $bf, $bf, $bf, $bf

; Group 5: design (first page).
CreditsDesignText: ; $33F7, entry $0a: "DESIGN".
    db $ba, $bc, $d8, $c4, $c0, $ce, $bf, $bf, $bf, $bf, $bf, $bf, $bf, $bf, $bf, $bf, $bf
CreditsAHigashiyaText: ; $3408, entry $0b: "A.HIGASHIYA".
    db $b4, $e8, $c2, $c4, $c0, $b4, $d8, $c2, $c4, $e4, $b4, $bf, $bf, $bf, $bf, $bf, $bf
CreditsKYamagamiText: ; $3419, entry $0c: "K.YAMAGAMI".
    db $c8, $e8, $e4, $b4, $cc, $b4, $c0, $b4, $cc, $c4, $bf, $bf, $bf, $bf, $bf, $bf, $bf

; Group 6: design (second page).
CreditsKKatsuyamaText: ; $342A, entry $0d: "K.KATSUYAMA".
    db $c8, $e8, $c8, $b4, $da, $d8, $dc, $e4, $b4, $cc, $b4, $bf, $bf, $bf, $bf, $bf, $bf
CreditsKHayashiText: ; $343B, entry $0e: "K.HAYASHI".
    db $c8, $e8, $c2, $b4, $e4, $b4, $d8, $c2, $c4, $bf, $bf, $bf, $bf, $bf, $bf, $bf, $bf

; Group 7: special thanks (first page).
CreditsSpecialThanksText: ; $344C, entry $0f: "SPECIAL THANKS TO".
    db $d8, $d2, $bc, $b8, $c4, $b4, $ca, $fb, $da, $c2, $b4, $ce, $c8, $d8, $fb, $da, $d0
CreditsHHirayamaText: ; $345D, entry $10: "H.HIRAYAMA".
    db $c2, $e8, $c2, $c4, $d6, $b4, $e4, $b4, $cc, $b4, $bf, $bf, $bf, $bf, $bf, $bf, $bf
CreditsYFujiiText: ; $346E, entry $11: "Y.FUJII".
    db $e4, $e8, $be, $dc, $c6, $c4, $c4, $bf, $bf, $bf, $bf, $bf, $bf, $bf, $bf, $bf, $bf

; Group 8: special thanks (second page).
CreditsKTakeuchiText: ; $347F, entry $12: "K.TAKEUCHI".
    db $c8, $e8, $da, $b4, $c8, $bc, $dc, $b8, $c2, $c4, $bf, $bf, $bf, $bf, $bf, $bf, $bf
CreditsHAyrtonWadaText: ; $3490, entry $13: "H.AYRTON.WADA".
    db $c2, $e8, $b4, $e4, $d6, $da, $d0, $ce, $e8, $e0, $b4, $ba, $b4, $bf, $bf, $bf, $bf

; Group 9: special thanks (third page).
CreditsYKawakamiText: ; $34A1, entry $14: "Y.KAWAKAMI".
    db $e4, $e8, $c8, $b4, $e0, $b4, $c8, $b4, $cc, $c4, $bf, $bf, $bf, $bf, $bf, $bf, $bf
CreditsMNakataniText: ; $34B2, entry $15: "M.NAKATANI".
    db $cc, $e8, $ce, $b4, $c8, $b4, $da, $b4, $ce, $c4, $bf, $bf, $bf, $bf, $bf, $bf, $bf

; Group 10: special thanks (fourth page).
CreditsHNakazawaText: ; $34C3, entry $16: "H.NAKAZAWA".
    db $c2, $e8, $ce, $b4, $c8, $b4, $e6, $b4, $e0, $b4, $bf, $bf, $bf, $bf, $bf, $bf, $bf
CreditsYArashibaText: ; $34D4, entry $17: "Y.ARASHIBA".
    db $e4, $e8, $b4, $d6, $b4, $d8, $c2, $c4, $b6, $b4, $bf, $bf, $bf, $bf, $bf, $bf, $bf

; Group 11: title and copyright.
CreditsSolarStrikerText: ; $34E5, entry $18: "SOLARSTRIKER".
    db $bf, $d8, $d0, $ca, $b4, $d6, $d8, $da, $d6, $c4, $c8, $bc, $d6, $bf, $bf, $bf, $bf
CreditsCopyrightBlankText0: ; $34F6, entry $19: blank row.
    db $bf, $bf, $bf, $bf, $bf, $bf, $bf, $bf, $bf, $bf, $bf, $bf, $bf, $bf, $bf, $bf, $bf
CreditsCopyrightBlankText1: ; $3507, entry $1a: blank row.
    db $bf, $bf, $bf, $bf, $bf, $bf, $bf, $bf, $bf, $bf, $bf, $bf, $bf, $bf, $bf, $bf, $bf
CreditsCopyrightText: ; $3518, entry $1b: "(C)1989 Nintendo".
    db $bf, $fc, $a2, $b2, $b0, $b2, $bf, $ea, $eb, $ec, $ed, $ee, $ef, $bf, $bf, $bf, $bf

; Each pointer selects a movement command sequence, read in order.
ProtodroidMovementScriptB: ; $3529
    dw MovementRightToDownCommands
    dw MovementDownToLeftCommands
    dw MovementLeft8Commands
    dw MovementLeft16Commands

ProtodroidMovementScriptA: ; $3531
    dw MovementLeftToDownCommands
    dw MovementDownToRightCommands
    dw MovementRight8Commands
    dw MovementRight16Commands

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
    dw MovementDown16Commands
    dw MovementDownToDownRightCommands
    dw MovementDownRightToRightCommands
    dw MovementRight16Commands
    dw MovementRight16Commands
    dw MovementRight16Commands
    dw MovementRight16Commands
    dw MovementRight16Commands
    dw MovementRight16Commands

CruiserMovementScriptB: ; $3561
    dw MovementDown16Commands
    dw MovementDownToDownLeftCommands
    dw MovementDownLeftToLeftCommands
    dw MovementLeft16Commands
    dw MovementLeft16Commands
    dw MovementLeft16Commands
    dw MovementLeft16Commands
    dw MovementLeft16Commands
    dw MovementLeft16Commands

; Each pointer selects a movement command sequence, read in order.
RotomechMovementScriptA: ; $3573
    dw MovementDownToDownLeftCommands
    dw MovementDownLeft8Commands
    dw MovementDownLeftToDownCommands
    dw MovementDownToDownRightCommands
    dw MovementDownRight8Commands
    dw MovementDownRightToDownCommands

RotomechMovementScriptB: ; $357F
    dw MovementDownToDownRightCommands
    dw MovementDownRight8Commands
    dw MovementDownRightToDownCommands
    dw MovementDownToDownLeftCommands
    dw MovementDownLeft8Commands
    dw MovementDownLeftToDownCommands

BatwingMovementScriptA: ; $358B
    dw MovementDown16Commands
    dw MovementDown16Commands
    dw MovementUpRight16Commands
    dw MovementDown16Commands
    dw MovementDown16Commands

BatwingMovementScriptB: ; $3595
    dw MovementDown16Commands
    dw MovementDown16Commands
    dw MovementUpLeft16Commands
    dw MovementDown16Commands
    dw MovementDown16Commands

; Each pointer selects a movement command sequence, read in order.
PincherMovementScriptA: ; $359F
    dw MovementDown8Commands
    dw MovementPause8Commands
    dw MovementRight8Commands
    dw MovementDown8Commands
    dw MovementPause8Commands
    dw MovementRight8Commands
    dw MovementDown8Commands
    dw MovementPause8Commands
    dw MovementRight8Commands
    dw MovementDown8Commands
    dw MovementPause8Commands
    dw MovementRight8Commands
    dw MovementDown8Commands
    dw MovementPause8Commands
    dw MovementRight8Commands
    dw MovementDown8Commands
    dw MovementPause8Commands
    dw MovementRight8Commands

PincherMovementScriptB: ; $35C3
    dw MovementDown16Commands
    dw MovementPause8Commands
    dw MovementLeft16Commands
    dw MovementDown16Commands
    dw MovementPause8Commands
    dw MovementLeft16Commands
    dw MovementDown16Commands
    dw MovementPause8Commands
    dw MovementLeft16Commands
    dw MovementDown16Commands
    dw MovementPause8Commands
    dw MovementLeft16Commands
    dw MovementDown16Commands
    dw MovementPause8Commands
    dw MovementLeft16Commands
    dw MovementDown16Commands
    dw MovementPause8Commands
    dw MovementLeft16Commands

; Zigzag script B starts at script A's second pointer; both share the remaining data.
ZigzagMovementScriptA: ; $35E7
    dw MovementDownRight16Commands

ZigzagMovementScriptB: ; $35E9
    dw MovementDownLeft16Commands
    dw MovementDownRight16Commands
    dw MovementDownLeft16Commands
    dw MovementDownRight16Commands
    dw MovementDownLeft16Commands
    dw MovementDownLeft16Commands
    dw MovementDownRight16Commands
    dw MovementDownLeft16Commands
    dw MovementDownRight16Commands
    dw MovementDownLeft16Commands

MiditronMovementScriptA: ; $35FD
    dw MovementDown8Commands
    dw MovementDown8Commands
    dw MovementRight8Commands
    dw MovementRight8Commands
    dw MovementRight8Commands
    dw MovementUp16Commands
    dw MovementUp16Commands
    dw MovementUp16Commands
    dw MovementUp16Commands
    dw MovementUp16Commands
    dw MovementUp16Commands

MiditronMovementScriptB: ; $3613
    dw MovementDown8Commands
    dw MovementDown8Commands
    dw MovementLeft8Commands
    dw MovementLeft8Commands
    dw MovementLeft8Commands
    dw MovementUp16Commands
    dw MovementUp16Commands
    dw MovementUp16Commands
    dw MovementUp16Commands
    dw MovementUp16Commands
    dw MovementUp16Commands

AnthropMovementScriptA: ; $3629
    dw MovementDown8Commands
    dw MovementDownRight8Commands
    dw MovementUpRight8Commands
    dw MovementDownRight8Commands
    dw MovementUpRight8Commands
    dw MovementUp16Commands
    dw MovementUp16Commands
    dw MovementUp16Commands
    dw MovementUp16Commands
    dw MovementUp16Commands
    dw MovementUp16Commands

AnthropMovementScriptB: ; $363F
    dw MovementDown8Commands
    dw MovementDownLeft8Commands
    dw MovementUpLeft8Commands
    dw MovementDownLeft8Commands
    dw MovementUpLeft8Commands
    dw MovementUp16Commands
    dw MovementUp16Commands
    dw MovementUp16Commands
    dw MovementUp16Commands
    dw MovementUp16Commands
    dw MovementUp16Commands

OctopodMovementScriptA: ; $3655
    dw MovementDown16Commands
    dw MovementDown8Commands
    dw MovementDownToRightCommands
    dw MovementRightToUpCommands
    dw MovementUpToLeftCommands
    dw MovementLeftToDownCommands
    dw MovementDown16Commands
    dw MovementDown16Commands
    dw MovementDown16Commands
    dw MovementDown16Commands

OctopodMovementScriptB: ; $3669
    dw MovementDown16Commands
    dw MovementDown8Commands
    dw MovementDownToLeftCommands
    dw MovementLeftToUpCommands
    dw MovementUpToRightCommands
    dw MovementRightToDownCommands
    dw MovementDown16Commands
    dw MovementDown16Commands
    dw MovementDown16Commands
    dw MovementDown16Commands

SkimbotMovementScript: ; $367D
    dw MovementDown16Commands, MovementDown16Commands, MovementDown16Commands, MovementDown16Commands, MovementDown16Commands

TwerkMovementScript: ; $3687
    dw MovementDownToLeftCommands, MovementRightToDownCommands, MovementUpToRightCommands, MovementLeftToUpCommands, MovementDown16Commands
    dw MovementDownToLeftCommands, MovementRightToDownCommands, MovementUpToRightCommands, MovementLeftToUpCommands, MovementDown16Commands
    dw MovementDownToLeftCommands, MovementRightToDownCommands, MovementUpToRightCommands, MovementLeftToUpCommands, MovementDown16Commands

ScarabMovementScriptA: ; $36A5
    dw MovementDownToDownRightCommands, MovementDownRightToRightCommands, MovementLeftToDownLeftCommands, MovementDownLeftToDownCommands
    dw MovementDownToDownRightCommands, MovementDownRightToRightCommands, MovementLeftToDownLeftCommands, MovementDownLeftToDownCommands
    dw MovementDownToDownRightCommands, MovementDownRightToRightCommands, MovementLeftToDownLeftCommands, MovementDownLeftToDownCommands

ScarabMovementScriptB: ; $36BD
    dw MovementDownToDownLeftCommands, MovementDownLeftToLeftCommands, MovementRightToDownRightCommands, MovementDownRightToDownCommands
    dw MovementDownToDownLeftCommands, MovementDownLeftToLeftCommands, MovementRightToDownRightCommands, MovementDownRightToDownCommands
    dw MovementDownToDownLeftCommands, MovementDownLeftToLeftCommands, MovementRightToDownRightCommands, MovementDownRightToDownCommands

MackMovementScript: ; $36D5
    dw MovementDown8Commands, MovementPause8Commands
    dw MovementDown8Commands, MovementPause8Commands
    dw MovementDown8Commands, MovementPause8Commands
    dw MovementDown8Commands, MovementPause8Commands
    dw MovementDown8Commands, MovementPause8Commands
    dw MovementDown8Commands, MovementPause8Commands

VexorMovementScriptA: ; $36ED
    dw MovementDown16Commands, MovementRight8Commands, MovementRightToDownRightCommands, MovementDownRightToDownCommands
    dw MovementDown16Commands, MovementDown16Commands, MovementDown16Commands, MovementDown16Commands

VexorMovementScriptB: ; $36FD
    dw MovementDown16Commands, MovementLeft8Commands, MovementLeftToDownLeftCommands, MovementDownLeftToDownCommands
    dw MovementDown16Commands, MovementDown16Commands, MovementDown16Commands, MovementDown16Commands

WarhawkMovementScriptA: ; $370D
    dw MovementDown16Commands, MovementRight16Commands, MovementDown16Commands, MovementLeft16Commands
    dw MovementDown16Commands, MovementRight16Commands, MovementDown16Commands, MovementLeft16Commands
    dw MovementDown16Commands, MovementRight16Commands, MovementDown16Commands, MovementLeft16Commands

WarhawkMovementScriptB: ; $3725
    dw MovementDown16Commands, MovementLeft16Commands, MovementDown16Commands, MovementRight16Commands
    dw MovementDown16Commands, MovementLeft16Commands, MovementDown16Commands, MovementRight16Commands
    dw MovementDown16Commands, MovementLeft16Commands, MovementDown16Commands, MovementRight16Commands

DestructorMovementScript: ; $373D
    dw MovementDown8Commands, MovementLeft8Commands, MovementLeftToDownCommands, MovementDownToRightCommands, MovementRight16Commands, MovementRightToDownCommands
    dw MovementDownToLeftCommands, MovementLeft16Commands, MovementLeftToUpCommands, MovementUpToRightCommands, MovementRight16Commands, MovementRightToUpCommands
    dw MovementUpToLeftCommands, MovementLeft16Commands, MovementLeftToDownCommands, MovementDownToRightCommands, MovementRight16Commands, MovementRightToDownCommands
    dw MovementDownToLeftCommands, MovementLeft16Commands, MovementLeftToUpCommands, MovementUpToRightCommands, MovementRight16Commands, MovementRightToUpCommands
    dw MovementUpToLeftCommands, MovementLeft16Commands, MovementLeftToDownCommands, MovementDownToRightCommands, MovementRight16Commands, MovementRightToDownCommands
    dw MovementDownToLeftCommands, MovementLeft16Commands, MovementLeftToUpCommands, MovementUpToRightCommands, MovementRight16Commands, MovementRightToUpCommands
    dw MovementUpToLeftCommands, MovementLeft16Commands, MovementLeftToDownCommands, MovementDownToRightCommands, MovementRight16Commands, MovementRightToDownCommands
    dw MovementDownToLeftCommands, MovementLeft16Commands, MovementLeftToUpCommands, MovementUpToRightCommands, MovementRight16Commands, MovementRightToUpCommands
    dw MovementUpToLeftCommands, MovementLeft16Commands, MovementLeftToDownCommands, MovementDownToRightCommands, MovementRight16Commands, MovementRightToDownCommands
    dw MovementDownToLeftCommands, MovementLeft16Commands, MovementLeftToUpCommands, MovementUpToRightCommands, MovementRight16Commands, MovementRightToUpCommands
    dw MovementUpToLeftCommands, MovementLeft8Commands, MovementDown16Commands, MovementDown16Commands, MovementDown16Commands

UltraCrusherMovementScript: ; $37BF
    dw MovementDown8Commands
    dw MovementDown16Commands, MovementDown16Commands, MovementUp16Commands, MovementUp16Commands, MovementLeft16Commands, MovementRight16Commands, MovementRight16Commands, MovementLeft16Commands
    dw MovementDown16Commands, MovementDown16Commands, MovementUp16Commands, MovementUp16Commands, MovementLeft16Commands, MovementRight16Commands, MovementRight16Commands, MovementLeft16Commands
    dw MovementDown16Commands, MovementDown16Commands, MovementUp16Commands, MovementUp16Commands, MovementLeft16Commands, MovementRight16Commands, MovementRight16Commands, MovementLeft16Commands
    dw MovementDown16Commands, MovementDown16Commands, MovementUp16Commands, MovementUp16Commands, MovementLeft16Commands, MovementRight16Commands, MovementRight16Commands, MovementLeft16Commands
    dw MovementDown16Commands, MovementDown16Commands, MovementUp16Commands, MovementUp16Commands, MovementLeft16Commands, MovementRight16Commands, MovementRight16Commands, MovementLeft16Commands
    dw MovementDown16Commands, MovementDown16Commands, MovementUp16Commands, MovementUp16Commands, MovementLeft16Commands, MovementRight16Commands, MovementRight16Commands, MovementLeft16Commands
    dw MovementDown16Commands, MovementDown16Commands, MovementUp16Commands, MovementUp16Commands, MovementLeft16Commands, MovementRight16Commands, MovementRight16Commands, MovementLeft16Commands
    dw MovementDown16Commands, MovementDown16Commands, MovementUp16Commands, MovementUp16Commands, MovementLeft16Commands, MovementRight16Commands, MovementRight16Commands, MovementLeft16Commands
    dw MovementDown16Commands, MovementDown16Commands, MovementUp16Commands, MovementUp16Commands, MovementLeft16Commands, MovementRight16Commands, MovementRight16Commands, MovementLeft16Commands
    dw MovementDown16Commands, MovementDown16Commands, MovementUp16Commands, MovementUp16Commands, MovementLeft16Commands, MovementRight16Commands, MovementRight16Commands, MovementLeft16Commands
    dw MovementDown16Commands, MovementDown16Commands, MovementUp16Commands, MovementUp16Commands, MovementLeft16Commands, MovementRight16Commands, MovementRight16Commands, MovementLeft16Commands
    dw MovementDown16Commands, MovementDown16Commands, MovementUp16Commands, MovementUp16Commands, MovementLeft16Commands, MovementRight16Commands, MovementRight16Commands, MovementLeft16Commands
    dw MovementDown16Commands, MovementDown16Commands, MovementUp16Commands, MovementUp16Commands, MovementLeft16Commands, MovementRight16Commands, MovementRight16Commands, MovementLeft16Commands
    dw MovementDown16Commands, MovementDown16Commands, MovementUp16Commands, MovementUp16Commands, MovementLeft16Commands, MovementRight16Commands, MovementRight16Commands, MovementLeft16Commands
    dw MovementDown16Commands, MovementDown16Commands, MovementUp16Commands, MovementUp16Commands, MovementLeft16Commands, MovementRight16Commands, MovementRight16Commands, MovementLeft16Commands
    dw MovementDown16Commands, MovementDown16Commands, MovementUp16Commands, MovementUp16Commands, MovementLeft16Commands, MovementRight16Commands, MovementRight16Commands, MovementLeft16Commands
    dw MovementDown16Commands, MovementDown16Commands, MovementDown16Commands, MovementDown16Commands

EpikhanMovementScript: ; $38C9
    ; Enter: move down 24 pixels, then pause for 8 movement updates.
    dw MovementDown8Commands, MovementPause8Commands
    ; Sweep horizontally with pauses: $3CA1 = left, $3C91 = right, $3C89 = pause.
    dw MovementLeft16Commands, MovementPause8Commands, MovementRight16Commands, MovementRight16Commands, MovementPause8Commands, MovementLeft16Commands
    dw MovementLeft16Commands, MovementPause8Commands, MovementRight16Commands, MovementRight16Commands, MovementPause8Commands, MovementLeft16Commands
    dw MovementLeft16Commands, MovementPause8Commands, MovementRight16Commands, MovementRight16Commands, MovementPause8Commands, MovementLeft16Commands
    dw MovementLeft16Commands, MovementPause8Commands, MovementRight16Commands, MovementRight16Commands, MovementPause8Commands, MovementLeft16Commands
    dw MovementLeft16Commands, MovementPause8Commands, MovementRight16Commands, MovementRight16Commands, MovementPause8Commands, MovementLeft16Commands
    dw MovementLeft16Commands, MovementPause8Commands, MovementRight16Commands, MovementRight16Commands, MovementPause8Commands, MovementLeft16Commands
    dw MovementLeft16Commands, MovementPause8Commands, MovementRight16Commands, MovementRight16Commands, MovementPause8Commands, MovementLeft16Commands
    dw MovementLeft16Commands, MovementPause8Commands, MovementRight16Commands, MovementRight16Commands, MovementPause8Commands, MovementLeft16Commands
    dw MovementLeft16Commands, MovementPause8Commands, MovementRight16Commands, MovementRight16Commands, MovementPause8Commands, MovementLeft16Commands
    dw MovementLeft16Commands, MovementPause8Commands, MovementRight16Commands, MovementRight16Commands, MovementPause8Commands, MovementLeft16Commands
    ; $3945: exit downward, 24 pixels per sequence over 16 movement updates.
    dw MovementDownWithPauses16Commands, MovementDownWithPauses16Commands, MovementDownWithPauses16Commands, MovementDownWithPauses16Commands
    dw MovementDownWithPauses16Commands, MovementDownWithPauses16Commands, MovementDownWithPauses16Commands, MovementDownWithPauses16Commands

OmniquadCenterMovementScript: ; $3955
    dw MovementDown16Commands, MovementUpToLeftCommands, MovementLeftToDownCommands, MovementDownToRightCommands, MovementRightToUpCommands, MovementUpToRightCommands
    dw MovementRightToDownCommands, MovementDownToLeftCommands, MovementLeftToUpCommands, MovementUpToLeftCommands, MovementLeftToDownCommands, MovementDownToRightCommands
    dw MovementRightToUpCommands, MovementUpToRightCommands, MovementRightToDownCommands, MovementDownToLeftCommands, MovementLeftToUpCommands, MovementPause8Commands
    dw MovementPause8Commands, MovementPause8Commands, MovementPause8Commands, MovementPause8Commands, MovementPause8Commands, MovementPause8Commands
    dw MovementPause8Commands, MovementPause6Commands, MovementUpToLeftCommands, MovementLeftToDownCommands, MovementDownToRightCommands, MovementRightToUpCommands
    dw MovementUpToRightCommands, MovementRightToDownCommands, MovementDownToLeftCommands, MovementLeftToUpCommands, MovementPause8Commands, MovementPause8Commands
    dw MovementPause8Commands, MovementPause8Commands, MovementPause8Commands, MovementPause8Commands, MovementPause8Commands, MovementPause8Commands
    dw MovementPause6Commands, MovementDownWithPauses16Commands, MovementDownWithPauses16Commands, MovementDownWithPauses16Commands, MovementDownWithPauses16Commands, MovementDownWithPauses16Commands
    dw MovementDownWithPauses16Commands

OmniquadOuterMovementScript1: ; $39B7
    dw MovementDown16Commands, MovementUpToLeftCommands, MovementLeftToDownCommands, MovementDownToRightCommands, MovementRightToUpCommands, MovementUpToRightCommands
    dw MovementRightToDownCommands, MovementDownToLeftCommands, MovementLeftToUpCommands, MovementUpToLeftCommands, MovementLeftToDownCommands, MovementDownToRightCommands
    dw MovementRightToUpCommands, MovementUpToRightCommands, MovementRightToDownCommands, MovementDownToLeftCommands, MovementLeftToUpCommands, MovementPause8Commands
    dw MovementDown11Commands, MovementPause8Commands, MovementUpRight16Commands, MovementPause8Commands, MovementLeft11Commands, MovementPause8Commands
    dw MovementUpToLeftCommands, MovementLeftToDownCommands, MovementDownToRightCommands, MovementRightToUpCommands, MovementUpToRightCommands, MovementRightToDownCommands
    dw MovementDownToLeftCommands, MovementLeftToUpCommands, MovementPause8Commands, MovementRight11Commands, MovementPause8Commands, MovementUpLeft16Commands
    dw MovementPause8Commands, MovementDown11Commands, MovementPause8Commands, MovementDownWithPauses16Commands, MovementDownWithPauses16Commands, MovementDownWithPauses16Commands
    dw MovementDownWithPauses16Commands, MovementDownWithPauses16Commands, MovementDownWithPauses16Commands

OmniquadOuterMovementScript2: ; $3A11
    dw MovementDown16Commands, MovementUpToLeftCommands, MovementLeftToDownCommands, MovementDownToRightCommands, MovementRightToUpCommands, MovementUpToRightCommands
    dw MovementRightToDownCommands, MovementDownToLeftCommands, MovementLeftToUpCommands, MovementUpToLeftCommands, MovementLeftToDownCommands, MovementDownToRightCommands
    dw MovementRightToUpCommands, MovementUpToRightCommands, MovementRightToDownCommands, MovementDownToLeftCommands, MovementLeftToUpCommands, MovementPause8Commands
    dw MovementLeft11Commands, MovementPause8Commands, MovementDownRight16Commands, MovementPause8Commands, MovementUp11Commands, MovementPause8Commands
    dw MovementUpToLeftCommands, MovementLeftToDownCommands, MovementDownToRightCommands, MovementRightToUpCommands, MovementUpToRightCommands, MovementRightToDownCommands
    dw MovementDownToLeftCommands, MovementLeftToUpCommands, MovementPause8Commands, MovementDown11Commands, MovementPause8Commands, MovementUpRight16Commands
    dw MovementPause8Commands, MovementLeft11Commands, MovementPause8Commands, MovementDownWithPauses16Commands, MovementDownWithPauses16Commands, MovementDownWithPauses16Commands
    dw MovementDownWithPauses16Commands, MovementDownWithPauses16Commands, MovementDownWithPauses16Commands

OmniquadOuterMovementScript3: ; $3A6B
    dw MovementDown16Commands, MovementUpToLeftCommands, MovementLeftToDownCommands, MovementDownToRightCommands, MovementRightToUpCommands, MovementUpToRightCommands
    dw MovementRightToDownCommands, MovementDownToLeftCommands, MovementLeftToUpCommands, MovementUpToLeftCommands, MovementLeftToDownCommands, MovementDownToRightCommands
    dw MovementRightToUpCommands, MovementUpToRightCommands, MovementRightToDownCommands, MovementDownToLeftCommands, MovementLeftToUpCommands, MovementPause8Commands
    dw MovementRight11Commands, MovementPause8Commands, MovementUpLeft16Commands, MovementPause8Commands, MovementDown11Commands, MovementPause8Commands
    dw MovementUpToLeftCommands, MovementLeftToDownCommands, MovementDownToRightCommands, MovementRightToUpCommands, MovementUpToRightCommands, MovementRightToDownCommands
    dw MovementDownToLeftCommands, MovementLeftToUpCommands, MovementPause8Commands, MovementUp11Commands, MovementPause8Commands, MovementDownLeft16Commands
    dw MovementPause8Commands, MovementRight11Commands, MovementPause8Commands, MovementDownWithPauses16Commands, MovementDownWithPauses16Commands, MovementDownWithPauses16Commands
    dw MovementDownWithPauses16Commands, MovementDownWithPauses16Commands, MovementDownWithPauses16Commands

OmniquadOuterMovementScript4: ; $3AC5
    dw MovementDown16Commands, MovementUpToLeftCommands, MovementLeftToDownCommands, MovementDownToRightCommands, MovementRightToUpCommands, MovementUpToRightCommands
    dw MovementRightToDownCommands, MovementDownToLeftCommands, MovementLeftToUpCommands, MovementUpToLeftCommands, MovementLeftToDownCommands, MovementDownToRightCommands
    dw MovementRightToUpCommands, MovementUpToRightCommands, MovementRightToDownCommands, MovementDownToLeftCommands, MovementLeftToUpCommands, MovementPause8Commands
    dw MovementUp11Commands, MovementPause8Commands, MovementDownLeft16Commands, MovementPause8Commands, MovementRight11Commands, MovementPause8Commands
    dw MovementUpToLeftCommands, MovementLeftToDownCommands, MovementDownToRightCommands, MovementRightToUpCommands, MovementUpToRightCommands, MovementRightToDownCommands
    dw MovementDownToLeftCommands, MovementLeftToUpCommands, MovementPause8Commands, MovementLeft11Commands, MovementPause8Commands, MovementDownRight16Commands
    dw MovementPause8Commands, MovementUp11Commands, MovementPause8Commands, MovementDownWithPauses16Commands, MovementDownWithPauses16Commands, MovementDownWithPauses16Commands
    dw MovementDownWithPauses16Commands, MovementDownWithPauses16Commands, MovementDownWithPauses16Commands

XenocryptMovementScript1: ; $3B1F: 36 sequence pointers.
    dw MovementDown8Commands, MovementPause8Commands, MovementRight8Commands, MovementRightToDownCommands, MovementDownToLeftCommands, MovementLeft8Commands
    dw MovementLeft8Commands, MovementLeftToUpCommands, MovementUpToRightCommands, MovementRight8Commands, MovementLeft16Commands, MovementPause8Commands
    dw MovementPause8Commands, MovementPause8Commands, MovementPause8Commands, MovementPause8Commands, MovementPause8Commands, MovementPause8Commands
    dw MovementPause8Commands, MovementPause8Commands, MovementPause8Commands, MovementPause8Commands, MovementPause8Commands, MovementRight16Commands
    dw MovementRight16Commands, MovementPause8Commands, MovementDownToLeftCommands, MovementLeftToUpCommands, MovementPause8Commands, MovementLeft16Commands
    dw MovementPause8Commands, MovementPause8Commands, MovementDownRight16Commands, MovementPause8Commands, MovementDownRight16Commands, MovementDownRight16Commands

XenocryptMovementScript2: ; $3B67: 39 sequence pointers.
    dw MovementDown8Commands, MovementPause8Commands, MovementRight8Commands, MovementRightToDownCommands, MovementDownToLeftCommands, MovementLeft8Commands
    dw MovementLeft8Commands, MovementLeftToUpCommands, MovementUpToRightCommands, MovementRight8Commands, MovementLeft8Commands, MovementPause8Commands
    dw MovementPause8Commands, MovementPause8Commands, MovementLeft8Commands, MovementPause8Commands, MovementPause8Commands, MovementPause8Commands
    dw MovementPause8Commands, MovementRight8Commands, MovementPause8Commands, MovementPause8Commands, MovementPause8Commands, MovementPause8Commands
    dw MovementRight16Commands, MovementRight8Commands, MovementPause8Commands, MovementPause8Commands, MovementDownToLeftCommands, MovementLeftToUpCommands
    dw MovementPause8Commands, MovementLeft8Commands, MovementPause8Commands, MovementPause8Commands, MovementPause8Commands, MovementDownRight16Commands
    dw MovementPause8Commands, MovementDownRight16Commands, MovementDownRight16Commands

XenocryptMovementScript3: ; $3BB5: 38 sequence pointers.
    dw MovementDown8Commands, MovementPause8Commands, MovementRight8Commands, MovementRightToDownCommands, MovementDownToLeftCommands, MovementLeft8Commands
    dw MovementLeft8Commands, MovementLeftToUpCommands, MovementUpToRightCommands, MovementRight8Commands, MovementRight8Commands, MovementPause8Commands
    dw MovementPause8Commands, MovementPause8Commands, MovementLeft16Commands, MovementLeft8Commands, MovementPause8Commands, MovementPause8Commands
    dw MovementRight16Commands, MovementRight8Commands, MovementPause8Commands, MovementPause8Commands, MovementRight8Commands, MovementPause8Commands
    dw MovementPause8Commands, MovementPause8Commands, MovementPause8Commands, MovementDownToLeftCommands, MovementLeftToUpCommands, MovementPause8Commands
    dw MovementRight8Commands, MovementPause8Commands, MovementPause8Commands, MovementPause8Commands, MovementDownLeft16Commands, MovementPause8Commands
    dw MovementDownLeft16Commands, MovementDownLeft16Commands

XenocryptMovementScript4: ; $3C01: 34 sequence pointers.
    dw MovementDown8Commands, MovementPause8Commands, MovementRight8Commands, MovementRightToDownCommands, MovementDownToLeftCommands, MovementLeft8Commands
    dw MovementLeft8Commands, MovementLeftToUpCommands, MovementUpToRightCommands, MovementRight8Commands, MovementRight16Commands, MovementPause8Commands
    dw MovementPause8Commands, MovementLeft16Commands, MovementLeft16Commands, MovementPause8Commands, MovementRight16Commands, MovementRight16Commands
    dw MovementPause8Commands, MovementPause8Commands, MovementPause8Commands, MovementPause8Commands, MovementPause8Commands, MovementPause8Commands
    dw MovementDownToLeftCommands, MovementLeftToUpCommands, MovementPause8Commands, MovementRight16Commands, MovementPause8Commands, MovementPause8Commands
    dw MovementDownLeft16Commands, MovementPause8Commands, MovementDownLeft16Commands, MovementDownLeft16Commands

QuasiObliteratorLeftMovementScript: ; $3C45
    dw MovementDown16Commands, MovementLeft16Commands, MovementUp8Commands, MovementRight16Commands, MovementLeft16Commands, MovementDown16Commands
    dw MovementRight16Commands, MovementUp8Commands, MovementLeft16Commands, MovementRight16Commands, MovementDown8Commands, MovementLeft16Commands
    dw MovementUp8Commands, MovementRight16Commands, MovementDown16Commands, MovementDown16Commands, MovementDown16Commands

QuasiObliteratorRightMovementScript: ; $3C67
    dw MovementDown16Commands, MovementRight16Commands, MovementUp8Commands, MovementLeft16Commands, MovementRight16Commands, MovementDown16Commands
    dw MovementLeft16Commands, MovementUp8Commands, MovementRight16Commands, MovementLeft16Commands, MovementDown8Commands, MovementRight16Commands
    dw MovementUp8Commands, MovementLeft16Commands, MovementDown16Commands, MovementDown16Commands, MovementDown16Commands


; Shared movement commands: bit 7 = Y -3, bit 6 = Y +3,
; bit 5 = X -3, bit 4 = X +3; bit 3 advances to the next script pointer.
; The final command still applies movement. Offsets exclude the caller's downward drift.
MovementPause8Commands: ; $3C89: 8 commands with no scripted movement; caller's drift still applies.
    db $00, $00, $00, $00, $00, $00, $00, $08

MovementRight16Commands: ; $3C91: 16 commands moving right.
    db $10, $10, $10, $10, $10, $10, $10, $10, $10, $10, $10, $10, $10, $10, $10, $18

MovementLeft16Commands: ; $3CA1: 16 commands moving left.
    db $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $28

MovementDown16Commands: ; $3CB1: 16 commands moving down.
    db $40, $40, $40, $40, $40, $40, $40, $40
    db $40, $40, $40, $40, $40, $40, $40, $48

MovementUp16Commands: ; $3CC1: 16 commands moving up.
    db $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $88

MovementDownRight16Commands: ; $3CD1: 16 commands moving down-right.
    db $50, $50, $50, $50, $50, $50, $50, $50, $50, $50, $50, $50, $50, $50, $50, $58

MovementDownLeft16Commands: ; $3CE1: 16 commands moving down-left.
    db $60, $60, $60, $60, $60, $60, $60, $60, $60, $60, $60, $60, $60, $60, $60, $68

MovementUpRight16Commands: ; $3CF1: 16 commands moving up-right.
    db $90, $90, $90, $90, $90, $90, $90, $90, $90, $90, $90, $90, $90, $90, $90, $98

MovementUpLeft16Commands: ; $3D01: 16 commands moving up-left.
    db $a0, $a0, $a0, $a0, $a0, $a0, $a0, $a0, $a0, $a0, $a0, $a0, $a0, $a0, $a0, $a8

MovementRight11Commands: ; $3D11: 11 commands moving right.
    db $10, $10, $10, $10, $10, $10, $10, $10, $10, $10, $18

MovementLeft11Commands: ; $3D1C: 11 commands moving left.
    db $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $28

MovementDown11Commands: ; $3D27: 11 commands moving down.
    db $40, $40, $40, $40, $40, $40, $40, $40, $40, $40, $48

MovementUp11Commands: ; $3D32: 11 commands moving up.
    db $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $88

MovementRight8Commands: ; $3D3D: 8 commands moving right.
    db $10, $10, $10, $10, $10, $10, $10, $18

MovementLeft8Commands: ; $3D45: 8 commands moving left.
    db $20, $20, $20, $20, $20, $20, $20, $28

MovementDown8Commands: ; $3D4D: 8 commands moving down.
    db $40, $40, $40, $40, $40, $40, $40, $48

MovementUp8Commands: ; $3D55: 8 commands moving up.
    db $80, $80, $80, $80, $80, $80, $80, $88

MovementDownRight8Commands: ; $3D5D: 8 commands moving down-right.
    db $50, $50, $50, $50, $50, $50, $50, $58

MovementDownLeft8Commands: ; $3D65: 8 commands moving down-left.
    db $60, $60, $60, $60, $60, $60, $60, $68

MovementUpRight8Commands: ; $3D6D: 8 commands moving up-right.
    db $90, $90, $90, $90, $90, $90, $90, $98

MovementUpLeft8Commands: ; $3D75: 8 commands moving up-left.
    db $a0, $a0, $a0, $a0, $a0, $a0, $a0, $a8

MovementPause6Commands: ; $3D7D: 6 commands with no scripted movement; caller's drift still applies.
    db $00, $00, $00, $00, $00, $08

MovementDownWithPauses16Commands: ; $3D83: Alternate down +3 and no movement for 16 commands.
    db $40, $00, $40, $00, $40, $00, $40, $00
    db $40, $00, $40, $00, $40, $00, $40, $08

MovementRightToDownRightCommands: ; $3D93: Blend rightward movement into down-right movement.
    db $10, $10, $10, $50, $10, $10, $50, $10, $50, $50, $58

MovementDownRightToDownCommands: ; $3D9E: Blend down-right movement into downward movement.
    db $50, $50, $50, $40, $50, $40, $40, $50, $40, $40, $48

MovementDownToDownLeftCommands: ; $3DA9: Blend downward movement into down-left movement.
    db $40, $40, $40, $60, $40, $40, $60, $40, $60, $60, $68

MovementDownLeftToLeftCommands: ; $3DB4: Blend down-left movement into leftward movement.
    db $60, $60, $60, $20, $60, $20, $20, $60, $20, $20, $28

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
    jr nz, MovementUpRight8Commands + 2

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
    db $18 ; $3DEA: final command of the preceding sequence.

MovementLeftToDownLeftCommands: ; $3DEB: Blend leftward movement into down-left movement.
    db $20, $20, $20, $60, $20, $20, $60, $20, $60, $60, $68

MovementDownLeftToDownCommands: ; $3DF6: Blend down-left movement into downward movement.
    db $60, $60, $60, $40, $60, $40, $40, $60, $40, $40, $48

MovementDownToDownRightCommands: ; $3E01: Blend downward movement into down-right movement.
    db $40, $40, $40, $50, $40, $40, $50, $40, $50, $50, $58

MovementDownRightToRightCommands: ; $3E0C: Blend down-right movement into rightward movement.
    db $50, $50, $50, $10, $50, $10, $10, $50, $10, $10, $18

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
    and b
    and b
    jr nz, jr_000_3ddd

    jr nz, MovementLeftToUpCommands + 6

    and b
    jr nz, MovementLeftToUpCommands + 9

    db $28


MovementRightToDownCommands: ; $3E43: Blend rightward movement into downward movement.
    db $10, $10, $50, $10, $50, $50, $50, $40, $50, $40, $48

MovementDownToLeftCommands: ; $3E4E: Blend downward movement into leftward movement.
    db $40, $40, $60, $40, $60, $60, $60, $20, $60, $20, $28

MovementLeftToUpCommands: ; $3E59: Blend leftward movement into upward movement.
    db $20, $20, $a0, $20, $a0, $a0, $a0, $80, $a0, $80, $88

MovementUpToRightCommands: ; $3E64: Blend upward movement into rightward movement.
    db $80, $80, $90, $80, $90, $90, $90, $10, $90, $10, $18

MovementLeftToDownCommands: ; $3E6F: Blend leftward movement into downward movement.
    db $20, $20, $60, $20, $60, $60, $60, $40, $60, $40, $48

MovementDownToRightCommands: ; $3E7A: Blend downward movement into rightward movement.
    db $40, $40, $50, $40, $50, $50, $50, $10, $50, $10, $18

MovementRightToUpCommands: ; $3E85: Blend rightward movement into upward movement.
    db $10, $10, $90, $10, $90, $90, $90, $80, $90, $80, $88

MovementUpToLeftCommands: ; $3E90: Blend upward movement into leftward movement.
    db $80, $80, $a0, $80, $a0, $a0, $a0, $20, $a0, $20, $28

    ; Packet format: destination high byte, destination low byte, control, data.
    ; These destinations are in VRAM (the background tile map).
    ; All controls below have mode 0: copy the following bytes to the destination.
    ; wHardModeUnlocked = 0 selects the sequence at ROM $3E9B.
    ; ROM $3E9B: HL = $99EB, copy 4 bytes to $99EB-$99EE.
TitleScreenStartPromptTilePackets:
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
TitleScreenStartSelectPromptTilePackets:
    db $99, $eb, $04, $d2, $dc, $d8, $c2
    ; ROM $3ECE: HL = $9A07, copy 13 bytes to $9A07-$9A13.
    db $9a, $07, $0d, $d8, $bc, $ca, $bc, $b8, $da, $bf, $b6, $dc, $da, $da, $d0, $ce
    ; ROM $3EDE: HL = $9A48, copy 3 bytes to $9A48-$9A4A.
    db $9a, $48, $03, $da, $d0, $d2
    ; ROM $3EE4: HL = $9A88, copy 12 bytes to $9A88-$9A93.
    db $9a, $88, $0c, $fc, $a2, $b2, $b0, $b2, $ff, $ea, $eb, $ec, $ed, $ee, $ef
    db $00 ; ROM $3EF3: end of sequence.

    ; 3EF4
InitialHUDTilePackets:
    db $9c, $00, $13, $d8, $b8, $d0, $d6, $bc, $00, 
    db $f0, $f0, $f0, $f0, $f0, $f0, $f0, $f0,
    db $00, $00, $fa, $f0, $f3, 
    db $00

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
