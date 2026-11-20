; Disassembly of "SolarStriker (World).gb"
; This file was created with:
; mgbdis v3.0 - Game Boy ROM disassembler by Matt Currie and contributors.
; https://github.com/mattcurrie/mgbdis

SECTION "ROM Bank $001", ROMX[$4000], BANK[$1]

InitializeDestructor:
    xor a
    ld hl, $cac0
    ld b, $10

.clearStateBytes
    ld [hl+], a
    dec b
    jr nz, .clearStateBytes

    ld bc, DestructorInitTemplate
    call TryInitializeObjectInFreeSlot
    or a
    jp z, RemoveCurrentHandler

    ld a, $05
    ld [wEnemyShotSpeedLevel], a
    ld de, ConfigureDestructor
    jp SetCurrentHandlerAddress

ConfigureDestructor:
    ld a, [bc]
    call SetObjectPointer
    ld de, DestructorMovementScript
    call InitializeMovementScript
    ld de, DestructorBaseGraphics
    call SetObjectGraphicsPointer
    ld de, TryFireDestructorOrb
    call StoreAddressInFreeWramSlot
    ld de, UpdateDestructorMovement
    jp SetCurrentHandlerAddress


UpdateDestructorMovement:
    call UpdateScriptedEnemyMovementNoDrift
    cp [hl]
    jr c, HandleDestructorDefeat

    ld de, UpdateDestructorStatus
    jp SetCurrentHandlerAddress


HandleDestructorDefeat:
    ld de, DestructorBaseGraphics
    call SetObjectGraphicsPointer
    jp StartBossDestructionSequence


UpdateDestructorStatus:
    ld a, [bc]
    call SetObjectPointer
    inc hl
    ld a, [hl+]
    cp $a0
    jp nc, HandleDestructorExit

    ld de, wEnemyFiringSequenceSpawnY
    add $10
    ld [de], a
    inc de
    ld a, [hl]
    add $0c
    ld [de], a
    ld de, DestructorBaseGraphics
    call SetObjectGraphicsPointer
    ld de, CheckDestructorCollision
    jp SetCurrentHandlerAddress

CheckDestructorCollision:
    push bc
    call CheckPlayerCenterInEnemyHitbox
    pop bc
    call CheckForNewEnemyDamage
    or a
    jr z, .applyMovementHandler

    ld de, DestructorDamageGraphics
    call SetObjectGraphicsPointer

.applyMovementHandler
    ld de, UpdateDestructorMovement
    jp SetCurrentHandlerAddress

; Shared defeat sequence for Destructor, UltraCrusher, and Epikhan.
StartBossDestructionSequence:
    ld a, $53
    call AddPlayerScore
    ld a, $01
    ld [wBossEncounterEnding], a
    ld [wPlayerInvincible], a
    ld de, DelayThenHideBackground
    call StoreAddressInFreeWramSlot
    ld de, UpdateBossDestructionSequence
    jp SetCurrentHandlerAddress


HandleDestructorExit:
    ld a, $01
    ld [wBossEncounterEnding], a
    ld hl, wPlayerInvincible
    ld [hl+], a
    ld [hl], a
    ld de, DelayThenHideBackground
    call StoreAddressInFreeWramSlot
    jp FinishBossExitAndStartStageTransition


UpdateBossDestructionSequence:
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
    cp $05
    jp z, FinishBossExitAndStartStageTransition

    ld hl, BossPartDestructionSmokeOffsets
    call TriggerSmokeEffect
    jp AdvanceToNextHandler


DestructorInitTemplate:
    db $24, $10, $10, $00, $00, $20, $20, $70

DestructorBaseGraphics:
    db $6c, $00, $6e, $00, $6e, $20, $6c, $20
    db $70, $00, $72, $00, $72, $20, $70, $20

DestructorDamageGraphics:
    db $6c, $10, $6e, $10, $6e, $30, $6c, $30
    db $70, $10, $72, $10, $72, $30, $70, $30

InitializeUltraCrusher:
    xor a
    ld hl, $cac0
    ld b, $10

.clearStateBytes
    ld [hl+], a
    dec b
    jr nz, .clearStateBytes

    ld bc, UltraCrusherInitTemplate
    call TryInitializeObjectInFreeSlot
    or a
    jp z, RemoveCurrentHandler

    ld de, UpdateUltraCrusherShotTimer
    call StoreAddressInFreeWramSlot
    ld de, ConfigureUltraCrusher
    jp SetCurrentHandlerAddress

ConfigureUltraCrusher:
    ld a, [bc]
    ld [$cf99], a
    call SetObjectPointer
    ld de, UltraCrusherMovementScript
    call InitializeMovementScript
    ld de, UltraCrusherBaseGraphics
    call SetObjectGraphicsPointer
    ld de, UpdateUltraCrusherMovement
    jp SetCurrentHandlerAddress

UpdateUltraCrusherMovement:
    call UpdateScriptedEnemyMovementNoDrift
    cp [hl]
    jr c, HandleUltraCrusherDefeat

    ld a, $05
    ld [wEnemyShotSpeedLevel], a
    ld de, UpdateUltraCrusherStatus
    jp SetCurrentHandlerAddress


HandleUltraCrusherDefeat:
    ld de, UltraCrusherBaseGraphics
    call SetObjectGraphicsPointer
    jp StartBossDestructionSequence


UpdateUltraCrusherStatus:
    ld a, [bc]
    call SetObjectPointer
    inc hl
    ld a, [hl]
    cp $a0
    jp nc, HandleUltraCrusherExit

    call CheckEnemyShotTimer
    or a
    jr nz, .restoreBaseGraphics

    ld de, wEnemyFiringSequenceSpawnY
    ld bc, $100c
    call StoreOffsetObjectPosition
    ld a, $06
    ld [de], a
    ld hl, wSelectedObjectPointer
    ld a, [hl+]
    ld h, [hl]
    ld l, a
    ld a, [hl]
    cp $50
    jr c, .updateFiringSequence

    ld a, $07
    ld [de], a

.updateFiringSequence
    inc de
    xor a
    ld [de], a
    ld de, UpdateEnemyFiringSequence
    call StoreAddressInFreeWramSlot

.restoreBaseGraphics
    ld de, UltraCrusherBaseGraphics
    call SetObjectGraphicsPointer
    ld de, CheckUltraCrusherCollision
    jp SetCurrentHandlerAddress


CheckUltraCrusherCollision:
    push bc
    call CheckPlayerCenterInEnemyHitbox
    pop bc
    call CheckForNewEnemyDamage
    or a
    jr z, .setMovementHandler

    ld de, UltraCrusherDamageGraphics
    call SetObjectGraphicsPointer

.setMovementHandler
    ld de, UpdateUltraCrusherMovement
    jp SetCurrentHandlerAddress


HandleUltraCrusherExit:
    ld a, $01
    ld [wBossEncounterEnding], a
    ld [wPlayerInvincible], a
    ld de, DelayThenHideBackground
    call StoreAddressInFreeWramSlot
    jp FinishBossExitAndStartStageTransition


UltraCrusherInitTemplate:
    db $24, $10, $10, $02, $02, $1c, $1c, $60

UltraCrusherBaseGraphics:
    db $8c, $00, $8e, $00, $8e, $20, $8c, $20
    db $90, $00, $92, $00, $92, $20, $90, $20

UltraCrusherDamageGraphics:
    db $8c, $10, $8e, $10, $8e, $30, $8c, $30
    db $90, $10, $92, $10, $92, $30, $90, $30

InitializeEpikhan:
    xor a
    ld hl, $cac0
    ld b, $10

.clearStateBytes
    ld [hl+], a
    dec b
    jr nz, .clearStateBytes

    ld [$cf99], a
    ld bc, EpikhanInitTemplate
    call TryInitializeObjectInFreeSlot
    or a
    jp z, RemoveCurrentHandler

    ld de, ConfigureEpikhan
    jp SetCurrentHandlerAddress

ConfigureEpikhan:
    ld a, [bc]
    call SetObjectPointer
    ld de, EpikhanMovementScript
    call InitializeMovementScript
    ld de, EpikhanBaseGraphics
    call SetObjectGraphicsPointer
    ld de, UpdateEpikhanMovement
    jp SetCurrentHandlerAddress


    ; Apply scripted movement.
UpdateEpikhanMovement:
    ; Returns object byte $0C in A, with HL pointing to byte $0D.
    call UpdateScriptedEnemyMovementNoDrift
    cp [hl]
    jp c, HandleEpikhanDefeat ; object[$0C] < object[$0D]

    ld a, $05
    ld [wEnemyShotSpeedLevel], a
    ld de, UpdateEpikhanStatus
    jp SetCurrentHandlerAddress


HandleEpikhanDefeat:
    ld de, EpikhanBaseGraphics
    call SetObjectGraphicsPointer
    jp StartBossDestructionSequence

UpdateEpikhanStatus:
    ld a, [bc]
    call SetObjectPointer
    inc hl
    ld a, [hl]
    cp $a0
    jp nc, HandleEpikhanExit

    ld hl, $cf99
    inc [hl]
    ld a, [hl]
    cp $0b
    jr nz, .restoreBaseGraphics

    xor a
    ld [hl], a
    ld de, wEnemyFiringSequenceSpawnY
    ld bc, $100c
    call StoreOffsetObjectPosition
    ld a, $03
    ld [de], a
    inc de
    xor a
    ld [de], a
    ld de, UpdateEnemyFiringSequence
    call StoreAddressInFreeWramSlot

.restoreBaseGraphics
    ld de, EpikhanBaseGraphics
    call SetObjectGraphicsPointer
    ld de, CheckEpikhanCollision
    jp SetCurrentHandlerAddress

CheckEpikhanCollision:
    push bc
    call CheckPlayerCenterInEnemyHitbox
    pop bc
    call CheckForNewEnemyDamage
    or a
    jr z, .scheduleMovement

    ld de, EpikhanDamageGraphics
    call SetObjectGraphicsPointer

.scheduleMovement:
    ld de, UpdateEpikhanMovement
    jp SetCurrentHandlerAddress


HandleEpikhanExit:
    ld a, $01
    ld [wBossEncounterEnding], a
    ld [wPlayerInvincible], a
    ld de, DelayThenHideBackground
    call StoreAddressInFreeWramSlot
    jp FinishBossExitAndStartStageTransition


EpikhanInitTemplate:
    db $24, $10, $10, $02, $02, $1c, $1c, $60

EpikhanBaseGraphics:
    db $64, $00, $66, $00, $66, $20, $64, $20
    db $68, $00, $6a, $00, $6a, $20, $68, $20

EpikhanDamageGraphics:
    db $64, $10, $66, $10, $66, $30, $64, $30
    db $68, $10, $6a, $10, $6a, $30, $68, $30

InitializeOmniquad:
    xor a
    ld hl, $cac0
    ld [hl+], a
    ld [hl], a
    ld b, $05

.registerPartHandlers
    push bc
    ld de, InitializeOmniquadPart
    call StoreAddressInFreeWramSlot
    pop bc
    dec b
    jr nz, .registerPartHandlers

    jp RemoveCurrentHandler

InitializeOmniquadPart:
    ld bc, OmniquadInitTemplate
    call TryInitializeObjectInFreeSlot
    or a
    jp z, RemoveCurrentHandler

    ld hl, wCurrentHandlerDataPointer
    ld a, [hl+]
    ld h, [hl]
    ld l, a
    ld de, HANDLER_BOSS_PART_INDEX_OFFSET
    add hl, de
    ld de, wNextBossPartIndex
    ld a, [de]
    ld [hl], a
    inc a
    ld [de], a
    ld de, ConfigureOmniquadPart
    jp SetCurrentHandlerAddress

ConfigureOmniquadPart:
    ld a, [bc]
    push bc
    call SetObjectPointer
    ld hl, HANDLER_BOSS_PART_INDEX_OFFSET
    add hl, bc
    ld a, [hl]
    add a
    ld l, a
    ld h, $00
    ld de, OmniquadMovementScriptTable
    add hl, de
    ld a, [hl+]
    ld d, [hl]
    ld e, a
    call InitializeMovementScript
    pop bc
    ld hl, HANDLER_BOSS_PART_INDEX_OFFSET
    add hl, bc
    ld a, [hl]
    push af
    ld hl, OmniquadStartingCoordinates
    call ApplyHorizontalScrollOffsetToCoordinatePair
    ld bc, OmniquadInitTemplate
    call ResetObjectAttributes
    pop af
    ld de, OmniquadOuterBaseGraphics
    or a
    jr nz, .applyGraphics

    ld de, OmniquadCenterBaseGraphics ; index 0 is the center

.applyGraphics
    call SetObjectGraphicsPointer
    ld de, UpdateOmniquadMovement
    jp SetCurrentHandlerAddress

UpdateOmniquadMovement:
    call UpdateScriptedEnemyMovementNoDrift
    cp [hl]
    jr c, HandleOmniquadPartDefeat

    ld a, [wBossEncounterEnding]
    or a
    jp nz, HandleEnemyDefeat

    ld de, CheckOmniquadCollision
    jp SetCurrentHandlerAddress

HandleOmniquadPartDefeat:
    ld hl, wCurrentHandlerDataPointer
    ld a, [hl+]
    ld h, [hl]
    ld l, a
    ld de, HANDLER_BOSS_PART_INDEX_OFFSET
    add hl, de
    ld d, $23
    ld a, [hl]
    or a
    jp nz, HandleEnemyDefeat

    inc a
    ld [wBossEncounterEnding], a
    jp HandleEnemyDefeat

CheckOmniquadCollision:
    call CheckPlayerCenterInEnemyHitbox
    ld hl, wCurrentHandlerDataPointer
    ld a, [hl+]
    ld h, [hl]
    ld l, a
    ld bc, HANDLER_BOSS_PART_INDEX_OFFSET
    add hl, bc
    ld a, [hl]
    or a
    jr nz, .applyOuterBaseGraphics

    ld de, OmniquadCenterBaseGraphics
    call SetObjectGraphicsPointer
    jr .setStatusHandler

.applyOuterBaseGraphics
    ld de, OmniquadOuterBaseGraphics
    call SetObjectGraphicsPointer

.setStatusHandler
    ld de, UpdateOmniquadStatus
    jp SetCurrentHandlerAddress

UpdateOmniquadStatus:
    ld a, [bc]
    call SetObjectPointer
    inc hl
    ld a, [hl]
    cp $a0
    jp nc, FreeObjectAndRemoveHandler

    call CheckForNewEnemyDamage
    or a
    jr z, .setMovementHandler

    ld hl, wCurrentHandlerDataPointer
    ld a, [hl+]
    ld h, [hl]
    ld l, a
    ld bc, HANDLER_BOSS_PART_INDEX_OFFSET
    add hl, bc
    ld a, [hl]
    or a
    jr nz, .setOuterDamageGraphics

    ld de, OmniquadCenterDamageGraphics
    call SetObjectGraphicsPointer
    jr .setMovementHandler

.setOuterDamageGraphics
    ld de, OmniquadOuterDamageGraphics
    call SetObjectGraphicsPointer

.setMovementHandler
    ld de, UpdateOmniquadMovement
    jp SetCurrentHandlerAddress

OmniquadMovementScriptTable:
    dw OmniquadCenterMovementScript ; center
    dw OmniquadOuterMovementScript1 ; outer part 1
    dw OmniquadOuterMovementScript2 ; outer part 2
    dw OmniquadOuterMovementScript3 ; outer part 3
    dw OmniquadOuterMovementScript4 ; outer part 4

OmniquadInitTemplate:
    db $12, $08, $08, $00, $00, $10, $10, $38

OmniquadOuterBaseGraphics:
    db $76, $00, $76, $20

OmniquadCenterBaseGraphics:
    db $74, $00, $74, $20

OmniquadOuterDamageGraphics:
    db $76, $10, $76, $30

OmniquadCenterDamageGraphics:
    db $74, $10, $74, $30

InitializeXenocrypt:
    xor a
    ld hl, $cac0
    ld [hl+], a
    ld [hl], a
    ld b, $04 ; 4 parts

.registerPartHandlers
    push bc
    ld de, InitializeXenocryptPart
    call StoreAddressInFreeWramSlot
    pop bc
    dec b
    jr nz, .registerPartHandlers

    jp RemoveCurrentHandler

InitializeXenocryptPart:
    ld de, wNextBossPartIndex
    ld a, [de]
    xor $07
    add $02
    ld [wStageEventParams + 1], a
    ld bc, XenocryptPartInitTemplate
    call TryInitializeObjectInFreeSlot
    or a
    jp z, RemoveCurrentHandler

    ld hl, wCurrentHandlerDataPointer
    ld a, [hl+]
    ld h, [hl]
    ld l, a
    ld de, HANDLER_BOSS_PART_INDEX_OFFSET
    add hl, de
    ld de, wNextBossPartIndex
    ld a, [de]
    ld [hl], a
    inc a
    ld [de], a
    ld de, ConfigureXenocryptPart
    jp SetCurrentHandlerAddress

ConfigureXenocryptPart:
    ld a, [bc]
    push bc
    call SetObjectPointer
    ld hl, HANDLER_BOSS_PART_INDEX_OFFSET
    add hl, bc
    ld a, [hl]
    add a
    ld l, a
    ld h, $00
    ld de, XenocryptMovementScriptTable
    add hl, de
    ld a, [hl+]
    ld d, [hl]
    ld e, a
    call InitializeMovementScript
    pop bc
    ld hl, HANDLER_BOSS_PART_INDEX_OFFSET
    add hl, bc
    ld a, [hl]
    ld hl, XenocryptStartingXCoords
    call GetStartingXCoord
    ld bc, XenocryptPartInitTemplate
    call ResetObjectAttributes
    ld de, XenocryptPartBaseGraphics
    call SetObjectGraphicsPointer
    ld de, UpdateXenocryptMovement
    jp SetCurrentHandlerAddress

UpdateXenocryptMovement:
    call UpdateScriptedEnemyMovementNoDrift
    cp [hl]
    jr c, HandleXenocryptPartDefeat

    ld de, UpdateXenocryptPartStatus
    jp SetCurrentHandlerAddress


HandleXenocryptPartDefeat:
    ld de, XenocryptPartBaseGraphics
    call SetObjectGraphicsPointer
    ld de, DestroyXenocryptPart
    jp SetCurrentHandlerAddress

UpdateXenocryptPartStatus:
    ld a, [bc]
    call SetObjectPointer
    inc hl
    ld a, [hl]
    cp $a0
    jp nc, FreeObjectAndRemoveHandler

    ld de, $0004
    add hl, de
    xor a
    ld [hl], a
    call CheckEnemyShotTimer
    or a
    jr nz, .setCollisionHandler

    ld de, wEnemyShotSpawnY
    ld a, [de]
    or a
    jr nz, .setCollisionHandler

    ld bc, $1c00
    call StoreOffsetObjectPosition
    ld de, TrySpawnAlternateEnemyProjectile
    call StoreAddressInFreeWramSlot

.setCollisionHandler
    ld de, XenocryptPartBaseGraphics
    call SetObjectGraphicsPointer
    ld de, CheckXenocryptPartCollision
    jp SetCurrentHandlerAddress

CheckXenocryptPartCollision:
    push bc
    call CheckEnemyCollisionWithPlayer
    pop bc
    call CheckForNewEnemyDamage
    or a
    jr z, .setMovementHandler

    ld de, XenocryptPartDamageGraphics
    call SetObjectGraphicsPointer

.setMovementHandler
    ld de, UpdateXenocryptMovement
    jp SetCurrentHandlerAddress

DestroyXenocryptPart:
    ld a, [bc]
    call SetObjectPointer
    inc hl
    ld de, $ca34
    ld a, [hl+]
    add $10
    ld [de], a
    inc de
    ld a, [hl]
    ld [de], a
    ld de, InitializeSmokeObject
    call StoreAddressInFreeWramSlot
    ld hl, BossPartDestructionSound
    ld a, $01
    call SetupAudioPlayback
    ld d, $33
    jp HandleEnemyDefeat


XenocryptMovementScriptTable:
    dw XenocryptMovementScript1 ; script index $00
    dw XenocryptMovementScript2 ; script index $01
    dw XenocryptMovementScript3 ; script index $02
    dw XenocryptMovementScript4 ; script index $03

XenocryptPartInitTemplate:
    db $21, $10, $04, $00, $00, $20, $08, $20

XenocryptPartBaseGraphics:
    db $78, $00, $78, $40

XenocryptPartDamageGraphics:
    db $78, $10, $78, $50

InitializeQuasiObliterator:
    xor a
    ld hl, $cac0
    ld [hl+], a
    ld [hl], a
    ld b, $02

.registerPartHandlers
    push bc
    ld de, InitializeQuasiObliteratorPart
    call StoreAddressInFreeWramSlot
    pop bc
    dec b
    jr nz, .registerPartHandlers

    jp RemoveCurrentHandler

InitializeQuasiObliteratorPart:
    ld de, wNextBossPartIndex
    ld a, [de]
    xor $07
    ld [wStageEventParams + 1], a
    ld bc, QuasiObliteratorInitTemplate
    call TryInitializeObjectInFreeSlot
    or a
    jp z, RemoveCurrentHandler

    ld hl, wCurrentHandlerDataPointer
    ld a, [hl+]
    ld h, [hl]
    ld l, a
    ld de, HANDLER_BOSS_PART_INDEX_OFFSET
    add hl, de
    ld de, wNextBossPartIndex
    ld a, [de]
    ld [hl], a
    inc a
    ld [de], a
    ld de, ConfigureQuasiObliteratorPart
    jp SetCurrentHandlerAddress

ConfigureQuasiObliteratorPart:
    ld a, [bc]
    push bc
    call SetObjectPointer
    ld hl, HANDLER_BOSS_PART_INDEX_OFFSET
    add hl, bc
    ld de, QuasiObliteratorLeftMovementScript
    ld a, [hl]
    or a
    jr z, .setMovementScript

    ld de, QuasiObliteratorRightMovementScript

.setMovementScript
    call InitializeMovementScript
    pop bc
    ld hl, HANDLER_BOSS_PART_INDEX_OFFSET
    add hl, bc
    ld a, [hl]
    push af
    ld hl, QuasiObliteratorStartingXCoords
    call GetStartingXCoord
    ld bc, QuasiObliteratorInitTemplate
    call ResetObjectAttributes
    pop af
    ld de, QuasiObliteratorLeftPartBaseGraphics
    or a
    jr z, .applyGraphics

    ld de, QuasiObliteratorRightPartBaseGraphics

.applyGraphics
    call SetObjectGraphicsPointer
    ld de, UpdateQuasiObliteratorMovement
    jp SetCurrentHandlerAddress

UpdateQuasiObliteratorMovement:
    call UpdateScriptedEnemyMovementNoDrift
    cp [hl]
    jr c, HandleQuasiObliteratorPartDefeat

    ld de, UpdateQuasiObliteratorPartStatus
    jp SetCurrentHandlerAddress


HandleQuasiObliteratorPartDefeat:
    ld hl, wCurrentHandlerDataPointer
    ld a, [hl+]
    ld h, [hl]
    ld l, a
    ld bc, HANDLER_BOSS_PART_INDEX_OFFSET
    add hl, bc
    ld de, QuasiObliteratorRightPartBaseGraphics
    ld a, [hl]
    or a
    jr nz, .destroyPart

    ld de, QuasiObliteratorLeftPartBaseGraphics

.destroyPart
    call SetObjectGraphicsPointer
    ld a, $14
    call AddPlayerScore
    ld de, UpdateQuasiObliteratorPartDestructionSequence
    jp SetCurrentHandlerAddress

UpdateQuasiObliteratorPartStatus:
    ld a, [bc]
    call SetObjectPointer
    inc hl
    ld a, [hl]
    cp $a0
    jp nc, FreeObjectAndRemoveHandler

    call CheckEnemyShotTimer
    or a
    jr nz, .setCollisionHandler

    ld de, wEnemyFiringSequenceSpawnY
    ld bc, $1008
    call StoreOffsetObjectPosition
    ld a, $02
    ld [de], a
    inc de
    xor a
    ld [de], a
    ld de, UpdateEnemyFiringSequence
    call StoreAddressInFreeWramSlot

.setCollisionHandler
    ld de, CheckQuasiObliteratorPartCollision
    jp SetCurrentHandlerAddress


CheckQuasiObliteratorPartCollision:
    call CheckPlayerCenterInEnemyHitbox
    ld hl, wCurrentHandlerDataPointer
    ld a, [hl+]
    ld h, [hl]
    ld l, a
    ld bc, HANDLER_BOSS_PART_INDEX_OFFSET
    add hl, bc
    ld de, QuasiObliteratorRightPartBaseGraphics
    ld a, [hl]
    or a
    jr nz, .applyGraphics

    ld de, QuasiObliteratorLeftPartBaseGraphics

.applyGraphics
    call SetObjectGraphicsPointer
    ld de, HandleQuasiObliteratorPartHit
    jp SetCurrentHandlerAddress

HandleQuasiObliteratorPartHit:
    call CheckForNewEnemyDamage
    or a
    jr z, .setMovementHandler

    ld hl, wCurrentHandlerDataPointer
    ld a, [hl+]
    ld h, [hl]
    ld l, a
    ld bc, HANDLER_BOSS_PART_INDEX_OFFSET
    add hl, bc
    ld de, QuasiObliteratorRightPartDamageGraphics
    ld a, [hl]
    or a
    jr nz, .applyGraphics

    ld de, QuasiObliteratorLeftPartDamageGraphics

.applyGraphics
    call SetObjectGraphicsPointer

.setMovementHandler
    ld de, UpdateQuasiObliteratorMovement
    jp SetCurrentHandlerAddress


QuasiObliteratorInitTemplate:
    db $22, $10, $08, $00, $00, $20, $10, $3c

QuasiObliteratorLeftPartBaseGraphics:
    db $7c, $00, $7e, $00, $7c, $40, $7e, $40

QuasiObliteratorRightPartBaseGraphics:
    db $7e, $20, $7c, $20, $7e, $60, $7c, $60

QuasiObliteratorLeftPartDamageGraphics:
    db $7c, $10, $7e, $10, $7c, $50, $7e, $50

QuasiObliteratorRightPartDamageGraphics:
    db $7e, $30, $7c, $30, $7e, $70, $7c, $70

; Returns damage threshold in A, with HL pointing to accumulated damage.
UpdateScriptedEnemyMovementNoDrift:
    ld a, [bc]
    call SetObjectPointer
    call ReadMovementScriptCommand
    call MoveObject
    ld hl, wSelectedObjectPointer
    ld a, [hl+]
    ld h, [hl]
    ld l, a
    ld de, OBJECT_DAMAGE_THRESHOLD_OFFSET
    add hl, de
    ld a, [hl+]
    ret

UpdateQuasiObliteratorPartDestructionSequence:
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
    cp $05
    jp z, FreeObjectAndRemoveHandler

    ld hl, BossPartDestructionSmokeOffsets
    call TriggerSmokeEffect
    jp AdvanceToNextHandler

TriggerSmokeEffect:
    add a
    ld c, a
    ld b, $00
    add hl, bc
    push hl
    ld hl, wSelectedObjectPointer
    ld a, [hl+]
    ld h, [hl]
    ld l, a
    inc hl
    pop bc
    ld de, $ca34
    ld a, [bc]
    add [hl]
    ld [de], a
    inc bc
    inc de
    inc hl
    ld a, [bc]
    add [hl]
    ld [de], a
    ld de, InitializeSmokeObject
    call StoreAddressInFreeWramSlot
    ld hl, BossPartDestructionSound
    ld a, $01
    call SetupAudioPlayback
    ret

BossPartDestructionSmokeOffsets:
    db $08, $08, $10, $10, $10, $00, $00, $10, $00, $00

AssignBossPartIndex:
    ld hl, wCurrentHandlerDataPointer
    ld a, [hl+]
    ld h, [hl]
    ld l, a
    ld de, HANDLER_BOSS_PART_INDEX_OFFSET
    add hl, de
    ld de, wNextBossPartIndex
    ld a, [de]
    ld [hl], a
    inc a
    ld [de], a
    ret

AdvanceBossDestructionCounter:
    ld a, [bc]
    call SetObjectPointer
    ld hl, HANDLER_BOSS_SMOKE_SPAWN_COUNTER_OFFSET
    add hl, bc
    ld a, [hl]
    inc [hl]
    ret


UpdateStageFourBossPartStatus:
    ld a, [bc]
    call SetObjectPointer
    ld a, [wBossEncounterEnding]
    or a
    jp nz, FreeObjectAndRemoveHandler

    ld de, UpdateStageFourBossPartPosition
    jp SetCurrentHandlerAddress

UpdateStageFourBossPartPosition:
    ld a, [bc]
    call SetObjectPointer
    ld de, $0000
    call MoveObject
    ld de, CheckStageFourBossPartCollision
    jp SetCurrentHandlerAddress

CheckStageFourBossPartCollision:
    call CheckPlayerCenterInEnemyHitbox
    ld de, UpdateStageFourBossPartStatus
    jp SetCurrentHandlerAddress

DelayThenHideBackground:
    ld hl, $cac3
    inc [hl]
    ld a, [hl+]
    cp $20
    jp c, AdvanceToNextHandler

    ldh a, [rLCDC]
    and $fe
    ldh [rLCDC], a
    jp RemoveCurrentHandler

FinishBossExitAndStartStageTransition:
    ld a, [wCurrentStage]
    cp $06
    jr nz, .subStageSix

    ld de, SetupStageSixTransition
    call StoreAddressInFreeWramSlot
    jp FreeObjectAndRemoveHandler


.subStageSix
    ld de, SetupStageTransition
    call StoreAddressInFreeWramSlot
    jp FreeObjectAndRemoveHandler


    ; 4703
AudioWaveformTable:
    ; $4703-$4802: 16 waveforms, 16 bytes each (32 packed 4-bit samples).
    ; Waveforms $0A-$0F contain identical data.
    db $01, $23, $45, $67, $89, $ab, $cd, $ef, $ed, $cb, $a9, $87, $65, $43, $21, $00
    db $9b, $e0, $ba, $98, $76, $54, $32, $10, $9b, $e0, $ba, $98, $76, $54, $32, $10
    db $fe, $dc, $ba, $98, $76, $54, $32, $10, $fe, $dc, $ba, $98, $76, $54, $32, $10
    db $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $f0
    db $9b, $e0, $ba, $98, $76, $54, $32, $10, $9b, $e0, $ba, $98, $76, $54, $32, $10
    db $fd, $b9, $75, $31, $ec, $a8, $64, $20, $fd, $b9, $75, $31, $ec, $a8, $64, $20
    db $fe, $dc, $cd, $ed, $ca, $86, $42, $10, $fe, $dc, $cd, $ed, $ca, $86, $42, $10
    db $fd, $b9, $ab, $97, $65, $43, $21, $10, $fd, $b9, $ab, $97, $65, $43, $21, $10
    db $44, $44, $44, $46, $67, $8a, $cf, $b8, $44, $44, $44, $46, $67, $8a, $cf, $b8
    db $ff, $a8, $ff, $a8, $77, $66, $55, $42, $ff, $a8, $ff, $a8, $77, $66, $55, $42
    db $ff, $aa, $88, $88, $88, $88, $88, $88, $ff, $aa, $88, $88, $88, $88, $88, $88
    db $ff, $aa, $88, $88, $88, $88, $88, $88, $ff, $aa, $88, $88, $88, $88, $88, $88
    db $ff, $aa, $88, $88, $88, $88, $88, $88, $ff, $aa, $88, $88, $88, $88, $88, $88
    db $ff, $aa, $88, $88, $88, $88, $88, $88, $ff, $aa, $88, $88, $88, $88, $88, $88
    db $ff, $aa, $88, $88, $88, $88, $88, $88, $ff, $aa, $88, $88, $88, $88, $88, $88
    db $ff, $aa, $88, $88, $88, $88, $88, $88, $ff, $aa, $88, $88, $88, $88, $88, $88


; $4803-$487A: 15 volume sequences, 8 bytes (16 packed 4-bit steps) each.
; Indices $01-$0F select sequences; index $00 disables volume sequencing.
; Steps read the high nibble first, then the low nibble; step 15 is held.
AudioVolumeSequenceTable:
AudioVolumeSequence01: ; $01:$4803-$480A
    db $ff, $cc, $aa, $aa, $aa, $88, $88, $77

AudioVolumeSequence02: ; $01:$480B-$4812
    db $ff, $55, $77, $99, $aa, $bb, $dd, $ff

AudioVolumeSequence03: ; $01:$4813-$481A
    db $fe, $dc, $ba, $98, $89, $ab, $cd, $ef

AudioVolumeSequence04: ; $01:$481B-$4822
    db $89, $ab, $cd, $ef, $fe, $dc, $ba, $98

AudioVolumeSequence05: ; $01:$4823-$482A
    db $fd, $b9, $75, $31, $ec, $a8, $64, $20

AudioVolumeSequence06: ; $01:$482B-$4832
    db $fe, $dc, $cd, $ed, $ca, $86, $42, $10

AudioVolumeSequence07: ; $01:$4833-$483A
    db $fd, $b9, $ab, $97, $65, $43, $21, $10

AudioVolumeSequence08: ; $01:$483B-$4842
    db $44, $44, $44, $46, $67, $8a, $cf, $b8

AudioVolumeSequence09: ; $01:$4843-$484A
    db $ff, $a8, $ff, $a8, $77, $66, $55, $42

AudioVolumeSequence0A: ; $01:$484B-$4852
    db $ff, $11, $11, $11, $11, $11, $11, $11

AudioVolumeSequence0B: ; $01:$4853-$485A
    db $ff, $cc, $88, $88, $66, $44, $22, $11

AudioVolumeSequence0C: ; $01:$485B-$4862
    db $ff, $aa, $88, $88, $88, $77, $66, $66

AudioVolumeSequence0D: ; $01:$4863-$486A
    db $bb, $aa, $66, $66, $44, $44, $22, $22

AudioVolumeSequence0E: ; $01:$486B-$4872
    db $ff, $ff, $88, $aa, $88, $77, $66, $55

AudioVolumeSequence0F: ; $01:$4873-$487A
    db $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff

; Signed frequency deltas applied by Call_001_5212: $00 holds pitch,
; $01 adds 1, $FF subtracts 1, and $80 restarts the selected sequence.
; Index $00 disables pitch sequencing; its $8000 entry is not a ROM pointer.

AudioPitchSequence01: ; $01:$487B
    db $00, $ff, $00, $00, $01, $00, $00, $ff, $00, $01, $00, $80

AudioPitchSequence02: ; $01:$4887
    db $01, $ff, $01, $ff, $01, $ff, $01, $ff, $01, $ff, $80

AudioPitchSequence03: ; $01:$4892
    db $01, $ff, $01, $ff, $01, $ff, $01, $ff, $01, $80

AudioPitchSequence04: ; $01:$489C
    db $00, $ff, $00, $01, $00, $80

AudioPitchSequence05: ; $01:$48A2
    db $00, $ff, $00, $01, $00, $ff, $80

AudioPitchSequence06: ; $01:$48A9
    db $00, $ff, $00, $00, $01, $00, $00, $ff, $00, $80

AudioPitchSequence07: ; $01:$48B3
    db $00, $ff, $00, $00, $01, $00, $00, $ff, $00, $80

AudioPitchSequence08: ; $01:$48BD
    db $00, $ff, $00, $00, $01, $00, $00, $ff, $00, $80

AudioPitchSequence09: ; $01:$48C7
    db $00, $ff, $00, $00, $01, $00, $00, $ff, $00, $80

AudioPitchSequence0A: ; $01:$48D1
    db $00, $ff, $00, $00, $01, $00, $00, $ff, $00, $80

AudioPitchSequence0B: ; $01:$48DB
    db $00, $ff, $00, $00, $01, $00, $00, $ff, $00, $80

AudioPitchSequence0C: ; $01:$48E5
    db $00, $ff, $00, $00, $01, $00, $00, $ff, $00, $80

AudioPitchSequence0D: ; $01:$48EF
    db $00, $ff, $00, $00, $01, $00, $00, $ff, $00, $80

AudioPitchSequence0E: ; $01:$48F9
    db $00, $ff, $00, $00, $01, $00, $00, $ff, $00, $80

AudioPitchSequence0F: ; $01:$4903
    ; Continues into the first table entry below ($00, $80).
    db $00, $ff, $00, $00, $01, $00, $00, $ff

; $490B-$492A: 16 little-endian lookup entries.
; The first word also supplies the final hold/restart bytes of sequence $0F.
AudioPitchSequenceTable:
    dw $8000 ; index $00: disabled; shared sequence $0F tail ($00, $80)
    dw AudioPitchSequence01 ; index $01
    dw AudioPitchSequence02 ; index $02
    dw AudioPitchSequence03 ; index $03
    dw AudioPitchSequence04 ; index $04
    dw AudioPitchSequence05 ; index $05
    dw AudioPitchSequence06 ; index $06
    dw AudioPitchSequence07 ; index $07
    dw AudioPitchSequence08 ; index $08
    dw AudioPitchSequence09 ; index $09
    dw AudioPitchSequence0A ; index $0a
    dw AudioPitchSequence0B ; index $0b
    dw AudioPitchSequence0C ; index $0c
    dw AudioPitchSequence0D ; index $0d
    dw AudioPitchSequence0E ; index $0e
    dw AudioPitchSequence0F ; index $0f

; $492B-$495B: raw lookup data preceding InitAudio.
; Lookup uses a 1-based index with base $492A; valid index range is unconfirmed.
AudioNoiseSettingsTable:
    db $6d, $15, $04, $19, $00, $12, $37, $70
    db $65, $8a, $8f, $d0, $d4, $60, $64, $70
    db $73, $19, $5a, $45, $65, $67, $69, $6b
    db $6d, $6e, $60, $63, $d4, $d8, $df, $65
    db $6a, $02, $04, $07, $55, $0a, $4f, $80
    db $87, $8a, $8f, $d0, $d4, $d8, $df, $3a
    db $6d

InitAudio:
    call ResetAudioChannels
    ld a, $80
    ldh [rNR52], a
    ld a, $77
    ldh [rNR50], a
    ld a, $ff
    ldh [rNR51], a ; AUDTERM all L/R output channels on
    ; Clear $CC00–$CD86
    ; Sets the first byte to 0 and then because dest is one in
    ; front this propogates the 0 through the whole region
    ld hl, $cc00
    ld de, $cc01
    ld bc, $0186
    ld [hl], $00
    call AudioCopyMemorySetup
    ei
    ret

ResetAudioChannels:
    di
    ld a, $00 
    ldh [rNR50], a ; Master vol min for L/R, VIN audio routing disable
    ld a, $80
    ldh [rNR52], a ; Enable Audio system
    ld a, $08
    ldh [rNR12], a ; CH1: initial volume 0, envelope up, pace 0
    ldh [rNR22], a ; CH2: same
    ldh [rNR42], a ; CH4: same
    ld a, $80 
    ldh [rNR14], a ; Trigger CH1; frequency high bits 0; length disabled
    ldh [rNR24], a ; Trigger CH2; frequency high bits 0; length disabled
    ldh [rNR44], a ; Trigger CH4; length disabled
    xor a
    ldh [rNR32], a ; Mute CH3 output
    ld a, $8f
    ldh [rNR52], a ; Keep audio enabled
    ld a, $77
    ldh [rNR50], a ; Maximum L/R master volume; VIN disconnected
    ret


    ld hl, $cc03
    ld e, a
    ld d, $00
    add hl, de
    ld a, [hl]
    or a
    ret


SetupAudioPlayback:
    or a
    jr nz, SaveAndCheckAudioInputs ; A is not zero

    dec a ; a is zero, set to $FF

SaveAndCheckAudioInputs:
    ld [wRequestedPlaybackRepeatCount], a ; original value or $FF
    ; Store data pointer held in hl
    ld a, l
    ld [wRequestedAudioPlaybackPointer], a
    ld a, h
    ld [wRequestedAudioPlaybackPointer + 1], a ; store the requested audio pointer in CD81 and CD82
    di
    call CheckAndReleaseAudioChannels
    jr c, FinishAudioPlaybackSetup

    call FindFreePlaybackSlot
    jr c, FinishAudioPlaybackSetup

    call InitAudioSlot
    ld a, [wAllocatedPlaybackSlot]
    or a

FinishAudioPlaybackSetup:
    push af
    ei
    pop af
    ret


CheckAndReleaseAudioChannels:
    call CheckAudioChannelAvailability
    ret c

    ld e, $00
    ld d, $04
    ld a, [wRequestedAudioPlaybackPointer]
    ld l, a
    ld a, [wRequestedAudioPlaybackPointer + 1]
    ld h, a
    inc hl
    inc hl

CheckAndReleaseAudioChannelsLoop:
    ld a, [hl]
    inc hl
    ld b, [hl]
    inc hl
    ld c, [hl]
    inc hl
    or b
    jr z, CheckAndReleaseAudioChannelsNext

    inc e
    push hl
    ld hl, wChannelPlaybackSlotOwnerTable
    ld b, $00
    add hl, bc
    ld a, [hl]
    pop hl
    or a
    jr z, CheckAndReleaseAudioChannelsNext

    call ReleasePlaybackSlot
    jr CheckAndReleaseAudioChannels

CheckAndReleaseAudioChannelsNext:
    dec d
    jr nz, CheckAndReleaseAudioChannelsLoop

    ld a, e
    or a
    scf
    ret z

    or a
    ret

CheckAudioChannelAvailability:
    ; Read back data pointer
    ld a, [wRequestedAudioPlaybackPointer]
    ld l, a
    ld a, [wRequestedAudioPlaybackPointer + 1]
    ld h, a
    ; advance HL to next data byte
    inc hl

    ; Save next data byte in cd80
    ld e, [hl]
    ld a, e
    ld [wRequestedAudioPriority], a
    inc e
    inc hl ; move to next data byte
    ld d, $04 ; Check 4 entries

; 3 bytes make up a record
; first two are data pointer, 3rd is channel index
CheckAudioChannelAvailabilityLoop:
    ld a, [hl]
    inc hl
    ld b, [hl]
    inc hl
    ld c, [hl]
    inc hl
    or b
    jr z, CheckAudioChannelAvailabilityNext ; if both a and b is zero (no data pointer) skip and go to another loop

    ; $CC0F + channel index → owning playback slot
    ; $CC07 + owning slot   → comparison value
    push hl
    ld hl, wChannelPlaybackSlotOwnerTable
    ld b, $00
    add hl, bc
    ld c, [hl]
    ld hl, wPlaybackSlotPriorityTable - 1
    add hl, bc
    ld a, [hl]
    pop hl
    ; Reject if existing priority is higher than incoming priority.
    cp e
    ccf
    ret c

CheckAudioChannelAvailabilityNext:
    dec d
    jr nz, CheckAudioChannelAvailabilityLoop

    or a
    ret

InitAudioSlot:
    ld a, [wAllocatedPlaybackSlot]
    ld e, a
    ld d, $00
    ld hl, wPlaybackSlotActiveTable - 1
    add hl, de
    ld [hl], $ff
    ld hl, wPlaybackSlotPriorityTable - 1
    add hl, de
    ld a, [wRequestedAudioPriority]
    ld [hl], a
    ld a, e
    call GetAudioSlotRecord
    ld a, l
    ld [wCurrentAudioSlotRecordPointer], a
    ld a, h
    ld [wCurrentAudioSlotRecordPointer + 1], a
    ld hl, wCurrentPlaybackRecord
    ld de, wCurrentPlaybackRecord + 1
    ld bc, $0002
    ld [hl], $00
    call AudioCopyMemorySetup
    ld a, [wRequestedPlaybackRepeatCount]
    ld [wCurrentPlaybackRecord], a
    ld a, [wRequestedAudioPlaybackPointer]
    ld l, a
    ld a, [wRequestedAudioPlaybackPointer + 1]
    ld h, a
    ld a, [hl+]
    inc a
    ld [wCurrentPlaybackRecord + 1], a
    ld a, $01
    ld [wCurrentPlaybackRecord + 2], a
    inc hl
    call InitializeAudioEntries
    call CopyPlaybackRecord
    ret

InitializeAudioEntries:
    ld b, $04
    push hl
    pop de ; DE = address of first header entry

InitializeAudioEntriesLoop:
    ld a, [de]
    inc de
    ld l, a
    ld a, [de]
    inc de
    ld h, a
    ld a, [de]
    inc de
    ld c, a
    ld a, h
    or l
    jr z, InitializeAudioEntriesMoveNext

    ld a, $05
    sub b
    push de
    push bc
    call InitializeAudioChannel
    pop bc
    pop de
    jr c, InitializeAudioEntriesEnd

InitializeAudioEntriesMoveNext:
    dec b
    jr nz, InitializeAudioEntriesLoop

    or a

InitializeAudioEntriesEnd:
    ret

; A = hardware channel 1–4
; C = zero-based software selector 0–5
; HL = ROM stream address
InitializeAudioChannel:
    ld [wRequestedPlaybackHardwareChannel], a
    ld a, c
    inc a
    ld [wCurrentPlaybackSoftwareChannel], a
    push hl
    call GetAudioChannelRecord
    ld a, l
    ld [wCurrentAudioChannelRecordPointer], a
    ld a, h
    ld [wCurrentAudioChannelRecordPointer + 1], a
    ld hl, wCurrentAudioStreamStartPointer
    ld de, wCurrentAudioStreamStartPointer + 1
    ld bc, $002a
    ld [hl], $00
    call AudioCopyMemorySetup
    pop hl
    ld a, l
    ld [wCurrentAudioStreamStartPointer], a
    ld a, h
    ld [wCurrentAudioStreamStartPointer + 1], a
    ld a, [wRequestedPlaybackHardwareChannel]
    ld [wCurrentPlaybackHardwareChannel], a
    ld a, [wCurrentPlaybackSoftwareChannel]
    ld e, a
    ld d, $00
    ld hl, wChannelPlaybackSlotOwnerTable - 1
    add hl, de
    ld a, [wAllocatedPlaybackSlot]
    ld [hl], a
    ld hl, wSoftwareChannelActivity - 1
    add hl, de
    ld [hl], $00
    call PrependChannelToList
    call CopyToAudioChannelWram
    ld a, [wCurrentPlaybackSoftwareChannel]
    or a
    ret

PrependChannelToList:
    call GetChannelListAddress
    ld bc, $0003
    add hl, bc
    push hl
    pop de
    dec hl
    call CopyMemoryBackward
    ld a, [wCurrentPlaybackSoftwareChannel]
    ld [de], a
    ret

GetChannelListAddress:
    ld a, [wCurrentPlaybackHardwareChannel]
    add a
    ld hl, HardwareChannelListAddressTable - 2
    add l
    ld l, a
    ld a, $00
    adc h
    ld h, a
    ld a, [hl+]
    ld h, [hl]
    ld l, a
    ret

HardwareChannelListAddressTable:
    dw wHardwareChannel1List, wHardwareChannel2List, wHardwareChannel3List, wHardwareChannel4List

GetAudioSlotRecord:
    add a
    ld hl, AudioSlotRecordAddressTable - 2
    add l
    ld l, a
    ld a, $00
    adc h
    ld h, a
    ld a, [hl+]
    ld h, [hl]
    ld l, a
    ret


    ; Actual table starts at $4B2F
    ; only first 4 slots appear used
AudioSlotRecordAddressTable:
    dw $CC3B, $CC3E, $CC41, $CC44
    dw $CC47, $CC4A, $CC4D, $CC50

GetAudioChannelRecord:
    add a
    ld hl, AudioChannelRecordAddressTable - 2
    add l
    ld l, a
    ld a, $00
    adc h
    ld h, a
    ld a, [hl+]
    ld h, [hl]
    ld l, a
    ret


    ; Actual table starts at $4B4D
    ; only first 6 appear used
AudioChannelRecordAddressTable:
    dw $CC72, $CC9D, $CCC8, $CCF3
    dw $CD1E, $CD49, $CD74, $CD9F

FindFreePlaybackSlot:
    ld b, $04
    ld hl, wPlaybackSlotActiveTable

FindFreePlaybackSlotLoop:
    ld a, [hl+]
    or a
    jr z, StoreFreePlaybackSlotIndex

    dec b
    jr nz, FindFreePlaybackSlotLoop

    scf
    ret

StoreFreePlaybackSlotIndex:
    ld a, $05
    sub b
    ld [wAllocatedPlaybackSlot], a
    ret


    ld b, $06
    ld hl, wChannelPlaybackSlotOwnerTable

FindFreeAudioChannelLoop:
    ld a, [hl+]
    or a
    jr z, StoreFreeAudioChannelIndex

    dec b
    jr nz, FindFreeAudioChannelLoop

    scf
    ret

StoreFreeAudioChannelIndex:
    ld a, $07
    sub b
    ld [wCurrentPlaybackSoftwareChannel], a
    ret

; A = playback slot ID (1–4).
; Look up its WRAM record through AudioSlotRecordAddressTable.
; Save its address in wCurrentAudioSlotRecordPointer, then copy
; its 3 bytes into the working buffer wCurrentPlaybackRecord.
LoadPlaybackRecord:
    call GetAudioSlotRecord
    ld a, l
    ld [wCurrentAudioSlotRecordPointer], a
    ld a, h
    ld [wCurrentAudioSlotRecordPointer + 1], a
    ld de, wCurrentPlaybackRecord
    ld bc, $0003
    jp AudioCopyMemorySetup

CopyPlaybackRecord:
    ld hl, wCurrentPlaybackRecord
    ld a, [wCurrentAudioSlotRecordPointer]
    ld e, a
    ld a, [wCurrentAudioSlotRecordPointer + 1]
    ld d, a
    ld bc, $0003
    jp AudioCopyMemorySetup

LoadAudioChannelRecord:
    call GetAudioChannelRecord
    ld a, l
    ld [wCurrentAudioChannelRecordPointer], a
    ld a, h
    ld [wCurrentAudioChannelRecordPointer + 1], a
    ld de, wCurrentAudioStreamStartPointer
    ld bc, $002b
    jp AudioCopyMemorySetup

CopyToAudioChannelWram:
    ld hl, wCurrentAudioChannelRecord
    ld a, [wCurrentAudioChannelRecordPointer]
    ld e, a
    ld a, [wCurrentAudioChannelRecordPointer + 1]
    ld d, a
    ld bc, $002b
    jp AudioCopyMemorySetup

StopAudioPlayback:
    or a
    jr nz, ReleasePlaybackSlotWithInterruptsDisabled

ReleaseAllPlaybackSlotsLoop:
    inc a
    cp $05
    ret nc

    push af
    call ReleasePlaybackSlotWithInterruptsDisabled
    pop af
    jr ReleaseAllPlaybackSlotsLoop

ReleasePlaybackSlotWithInterruptsDisabled:
    di
    call ReleasePlaybackSlot
    ei
    ret

ReleasePlaybackSlot:
    or a
    ret z

    cp $05
    ret nc ; A >=5

    ld c, a
    ld b, $00
    ld hl, wPlaybackSlotActiveTable - 1
    add hl, bc
    ld [hl], $00
    ld hl, wPlaybackSlotPriorityTable - 1
    add hl, bc
    ld [hl], $00
    ld b, $06
    ld hl, wChannelPlaybackSlotOwnerTable
    ld de, wSoftwareChannelActivity

ReleasePlaybackSlotChannelsLoop:
    ld a, [hl]
    cp c
    jr nz, ReleasePlaybackSlotChannelsNext

    xor a
    ld [hl], a
    ld [de], a
    ld a, $07
    sub b
    push hl
    push de
    push bc
    call RemoveSoftwareChannelFromHardwareLists
    pop bc
    pop de
    pop hl

ReleasePlaybackSlotChannelsNext:
    inc hl
    inc de
    dec b
    jr nz, ReleasePlaybackSlotChannelsLoop

    ret

; A = software channel ID (1–6).
; Remove it from whichever hardware-channel list contains it.
; Perform hardware cleanup and restore the remaining wave stream's waveform.
RemoveSoftwareChannelFromHardwareLists:
    ld hl, wHardwareChannelBeingSearched
    ld [hl], $01
    ld hl, wHardwareChannel1List
    call RemoveSoftwareChannelFromList
    jr nc, .checkAndReturn

    ld hl, wHardwareChannelBeingSearched
    ld [hl], $02
    ld hl, wHardwareChannel2List
    call RemoveSoftwareChannelFromList
    jr nc, .checkAndReturn

    ld hl, wHardwareChannelBeingSearched
    ld [hl], $04
    ld hl, wHardwareChannel4List
    call RemoveSoftwareChannelFromList
    jr nc, .checkAndReturn

    ld hl, wHardwareChannelBeingSearched
    ld [hl], $03
    ld hl, wHardwareChannel3List
    call RemoveSoftwareChannelFromList
    ret c

    ld a, [hl]
    or a
    ret z

    push af
    call GetAudioChannelRecord
    ld de, $0006
    add hl, de
    ld a, [hl]
    call LoadWaveformToWaveRam
    pop af
    jr .return

.checkAndReturn
    ld a, [hl]
    or a
    ret z

.return
    ret

RemoveSoftwareChannelFromList:
    push hl
    ld bc, $0003
    ld d, $04

.findChannel
    cp [hl]
    jr z, .silence

    inc hl
    dec bc
    dec d
    jr nz, .findChannel

    scf
    jr .return

.silence
    call SilenceHardwareChannelIfRemovingHead
    ld e, l
    ld d, h
    inc hl
    ld a, b
    or c
    jr z, .zero

    call AudioCopyMemorySetup

.zero
    xor a
    ld [de], a

.return
    pop hl
    ret


SilenceHardwareChannelIfRemovingHead:
    push bc
    push de
    push hl
    ld a, c
    cp $03
    jr nz, jr_001_4c93

    ld a, [wHardwareChannelBeingSearched]
    call SilenceHardwareChannel

jr_001_4c93:
    pop hl
    pop de
    pop bc
    ret


UpdateAudio:
    push af
    ld a, [wAudioUpdateRunning]
    or a
    jr nz, .return

    dec a
    ld [wAudioUpdateRunning], a
    push hl
    push de
    push bc
    call UpdateAudioPlayback
    pop bc
    pop de
    pop hl
    xor a
    ld [wAudioUpdateRunning], a

.return
    pop af
    reti

UpdateAudioPlayback:
    call ProcessPlaybackSlots
    call UpdateChannelVolumeSequences
    call WritePendingAudioRegisters
    ret

ProcessPlaybackSlots:
    ld b, $04
    ld hl, wPlaybackSlotActiveTable

.checkSlot
    ld a, [hl+]
    or a
    jr z, .nextSlot

    ld a, $05
    sub b
    ld [$cc01], a ; store the playback slot currently being processed
    push bc
    push hl
    call LoadPlaybackRecord
    call UpdatePlaybackSlot
    call CopyPlaybackRecord
    pop hl
    pop bc

.nextSlot
    dec b
    jr nz, .checkSlot

    ret

UpdatePlaybackSlot:
    ld hl, wCurrentPlaybackRecord + 2
    dec [hl]
    ret nz

    ld a, [wCurrentPlaybackRecord + 1]
    ld [hl], a ; reset tick
    call CheckPlaybackCompletion
    ret c

    ld a, [$cc01]
    ld c, a
    ld b, $06
    ld hl, wChannelPlaybackSlotOwnerTable
    ld de, wSoftwareChannelActivity

.checkSlot
    ld a, [hl]
    cp c
    jr nz, .nextSlot ; check if the current channel is owned by the playback slot we are processing

    ; if it is then check the corresponding software channel activity entry
    ld a, [de]
    or a
    jr z, .nextSlot ; if no activity then move to next entry

    push hl
    push de
    push bc
    ld a, $07
    sub b
    ld [wCurrentSoftwareChannelId], a ; Store current software channel ID (1–6)
    call GetAudioChannelRecord
    ld c, l
    ld b, h
    ld a, l
    ld [wCurrentAudioChannelRecordPointer], a
    ld a, h
    ld [wCurrentAudioChannelRecordPointer + 1], a
    call TickAudioChannelStream
    pop bc
    pop de
    pop hl

.nextSlot:
    inc hl
    inc de
    dec b
    jr nz, .checkSlot

    ret

; BC = current audio channel record
TickAudioChannelStream:
    ld a, [wCurrentSoftwareChannelId]
    dec a
    ld e, a
    ld d, $00 ; DE = zero-based software channel index
    ld hl, CHANNEL_LENGTH_MODE_OFFSET
    add hl, bc
    ld a, [hl]
    or a
    jr nz, .checkStreamTimer ; jump if offset $1b in channel record is NOT zero

    ld hl, CHANNEL_VOLUME_SEQUENCE_DURATION_COUNTDOWN_OFFSET
    add hl, bc
    ld a, [hl]
    or a
    jr z, .checkStreamTimer ; jump if byte at offset $0a is 0

    dec [hl] ; if its not zero decrement it
    jr nz, .checkStreamTimer ; if its STILL not 0 then jump

    ld hl, CHANNEL_VOLUME_SEQUENCE_COUNTDOWN_OFFSET
    add hl, bc
    ld [hl], a ; A still holds 1 from before the decrement; set offset $0E to 1


.checkStreamTimer:
    ld hl, CHANNEL_STREAM_TIMER_OFFSET
    add hl, bc
    dec [hl]
    ret nz ; return if its not zero

    ld hl, wSoftwareChannelRegisterUpdatePending
    add hl, de
    ld [hl], $ff ; set a table entry starting at cc21 to FF, index is software channel - 1

ReadNextAudioStreamEntry:
    ld a, [wCurrentAudioChannelRecordPointer]
    ld c, a
    ld a, [wCurrentAudioChannelRecordPointer + 1]
    ld b, a
    ld hl, CHANNEL_AUDIO_STREAM_POINTER_OFFSET
    add hl, bc
    ld a, [hl] ; store the byte from record offset $02 in a
    inc hl ; move hl to offset $03
    push hl ; store address of offset $03
    ld h, [hl]
    ld l, a ; store pointer from $02-$03 into HL
    ld a, [hl+] ; get the byte that the pointer points to into a
    ld d, a ; put in d
    ld a, [hl+] ; get the next byte into a
    ld [wAudioStreamArgument], a
    ld a, h ; put high byte of address in a
    ld e, l ; put low byte into e
    pop hl ; HL now equals address of offset $03 again
    ld [hl-], a
    ld [hl], e ; change pointer stored at $02-$03
    ld a, d ; get the byte that the pointer pointed to this round
    ; preceeding code reads two bytes at pointer in $02-$03, advances two bytes
    ; and stores that new address back at $02-$03
    cp $b0
    jp nc, DispatchAudioCommand

    cp $a0
    jp nc, HandleCountedAudioJump

    cp $90
    jp nc, HandleAudioLoop

    ; byte was $00-$8F
    ld e, $80
    ld hl, CHANNEL_LENGTH_MODE_OFFSET
    add hl, bc
    ld a, [hl]
    or a
    jr z, .setPeriodHigh ; jump if byte there is zero

    ld e, $c0

; e is $c0 or $80 depending on offset $1b
.setPeriodHigh
    ld hl, CHANNEL_PERIOD_HIGH_CONTROL_OFFSET
    add hl, bc ; record offset $002a
    ld a, [hl]
    and $07
    or e ; keep low 3 bits; set bit 7, and bit 6 when E = $C0
    ld [hl], a ; store back at the offset
    ld hl, CHANNEL_HARDWARE_CHANNEL_OFFSET
    add hl, bc
    ld a, [hl]
    cp $04 ; compare the byte at record offset $04 with $04
    jr z, SetNoiseNote ; channel 4 takes the noise lookup path

    ld a, d
    and $f0
    jr z, InitializeRestVolume

    call GetAudioFrequencyEntry ; returns with a pointer to a table entry in hl
    ld a, [hl+]
    push hl
    ld hl, CHANNEL_PERIOD_LOW_NOISE_OFFSET
    add hl, bc
    ld [hl+], a ; store first byte in offset $29
    ld a, [hl]
    and $f8 ; and the byte at $2a with $f8
    pop hl
    or [hl] ; then or it with the second byte hl was pointing to from before
    ld hl, CHANNEL_PERIOD_HIGH_CONTROL_OFFSET
    add hl, bc
    ld [hl], a ; store combined control and pitch bits at offset $2A
    ld hl, CHANNEL_BASE_VOLUME_OFFSET
    add hl, bc
    ld a, [hl]
    ld [wAudioVolumeTemp], a ; store byte at offset $07 in wAudioVolumeTemp
    call WriteWaveChannelPitch
    jr InitializeNoteSequences

WriteWaveChannelPitch:
    ld hl, $0004
    add hl, bc
    ld a, [hl]
    cp $03
    ret nz ; return if the byte at record offset $04 is not 3

    ld hl, CHANNEL_PERIOD_LOW_NOISE_OFFSET
    add hl, bc
    ld a, [hl+]
    ldh [rNR33], a
    ld a, [hl]
    and $7f
    ldh [rNR34], a ; write pitch high/control bits with trigger bit 7 cleared
    ret

GetAudioFrequencyEntry:
    ld a, d
    swap a
    and $0f
    dec a
    add a
    add a
    ld e, a
    add a
    add e
    ld e, a
    ld a, d
    and $0f
    add e
    ld e, a
    ld hl, CHANNEL_AUDIO_FREQ_INDEX_ADJUSTMENT_OFFSET
    add hl, bc
    ld a, [hl]
    add e
    ld l, a
    ld h, $00
    add hl, hl
    ld de, AudioFrequencyTable
    add hl, de
    ret


InitializeRestVolume:
    ld hl, CHANNEL_ALTERNATE_VOLUME_OFFSET
    add hl, bc
    ld a, [hl]
    ld [wAudioVolumeTemp], a ; store the byte from record offset $08 in wAudioVolumeTemp
    ld hl, CHANNEL_VOLUME_SEQUENCE_DURATION_COUNTDOWN_OFFSET
    add hl, bc
    ld [hl], $00 ; zero out offset $0a
    ld a, $01
    ld hl, CHANNEL_VOLUME_SEQUENCE_COUNTDOWN_OFFSET
    add hl, bc
    ld [hl], a ; set offset $0e to 1
    jr SetNoteVolumeAndDuration

SetNoiseNote:
    ld a, d ; d is still the "original" byte
    and $ff
    jr z, InitializeRestVolume ; D was $00

    ld hl, AudioNoiseSettingsTable - 1 ; base $492A for the 1-based index
    add l
    ld l, a
    ld a, $00
    adc h
    ld h, a
    ld a, [hl] ; HL = $492A + incoming A
    cp $e0
    jr c, .setNoise ; table byte < $e0

    xor a

.setNoise:
    ld hl, CHANNEL_PERIOD_LOW_NOISE_OFFSET
    add hl, bc
    ld [hl], a ; put the byte (or 0) at record offset $29
    ld hl, CHANNEL_PITCH_SEQUENCE_INDEX_OFFSET
    add hl, bc
    ld [hl], $00 ; zero out offset $14
    ld hl, CHANNEL_BASE_VOLUME_OFFSET
    add hl, bc
    ld a, [hl]
    ld [wAudioVolumeTemp], a ; store the value from offset $07 in wAudioVolumeTemp

InitializeNoteSequences:
    ld hl, CHANNEL_VOLUME_SEQUENCE_DURATION_SHORTENING_OFFSET
    add hl, bc
    ld h, [hl]
    ld a, [wAudioStreamArgument]
    sub h
    jr z, .setOne ; byte at $09 was equal to second stream byte

    jr nc, .initializeSequences ; byte at $09 was < second byte

.setOne
    ld a, $01

.initializeSequences
    ld hl, CHANNEL_VOLUME_SEQUENCE_DURATION_COUNTDOWN_OFFSET
    add hl, bc
    ld [hl], a ; store max(1, second stream byte - record[$09]) at offset $0A
    ld a, $01
    ld hl, CHANNEL_VOLUME_SEQUENCE_COUNTDOWN_OFFSET
    add hl, bc
    ld [hl], a
    ld hl, CHANNEL_PITCH_SEQUENCE_STEP_COUNTDOWN_OFFSET
    add hl, bc
    ld [hl], a
    ld hl, CHANNEL_PITCH_SEQUENCE_START_DELAY_OFFSET
    add hl, bc
    ld a, [hl]
    ld hl, CHANNEL_PITCH_SEQUENCE_START_COUNTDOWN_OFFSET
    add hl, bc
    ld [hl], a ; copy record[$15] to record[$16]; $0E and $18 were set to 1 above
    xor a
    ld hl, CHANNEL_VOLUME_SEQUENCE_STEP_OFFSET
    add hl, bc
    ld [hl], a
    ld hl, $0012
    add hl, bc
    ld [hl], a ; set offset $0f and $12 to 0
    ld hl, CHANNEL_PITCH_SEQUENCE_INDEX_OFFSET
    add hl, bc
    ld a, [hl]
    add a
    ld hl, AudioPitchSequenceTable
    add l
    ld l, a
    ld a, $00
    adc h
    ld h, a
    ld a, [hl+]
    ld e, [hl]
    ld hl, CHANNEL_PITCH_SEQUENCE_POINTER_OFFSET
    add hl, bc
    ld [hl+], a
    ld [hl], e ; store the pointer from the lookup table to address offset $19-$1A

SetNoteVolumeAndDuration:
    ld a, [wAudioStreamArgument]
    ld hl, CHANNEL_STREAM_TIMER_OFFSET
    add hl, bc
    ld [hl], a ; store second byte into offset $0b
    push bc
    ld hl, CHANNEL_HARDWARE_CHANNEL_OFFSET
    add hl, bc
    ld c, [hl]
    ld a, [wAudioVolumeTemp]
    call EncodeAudioVolume
    ld e, b ; store return value in e
    pop bc
    ld hl, CHANNEL_VOLUME_SEQUENCE_INDEX_OFFSET
    add hl, bc
    ld a, [hl] ; get the byte from offset $0c into a
    or a
    ld a, e ; store return into a
    jr nz, .storeVolume ; jump if record[$0C] was nonzero; ld a, e preserves flags

    ld hl, CHANNEL_VOLUME_LOW_BITS_OFFSET
    add hl, bc
    ld a, [hl]
    or e ; get byte from CHANNEL_VOLUME_LOW_BITS_OFFSET and or it with e

.storeVolume
    ld hl, CHANNEL_VOLUME_REGISTER_OFFSET
    add hl, bc
    ld [hl], a ; store return value, possibly ORed with record[$13], at offset $28
    ret

; C = hardware channel
; A = volume to encode
EncodeAudioVolume:
    swap a
    and $f0
    ld b, a ; move original low nibble into high nibble; clear low nibble
    ld a, c
    cp $03
    jr nz, .return ; if C != $03, return that value directly

    ld a, b
    rlca
    rlca
    and $03
    push hl
    ld hl, WaveChannelVolumeTable
    add l
    ld l, a
    ld a, $00
    adc h
    ld h, a
    ld b, [hl] ; load selected table entry (index 0-3 computed above) into B
    pop hl

.return
    ld a, b
    ret

WaveChannelVolumeTable:
    db $00, $60, $40, $20

; byte was $A0-$AF
HandleCountedAudioJump:
    and $0f
    jp z, .checkArgument ; jump if the command's low nibble is 0

    ld e, a
    ld hl, CHANNEL_JUMP_REPEAT_COUNTER_OFFSET
    add hl, bc
    ld a, [hl]
    or a
    jr z, .setRepeatCounter ; byte at offset $001c was zero

    dec [hl]
    jr nz, .checkArgument ; decrement and jump if still not zero

    jp ReadNextAudioStreamEntry


.setRepeatCounter
    ld [hl], e ; put the byte into the CHANNEL_JUMP_REPEAT_COUNTER_OFFSET

.checkArgument
    ld a, [wAudioStreamArgument]
    ld l, a
    ld h, $00 ; HL = zero-extended second stream byte
    cp $80
    jr c, .reposition ; if the second byte is < $80 than jump

    dec h ; set h to $FF

; this repositions the stream pointer based on the offset calculated
.reposition
    add hl, hl ; double
    ld e, l
    ld d, h ; store in DE
    ld hl, CHANNEL_AUDIO_STREAM_POINTER_OFFSET
    add hl, bc
    ld a, [hl+] ; put the byte from offset CHANNEL_AUDIO_STREAM_POINTER_OFFSET in a
    push hl ; save CHANNEL_AUDIO_STREAM_POINTER_OFFSET + 1 address on stack
    ld h, [hl]
    ld l, a ; set hl ultimately to values from CHANNEL_AUDIO_STREAM_POINTER_OFFSET
    dec hl
    dec hl ; move back two bytes
    add hl, de ; add offset calculated before
    ld a, h
    ld e, l ; new pointer: high byte in A, low byte in E
    pop hl ; address of offset $0003
    ld [hl-], a
    ld [hl], e ; store that pointer back in CHANNEL_AUDIO_STREAM_POINTER_OFFSET
    jp ReadNextAudioStreamEntry

; byte was $90-$9F
HandleAudioLoop:
    and $0f
    jp z, .checkArgument ; low nibble was 0

    ld [$cd76], a ; store the byte in cd76
    ld hl, CHANNEL_AUDIO_STREAM_POINTER_OFFSET
    add hl, bc
    ld e, [hl]
    inc hl
    ld d, [hl] ; get the pointer from $02-$03 into DE
    ld hl, CHANNEL_LOOP_POINTERS_OFFSET
    add hl, bc ; point to record offset $1D
    ld c, $00

.checkEntry
    ld a, [hl+]
    cp e
    jr nz, .nextEntry ; byte read from HL is different than e

    ld a, [hl]
    cp d
    jr z, .decrementLoopCounter ; byte read is equal to d

.nextEntry
    inc hl
    inc c
    ld a, c
    cp $03
    jr c, .checkEntry ; repeat while fewer than three entries have been checked

    ld a, [wCurrentAudioChannelRecordPointer]
    ld e, a
    ld a, [wCurrentAudioChannelRecordPointer + 1]
    ld d, a
    ld hl, CHANNEL_LOOP_POINTERS_OFFSET
    add hl, de ; check offset $1d
    ld c, $00

.findFreeLoopSlot
    ld a, [hl+]
    or [hl]
    jr z, .storePointer ; jump if both bytes are zero

    inc hl
    inc c
    ld a, c
    cp $03
    jr c, .findFreeLoopSlot

    jp ReadNextAudioStreamEntry


.storePointer
    push hl ; save address of the empty entry's high byte
    ld hl, CHANNEL_AUDIO_STREAM_POINTER_OFFSET
    add hl, de
    ld a, [hl+]
    ld b, [hl] ; store a pointer between a and b registers
    pop hl ; restore the address
    ld [hl], b
    dec hl
    ld [hl], a ; overwrite the zeros with the pointer from $02-$03
    ld b, $00
    ld hl, CHANNEL_LOOP_COUNTERS_OFFSET
    add hl, de ; offset $23
    add hl, bc ; adjust for how many iterations we went through before
    ld a, [$cd76] ; saved low nibble of the loop command
    ld [hl], a ; put the byte in the newly calculated address
    jr .checkArgument

.decrementLoopCounter
    ld b, $00
    ld a, [wCurrentAudioChannelRecordPointer]
    ld e, a
    ld a, [wCurrentAudioChannelRecordPointer + 1]
    ld d, a
    ld hl, CHANNEL_LOOP_COUNTERS_OFFSET
    add hl, de
    add hl, bc
    dec [hl] ; record + $23 + C
    jr z, .clearPointer

.checkArgument
    ld a, [wAudioStreamArgument]
    ld l, a
    ld h, $00
    cp $80
    jr c, .newPointer

    dec h ; H = $FF: sign-extend a second byte of $80-$FF

.newPointer
    ld a, [wCurrentAudioChannelRecordPointer]
    ld c, a
    ld a, [wCurrentAudioChannelRecordPointer + 1]
    ld b, a
    add hl, hl
    ld e, l
    ld d, h ; offset in de
    ld hl, CHANNEL_AUDIO_STREAM_POINTER_OFFSET
    add hl, bc
    ld a, [hl+]
    push hl
    ld h, [hl]
    ld l, a
    dec hl
    dec hl
    add hl, de
    ld a, h
    ld e, l
    pop hl
    ld [hl-], a
    ld [hl], e ; new pointer = old pointer − 2 + (incoming HL × 2)
    jp ReadNextAudioStreamEntry


.clearPointer
    ld a, c
    add a
    ld c, a
    ld b, $00
    ld hl, CHANNEL_LOOP_POINTERS_OFFSET
    add hl, de
    add hl, bc
    ld [hl], $00
    inc hl
    ld [hl], $00 ; clear selected pointer; C already holds slot index * 2
    jp ReadNextAudioStreamEntry

; byte was $B0-$FF
DispatchAudioCommand:
    ld hl, ReadNextAudioStreamEntry
    push hl ; push address so we can use ret to go back
    cp $ed
    ret c ; $B0–$EC

    ; $ED-$FF
    ; byte is in a and d at this point
    ld hl, $0004
    add hl, bc
    ld a, [hl]
    add a
    ld hl, AudioCommandTables - 2 ; compensate for the 1-based channel index
    add l
    ld l, a
    ld a, $00
    adc h
    ld h, a
    ld a, [hl+]
    ld h, [hl]
    ld l, a ; hl is now one of the AudioCommandTable pointers
    ld a, d
    cpl
    add a
    add l
    ld l, a
    ld a, $00
    adc h
    ld h, a
    ld a, [hl+]
    ld h, [hl]
    ld l, a ; hl is now the address of the command. Ex: $FE -> AudioCmd_SetBaseVolume
    or h
    ret z ; if handler address is zero, return to the pushed $4D49 address

    ld a, [wAudioStreamArgument]
    ld d, a
    jp hl


; Channel index at record offset $04 is 1-based.
AudioCommandTables: ; $4FCB
    dw AudioCommandHandlers_1, AudioCommandHandlers_2
    dw AudioCommandHandlers_3, AudioCommandHandlers_4

AudioCommandHandlers_1: ; $4FD3
    ; One pointer per command, ordered $FF down to $ED; $0000 skips the command.
    dw AudioCmd_StopPlayback ; $FF
    dw AudioCmd_SetBaseVolume ; $FE
    dw AudioCmd_SetAlternateVolume ; $FD
    dw AudioCmd_SetVolumeSequencePointer ; $FC
    dw AudioCmd_SetVolumeLowBits ; $FB
    dw AudioCmd_SetVolumeSequenceInterval ; $FA
    dw AudioCmd_SetLengthPreserveDuty ; $F9
    dw AudioCmd_SetVolumeSequenceDurationShortening ; $F8
    dw AudioCmd_SetPitchSequenceIndex ; $F7
    dw AudioCmd_SetPitchSequenceStartDelay ; $F6
    dw AudioCmd_SetSweep ; $F5
    dw AudioCmd_SetDutyCycle ; $F4
    dw $0000 ; $F3
    dw $0000 ; $F2
    dw AudioCmd_SetMasterVolume ; $F1
    dw AudioCmd_SetPanningMask ; $F0
    dw AudioCmd_SetPitchSequenceStepInterval ; $EF
    dw AudioCmd_SetLengthMode ; $EE
    dw AudioCmd_SetNoteIndexOffset ; $ED

AudioCommandHandlers_2: ; $4FF9
    ; One pointer per command, ordered $FF down to $ED; $0000 skips the command.
    dw AudioCmd_StopPlayback ; $FF
    dw AudioCmd_SetBaseVolume ; $FE
    dw AudioCmd_SetAlternateVolume ; $FD
    dw AudioCmd_SetVolumeSequencePointer; $FC
    dw AudioCmd_SetVolumeLowBits ; $FB
    dw AudioCmd_SetVolumeSequenceInterval ; $FA
    dw AudioCmd_SetLengthPreserveDuty ; $F9
    dw AudioCmd_SetVolumeSequenceDurationShortening ; $F8
    dw AudioCmd_SetPitchSequenceIndex ; $F7
    dw AudioCmd_SetPitchSequenceStartDelay ; $F6
    dw $0000 ; $F5
    dw AudioCmd_SetDutyCycle ; $F4
    dw $0000 ; $F3
    dw $0000 ; $F2
    dw AudioCmd_SetMasterVolume ; $F1
    dw AudioCmd_SetPanningMask ; $F0
    dw AudioCmd_SetPitchSequenceStepInterval ; $EF
    dw AudioCmd_SetLengthMode ; $EE
    dw AudioCmd_SetNoteIndexOffset ; $ED

AudioCommandHandlers_3: ; $501F
    ; One pointer per command, ordered $FF down to $ED; $0000 skips the command.
    dw AudioCmd_StopPlayback ; $FF
    dw AudioCmd_SetBaseVolume ; $FE
    dw AudioCmd_SetAlternateVolume ; $FD
    dw AudioCmd_SetVolumeSequencePointer ; $FC
    dw $0000 ; $FB
    dw AudioCmd_SetVolumeSequenceInterval ; $FA
    dw AudioCmd_SetLengthPreserveDuty ; $F9
    dw AudioCmd_SetVolumeSequenceDurationShortening ; $F8
    dw AudioCmd_SetPitchSequenceIndex ; $F7
    dw AudioCmd_SetPitchSequenceStartDelay ; $F6
    dw $0000 ; $F5
    dw $0000 ; $F4
    dw $0000 ; $F3
    dw AudioCmd_SetWaveform ; $F2
    dw AudioCmd_SetMasterVolume ; $F1
    dw AudioCmd_SetPanningMask ; $F0
    dw AudioCmd_SetPitchSequenceStepInterval ; $EF
    dw AudioCmd_SetLengthMode ; $EE
    dw AudioCmd_SetNoteIndexOffset ; $ED

AudioCommandHandlers_4: ; $5045
    ; One pointer per command, ordered $FF down to $ED; $0000 skips the command.
    dw AudioCmd_StopPlayback ; $FF
    dw AudioCmd_SetBaseVolume ; $FE
    dw AudioCmd_SetAlternateVolume ; $FD
    dw AudioCmd_SetVolumeSequencePointer ; $FC
    dw AudioCmd_SetVolumeLowBits ; $FB
    dw AudioCmd_SetVolumeSequenceInterval ; $FA
    dw AudioCmd_SetLengthPreserveDuty ; $F9
    dw AudioCmd_SetVolumeSequenceDurationShortening ; $F8
    dw $0000 ; $F7
    dw $0000 ; $F6
    dw $0000 ; $F5
    dw $0000 ; $F4
    dw $0000 ; $F3
    dw $0000 ; $F2
    dw AudioCmd_SetMasterVolume ; $F1
    dw AudioCmd_SetPanningMask ; $F0
    dw $0000 ; $EF
    dw AudioCmd_SetLengthMode ; $EE
    dw $0000 ; $ED

AudioCmd_StopPlayback:
    pop hl
    ld a, [wCurrentSoftwareChannelId]
    ld e, a
    ld d, $00
    ld hl, wSoftwareChannelActivity - 1
    add hl, de
    ld [hl], $00
    ld hl, wSoftwareChannelRegisterUpdatePending - 1
    add hl, de
    ld [hl], $00
    call SilenceHardwareChannelFromRecord
    xor a
    ld hl, CHANNEL_BASE_VOLUME_OFFSET
    add hl, bc
    ld [hl], a
    ret


AudioCmd_SetBaseVolume:
    and $0f
    ld hl, CHANNEL_BASE_VOLUME_OFFSET
    add hl, bc
    ld [hl], a ; store low nibble of the second byte in offset CHANNEL_BASE_VOLUME_OFFSET
    ret ; goes back to 4d49

AudioCmd_SetAlternateVolume:
    and $0f
    ld hl, CHANNEL_ALTERNATE_VOLUME_OFFSET
    add hl, bc
    ld [hl], a
    ret

; Handles audio command $FC.
; Stores the low nibble at channel-record offset $0C.
; If nonzero, selects an 8-byte entry and stores its pointer at $10–$11.
; Reset also calls this with A = 0 and BC = 0, causing an
; ineffective audio-state write to mapper address $000C.
AudioCmd_SetVolumeSequencePointer:
StoreVolumeSequencePointer:
    and $0f
    ld hl, CHANNEL_VOLUME_SEQUENCE_INDEX_OFFSET
    add hl, bc
    ld [hl], a
    ret z

    add a
    add a
    add a
    ld de, AudioVolumeSequenceTable - 8 ; table with 8 byte entries. 1 indexed.
    add e
    ld e, a
    ld a, $00
    adc d
    ld d, a
    ld hl, CHANNEL_VOLUME_SEQUENCE_POINTER_OFFSET
    add hl, bc
    ld [hl], e
    inc hl
    ld [hl], d ; store pointer to the table starting at offset $10 in software channel record
    ret


AudioCmd_SetVolumeLowBits:
    and $0f
    ld hl, CHANNEL_VOLUME_LOW_BITS_OFFSET
    add hl, bc
    ld [hl], a
    ret

AudioCmd_SetVolumeSequenceInterval:
    ld hl, CHANNEL_VOLUME_SEQUENCE_INTERVAL_OFFSET
    add hl, bc
    ld [hl], a
    ret

AudioCmd_SetLengthPreserveDuty:
    ld hl, CHANNEL_HARDWARE_CHANNEL_OFFSET
    add hl, bc
    ld a, [hl]
    cp $03
    ld a, d
    jr z, .return

    and $3f
    ld d, a
    ld hl, CHANNEL_LENGTH_DUTY_OFFSET
    add hl, bc
    ld a, [hl]
    and $c0
    or d

.return
    ld [hl], a
    ret

AudioCmd_SetVolumeSequenceDurationShortening:
    ld hl, CHANNEL_VOLUME_SEQUENCE_DURATION_SHORTENING_OFFSET
    add hl, bc
    ld [hl], a
    ret


AudioCmd_SetPitchSequenceIndex:
    and $0f
    ld hl, CHANNEL_PITCH_SEQUENCE_INDEX_OFFSET
    add hl, bc
    ld [hl], a
    ret

AudioCmd_SetPitchSequenceStepInterval:
    and $0f
    ld hl, CHANNEL_PITCH_SEQUENCE_STEP_INTERVAL_OFFSET
    add hl, bc
    ld [hl], a
    ret

AudioCmd_SetPitchSequenceStartDelay:
    ld hl, CHANNEL_PITCH_SEQUENCE_START_DELAY_OFFSET
    add hl, bc
    ld [hl], a
    ret

AudioCmd_SetSweep:
    ld hl, CHANNEL_SWEEP_DAC_OFFSET
    add hl, bc
    ld [hl], a
    ret

AudioCmd_SetDutyCycle:
    and $c0
    ld d, a
    ld hl, $0027
    add hl, bc
    ld a, [hl]
    and $3f
    or d
    ld [hl], a
    ret

; stores waveform index at offset $06
; then falls through
AudioCmd_SetWaveform:
StoreWaveformIndexThenLoad:
    and $0f
    ld hl, CHANNEL_WAVEFORM_INDEX_OFFSET
    add hl, bc
    ld [hl], a

LoadWaveformToWaveRam:
    swap a
    ld hl, AudioWaveformTable
    add l
    ld l, a
    ld a, $00
    adc h
    ld h, a
    ld de, _AUD3WAVERAM
    ld bc, $0010
    jp AudioCopyMemorySetup

AudioCmd_SetMasterVolume:
    ldh [rNR50], a
    ret

AudioCmd_SetPanningMask:
    ld hl, CHANNEL_HARDWARE_CHANNEL_OFFSET
    add hl, bc
    ld e, [hl]
    jp StoreAudioPanningMask

AudioCmd_SetLengthMode:
    ld hl, CHANNEL_LENGTH_MODE_OFFSET
    add hl, bc
    ld [hl], a
    ret

AudioCmd_SetNoteIndexOffset:
    ld hl, CHANNEL_AUDIO_FREQ_INDEX_ADJUSTMENT_OFFSET
    add hl, bc
    ld [hl], a
    ret

UpdateChannelVolumeSequences:
    ld c, $00
    ld hl, $cc72 + CHANNEL_VOLUME_SEQUENCE_INDEX_OFFSET
    ld de, wSoftwareChannelActivity

.checkChannel
    push de
    push hl
    ld a, [de]
    or a
    jr z, .nextChannel ; skip this software channel if inactive

    ld a, [hl+]
    or a
    jr z, .nextChannel ; skip if this record's offset $0C is zero

    ld b, a ; if not store in b
    ld a, [hl+] ; store byte from offset + 1 in a
    dec [hl] ; decrement record offset $0E
    jr nz, .nextChannel ; if its not zero jump

    ; byte was 1 (and now is 0)
    ld [hl], a ; store the byte from offset + 1 in offset + 2
    push bc
    ld a, c
    ld [$cd74], a ; store the current software channel in cd74 (0-5)
    call UpdateChannelVolumeSequence
    pop bc

; move to processing next channel
; check if we have processed all 6 channels
.nextChannel
    pop hl
    ld de, $002b
    add hl, de
    pop de
    inc de
    inc c
    ld a, c
    cp $06
    jr c, .checkChannel

    ret

UpdateChannelVolumeSequence:
    ld e, l
    ld d, h
    ld hl, $fffa
    add hl, de ; subtract by 6
    ld c, [hl] ; store byte from offset $08 in c
    ld hl, $fffc
    add hl, de ; subtract by 4
    ld a, [hl] ; store byte from offset $0A in a
    or a
    ld a, c
    jr z, .checkBaseVolume ; byte at DE - 4 (record[$0A]) was zero; ld a, c preserves flags

    ld hl, $0001
    add hl, de
    ld a, [hl] ; read the CHANNEL_VOLUME_SEQUENCE_STEP_OFFSET
    cp $10
    jr c, .getPointer ; jump if < $10

    ld a, $0f

.getPointer
    ld c, a ; load the original value or $0f into c
    inc a ; increment a
    ld [hl], a ; load into CHANNEL_VOLUME_SEQUENCE_STEP_OFFSET
    inc hl ; move to offset + 2 ($10)
    ld a, [hl+]
    ld h, [hl]
    ld l, a ; load pointer from DE + 2/+3, which are record offsets $10-$11
    ld a, c
    srl a ; divide by two
    add l
    ld l, a ; adjust hl by result
    ld a, $00
    adc h ; h + carry, handles low byte overflow
    ld h, a ; HL = original pointer + floor(C / 2)
    ld a, [hl]
    bit 0, c ; test whether c is odd
    jr nz, .clearTopNibble ; if odd skip the swap a

    swap a

.clearTopNibble
    and $0f

.checkBaseVolume
    ld c, a
    ld hl, $fff9
    add hl, de  ; subtract 7 (offset $07)
    ld a, [hl] ; get the byte there
    and $0f ; extract low nibble
    add c ; add c to it
    sub $0f
    ld b, $00
    jr c, .storeVolume ; jump if sum was below 15

    ld hl, $fff6 ; subtract 10 (offset $04)
    add hl, de
    ld c, [hl]
    call EncodeAudioVolume

.storeVolume
    ld hl, $001a
    add hl, de
    ld a, [hl]
    and $0f      ; preserve the low nibble of record[$28]
    or b         ; combine it with the newly calculated bits
    push hl
    ld hl, $001a
    add hl, de
    cp [hl]      ; compare new value with old value
    ld [hl], a   ; store new value; flags stay unchanged
    pop hl       ; flags stay unchanged
    ret z        ; return if the value didn’t change

    ld [hl], a
    inc hl
    inc hl
    set 7, [hl] ; offset $2a
    ld a, [$cd74]
    ld c, a
    ld b, $00
    ld hl, wSoftwareChannelRegisterUpdatePending
    add hl, bc
    ld [hl], $ff ; write FF to cc21 + channel index
    ret


    cp $fd
    ei
    rst $30

    ; unused code block below
    ld c, $00
    ld hl, $cc86
    ld de, $cc15

jr_001_51e3:
    push de
    push hl
    ld a, [de]
    or a
    jr z, jr_001_5204

    ld a, [hl+]
    or a
    jr z, jr_001_5204

    inc hl
    ld a, [hl]
    or a
    jr z, jr_001_51f5

    dec [hl]
    jr jr_001_5204

jr_001_51f5:
    inc hl
    ld a, [hl+]
    dec [hl]
    jr nz, jr_001_5204

    ld [hl], a
    push bc
    ld a, c
    ld [$cd74], a
    call Call_001_5212
    pop bc

jr_001_5204:
    pop hl
    ld de, $002b
    add hl, de
    pop de
    inc de
    inc c
    ld a, c
    cp $06
    jr c, jr_001_51e3

    ret


Call_001_5212:
    inc hl
    ld e, l
    ld d, h
    ld l, e
    ld h, d
    ld c, [hl]
    inc hl
    ld b, [hl]

jr_001_521a:
    ld a, [bc]
    inc bc
    ld [hl], b
    dec hl
    ld [hl], c
    cp $80
    jr nz, jr_001_523a

    push hl
    ld hl, $fffb
    add hl, de
    ld a, [hl]
    add a
    ld hl, AudioPitchSequenceTable
    add l
    ld l, a
    ld a, $00
    adc h
    ld h, a
    ld c, [hl]
    inc hl
    ld b, [hl]
    pop hl
    inc hl
    jr jr_001_521a

jr_001_523a:
    or a
    ret z

    ld hl, $0010
    add hl, de
    ld b, $00
    cp $80
    jr c, jr_001_5247

    dec b

jr_001_5247:
    add [hl]
    ld [hl], a
    inc hl
    ld a, b
    adc [hl]
    and $07
    ld b, a
    ld a, [hl]
    and $c0
    or b
    ld [hl], a
    dec hl
    push hl
    ld a, [$cd74]
    add a
    ld hl, $526e
    add l
    ld l, a
    ld a, $00
    adc h
    ld h, a
    ld c, [hl]
    inc hl
    ld b, [hl]
    pop hl
    ld a, [hl]
    ld [bc], a
    inc bc
    inc hl
    ld a, [hl]
    ld [bc], a
    ret


    inc de
    rst $38
    jr @+$01

    dec e
    rst $38
    ld [hl+], a
    rst $38

WritePendingAudioRegisters:
    ld a, $80 ; useless, the next xor immediately clears
    xor a
    ld [$cc37], a ; zero out cc37
    ld c, $00 ; set a counter
    ld hl, wHardwareChannel1List

.checkChannel
    ld a, [hl]
    or a
    jr z, .nextChannel ; if first byte is zero move to the next channel

    ld b, a ; B = selected software channel ID (1-based)
    push hl ; store beginning of current hardware record
    ld hl, wAudioPanningTable - 1
    add l
    ld l, a
    ld a, $00
    adc h
    ld h, a ; HL = $CC1A + software channel ID: address of its panning mask
    ld a, [$cc37]
    or [hl] ; combine this channel's panning mask with masks already collected
    ld [$cc37], a ; put back in cc37, saving combined mask
    ld a, b ; put that first byte back in a
    ld hl, wSoftwareChannelRegisterUpdatePending - 1
    add l
    ld l, a
    ld a, $00
    adc h
    ld h, a
    ld a, [hl] ; read software channel's update flag at $CC20 + ID
    or a
    jr z, .restoreThenNext ; move to the next channel if its zero

    ld [hl], $00 ; zero out that entry
    push bc
    ld a, b ; first byte into a again
    call GetAudioChannelRecord
    push hl
    ld de, CHANNEL_REGISTER_BUFFER_OFFSET
    add hl, de ; get offset $26 of the audio channel
    ld a, c ; current hardware index (0 based) into a
    call UpdateHardwareChannelRegisters
    pop hl
    ld de, CHANNEL_PERIOD_HIGH_CONTROL_OFFSET
    add hl, de
    res 7, [hl] ; clear the saved trigger bit after writing hardware registers
    pop bc

.restoreThenNext
    pop hl

.nextChannel
    ld de, $0004
    add hl, de
    inc c
    ld a, c
    cp $04 ; 4 hardware channels to check
    jr c, .checkChannel

    ld a, [$cc37]
    ldh [rNR51], a ; store accumulated panning mask in NR51
    ret

; A = Hardware channel index 0-3
; HL is offset $26 of the audio channel
UpdateHardwareChannelRegisters:
    push bc
    push af
    ld e, l
    ld d, h
    inc de
    inc de ; move to offset $28
    ld c, a ; store hardware channel in c
    ld a, [de] ; store byte at offset $28 in A
    push af
    ld a, c
    cp $02
    jr nz, .getAddress ; if hardware channel is not 3 (index 2) jump

    ; Disable channel 3's DAC while updating its registers
    push af
    ldh a, [rNR30]
    and $7f
    ldh [rNR30], a
    pop af

.getAddress
    push hl ; offset $26 in the record still
    and $03 ; keep index 0-3; redundant for this caller's valid index
    ld c, a ; store hardware channel in c
    add a ; double a
    add c ; then add hardware channel back (multiply by three)
    ld hl, HardwareChannelRegisterCopyTable
    add l
    ld l, a
    ld a, $00
    adc h
    ld h, a ; HL points to selected 3-byte entry: destination address + byte count
    ld e, [hl]
    inc hl
    ld d, [hl] ; load address into de
    inc hl
    ld c, [hl] ; load byte count into c
    ld b, $00
    pop hl ; hl is offset $26 again
    ld a, c
    cp $04
    jr nz, .update

    ; bytes to copy is 4, move the pointer to offset $27
    inc hl

.update
    pop af ; A = saved record[$28]
    and $f0 ; keep upper nibble; result is unused by the copy helper
    jr nz, .copy ; target is the next instruction either way

.copy
    call AudioCopyMemorySetup ; copy BC bytes from [HL] to hardware registers at [DE]
    ld a, $77
    ldh [rNR50], a ; Maximum L/R master volume; VIN disconnected
    pop af
    cp $02
    jr nz, .return ; if channel is not 3 (index 2) jump

    ldh a, [rNR52]
    or $04
    ld a, $80 ; discard the NR52 value modified in A; it was never written back
    ldh [rNR30], a ; re-enable channel 3's DAC
    ld a, $77
    ldh [rNR50], a ; Maximum L/R master volume; VIN disconnected

.return
    pop bc
    ret


HardwareChannelRegisterCopyTable:
    dw rNR10
    db $05 ; bytes to copy

    dw rNR21
    db $04

    dw rNR30
    db $05

    dw rNR41
    db $04

; Sets playback to repeat or end
CheckPlaybackCompletion:
    ld a, [$cc01]
    ld c, a ; current playback slot being processed
    ld b, $06
    ld hl, wChannelPlaybackSlotOwnerTable
    ld de, wSoftwareChannelActivity

.checkSlot
    ld a, [hl+]
    cp c
    jr nz, .nextSlot ; check if the current channel is owned by the playback slot we are processing

    ; if it is then check the corresponding software channel activity entry
    ld a, [de]
    or a
    ret nz ; return if its NOT zero

.nextSlot:
    inc de
    dec b
    jr nz, .checkSlot

    ld a, [wCurrentPlaybackRecord]
    or a
    jr z, .endPlayback

    cp $ff
    jr z, .repeatPlayback

    dec a
    ld [wCurrentPlaybackRecord], a

.repeatPlayback
    call RestartPlaybackSlotChannels
    or a
    ret


.endPlayback
    ld a, [$cc01]
    call ReleasePlaybackSlot
    scf
    ret


RestartPlaybackSlotChannels:
    ld a, [$cc01]
    ld c, a
    ld b, $06
    ld hl, wChannelPlaybackSlotOwnerTable

.checkChannel:
    ld a, [hl]
    cp c
    jr nz, .nextChannel

    ld a, $07
    sub b
    push hl
    push bc
    call RestartSoftwareChannelPlayback
    pop bc
    pop hl

.nextChannel
    inc hl
    dec b
    jr nz, .checkChannel

    ret

; A = software channel
RestartSoftwareChannelPlayback:
    ld [wCurrentSoftwareChannelId], a
    call LoadAudioChannelRecord ; load the channel into the working record
    ld a, [wCurrentAudioStreamStartPointer]
    ld [$cc49], a
    ld a, [wCurrentAudioStreamStartPointer + 1]
    ld [$cc4a], a ; save a copy of the pointer in cc49-cc4a
    ld hl, $cc4c
    ld de, $cc4d
    ld bc, $0025
    ld [hl], $00
    call AudioCopyMemorySetup ; clear 38 bytes of memory starting at cc4c
    ld a, $00
    ld [$cc50], a
    ld a, $02
    ld [$cc54], a
    ld a, $02
    ld [$cc5e], a
    ld a, $28
    ld [$cc5c], a
    ld a, $0f
    ld [$cc4e], a
    ld a, $01
    ld [$cc52], a
    ld [$cc55], a ; set some flags?
    ld a, [wCurrentPlaybackHardwareChannel]
    ld e, a
    ld a, $03
    call StoreAudioPanningMask ; store a mask at an address based on hardware and software channel
    ; BC is zero after the preceding memory clear.
    ; This call writes 0 to $000C, not channel-record offset $0C.
    ; The working record's corresponding field is already cleared.
    xor a
    call StoreVolumeSequencePointer
    ld a, $08
    ld [$cc6d], a
    ld a, [wCurrentPlaybackHardwareChannel]
    cp $03
    jr nz, .setVolume ; skip if not channel 3

    ; runs for channel 3
    ld a, $80
    ld [$cc6d], a
    xor a
    call StoreWaveformIndexThenLoad

.setVolume
    ld a, [wCurrentPlaybackHardwareChannel]
    add a
    ld hl, AudioChannelVolumeRegisterTable - 2
    add l
    ld l, a
    ld a, $00
    adc h
    ld h, a
    ld a, [hl+]
    ld h, [hl]
    ld l, a ; Store register address in HL
    ld a, $00
    ldh [rNR50], a ; set minimum master volume
    ld [hl], $08 ; Initial volume 0; increase direction; envelope pace 0 (disabled), mutes for channel 3
    ld a, $77
    ldh [rNR50], a ; maximum L/R master volume; VIN disconnected
    ld a, [wCurrentSoftwareChannelId]
    ld hl, wSoftwareChannelActivity - 1
    add l
    ld l, a
    ld a, $00
    adc h
    ld h, a
    ld [hl], $ff ; set activity for selected channel
    call CopyToAudioChannelWram
    ret

AudioChannelVolumeRegisterTable:
    dw $FF12, $FF17, $FF1C, $FF21

; E = wCurrentPlaybackHardwareChannel
; A = routing selection; restart passes $03, stream commands supply their argument
; A restricts the output routing:
; 0 -> $00 -> Neither side
; 1 -> $01 -> Right
; 2 -> $10 -> Left
; 3 -> $11 -> Both
StoreAudioPanningMask:
    and $03
    ld d, a ; save the 2-bit routing selection (example: $03)
    rrca ; rotate right: original bit 0 moves to bit 7 and carry
    swap a ; swap nibbles; for routing $03, A becomes $18
    or d ; combine the routing bits (for routing $03, A becomes $1B)
    and $11 ; keep right/left routing bits 0 and 4 (for routing $03, A = $11)
    ld d, a ; D = unshifted routing mask ($00, $01, $10, or $11)
    ld a, e ; a = wCurrentPlaybackHardwareChannel

jr_001_541c:
    dec a
    jr z, jr_001_5423 ; if a is 0 (was 1) move on

    rlc d ; rotate routing mask left once per hardware channel
    jr jr_001_541c

; Hardware Channel -> Final D
; this applies when input A = $03
; 1 -> $11
; 2 -> $22
; 3 -> $44
; 4 -> $88

; This code then stores that mask at an address based on
; the software channel id:

; Software Channel Id -> Final HL
; 1 - > $CC1B
; 2 - > $CC1C
; 3 - > $CC1D
; 4 - > $CC1E
; 5 - > $CC1F
; 6 - > $CC20
jr_001_5423:
    ld a, [wCurrentSoftwareChannelId]
    ld hl, wAudioPanningTable - 1
    add l
    ld l, a
    ld a, $00
    adc h
    ld h, a
    ld [hl], d
    ret

SilenceHardwareChannelFromRecord:
    ld hl, CHANNEL_HARDWARE_CHANNEL_OFFSET
    add hl, bc
    ld a, [hl]

SilenceHardwareChannel:
    add a
    ld hl, AudioChannelControlRegisterTable - 2
    add l
    ld l, a
    ld a, $00
    adc h
    ld h, a
    push hl
    ld a, [hl+]
    ld h, [hl]
    ld l, a
    ld a, $00
    ldh [rNR50], a
    ld [hl], $08 ; set volume to 0 and envelope direction to increase
    ld a, $77
    ldh [rNR50], a
    pop de
    ld hl, $0008
    add hl, de
    ld a, [hl+]
    ld h, [hl]
    ld l, a
    ld [hl], $80 ; trigger channel with length control disabled
    ret

AudioChannelControlRegisterTable:
    dw rNR12, rNR22, rNR32, rNR42, rNR14, rNR24, rNR34, rNR44

; $5469-$551A: 89 two-byte frequency values (178 bytes).
; Eventually written to channel offsets $29-$2A
AudioFrequencyTable:
    dw $002c, $009d, $0107, $016b, $01c9, $0223 ; indices $00-$05
    dw $0277, $02c7, $0312, $0358, $039b, $03da ; indices $06-$0B
    dw $0416, $044e, $0483, $04b5, $04e5, $0511 ; indices $0C-$11
    dw $053b, $0563, $0589, $05ac, $05ce, $05ed ; indices $12-$17
    dw $060b, $0627, $0642, $065b, $0672, $0689 ; indices $18-$1D
    dw $069e, $06b2, $06c4, $06d6, $06e7, $06f7 ; indices $1E-$23
    dw $0706, $0714, $0721, $072d, $0739, $0744 ; indices $24-$29
    dw $074f, $0759, $0762, $076b, $0773, $077b ; indices $2A-$2F
    dw $0783, $078a, $0790, $0797, $079d, $07a2 ; indices $30-$35
    dw $07a7, $07ac, $07b1, $07b6, $07ba, $07be ; indices $36-$3B
    dw $07c1, $07c5, $07c8, $07cb, $07ce, $07d1 ; indices $3C-$41
    dw $07d4, $07d6, $07d9, $07db, $07dd, $07df ; indices $42-$47
    dw $07e1, $07e2, $07e4, $07e6, $07e7, $07e9 ; indices $48-$4D
    dw $07ea, $07eb, $07ec, $07ed, $07ee, $07ef ; indices $4E-$53
    dw $07f0, $07f1, $07f2, $07f3, $07f4 ; indices $54-$58
AudioFrequencyTableEnd:

    ld l, c
    ld d, h
    add c

jr_001_551e:
    ld d, h
    sbc c
    ld d, h
    or c
    ld d, h
    ret


    ld d, h
    pop hl
    ld d, h
    ld sp, hl
    ld d, h
    db $11
    ld d, l

AudioCopyMemorySetup:
    push af

; This routine appears to be often used to clear/zero memory
AudioCopyMemory: 
    ld a, [hl+]
    ld [de], a
    inc de
    dec bc
    ld a, b
    or c
    jr nz, AudioCopyMemory

    pop af
    ret

CopyMemoryBackward:
    push af

CopyMemoryBackwardLoop:
    ld a, [hl-]
    ld [de], a
    dec de
    dec bc
    ld a, b
    or c
    jr nz, CopyMemoryBackwardLoop

    pop af
    ret


GameOverMusic: ; $01:$5541
    db $06 ; Playback tick interval minus one
    db $00 ; Priority

    dw GameOverMusicStream1 ; Hardware channel 1: pulse
    db $00 ; Software channel selector

    dw GameOverMusicStream2 ; Hardware channel 2: pulse
    db $01 ; Software channel selector

    dw GameOverMusicStream3 ; Hardware channel 3: wave
    db $02 ; Software channel selector

    dw $0000 ; Hardware channel 4 unused

GameOverMusicStream1: ; $01:$554E-$5584
    db $fe, $0a, $f5, $08, $fc, $00, $fb, $05, $f4, $80, $fd, $03, $f0, $01, $50, $04
    db $44, $04, $50, $04, $4b, $08, $42, $04, $47, $04, $4b, $04, $49, $20, $50, $04
    db $44, $04, $50, $04, $4b, $08, $42, $04, $47, $04, $4b, $04, $49, $20, $a1, $f0
    db $f0, $00, $50, $40, $a0, $ff, $ff

GameOverMusicStream2: ; $01:$5585-$55E1
    db $fe, $0a, $f4, $80, $fc, $00, $fb, $05, $fd, $03, $f0, $02, $39, $04, $40, $04
    db $44, $04, $37, $08, $3b, $04, $42, $04, $4b, $04, $49, $04, $fb, $06, $f0, $03
    db $40, $04, $44, $04, $39, $04, $40, $04, $34, $04, $39, $04, $30, $04, $f0, $02
    db $fb, $04, $39, $04, $40, $04, $44, $04, $37, $08, $3b, $04, $42, $04, $4b, $04
    db $f0, $03, $39, $02, $40, $02, $45, $02, $49, $02, $40, $02, $45, $02, $49, $02
    db $50, $02, $55, $10, $a1, $dc, $f0, $00, $50, $40, $a0, $ff, $ff

GameOverMusicStream3: ; $01:$55E2-$5602
    db $fe, $07, $f2, $01, $fc, $0f, $fa, $06, $f8, $01, $fd, $00, $f0, $03, $fd, $03
    db $25, $0c, $24, $14, $22, $20, $25, $0c, $24, $14, $22, $20, $a1, $f9, $00, $08
    db $ff

; Stages 7 and 8 share this definition; StartStageMusic skips stage 7.
Stage8Music: ; $01:$5603
    db $04 ; Playback tick interval minus one
    db $00 ; Priority

    dw Stage8MusicStream1 ; Hardware channel 1: pulse 1
    db $00 ; Software channel selector

    dw Stage8MusicStream2 ; Hardware channel 2: pulse 2
    db $01 ; Software channel selector

    dw Stage8MusicStream3 ; Hardware channel 3: wave
    db $02 ; Software channel selector

    dw Stage8MusicStream4 ; Hardware channel 4: noise
    db $03 ; Software channel selector

Stage8MusicStream1: ; $01:$5611-$57B1
    db $f1, $77, $fe, $0e, $f5, $08, $f4, $40, $f8, $01, $fc, $0c, $fa, $06, $f0, $03
    db $00, $10, $fd, $02, $fc, $02, $30, $10, $32, $10, $34, $10, $34, $06, $34, $06
    db $34, $04, $30, $10, $32, $10, $32, $10, $32, $08, $31, $08, $30, $10, $32, $10
    db $34, $10, $34, $06, $34, $06, $34, $04, $30, $10, $32, $10, $32, $10, $32, $08
    db $31, $08, $30, $10, $32, $10, $34, $10, $34, $06, $34, $06, $34, $04, $30, $10
    db $32, $10, $fc, $0c, $34, $08, $32, $06, $32, $12, $31, $08, $2b, $06, $2b, $12
    db $92, $f9, $fc, $0e, $fd, $06, $f4, $40, $3b, $06, $41, $06, $42, $04, $44, $06
    db $42, $06, $41, $04, $42, $06, $41, $06, $3b, $04, $41, $04, $3b, $04, $39, $02
    db $3b, $04, $39, $02, $3b, $06, $41, $06, $42, $04, $41, $06, $42, $06, $41, $04
    db $42, $06, $41, $06, $39, $04, $44, $04, $42, $04, $41, $02, $3b, $04, $39, $02
    db $38, $06, $39, $06, $3b, $04, $38, $06, $39, $06, $3b, $04, $41, $06, $3b, $06
    db $39, $04, $41, $04, $3b, $04, $39, $02, $3b, $04, $39, $02, $39, $02, $38, $02
    db $39, $02, $3b, $04, $39, $04, $38, $02, $39, $02, $38, $02, $39, $02, $3b, $04
    db $39, $04, $38, $02, $39, $02, $38, $02, $39, $02, $3b, $04, $41, $04, $42, $02
    db $44, $20, $fd, $02, $fc, $02, $a0, $02, $a0, $b5, $39, $10, $3b, $10, $41, $10
    db $42, $06, $41, $06, $39, $04, $39, $10, $3b, $10, $44, $10, $38, $06, $39, $06
    db $3b, $04, $39, $10, $3b, $10, $41, $10, $44, $06, $42, $06, $41, $04, $39, $10
    db $3b, $10, $fa, $0c, $49, $20, $fe, $0e, $fa, $06, $f8, $01, $a1, $e6, $fe, $0c
    db $f8, $00, $49, $06, $49, $06, $49, $04, $49, $06, $49, $06, $49, $04, $49, $06
    db $49, $06, $49, $04, $f0, $03, $49, $02, $f0, $01, $49, $02, $f0, $03, $49, $02
    db $f0, $02, $49, $02, $f0, $03, $00, $02, $f0, $01, $49, $02, $f0, $03, $49, $02
    db $f0, $02, $49, $02, $f0, $03, $93, $e4, $fe, $0e, $fa, $06, $f8, $01, $f0, $03
    db $fe, $0f, $fc, $0c, $fd, $05, $49, $02, $49, $02, $00, $02, $49, $02, $49, $02
    db $00, $02, $49, $02, $49, $02, $00, $02, $49, $02, $49, $02, $00, $02, $47, $02
    db $47, $02, $47, $02, $00, $02, $49, $04, $00, $02, $49, $04, $00, $02, $49, $04
    db $fe, $06, $49, $04, $fe, $04, $49, $04, $fe, $02, $49, $04, $fe, $01, $49, $04
    db $ff

Stage8MusicStream2: ; $01:$57B2-$5930
    db $f4, $40, $f8, $01, $fc, $0c, $fa, $06, $f0, $03, $00, $10, $fd, $02, $fc, $02
    db $fe, $0d, $39, $10, $3b, $10, $41, $10, $44, $06, $42, $06, $41, $04, $39, $10
    db $3b, $10, $39, $10, $39, $10, $39, $10, $3b, $10, $41, $10, $3b, $06, $41, $06
    db $42, $04, $39, $10, $3b, $10, $39, $10, $39, $10, $39, $10, $3b, $10, $41, $10
    db $42, $06, $41, $06, $39, $04, $39, $10, $3b, $10, $fc, $0c, $3b, $08, $39, $06
    db $39, $12, $39, $08, $38, $06, $38, $12, $92, $f9, $fe, $0b, $fc, $0d, $fa, $0f
    db $fd, $02, $f4, $80, $34, $0c, $34, $04, $32, $0c, $32, $04, $31, $0c, $31, $04
    db $29, $04, $2b, $04, $31, $04, $2b, $02, $29, $02, $34, $0c, $34, $04, $32, $0c
    db $32, $04, $31, $0c, $31, $04, $2b, $04, $29, $04, $26, $04, $24, $04, $32, $06
    db $32, $06, $32, $04, $31, $06, $31, $06, $31, $04, $2b, $06, $2b, $06, $2b, $04
    db $28, $06, $29, $06, $2b, $04, $32, $02, $32, $02, $32, $02, $32, $04, $28, $02
    db $29, $02, $2b, $02, $31, $02, $31, $02, $31, $02, $31, $04, $28, $02, $29, $02
    db $2b, $02, $2b, $02, $2b, $02, $2b, $02, $2b, $04, $28, $02, $29, $02, $2b, $02
    db $34, $02, $34, $02, $34, $02, $34, $04, $34, $02, $34, $02, $34, $02, $fe, $0b
    db $34, $04, $32, $04, $31, $04, $29, $02, $2b, $02, $fe, $0d, $fc, $02, $fa, $06
    db $f4, $40, $30, $10, $32, $10, $34, $10, $34, $06, $34, $04, $34, $06, $30, $10
    db $32, $10, $34, $10, $34, $06, $34, $04, $34, $06, $30, $10, $32, $10, $34, $10
    db $34, $06, $34, $04, $34, $06, $30, $10, $32, $10, $32, $10, $32, $08, $31, $08
    db $f0, $03, $a1, $94, $30, $10, $32, $10, $34, $10, $34, $06, $34, $04, $34, $06
    db $30, $10, $32, $10, $32, $10, $32, $08, $31, $08, $91, $f5, $f0, $03, $fe, $0c
    db $fc, $0c, $fd, $05, $39, $02, $39, $02, $00, $02, $39, $02, $39, $02, $00, $02
    db $39, $02, $39, $02, $00, $02, $39, $02, $39, $02, $00, $02, $37, $02, $37, $02
    db $37, $02, $00, $02, $39, $02, $00, $04, $39, $02, $00, $04, $39, $04, $fe, $06
    db $39, $04, $fe, $04, $39, $04, $fe, $02, $39, $04, $fe, $01, $39, $04, $ff

Stage8MusicStream3: ; $01:$5931-$5B43
    db $fe, $0f, $f2, $01, $fc, $0c, $fa, $05, $f8, $01, $fd, $01, $f0, $03, $19, $02
    db $19, $02, $19, $02, $19, $02, $19, $02, $19, $02, $19, $02, $19, $02, $19, $02
    db $19, $02, $19, $02, $19, $02, $19, $02, $19, $02, $19, $02, $19, $02, $93, $f8
    db $94, $f7, $19, $02, $19, $02, $19, $02, $19, $02, $19, $02, $19, $02, $19, $02
    db $19, $02, $19, $02, $19, $02, $19, $02, $19, $02, $19, $02, $19, $02, $19, $02
    db $19, $02, $14, $06, $24, $0a, $00, $04, $24, $06, $24, $06, $14, $10, $00, $04
    db $24, $08, $24, $04, $92, $f7, $24, $02, $14, $02, $14, $02, $22, $02, $14, $02
    db $14, $02, $24, $02, $14, $02, $22, $02, $12, $02, $12, $02, $22, $02, $12, $02
    db $12, $02, $22, $02, $12, $02, $21, $02, $11, $02, $11, $02, $21, $02, $11, $02
    db $11, $02, $21, $02, $11, $02, $1b, $02, $1b, $02, $1b, $02, $1b, $02, $1b, $02
    db $1b, $02, $1b, $02, $1b, $02, $24, $02, $14, $02, $14, $02, $22, $02, $14, $02
    db $14, $02, $24, $02, $14, $02, $22, $02, $12, $02, $12, $02, $22, $02, $12, $02
    db $12, $02, $22, $02, $12, $02, $21, $02, $11, $02, $11, $02, $21, $02, $11, $02
    db $11, $02, $21, $02, $11, $02, $1b, $02, $1b, $02, $1b, $02, $1b, $02, $1b, $02
    db $1b, $02, $1b, $02, $1b, $02, $a0, $02, $a0, $b5, $12, $06, $22, $06, $19, $04
    db $11, $06, $21, $06, $19, $04, $1b, $06, $1b, $06, $16, $04, $14, $04, $1b, $04
    db $11, $04, $12, $04, $22, $02, $12, $02, $19, $02, $22, $04, $12, $02, $19, $02
    db $22, $02, $21, $02, $11, $02, $19, $02, $21, $04, $11, $02, $19, $02, $21, $02
    db $1b, $02, $16, $02, $1b, $02, $1b, $04, $16, $02, $19, $02, $1b, $02, $24, $02
    db $14, $02, $14, $02, $22, $02, $12, $02, $12, $02, $20, $02, $10, $02, $10, $02
    db $1b, $02, $1b, $02, $1b, $02, $20, $02, $10, $02, $22, $02, $12, $02, $15, $02
    db $15, $02, $15, $02, $15, $02, $15, $02, $15, $02, $15, $02, $15, $02, $17, $02
    db $17, $02, $17, $02, $17, $02, $17, $02, $17, $02, $17, $02, $17, $02, $19, $02
    db $19, $02, $19, $02, $19, $02, $19, $02, $19, $02, $19, $02, $19, $02, $19, $02
    db $19, $02, $19, $02, $19, $02, $19, $02, $19, $02, $19, $02, $19, $02, $93, $e0
    db $a1, $ac, $15, $02, $15, $02, $15, $02, $15, $02, $15, $02, $15, $02, $15, $02
    db $15, $02, $17, $02, $17, $02, $17, $02, $17, $02, $17, $02, $17, $02, $17, $02
    db $17, $02, $19, $02, $19, $02, $19, $02, $19, $02, $19, $02, $19, $02, $19, $02
    db $19, $02, $19, $02, $19, $02, $19, $02, $19, $02, $19, $02, $19, $02, $19, $02
    db $19, $02, $93, $e0, $19, $02, $19, $02, $00, $02, $19, $02, $19, $02, $00, $02
    db $19, $02, $19, $02, $00, $02, $19, $02, $19, $02, $00, $02, $17, $02, $17, $02
    db $17, $02, $00, $02, $19, $02, $00, $02, $00, $02, $19, $02, $00, $02, $00, $02
    db $29, $04, $fe, $06, $29, $04, $fe, $04, $29, $04, $fe, $02, $29, $04, $fe, $01
    db $29, $04, $ff

Stage8MusicStream4: ; $01:$5B44-$5D40
    db $fe, $08, $f8, $01, $f0, $03, $00, $10, $00, $40, $94, $ff, $00, $20, $f0, $02
    db $fb, $04, $f9, $10, $06, $08, $f0, $01, $06, $06, $f0, $03, $06, $0e, $fe, $0a
    db $f0, $03, $fb, $02, $f9, $50, $02, $04, $fe, $08, $95, $f2, $fb, $01, $f9, $38
    db $03, $02, $03, $02, $fb, $02, $f9, $50, $02, $02, $fb, $01, $f9, $38, $03, $02
    db $fb, $02, $f9, $50, $02, $02, $fb, $01, $f9, $38, $03, $02, $03, $02, $fb, $02
    db $f9, $50, $02, $02, $92, $ec, $fb, $01, $f9, $38, $03, $02, $03, $02, $fb, $02
    db $f9, $50, $02, $02, $fb, $01, $f9, $38, $03, $02, $fb, $02, $f9, $50, $02, $02
    db $02, $02, $02, $02, $02, $02, $91, $db, $fb, $01, $f9, $38, $03, $02, $03, $02
    db $03, $02, $03, $02, $03, $02, $03, $02, $fb, $02, $f9, $50, $02, $02, $fb, $01
    db $f9, $38, $03, $02, $92, $f2, $a0, $02, $a0, $bb, $03, $02, $03, $02, $03, $02
    db $03, $02, $03, $02, $03, $02, $fb, $02, $f9, $50, $02, $02, $02, $02, $f0, $03
    db $02, $02, $fb, $01, $f9, $38, $03, $02, $03, $02, $fb, $02, $f9, $50, $02, $02
    db $fb, $01, $f9, $38, $03, $02, $03, $02, $fb, $02, $f9, $50, $02, $02, $fb, $01
    db $f9, $38, $03, $02, $93, $ee, $f0, $01, $fb, $02, $f9, $50, $02, $02, $f0, $02
    db $02, $02, $f0, $01, $02, $02, $f0, $02, $02, $02, $f0, $01, $02, $02, $f0, $02
    db $02, $02, $f0, $01, $02, $02, $f0, $02, $02, $02, $f0, $03, $fb, $01, $f9, $38
    db $03, $02, $03, $02, $fb, $02, $f9, $50, $02, $02, $fb, $01, $f9, $38, $03, $02
    db $03, $02, $03, $02, $f0, $02, $fb, $02, $f9, $50, $02, $02, $f0, $01, $02, $02
    db $f0, $03, $92, $ed, $a0, $02, $a0, $b9, $f0, $03, $fb, $01, $f9, $38, $03, $02
    db $03, $02, $03, $02, $f0, $02, $fb, $02, $f9, $50, $02, $02, $f0, $01, $02, $02
    db $f0, $02, $02, $02, $f0, $01, $02, $02, $f0, $02, $02, $02, $f0, $03, $93, $d7
    db $a1, $eb, $fe, $0a, $fe, $0d, $f0, $02, $fb, $03, $f9, $30, $04, $02, $f0, $01
    db $04, $02, $f0, $03, $fe, $09, $fb, $02, $f9, $50, $02, $02, $fe, $0d, $f0, $02
    db $fb, $03, $f9, $30, $04, $02, $f0, $01, $04, $02, $f0, $03, $04, $02, $fe, $0a
    db $fb, $02, $f9, $50, $02, $02, $02, $02, $92, $e5, $fe, $0d, $f0, $02, $fb, $03
    db $f9, $30, $04, $02, $f0, $01, $04, $02, $fe, $09, $fb, $02, $f9, $50, $02, $02
    db $fe, $0d, $f0, $01, $fb, $03, $f9, $30, $04, $02, $f0, $02, $04, $02, $fe, $0a
    db $f0, $01, $fb, $02, $f9, $50, $02, $02, $f0, $02, $02, $02, $f0, $01, $02, $02
    db $f0, $03, $93, $c8, $f0, $03, $fe, $09, $02, $02, $02, $02, $fb, $01, $f9, $38
    db $03, $02, $93, $fb, $fb, $02, $f9, $50, $02, $02, $02, $02, $02, $02, $02, $02
    db $fb, $01, $f9, $38, $03, $02, $03, $02, $fb, $02, $f9, $50, $02, $02, $fb, $01
    db $f9, $38, $03, $02, $03, $02, $fb, $02, $f9, $50, $02, $02, $ff

ExtraLifeSound: ; $01:$5D41
    db $03 ; Playback tick interval minus one
    db $02 ; Priority

    dw ExtraLifeSoundStream1 ; Hardware channel 1: pulse
    db $04 ; Software channel selector

    dw ExtraLifeSoundStream2 ; Hardware channel 2: pulse
    db $05 ; Software channel selector

    dw $0000 ; Hardware channel 3 unused
    db $00 ; Software channel selector

    dw $0000 ; Hardware channel 4 unused

ExtraLifeSoundStream1: ; $01:$5D4E-$5D6C
    db $fe, $0f, $f5, $08, $f4, $40, $fc, $0e, $fa, $03, $f8, $01, $fd, $01, $f0, $01
    db $44, $02, $40, $02, $47, $02, $4b, $02, $50, $02, $52, $02, $57, $0c, $ff

ExtraLifeSoundStream2: ; $01:$5D6D-$5D89
    db $fe, $0f, $f4, $40, $fc, $0e, $fa, $03, $f8, $01, $fd, $01, $f0, $02, $40, $02
    db $37, $02, $44, $02, $47, $02, $47, $02, $4b, $02, $50, $0c, $ff

PauseScreenSound: ; $01:$5D8A
    db $02 ; Playback tick interval minus one
    db $02 ; Priority

    dw PauseScreenSoundStream1 ; Hardware channel 1: pulse
    db $00 ; Software channel selector

    dw PauseScreenSoundStream2 ; Hardware channel 2: pulse
    db $01 ; Software channel selector

    dw $0000 ; Hardware channel 3 unused
    db $02 ; Software channel selector

    dw $0000 ; Hardware channel 4 unused

PauseScreenSoundStream1: ; $01:$5D97-$5DB9
    db $fe, $0f, $f5, $08, $f4, $80, $fc, $0c, $fa, $06, $f8, $01, $fd, $03, $f0, $01
    db $30, $02, $34, $02, $37, $02, $37, $02, $40, $08, $00, $08, $fd, $01, $00, $08
    db $f0, $00, $ff

PauseScreenSoundStream2: ; $01:$5DBA-$5DDA
    db $fe, $0f, $f4, $80, $fc, $0c, $fa, $06, $f8, $01, $fd, $03, $f0, $02, $37, $02
    db $40, $02, $44, $02, $44, $02, $47, $06, $00, $08, $fd, $01, $00, $08, $f0, $00
    db $ff

TitleScreenMusic:
    db $03 ; Playback tick interval minus one
    db $00 ; Priority

    dw TitleScreenMusicStream1 ; Hardware channel 1: pulse
    db $00 ; Software channel selector

    dw TitleScreenMusicStream2 ; Hardware channel 2: pulse
    db $01

    dw TitleScreenMusicStream3 ; Hardware channel 3: wave
    db $02

    dw $0000 ; Hardware channel 4 unused

TitleScreenMusicStream1:
    db $fe, $06, $f4, $00, $fc, $0f, $fa, $02, $f7, $01, $ef, $03, $f6, $08, $f8, $01
    db $fd, $02, $f0, $01, $fe, $0a, $50, $01, $fe, $06, $50, $01, $f0, $02, $fe, $03
    db $50, $01, $fe, $01, $50, $01, $fe, $0a, $50, $01, $fe, $06, $50, $01, $f0, $01
    db $fe, $03, $50, $01, $fe, $01, $50, $01, $a0, $ed, $ff

TitleScreenMusicStream2:
    db $fe, $08, $f4, $00, $fc, $0f, $fa, $02, $f8, $01, $fd, $02, $f0, $03, $32, $20
    db $33, $20, $34, $20, $35, $20, $a0, $fc, $ff

TitleScreenMusicStream3:
    db $fe, $0f, $f2, $01, $fc, $0c, $fa, $04, $f8, $01, $fd, $01, $f0, $03, $20, $08
    db $20, $08, $20, $08, $20, $02, $20, $02, $20, $02, $00, $02, $a0, $f9, $ff


PowerUpAwardSound: ; $01:$5E5B
    db $02 ; Playback tick interval minus one
    db $02 ; Priority

    dw PowerUpAwardSoundStream1 ; Hardware channel 1: pulse
    db $05 ; Software channel selector

    dw PowerUpAwardSoundStream2 ; Hardware channel 2: pulse
    db $04 ; Software channel selector

    dw $0000 ; Hardware channel 3 unused
    db $00 ; Software channel selector

    dw $0000 ; Hardware channel 4 unused

PowerUpAwardSoundStream1: ; $01:$5E68-$5E94
    db $fe, $0a, $f5, $08, $f4, $00, $fc, $0b, $fa, $06, $f8, $01, $fd, $00, $f0, $03
    db $44, $02, $f0, $02, $42, $02, $f0, $01, $40, $02, $f0, $03, $42, $02, $f0, $01
    db $44, $02, $f0, $02, $49, $02, $f0, $03, $f8, $00, $47, $0c, $ff

PowerUpAwardSoundStream2: ; $01:$5E95-$5EAF
    db $fe, $0a, $f4, $00, $fc, $0b, $fa, $06, $f8, $01, $f0, $03, $47, $02, $45, $02
    db $44, $02, $45, $02, $47, $02, $42, $02, $40, $0c, $ff

BossMusic: ; $01:$5EB0
    db $03 ; Playback tick interval minus one
    db $00 ; Priority

    dw $0000 ; Hardware channel 1 unused
    db $02 ; Software channel selector

    dw BossMusicStream2 ; Hardware channel 2: pulse
    db $00 ; Software channel selector

    dw BossMusicStream3 ; Hardware channel 3: wave
    db $01 ; Software channel selector

    dw $0000 ; Hardware channel 4 unused

BossMusicStream2: ; $01:$5EBD-$5F01
    db $fe, $0c, $f8, $01, $fc, $01, $fa, $03, $f4, $40, $fd, $02, $f0, $03, $26, $04
    db $26, $04, $27, $04, $27, $02, $27, $02, $29, $04, $29, $02, $29, $02, $2a, $02
    db $30, $02, $34, $02, $36, $02, $93, $f4, $24, $04, $24, $04, $26, $04, $26, $02
    db $26, $02, $27, $04, $27, $02, $27, $02, $29, $02, $2a, $02, $32, $02, $34, $02
    db $93, $f4, $a0, $e6, $ff

BossMusicStream3: ; $01:$5F02-$5F22
    db $fe, $0f, $f8, $01, $fc, $0c, $fa, $04, $f2, $01, $fd, $02, $f0, $03, $19, $08
    db $19, $08, $00, $10, $93, $fd, $17, $08, $17, $08, $00, $10, $93, $fd, $a0, $f8
    db $ff

AlternateBossMusic: ; $01:$5F23
    db $03 ; Playback tick interval minus one
    db $00 ; Priority

    dw $0000 ; Hardware channel 1 unused
    db $00 ; Software channel selector

    dw AlternateBossMusicStream2 ; Hardware channel 2: pulse
    db $01 ; Software channel selector

    dw AlternateBossMusicStream3 ; Hardware channel 3: wave
    db $02 ; Software channel selector

    dw AlternateBossMusicStream4 ; Hardware channel 4: noise
    db $03 ; Software channel selector

AlternateBossMusicStream2: ; $01:$5F31-$5F8D
    db $fe, $0a, $f5, $08, $f4, $00, $fc, $01, $fa, $03, $f1, $77, $f8, $01, $fd, $01
    db $f0, $03, $ed, $00, $24, $04, $24, $04, $27, $04, $24, $04, $24, $04, $29, $04
    db $24, $04, $24, $04, $2a, $04, $24, $04, $24, $04, $29, $04, $24, $04, $24, $04
    db $27, $04, $24, $04, $91, $ef, $ed, $05, $24, $04, $24, $04, $27, $04, $24, $04
    db $24, $04, $29, $04, $24, $04, $24, $04, $2a, $04, $24, $04, $24, $04, $29, $04
    db $24, $04, $24, $04, $27, $04, $24, $04, $91, $f0, $a0, $dc, $ff

AlternateBossMusicStream3: ; $01:$5F8E-$5FE6
    db $fe, $0b, $fc, $0f, $fa, $03, $f2, $01, $f8, $01, $fd, $01, $f0, $03, $ed, $00
    db $14, $04, $14, $04, $17, $04, $14, $04, $14, $04, $19, $04, $14, $04, $14, $04
    db $1a, $04, $14, $04, $14, $04, $19, $04, $14, $04, $14, $04, $17, $04, $14, $04
    db $91, $ef, $ed, $05, $14, $04, $14, $04, $17, $04, $14, $04, $14, $04, $19, $04
    db $14, $04, $14, $04, $1a, $04, $14, $04, $14, $04, $19, $04, $14, $04, $14, $04
    db $17, $04, $14, $04, $91, $f0, $a0, $dc, $ff

AlternateBossMusicStream4: ; $01:$5FE7-$600D
    db $fe, $08, $f8, $01, $f0, $03, $fe, $07, $fb, $01, $f9, $38, $03, $04, $03, $02
    db $03, $02, $96, $fa, $fe, $0a, $f0, $02, $fb, $02, $f9, $50, $02, $04, $f0, $01
    db $02, $04, $f0, $03, $a0, $f1, $ff


StageTransitionMusic: ; $01:$600E
    db $03 ; Playback tick interval minus one
    db $03 ; Priority

    dw StageTransitionMusicStream1 ; Hardware channel 1: pulse
    db $00 ; Software channel selector

    dw StageTransitionMusicStream2 ; Hardware channel 2: pulse
    db $01 ; Software channel selector

    dw StageTransitionMusicStream3 ; Hardware channel 3: wave
    db $02 ; Software channel selector

    dw StageTransitionMusicStream4 ; Hardware channel 4: noise
    db $05 ; Software channel selector

StageTransitionMusicStream1: ; $01:$601C-$6046
    db $fe, $08, $f5, $00, $f4, $40, $fc, $0e, $fa, $06, $fd, $00, $f8, $01, $f0, $03
    db $47, $10, $45, $10, $44, $10, $42, $08, $44, $04, $45, $04, $47, $04, $00, $02
    db $47, $04, $00, $02, $47, $10, $fd, $03, $00, $08, $ff

StageTransitionMusicStream2: ; $01:$6047-$606F
    db $fe, $08, $f0, $03, $f4, $40, $fc, $0e, $fa, $06, $fd, $00, $f8, $01, $42, $10
    db $40, $10, $3b, $10, $39, $08, $3b, $04, $40, $04, $42, $04, $00, $02, $42, $04
    db $00, $02, $42, $10, $fd, $03, $00, $08, $ff

StageTransitionMusicStream3: ; $01:$6070-$60D2
    db $fe, $0f, $f0, $03, $fc, $0d, $f2, $01, $fa, $04, $f8, $01, $f0, $01, $17, $02
    db $f0, $02, $17, $02, $93, $fc, $f0, $01, $15, $02, $f0, $02, $15, $02, $93, $fc
    db $f0, $01, $14, $02, $f0, $02, $14, $02, $93, $fc, $f0, $01, $12, $02, $f0, $02
    db $12, $02, $91, $fc, $f0, $01, $14, $02, $f0, $02, $14, $02, $f0, $01, $15, $02
    db $f0, $02, $15, $02, $f0, $01, $17, $02, $f0, $02, $00, $02, $f0, $01, $00, $02
    db $f0, $02, $17, $02, $f0, $01, $00, $02, $f0, $02, $00, $02, $17, $10, $fd, $03
    db $00, $08, $ff

StageTransitionMusicStream4: ; $01:$60D3-$620F
    db $f8, $01, $fe, $08, $fd, $00, $f0, $03, $fc, $00, $fe, $06, $fb, $01, $f9, $38
    db $03, $02, $03, $02, $f0, $01, $fe, $09, $fb, $02, $f9, $50, $02, $02, $fe, $06
    db $f0, $03, $fb, $01, $f9, $38, $03, $02, $f0, $02, $fe, $09, $fb, $02, $f9, $50
    db $02, $02, $fe, $06, $f0, $03, $fb, $01, $f9, $38, $03, $02, $03, $02, $fe, $09
    db $f0, $01, $fb, $02, $f9, $50, $02, $02, $f0, $03, $fe, $06, $fb, $01, $f9, $38
    db $03, $02, $03, $02, $fe, $09, $f0, $02, $fb, $02, $f9, $50, $02, $02, $f0, $03
    db $fe, $06, $fb, $01, $f9, $38, $03, $02, $fe, $09, $f0, $01, $fb, $02, $f9, $50
    db $02, $02, $f0, $03, $fe, $06, $fb, $01, $f9, $38, $03, $02, $03, $02, $f0, $02
    db $fe, $09, $fb, $02, $f9, $50, $02, $02, $f0, $03, $fe, $06, $fb, $01, $f9, $38
    db $03, $02, $03, $02, $f0, $01, $fe, $09, $fb, $02, $f9, $50, $02, $02, $fe, $06
    db $f0, $03, $fb, $01, $f9, $38, $03, $02, $fe, $09, $f0, $02, $fb, $02, $f9, $50
    db $02, $02, $fe, $06, $f0, $03, $fb, $01, $f9, $38, $03, $02, $03, $02, $fe, $09
    db $f0, $01, $fb, $02, $f9, $50, $02, $02, $f0, $03, $fe, $06, $fb, $01, $f9, $38
    db $03, $02, $03, $02, $f0, $02, $fe, $09, $fb, $02, $f9, $50, $02, $02, $f0, $03
    db $fe, $06, $fb, $01, $f9, $38, $03, $02, $fe, $09, $f0, $01, $fb, $02, $f9, $50
    db $02, $02, $f0, $03, $fe, $06, $fb, $01, $f9, $38, $03, $02, $03, $02, $fe, $09
    db $f0, $02, $fb, $02, $f9, $50, $02, $02, $f0, $03, $02, $02, $fe, $0c, $f0, $01
    db $fb, $01, $f9, $38, $03, $02, $f0, $02, $03, $02, $fe, $09, $f0, $03, $fb, $02
    db $f9, $50, $02, $02, $fe, $0c, $f0, $01, $fb, $01, $f9, $38, $03, $02, $f0, $02
    db $03, $02, $fe, $0c, $f0, $03, $fb, $02, $f9, $50, $02, $04, $ff

; Stages 0, 1, and 2 share this definition.
Stage1Music: ; $01:$6210
    db $02 ; Playback tick interval minus one
    db $00 ; Priority

    dw $0000 ; Hardware channel 1: pulse 1 (unused)
    db $03 ; Software channel selector

    dw Stage1MusicStream2 ; Hardware channel 2: pulse 2
    db $00 ; Software channel selector

    dw Stage1MusicStream3 ; Hardware channel 3: wave
    db $01 ; Software channel selector

    dw Stage1MusicStream4 ; Hardware channel 4: noise
    db $02 ; Software channel selector

Stage1MusicStream2: ; $01:$621E-$6294
    db $f0, $03, $fe, $09, $f4, $80, $f8, $01, $fc, $0e, $fa, $05, $fd, $05, $fd, $00
    db $00, $40, $fd, $05, $39, $04, $40, $04, $44, $04, $47, $24, $46, $06, $47, $06
    db $46, $04, $44, $0c, $40, $10, $37, $24, $39, $04, $40, $04, $44, $04, $47, $24
    db $46, $06, $47, $06, $49, $04, $49, $0c, $47, $0c, $46, $04, $42, $24, $39, $0c
    db $40, $0c, $45, $0c, $39, $04, $40, $04, $45, $04, $39, $04, $40, $08, $45, $04
    db $47, $0c, $42, $0c, $3b, $04, $37, $24, $50, $04, $52, $04, $00, $04, $47, $04
    db $49, $04, $00, $04, $42, $04, $44, $04, $00, $04, $40, $04, $42, $04, $00, $04
    db $37, $08, $38, $08, $a0, $cd, $ff

Stage1MusicStream3: ; $01:$6295-$636B
    db $f0, $03, $f2, $01, $fe, $0f, $f8, $01, $fc, $0d, $fa, $05, $fd, $05, $30, $04
    db $32, $04, $00, $04, $27, $04, $29, $04, $00, $04, $22, $04, $24, $04, $00, $04
    db $20, $04, $22, $04, $00, $04, $17, $08, $18, $08, $19, $04, $19, $04, $19, $04
    db $19, $04, $19, $04, $19, $04, $19, $04, $19, $04, $91, $f8, $19, $04, $19, $04
    db $19, $04, $19, $04, $19, $04, $19, $04, $19, $04, $17, $14, $17, $08, $18, $08
    db $19, $04, $19, $04, $19, $04, $19, $04, $19, $04, $19, $04, $19, $04, $19, $04
    db $91, $f8, $19, $04, $19, $04, $19, $04, $19, $04, $19, $04, $19, $04, $19, $04
    db $17, $14, $17, $04, $1b, $08, $15, $04, $15, $04, $15, $04, $15, $04, $15, $04
    db $15, $04, $15, $04, $15, $04, $15, $04, $15, $04, $15, $04, $15, $04, $15, $04
    db $14, $04, $15, $04, $17, $04, $17, $04, $17, $04, $17, $04, $17, $04, $17, $04
    db $17, $04, $17, $04, $17, $04, $17, $04, $17, $04, $17, $04, $17, $04, $17, $04
    db $17, $08, $18, $08, $30, $04, $32, $04, $00, $04, $27, $04, $29, $04, $00, $04
    db $22, $04, $24, $04, $00, $04, $20, $04, $22, $04, $00, $04, $17, $08, $18, $08
    db $a0, $02, $a0, $9e, $a0, $ff, $ff

Stage1MusicStream4: ; $01:$636C-$651C
    db $f0, $03, $fe, $07, $f8, $01, $fd, $00, $fc, $00, $fb, $02, $f9, $30, $02, $04
    db $02, $04, $fb, $01, $f9, $38, $03, $04, $fb, $02, $f9, $30, $02, $04, $02, $04
    db $fb, $01, $f9, $38, $03, $04, $fb, $02, $f9, $30, $02, $04, $02, $04, $fb, $01
    db $f9, $38, $03, $04, $fb, $02, $f9, $30, $02, $04, $02, $04, $fb, $01, $f9, $38
    db $03, $04, $fb, $02, $f9, $30, $02, $04, $fb, $01, $f9, $38, $03, $04, $fb, $02
    db $f9, $30, $02, $04, $fb, $01, $f9, $38, $03, $04, $03, $02, $03, $02, $03, $02
    db $03, $02, $fb, $02, $f9, $30, $02, $04, $fb, $01, $f9, $38, $03, $02, $03, $02
    db $03, $02, $03, $02, $03, $02, $03, $02, $03, $02, $fb, $02, $f9, $30, $02, $04
    db $fb, $01, $f9, $38, $03, $02, $a0, $02, $a0, $c1, $03, $02, $03, $02, $03, $02
    db $03, $02, $fb, $02, $f9, $30, $02, $02, $fb, $01, $f9, $38, $03, $02, $03, $02
    db $03, $02, $03, $02, $03, $02, $fb, $02, $f9, $30, $02, $02, $fb, $01, $f9, $38
    db $03, $02, $03, $02, $03, $02, $fb, $02, $f9, $30, $02, $02, $fb, $01, $f9, $38
    db $03, $02, $93, $cc, $fb, $02, $f9, $30, $02, $02, $fb, $01, $f9, $38, $03, $02
    db $03, $02, $fb, $02, $f9, $30, $02, $02, $fb, $01, $f9, $38, $03, $02, $03, $02
    db $fb, $02, $f9, $30, $02, $02, $fb, $01, $f9, $38, $03, $02, $fb, $02, $f9, $30
    db $02, $02, $fb, $01, $f9, $38, $03, $02, $03, $02, $fb, $02, $f9, $30, $02, $02
    db $fb, $01, $f9, $38, $03, $02, $fb, $02, $f9, $30, $02, $02, $fb, $01, $f9, $38
    db $03, $02, $fb, $02, $f9, $30, $02, $02, $a0, $02, $a0, $b7, $02, $02, $fb, $01
    db $f9, $38, $03, $02, $03, $02, $fb, $02, $f9, $30, $02, $02, $fb, $01, $f9, $38
    db $03, $02, $03, $02, $fb, $02, $f9, $30, $02, $02, $02, $02, $fb, $01, $f9, $38
    db $03, $02, $03, $02, $fb, $02, $f9, $30, $02, $02, $fb, $01, $f9, $38, $03, $02
    db $03, $02, $fb, $02, $f9, $30, $02, $02, $fb, $01, $f9, $38, $03, $02, $03, $02
    db $91, $b2, $fb, $02, $f9, $30, $02, $04, $02, $04, $fb, $01, $f9, $38, $03, $02
    db $00, $02, $fb, $02, $f9, $30, $02, $04, $02, $04, $fb, $01, $f9, $38, $03, $02
    db $00, $02, $fb, $02, $f9, $30, $02, $04, $02, $04, $fb, $01, $f9, $38, $03, $02
    db $00, $02, $fb, $02, $f9, $30, $02, $04, $02, $04, $fb, $01, $f9, $38, $03, $02
    db $00, $02, $fb, $02, $f9, $30, $02, $04, $00, $04, $02, $04, $00, $04, $a0, $b6
    db $ff

; Stage 4.
Stage4Music: ; $01:$651D
    db $04 ; Playback tick interval minus one
    db $00 ; Priority

    dw $0000 ; Hardware channel 1: pulse 1 (unused)
    db $03 ; Software channel selector

    dw Stage4MusicStream2 ; Hardware channel 2: pulse 2
    db $00 ; Software channel selector

    dw Stage4MusicStream3 ; Hardware channel 3: wave
    db $01 ; Software channel selector

    dw Stage4MusicStream4 ; Hardware channel 4: noise
    db $02 ; Software channel selector

Stage4MusicStream2: ; $01:$652B-$65BF
    db $f0, $03, $fe, $0a, $f4, $80, $f8, $01, $fc, $0e, $fa, $06, $fd, $00, $ed, $02
    db $00, $40, $00, $40, $00, $20, $00, $0c, $fd, $05, $39, $02, $40, $02, $44, $04
    db $42, $04, $3b, $06, $37, $02, $34, $0c, $30, $02, $34, $02, $37, $04, $35, $04
    db $34, $04, $30, $04, $32, $0c, $40, $04, $3b, $0c, $37, $04, $39, $0c, $39, $02
    db $40, $02, $44, $04, $42, $04, $3b, $06, $37, $02, $34, $0c, $30, $02, $34, $02
    db $37, $04, $35, $04, $34, $06, $30, $02, $32, $06, $34, $02, $29, $02, $2b, $02
    db $30, $02, $32, $02, $34, $04, $32, $04, $2b, $04, $27, $04, $44, $0c, $47, $04
    db $42, $0c, $42, $02, $44, $02, $45, $08, $44, $04, $40, $04, $44, $06, $42, $0a
    db $44, $0c, $47, $04, $42, $0c, $42, $02, $44, $02, $45, $08, $47, $08, $49, $10
    db $00, $10, $a0, $b7, $ff

Stage4MusicStream3: ; $01:$65C0-$6702
    db $f0, $03, $fe, $0f, $f2, $01, $fc, $0d, $fa, $04, $f8, $01, $fd, $01, $ed, $02
    db $19, $02, $19, $02, $17, $02, $19, $02, $00, $08, $20, $02, $20, $02, $00, $04
    db $22, $02, $22, $02, $00, $04, $19, $02, $19, $02, $17, $02, $19, $02, $00, $08
    db $20, $02, $20, $02, $00, $04, $17, $02, $17, $02, $00, $04, $19, $02, $19, $02
    db $17, $02, $19, $02, $00, $08, $20, $02, $20, $02, $00, $04, $22, $02, $22, $02
    db $00, $04, $19, $02, $19, $02, $17, $02, $19, $02, $00, $08, $20, $02, $20, $02
    db $00, $04, $17, $02, $17, $02, $00, $04, $24, $04, $24, $04, $24, $04, $24, $04
    db $24, $04, $22, $04, $1b, $04, $17, $04, $a0, $02, $a0, $cb, $19, $02, $19, $02
    db $17, $02, $19, $02, $00, $08, $20, $02, $20, $02, $00, $04, $22, $02, $22, $02
    db $00, $04, $19, $02, $19, $02, $17, $02, $19, $02, $00, $08, $27, $02, $27, $02
    db $00, $04, $20, $02, $20, $02, $00, $04, $22, $04, $22, $04, $22, $04, $22, $04
    db $24, $04, $24, $04, $24, $04, $22, $04, $19, $02, $19, $02, $17, $02, $19, $02
    db $00, $08, $20, $02, $20, $02, $00, $04, $22, $02, $22, $02, $00, $04, $19, $02
    db $19, $02, $17, $02, $19, $02, $00, $08, $27, $02, $27, $02, $00, $04, $20, $02
    db $20, $02, $00, $04, $22, $04, $22, $04, $22, $04, $22, $04, $27, $04, $27, $04
    db $27, $04, $27, $04, $20, $06, $20, $02, $20, $08, $22, $06, $22, $02, $22, $08
    db $24, $06, $24, $02, $24, $08, $24, $04, $22, $04, $1b, $04, $17, $04, $20, $06
    db $20, $02, $20, $08, $22, $06, $22, $02, $22, $08, $25, $04, $00, $01, $20, $01
    db $22, $01, $25, $01, $27, $04, $00, $01, $1b, $01, $22, $01, $27, $01, $29, $02
    db $29, $02, $29, $02, $29, $02, $29, $02, $29, $02, $29, $02, $29, $02, $00, $10
    db $a0, $9d, $ff

Stage4MusicStream4: ; $01:$6703-$6B5F
    db $fe, $08, $f8, $01, $fd, $00, $fc, $00, $f0, $03, $fe, $05, $fb, $01, $f9, $38
    db $03, $02, $00, $02, $03, $02, $03, $02, $fe, $08, $fb, $02, $f9, $30, $02, $02
    db $fe, $05, $fb, $01, $f9, $38, $03, $02, $00, $02, $03, $02, $03, $02, $03, $02
    db $fe, $08, $fb, $02, $f9, $30, $02, $02, $00, $02, $fb, $01, $f9, $38, $03, $02
    db $03, $02, $fe, $08, $fb, $02, $f9, $30, $02, $02, $00, $02, $fe, $05, $fb, $01
    db $f9, $38, $03, $02, $00, $02, $03, $02, $03, $02, $fe, $08, $fb, $02, $f9, $30
    db $02, $02, $fe, $05, $fb, $01, $f9, $38, $03, $02, $00, $02, $03, $02, $03, $02
    db $03, $02, $fe, $08, $fb, $02, $f9, $30, $02, $02, $00, $02, $fb, $01, $f9, $38
    db $03, $02, $03, $02, $fe, $08, $fb, $02, $f9, $30, $02, $02, $00, $02, $fe, $05
    db $fb, $01, $f9, $38, $03, $02, $00, $02, $03, $02, $03, $02, $fe, $08, $fb, $02
    db $f9, $30, $02, $02, $fe, $05, $fb, $01, $f9, $38, $03, $02, $00, $02, $03, $02
    db $a0, $02, $a0, $ac, $03, $02, $03, $02, $fe, $08, $fb, $02, $f9, $30, $02, $02
    db $00, $02, $fb, $01, $f9, $38, $03, $02, $03, $02, $fe, $08, $fb, $02, $f9, $30
    db $02, $02, $00, $02, $fe, $05, $fb, $01, $f9, $38, $03, $02, $00, $02, $03, $02
    db $03, $02, $fe, $08, $fb, $02, $f9, $30, $02, $02, $fe, $05, $fb, $01, $f9, $38
    db $03, $02, $00, $02, $03, $02, $03, $02, $03, $02, $fe, $08, $fb, $02, $f9, $30
    db $02, $02, $00, $02, $fb, $01, $f9, $38, $03, $02, $03, $02, $fe, $08, $fb, $02
    db $f9, $30, $02, $02, $00, $02, $fe, $06, $fb, $01, $f9, $38, $03, $04, $03, $04
    db $03, $04, $03, $04, $fe, $06, $03, $02, $fe, $08, $fb, $02, $f9, $30, $02, $02
    db $fe, $06, $fb, $01, $f9, $38, $03, $02, $fe, $08, $fb, $02, $f9, $30, $02, $02
    db $fe, $06, $fb, $01, $f9, $38, $03, $02, $fe, $08, $fb, $02, $f9, $30, $02, $02
    db $fe, $06, $fb, $01, $f9, $38, $03, $02, $fe, $08, $fb, $02, $f9, $30, $02, $02
    db $a0, $02, $a0, $a8, $fe, $05, $fb, $01, $f9, $38, $03, $02, $00, $02, $03, $02
    db $03, $02, $fe, $08, $fb, $02, $f9, $30, $02, $02, $fe, $05, $fb, $01, $f9, $38
    db $03, $02, $00, $02, $03, $02, $03, $02, $03, $02, $fe, $08, $fb, $02, $f9, $30
    db $02, $02, $00, $02, $fb, $01, $f9, $38, $03, $02, $03, $02, $fe, $08, $fb, $02
    db $f9, $30, $02, $02, $00, $02, $fe, $05, $fb, $01, $f9, $38, $03, $02, $00, $02
    db $03, $02, $03, $02, $fe, $08, $fb, $02, $f9, $30, $02, $02, $fe, $05, $fb, $01
    db $f9, $38, $03, $02, $00, $02, $03, $02, $03, $02, $03, $02, $fe, $08, $fb, $02
    db $f9, $30, $02, $02, $00, $02, $fb, $01, $f9, $38, $03, $02, $03, $02, $fe, $08
    db $fb, $02, $f9, $30, $02, $02, $00, $02, $a0, $02, $a0, $bc, $fe, $06, $fb, $01
    db $f9, $38, $03, $02, $03, $02, $03, $02, $03, $02, $03, $02, $03, $02, $03, $02
    db $03, $02, $fe, $08, $fb, $02, $f9, $30, $02, $02, $02, $02, $00, $02, $02, $02
    db $02, $02, $00, $02, $02, $02, $02, $02, $fe, $05, $fb, $01, $f9, $38, $03, $02
    db $00, $02, $03, $02, $03, $02, $fe, $08, $fb, $02, $f9, $30, $02, $02, $fe, $05
    db $fb, $01, $f9, $38, $03, $02, $00, $02, $03, $02, $03, $02, $03, $02, $fe, $08
    db $fb, $02, $f9, $30, $02, $02, $00, $02, $fb, $01, $f9, $38, $03, $02, $03, $02
    db $fe, $08, $fb, $02, $f9, $30, $02, $02, $00, $02, $fe, $05, $fb, $01, $f9, $38
    db $03, $02, $00, $02, $03, $02, $03, $02, $fe, $08, $fb, $02, $f9, $30, $02, $02
    db $fe, $05, $fb, $01, $f9, $38, $03, $02, $00, $02, $03, $02, $a0, $02, $a0, $b6
    db $03, $02, $03, $02, $fe, $08, $fb, $02, $f9, $30, $02, $02, $00, $02, $fb, $01
    db $f9, $38, $03, $02, $03, $02, $fe, $08, $fb, $02, $f9, $30, $02, $02, $00, $02
    db $fe, $06, $fb, $01, $f9, $38, $03, $02, $03, $02, $03, $02, $03, $02, $03, $02
    db $03, $02, $03, $02, $03, $02, $fe, $08, $fb, $02, $f9, $30, $02, $02, $02, $02
    db $00, $02, $02, $02, $02, $02, $00, $02, $02, $02, $02, $02, $a0, $02, $a0, $d8
    db $fe, $05, $fb, $01, $f9, $38, $03, $02, $03, $02, $fe, $08, $fb, $02, $f9, $30
    db $02, $02, $fe, $05, $fb, $01, $f9, $38, $03, $02, $fe, $05, $03, $02, $03, $02
    db $fe, $08, $fb, $02, $f9, $30, $02, $02, $fe, $05, $fb, $01, $f9, $38, $03, $02
    db $fe, $05, $03, $02, $03, $02, $fe, $08, $fb, $02, $f9, $30, $02, $02, $fe, $05
    db $fb, $01, $f9, $38, $03, $02, $fe, $05, $03, $02, $03, $02, $fe, $08, $fb, $02
    db $f9, $30, $02, $02, $02, $02, $a0, $02, $a0, $d3, $fe, $05, $fb, $01, $f9, $38
    db $03, $02, $03, $02, $fe, $08, $fb, $02, $f9, $30, $02, $02, $fe, $05, $fb, $01
    db $f9, $38, $03, $02, $fe, $05, $03, $02, $03, $02, $fe, $08, $fb, $02, $f9, $30
    db $02, $02, $fe, $05, $fb, $01, $f9, $38, $03, $02, $fe, $08, $fb, $02, $f9, $30
    db $02, $02, $fe, $05, $fb, $01, $f9, $38, $03, $02, $fe, $08, $fb, $02, $f9, $30
    db $02, $02, $fe, $05, $fb, $01, $f9, $38, $03, $02, $fe, $08, $fb, $02, $f9, $30
    db $02, $02, $fe, $05, $fb, $01, $f9, $38, $03, $02, $fe, $08, $fb, $02, $f9, $30
    db $02, $02, $fe, $05, $fb, $01, $f9, $38, $03, $02, $fe, $05, $03, $02, $03, $02
    db $fe, $08, $fb, $02, $f9, $30, $02, $02, $fe, $05, $fb, $01, $f9, $38, $03, $02
    db $fe, $05, $03, $02, $03, $02, $fe, $08, $fb, $02, $f9, $30, $02, $02, $fe, $05
    db $fb, $01, $f9, $38, $03, $02, $fe, $05, $03, $02, $03, $02, $fe, $08, $fb, $02
    db $f9, $30, $02, $02, $fe, $05, $fb, $01, $f9, $38, $03, $02, $fe, $05, $03, $02
    db $03, $02, $fe, $08, $fb, $02, $f9, $30, $02, $02, $02, $02, $02, $02, $02, $02
    db $00, $04, $02, $02, $02, $02, $00, $04, $a0, $02, $a0, $97, $fe, $08, $02, $02
    db $fe, $05, $fb, $01, $f9, $38, $03, $02, $fe, $08, $fb, $02, $f9, $30, $02, $02
    db $fe, $05, $fb, $01, $f9, $38, $03, $02, $fe, $08, $fb, $02, $f9, $30, $02, $02
    db $fe, $05, $fb, $01, $f9, $38, $03, $02, $fe, $08, $fb, $02, $f9, $30, $02, $02
    db $fe, $05, $fb, $01, $f9, $38, $03, $02, $03, $02, $fe, $08, $fb, $02, $f9, $30
    db $02, $02, $00, $02, $fe, $05, $fb, $01, $f9, $38, $03, $02, $fe, $08, $fb, $02
    db $f9, $30, $02, $02, $00, $02, $02, $02, $02, $02, $a0, $d0, $ff

; Stage 3.
Stage3Music: ; $01:$6B60
    db $03 ; Playback tick interval minus one
    db $00 ; Priority

    dw $0000 ; Hardware channel 1: pulse 1 (unused)
    db $03 ; Software channel selector

    dw Stage3MusicStream2 ; Hardware channel 2: pulse 2
    db $00 ; Software channel selector

    dw Stage3MusicStream3 ; Hardware channel 3: wave
    db $01 ; Software channel selector

    dw Stage3MusicStream4 ; Hardware channel 4: noise
    db $02 ; Software channel selector

Stage3MusicStream2: ; $01:$6B6E-$6BDC
    db $f0, $03, $f4, $80, $fc, $0e, $fa, $07, $fd, $03, $fe, $0a, $00, $20, $fd, $00
    db $00, $20, $fd, $05, $39, $1c, $3b, $04, $40, $1c, $44, $04, $42, $18, $3b, $08
    db $37, $20, $39, $1c, $3b, $04, $40, $1c, $44, $04, $42, $18, $3b, $08, $37, $1c
    db $3b, $04, $42, $04, $00, $02, $40, $04, $00, $02, $44, $06, $42, $06, $3b, $04
    db $37, $04, $42, $04, $00, $02, $40, $04, $00, $02, $44, $06, $42, $06, $3b, $04
    db $40, $02, $42, $02, $42, $04, $00, $02, $40, $04, $00, $02, $44, $06, $42, $06
    db $3b, $04, $40, $04, $42, $04, $44, $04, $47, $04, $49, $20, $a0, $d1, $ff

Stage3MusicStream3: ; $01:$6BDD-$6CED
    db $f0, $03, $fe, $0f, $f2, $01, $fc, $0d, $fa, $05, $f8, $01, $fd, $05, $19, $02
    db $19, $02, $19, $02, $19, $02, $19, $02, $19, $02, $19, $02, $19, $02, $93, $f1
    db $19, $02, $19, $02, $19, $02, $00, $02, $19, $02, $19, $02, $19, $02, $00, $02
    db $19, $02, $19, $02, $00, $02, $19, $02, $19, $02, $19, $02, $19, $02, $00, $02
    db $17, $02, $17, $02, $17, $02, $00, $02, $17, $02, $17, $02, $17, $02, $00, $02
    db $17, $02, $17, $02, $00, $02, $17, $02, $17, $02, $17, $02, $17, $02, $00, $02
    db $15, $02, $15, $02, $00, $02, $00, $02, $15, $02, $15, $02, $00, $02, $15, $02
    db $15, $02, $15, $02, $15, $02, $15, $02, $00, $02, $00, $02, $15, $02, $15, $02
    db $17, $02, $17, $02, $17, $02, $00, $02, $17, $02, $17, $02, $17, $02, $00, $02
    db $17, $02, $17, $02, $17, $02, $17, $02, $00, $02, $17, $02, $17, $02, $00, $02
    db $91, $c0, $22, $02, $22, $02, $22, $02, $20, $02, $20, $02, $20, $02, $24, $02
    db $24, $02, $24, $02, $22, $02, $22, $02, $22, $02, $1b, $02, $1b, $02, $17, $02
    db $17, $02, $22, $02, $22, $02, $22, $02, $20, $02, $20, $02, $20, $02, $24, $02
    db $24, $02, $24, $02, $22, $02, $22, $02, $22, $02, $1b, $02, $1b, $02, $20, $02
    db $22, $02, $22, $02, $22, $02, $00, $02, $20, $02, $20, $02, $00, $02, $24, $02
    db $24, $02, $00, $02, $22, $02, $22, $02, $00, $02, $1b, $02, $1b, $02, $20, $02
    db $20, $02, $22, $02, $22, $02, $24, $02, $24, $02, $27, $02, $27, $02, $a0, $80
    db $ff

Stage3MusicStream4: ; $01:$6CEE-$6FCE
    db $f0, $03, $f8, $01, $fe, $06, $fd, $00, $fc, $00, $00, $1c, $fb, $02, $f9, $30
    db $02, $04, $fe, $05, $fb, $01, $f9, $38, $03, $02, $03, $02, $03, $02, $03, $02
    db $fe, $08, $fb, $02, $f9, $30, $02, $04, $00, $04, $fe, $05, $fb, $01, $f9, $38
    db $03, $02, $00, $02, $03, $02, $03, $02, $fe, $08, $fb, $02, $f9, $30, $02, $04
    db $00, $04, $fe, $05, $fb, $01, $f9, $38, $03, $02, $03, $02, $03, $02, $03, $02
    db $fe, $08, $fb, $02, $f9, $30, $02, $04, $fe, $05, $fb, $01, $f9, $38, $03, $02
    db $03, $02, $03, $02, $03, $02, $03, $02, $03, $02, $03, $02, $03, $02, $fe, $08
    db $fb, $02, $f9, $30, $02, $04, $fe, $05, $fb, $01, $f9, $38, $03, $02, $03, $02
    db $03, $02, $03, $02, $fe, $08, $fb, $02, $f9, $30, $02, $04, $fe, $05, $fb, $01
    db $f9, $38, $03, $02, $03, $02, $03, $02, $03, $02, $03, $02, $03, $02, $03, $02
    db $03, $02, $fe, $08, $fb, $02, $f9, $30, $02, $04, $a0, $02, $a0, $b3, $fe, $05
    db $fb, $01, $f9, $38, $03, $02, $03, $02, $03, $02, $03, $02, $fe, $08, $fb, $02
    db $f9, $30, $02, $04, $fe, $05, $fb, $01, $f9, $38, $03, $02, $03, $02, $fe, $05
    db $03, $02, $03, $02, $00, $04, $fe, $05, $03, $02, $03, $02, $03, $02, $00, $02
    db $fe, $05, $03, $02, $03, $02, $03, $02, $03, $02, $fe, $08, $fb, $02, $f9, $30
    db $02, $04, $fe, $05, $fb, $01, $f9, $38, $03, $02, $03, $02, $fe, $05, $03, $02
    db $03, $02, $00, $04, $fe, $08, $fb, $02, $f9, $30, $02, $04, $fe, $05, $fb, $01
    db $f9, $38, $03, $02, $03, $02, $fe, $05, $03, $02, $03, $02, $03, $02, $03, $02
    db $fe, $08, $fb, $02, $f9, $30, $02, $04, $02, $04, $fe, $05, $fb, $01, $f9, $38
    db $03, $02, $03, $02, $03, $02, $03, $02, $fe, $08, $fb, $02, $f9, $30, $02, $04
    db $fe, $05, $fb, $01, $f9, $38, $03, $02, $03, $02, $03, $02, $03, $02, $03, $02
    db $03, $02, $03, $02, $03, $02, $fe, $08, $fb, $02, $f9, $30, $02, $04, $fe, $05
    db $fb, $01, $f9, $38, $03, $02, $03, $02, $03, $02, $03, $02, $fe, $08, $fb, $02
    db $f9, $30, $02, $04, $fe, $05, $fb, $01, $f9, $38, $03, $02, $03, $02, $03, $02
    db $03, $02, $03, $02, $03, $02, $03, $02, $03, $02, $fe, $08, $fb, $02, $f9, $30
    db $02, $04, $a0, $02, $a0, $8c, $fe, $05, $fb, $01, $f9, $38, $03, $02, $03, $02
    db $03, $02, $03, $02, $fe, $08, $fb, $02, $f9, $30, $02, $04, $fe, $05, $fb, $01
    db $f9, $38, $03, $02, $03, $02, $fe, $05, $03, $02, $03, $02, $00, $04, $fe, $05
    db $03, $02, $03, $02, $03, $02, $00, $02, $fe, $05, $03, $02, $03, $02, $03, $02
    db $03, $02, $fe, $08, $fb, $02, $f9, $30, $02, $04, $fe, $05, $fb, $01, $f9, $38
    db $03, $02, $03, $02, $fe, $05, $03, $02, $03, $02, $00, $04, $fe, $08, $fb, $02
    db $f9, $30, $02, $04, $fe, $05, $fb, $01, $f9, $38, $03, $02, $03, $02, $fe, $05
    db $03, $02, $03, $02, $03, $02, $03, $02, $fe, $08, $fb, $02, $f9, $30, $02, $04
    db $02, $04, $fe, $05, $fb, $01, $f9, $38, $03, $02, $03, $02, $03, $02, $03, $02
    db $fe, $08, $fb, $02, $f9, $30, $02, $04, $fe, $05, $fb, $01, $f9, $38, $03, $02
    db $03, $02, $03, $02, $03, $02, $03, $02, $03, $02, $03, $02, $03, $02, $fe, $08
    db $fb, $02, $f9, $30, $02, $04, $fe, $05, $fb, $01, $f9, $38, $03, $02, $03, $02
    db $03, $02, $03, $02, $fe, $08, $fb, $02, $f9, $30, $02, $04, $fe, $05, $fb, $01
    db $f9, $38, $03, $02, $03, $02, $03, $02, $03, $02, $03, $02, $03, $02, $03, $02
    db $03, $02, $fe, $08, $fb, $02, $f9, $30, $02, $04, $a0, $02, $a0, $8c, $fe, $05
    db $fb, $01, $f9, $38, $03, $02, $03, $02, $03, $02, $03, $02, $fe, $08, $fb, $02
    db $f9, $30, $02, $04, $fe, $05, $fb, $01, $f9, $38, $03, $02, $03, $02, $fe, $05
    db $03, $02, $03, $02, $00, $04, $fe, $05, $03, $02, $03, $02, $03, $02, $00, $02
    db $fe, $05, $03, $02, $03, $02, $03, $02, $03, $02, $fe, $08, $fb, $02, $f9, $30
    db $02, $04, $fe, $05, $fb, $01, $f9, $38, $03, $02, $03, $02, $fe, $05, $03, $02
    db $03, $02, $00, $04, $fe, $08, $fb, $02, $f9, $30, $02, $04, $fe, $05, $a0, $cf
    db $ff

; Stage 5.
Stage5Music: ; $01:$6FCF
    db $03 ; Playback tick interval minus one
    db $00 ; Priority

    dw $0000 ; Hardware channel 1: pulse 1 (unused)
    db $03 ; Software channel selector

    dw Stage5MusicStream2 ; Hardware channel 2: pulse 2
    db $00 ; Software channel selector

    dw Stage5MusicStream3 ; Hardware channel 3: wave
    db $01 ; Software channel selector

    dw Stage5MusicStream4 ; Hardware channel 4: noise
    db $02 ; Software channel selector

Stage5MusicStream2: ; $01:$6FDD-$70B3
    db $f0, $03, $fe, $08, $f4, $80, $fd, $05, $fc, $0e, $fa, $06, $f8, $01, $ed, $01
    db $34, $1c, $35, $14, $30, $18, $32, $18, $29, $20, $34, $1c, $35, $14, $30, $18
    db $32, $18, $29, $20, $32, $1c, $34, $14, $35, $18, $34, $18, $32, $10, $2b, $08
    db $27, $08, $32, $1c, $34, $14, $35, $18, $34, $18, $32, $10, $27, $08, $2b, $08
    db $34, $1c, $35, $14, $30, $18, $32, $18, $29, $20, $34, $1c, $35, $14, $30, $18
    db $32, $18, $29, $20, $32, $1c, $34, $14, $35, $18, $34, $18, $32, $10, $2b, $08
    db $27, $08, $32, $1c, $34, $14, $35, $18, $34, $18, $32, $10, $27, $08, $2b, $08
    db $34, $1c, $35, $14, $30, $18, $32, $0c, $34, $04, $29, $28, $34, $1c, $35, $14
    db $30, $18, $32, $0c, $34, $04, $37, $10, $35, $18, $32, $1c, $37, $14, $32, $0c
    db $2b, $0c, $34, $0c, $32, $24, $37, $0c, $35, $0c, $34, $0c, $37, $18, $3b, $14
    db $40, $18, $42, $18, $44, $1c, $45, $14, $40, $18, $42, $18, $39, $20, $44, $1c
    db $45, $14, $40, $18, $42, $18, $39, $20, $42, $1c, $44, $14, $45, $18, $44, $18
    db $42, $10, $3b, $08, $37, $08, $42, $1c, $44, $14, $45, $18, $44, $18, $42, $10
    db $37, $08, $3b, $08, $a0, $9e, $ff

Stage5MusicStream3: ; $01:$70B4-$70E0
    db $f0, $03, $f2, $01, $fc, $0d, $fa, $07, $f8, $01, $fe, $0f, $ed, $01, $19, $04
    db $19, $04, $09, $02, $19, $02, $19, $02, $19, $02, $9f, $fa, $17, $04, $17, $04
    db $07, $02, $17, $02, $17, $02, $17, $02, $9f, $fa, $a0, $f2, $ff

Stage5MusicStream4: ; $01:$70E1-$70F7
    db $f8, $01, $fe, $06, $fb, $02, $f9, $30, $02, $04, $02, $04, $00, $02, $02, $02
    db $02, $02, $02, $02, $a0, $f8, $ff

; Stage 6.
Stage6Music: ; $01:$70F8
    db $04 ; Playback tick interval minus one
    db $00 ; Priority

    dw $0000 ; Hardware channel 1: pulse 1 (unused)
    db $03 ; Software channel selector

    dw Stage6MusicStream2 ; Hardware channel 2: pulse 2
    db $00 ; Software channel selector

    dw Stage6MusicStream3 ; Hardware channel 3: wave
    db $01 ; Software channel selector

    dw $0000 ; Hardware channel 4: noise (unused)

Stage6MusicStream2: ; $01:$7105-$72BD
    db $f0, $03, $fe, $0d, $f4, $80, $f8, $00, $fc, $0e, $fa, $05, $ed, $01, $00, $20
    db $00, $0e, $fd, $03, $39, $08, $00, $0a, $00, $0e, $3b, $08, $00, $08, $32, $04
    db $00, $04, $34, $02, $00, $02, $35, $14, $00, $20, $00, $0e, $39, $08, $00, $0a
    db $00, $0e, $40, $08, $00, $08, $32, $02, $00, $02, $34, $02, $00, $02, $35, $02
    db $37, $02, $00, $02, $32, $08, $00, $1a, $00, $20, $00, $0e, $39, $08, $00, $0a
    db $00, $0e, $3b, $08, $00, $08, $32, $04, $00, $04, $34, $02, $00, $02, $35, $14
    db $00, $20, $00, $0e, $39, $08, $00, $0a, $00, $0e, $40, $08, $00, $08, $32, $02
    db $00, $02, $34, $02, $00, $02, $35, $02, $37, $02, $00, $02, $40, $02, $00, $02
    db $42, $02, $00, $02, $44, $02, $00, $02, $47, $04, $00, $22, $a0, $02, $a0, $c0
    db $39, $02, $3b, $02, $40, $02, $39, $02, $00, $02, $42, $02, $00, $02, $44, $02
    db $00, $02, $47, $02, $00, $02, $49, $08, $00, $04, $39, $02, $3b, $02, $40, $02
    db $39, $02, $00, $02, $40, $02, $00, $02, $3b, $02, $00, $02, $47, $02, $00, $02
    db $50, $02, $00, $02, $4b, $04, $00, $04, $39, $02, $3b, $02, $40, $02, $39, $02
    db $00, $02, $42, $02, $00, $02, $44, $02, $00, $02, $47, $02, $00, $02, $49, $08
    db $00, $04, $39, $02, $3b, $02, $40, $02, $39, $02, $00, $02, $40, $02, $00, $02
    db $3b, $02, $00, $02, $47, $02, $00, $02, $50, $02, $00, $02, $4b, $04, $00, $04
    db $39, $02, $3b, $02, $40, $02, $39, $02, $00, $02, $42, $02, $00, $02, $44, $02
    db $00, $02, $47, $02, $00, $02, $49, $08, $00, $04, $39, $02, $3b, $02, $40, $02
    db $39, $02, $00, $02, $40, $02, $00, $02, $3b, $02, $00, $02, $47, $08, $00, $08
    db $39, $02, $3b, $02, $40, $02, $39, $02, $00, $02, $42, $02, $00, $02, $44, $02
    db $00, $02, $47, $02, $00, $02, $49, $08, $00, $04, $a0, $02, $a0, $a1, $39, $02
    db $3b, $02, $40, $02, $39, $02, $00, $02, $40, $02, $00, $02, $3b, $02, $00, $02
    db $47, $02, $00, $02, $50, $02, $00, $02, $4b, $04, $00, $04, $39, $02, $3b, $02
    db $40, $02, $39, $02, $00, $02, $42, $02, $00, $02, $44, $02, $00, $02, $47, $02
    db $00, $02, $49, $08, $00, $04, $39, $02, $3b, $02, $40, $02, $39, $02, $00, $02
    db $40, $02, $00, $02, $3b, $02, $00, $02, $47, $08, $00, $08, $39, $02, $3b, $02
    db $40, $02, $39, $02, $00, $02, $42, $02, $00, $02, $44, $02, $00, $02, $47, $02
    db $00, $02, $49, $08, $00, $04, $a0, $cb, $ff

Stage6MusicStream3: ; $01:$72BE-$72D0
    db $f0, $03, $f2, $01, $f8, $01, $fc, $0b, $fa, $04, $fe, $0f, $ed, $01, $19, $02
    db $a0, $ff, $ff


PlayerFiringSound: ; $01:$72D1
    db $01 ; Playback tick interval minus one
    db $00 ; Priority

    dw PlayerFiringSoundStream1 ; Hardware channel 1: pulse
    db $04 ; Software channel selector

    dw $0000 ; Hardware channel 2 unused
    db $00 ; Software channel selector

    dw $0000 ; Hardware channel 3 unused
    db $01 ; Software channel selector

    dw $0000 ; Hardware channel 4 unused

PlayerFiringSoundStream1: ; $01:$72DE-$72EE
    db $f0, $03, $f5, $2e, $f4, $40, $fc, $0d, $fa, $06, $fe, $0a, $fd, $01, $60, $04
    db $ff

MaxPowerFiringSound: ; $01:$72EF
    db $02 ; Playback tick interval minus one
    db $00 ; Priority

    dw MaxPowerFiringSoundStream1 ; Hardware channel 1: pulse
    db $04 ; Software channel selector

    dw $0000 ; Hardware channel 2 unused
    db $00 ; Software channel selector

    dw $0000 ; Hardware channel 3 unused
    db $01 ; Software channel selector

    dw $0000 ; Hardware channel 4 unused

MaxPowerFiringSoundStream1: ; $01:$72FC-$7310
    db $f0, $03, $fe, $08, $f5, $2f, $fc, $0f, $fd, $08, $fa, $01, $f4, $80, $f8, $00
    db $57, $04, $00, $02, $ff

; Played by CheckForNewEnemyDamage when new damage is detected and sound is allowed.
BossDamageSound: ; $01:$7311
    db $03 ; Playback tick interval minus one
    db $00 ; Priority

    dw BossDamageSoundStream1 ; Hardware channel 1: pulse
    db $04 ; Software channel selector

    dw $0000 ; Hardware channel 2 unused
    db $00 ; Software channel selector

    dw $0000 ; Hardware channel 3 unused
    db $01 ; Software channel selector

    dw $0000 ; Hardware channel 4 unused

BossDamageSoundStream1: ; $01:$731E-$732C
    db $f0, $03, $f5, $08, $f4, $00, $fb, $02, $fe, $07, $fd, $01, $60, $04, $ff

DefeatSound0: ; $01:$732D; defeat sound index $00
    db $03 ; Playback tick interval minus one
    db $00 ; Priority

    dw $0000 ; Hardware channel 1 unused
    db $00 ; Software channel selector

    dw $0000 ; Hardware channel 2 unused
    db $01 ; Software channel selector

    dw $0000 ; Hardware channel 3 unused
    db $02 ; Software channel selector

    dw DefeatSound0Stream4 ; Hardware channel 4: noise
    db $05 ; Software channel selector

DefeatSound0Stream4: ; $01:$733B-$734B
    db $f0, $03, $fe, $0c, $f1, $77, $fd, $05, $fb, $01, $f9, $04, $10, $02, $00, $02
    db $ff

; Used for Xenocrypt part destruction and shared boss-destruction smoke effects.
BossPartDestructionSound: ; $01:$734C
    db $02 ; Playback tick interval minus one
    db $02 ; Priority

    dw $0000 ; Hardware channel 1 unused
    db $00 ; Software channel selector

    dw $0000 ; Hardware channel 2 unused
    db $01 ; Software channel selector

    dw $0000 ; Hardware channel 3 unused
    db $02 ; Software channel selector

    dw BossPartDestructionSoundStream4 ; Hardware channel 4: noise
    db $05 ; Software channel selector

BossPartDestructionSoundStream4: ; $01:$735A-$739A
    db $fe, $0b, $fd, $02, $f0, $03, $10, $02, $fe, $09, $f0, $01, $10, $02, $fe, $06
    db $f0, $02, $10, $02, $fe, $09, $fd, $04, $f0, $03, $10, $04, $fe, $09, $f0, $01
    db $10, $06, $fe, $06, $f0, $03, $10, $04, $f0, $01, $10, $01, $f0, $03, $10, $01
    db $f0, $02, $10, $01, $f0, $03, $fe, $03, $10, $06, $fe, $01, $fd, $00, $10, $04
    db $ff

PlayerDeathSound: ; $01:$739B
    db $03 ; Playback tick interval minus one
    db $03 ; Priority

    dw $0000 ; Hardware channel 1 unused
    db $00 ; Software channel selector

    dw $0000 ; Hardware channel 2 unused
    db $01 ; Software channel selector

    dw $0000 ; Hardware channel 3 unused
    db $02 ; Software channel selector

    dw PlayerDeathSoundStream4 ; Hardware channel 4: noise
    db $05 ; Software channel selector

PlayerDeathSoundStream4: ; $01:$73A9-$73D7
    db $fe, $0f, $fd, $02, $f0, $03, $fb, $07, $f9, $04, $0f, $0f, $fe, $0d, $f0, $01
    db $0f, $06, $fe, $08, $f0, $02, $0f, $04, $f0, $01, $0f, $02, $f0, $02, $0f, $01
    db $f0, $01, $0f, $01, $f0, $01, $0f, $01, $fe, $04, $f0, $03, $0f, $08, $ff

DefeatSound1: ; $01:$73D8; defeat sound index $01
    db $01 ; Playback tick interval minus one
    db $01 ; Priority

    dw DefeatSound1Stream1 ; Hardware channel 1: pulse
    db $04 ; Software channel selector

    dw $0000 ; Hardware channel 2 unused
    db $01 ; Software channel selector

    dw $0000 ; Hardware channel 3 unused
    db $02 ; Software channel selector

    dw $0000 ; Hardware channel 4 unused

DefeatSound1Stream1: ; $01:$73E5-$73FF
    db $fe, $08, $f5, $0d, $fc, $00, $fb, $02, $f8, $00, $f0, $03, $f4, $40, $60, $01
    db $50, $01, $57, $01, $47, $01, $59, $01, $49, $01, $ff

DefeatSound2: ; $01:$7400; defeat sound index $02
    db $00 ; Playback tick interval minus one
    db $01 ; Priority

    dw DefeatSound2Stream1 ; Hardware channel 1: pulse
    db $04 ; Software channel selector

    dw $0000 ; Hardware channel 2 unused
    db $01 ; Software channel selector

    dw $0000 ; Hardware channel 3 unused
    db $02 ; Software channel selector

    dw $0000 ; Hardware channel 4 unused

DefeatSound2Stream1: ; $01:$740D-$7449
    db $fe, $08, $f5, $08, $fc, $00, $fb, $05, $f8, $00, $f0, $03, $f4, $40, $ed, $f4
    db $60, $01, $70, $01, $5b, $01, $6b, $01, $4a, $01, $5a, $01, $59, $01, $69, $01
    db $57, $01, $67, $01, $56, $01, $66, $01, $55, $01, $65, $01, $54, $01, $64, $01
    db $50, $01, $60, $01, $49, $01, $59, $01, $47, $01, $57, $01, $ff

DefeatSound3: ; $01:$744A; defeat sound index $03
    db $03 ; Playback tick interval minus one
    db $01 ; Priority

    dw $0000 ; Hardware channel 1 unused
    db $00 ; Software channel selector

    dw $0000 ; Hardware channel 2 unused
    db $01 ; Software channel selector

    dw $0000 ; Hardware channel 3 unused
    db $02 ; Software channel selector

    dw DefeatSound3Stream4 ; Hardware channel 4: noise
    db $05 ; Software channel selector

DefeatSound3Stream4: ; $01:$7458-$7464
    db $fe, $07, $fd, $02, $f0, $03, $fb, $05, $f9, $04, $0e, $0d, $ff

    rst $10
    jp $d665


    push de
    ld c, a
    push de
    cp c
    ld d, c
    ei
    ld [hl], l
    rst $38
    push hl
    cp $15
    ld a, e
    dec [hl]
    ld e, a
    sub h
    ld h, h
    ld e, c
    rst $38
    ld d, l
    cp l
    add c
    db $fd
    scf
    add a
    dec [hl]
    ccf
    push de
    cp a
    rst $10
    rst $38
    ld e, c
    ld l, e
    dec d
    rst $38
    ld d, l
    cp a
    ld h, e
    rst $18
    ld b, l
    xor a
    ld d, l
    ld a, a
    ld d, [hl]
    rst $38
    ld c, a
    rra
    db $fd
    sbc $74
    xor $5c
    xor $f7
    ld a, a
    ld e, a
    ld a, c
    db $dd
    cp l
    rst $10
    push bc
    ld e, l
    or l
    ld e, a
    or a
    ld d, a
    ld a, [$fb5f]
    inc de
    or l
    db $dd
    push af
    ld d, a
    db $fd
    ld a, [hl]
    rst $18
    db $fd
    pop hl
    push bc
    ld a, $5d
    cp e
    ld e, l
    rst $28
    ld b, e
    ld e, a
    sub c
    sbc a
    ld c, l
    rst $30
    xor l
    rst $38
    ld l, l
    rst $18
    push de
    rst $28
    ld e, a
    sbc e
    ld a, h
    ld h, a
    ld [hl], l
    rst $20
    adc b
    sbc a
    ld b, l
    rst $20
    ld [hl], a
    ld l, [hl]
    rst $28
    rst $30
    ld e, h
    sbc a
    ld e, c
    sbc a
    ld d, l
    ld a, a
    dec [hl]
    cp a
    rlca
    db $fd
    ld [hl], l
    sbc $4f
    rst $38
    ld [hl], l
    rst $38
    ld d, l
    rst $38
    or a
    di
    push de
    ld sp, hl
    db $dd
    rra
    ld [hl], l
    rst $38
    ld e, l
    rst $18
    push af
    ld a, a
    ld d, a
    ld e, b
    xor e
    rst $38
    ld d, c
    cp a
    ld e, l
    rst $38
    ld b, [hl]
    rst $20
    ld [hl], h
    sbc [hl]
    jp Stage8MusicStream2 + $2d


    db $fd
    ld h, h
    pop bc
    db $dd
    rst $28
    push af
    ld a, l
    push de
    ld a, l
    ld d, l
    adc $dd
    cp $51
    db $dd
    ld de, $fcd9
    cp l
    ld a, a
    cp $55
    db $dd
    dec d
    rst $38
    ld d, l
    ld l, [hl]
    ld d, a
    rst $38
    ld d, l
    db $fc
    inc d
    db $fd
    push af
    and e
    db $fd
    ld [hl], a
    ld d, l
    ld a, [hl]
    ld h, l
    cp [hl]
    ld d, c
    rst $28
    ld e, c
    ld a, a
    ld d, c
    ld sp, hl
    push de
    scf
    ld [hl], h
    push af
    db $57, $cd, $54, $53, $55
    db $fd
    ld e, a
    cpl
    add a
    rst $28
    ld [hl], h
    ei
    ld e, $7e
    ld b, c
    rst $28
    ld h, l
    cp a
    inc e
    ccf
    ld d, l
    rst $38
    rst $10
    ld sp, hl
    call $d5fa
    ld e, a
    ld [hl], l
    ld h, c
    ld [hl], b
    rst $18
    ld b, l
    rst $30
    ld a, l
    ld [hl], e
    ld d, c
    ld sp, hl
    add hl, de
    ld a, a
    ld d, a
    rst $18
    ld e, a
    ld a, [hl-]
    or e
    rst $38
    ld d, l
    db $fd
    ld b, l
    cp $d5
    cp [hl]
    ld a, l
    and a
    ld d, h
    rst $30
    ld e, a
    rst $38
    ld d, [hl]
    sbc $d5
    ld a, e
    ld e, b
    jp z, $f401

    ld c, h
    db $db
    rra
    ldh [$ffc7], a
    adc e
    ld [hl], a
    adc $53
    ld a, e
    ld d, l
    scf
    ld b, h
    cp a
    ld d, a
    dec c
    ld e, l
    rst $38
    ld e, b
    push af
    ld a, c
    dec sp
    ld b, l
    dec de
    ld e, c
    db $fd
    ld e, l
    or $5d
    ld a, a
    inc [hl]
    ld a, a
    ld e, l
    ld a, a
    ld d, c
    xor a
    ld b, h
    ld sp, hl
    ld d, l
    cp a
    or l
    rst $30
    ld d, l
    sbc $f5
    rst $38
    ret nc

    sub a
    or l
    ld a, d
    dec e
    cp l
    ld a, h
    rst $38
    sub l
    ld a, [$6f5c]
    inc d
    sbc [hl]
    ld [hl], a
    sub b
    push af
    rst $38
    ld c, c
    ld l, l
    rla
    xor a
    pop af
    ld l, b
    ld [hl], l
    ld a, a
    ld a, l
    rst $38
    ld e, l
    rst $38
    inc e
    xor a
    push bc
    ld [hl], a
    ld b, c
    ld e, c
    ld d, l
    ld l, $75
    rst $38
    ld [hl], l
    ld a, [$ff77]
    ld b, l
    sbc d
    ld [hl], a
    rst $38
    ld e, $fd
    ld a, l
    rst $28
    rst $18
    rst $38
    ld [hl], c
    rst $18
    ld a, b
    rst $18
    or l
    cpl
    dec d
    ei
    push af
    ei
    ld e, l
    db $f4
    ld e, l
    rst $38
    ld e, a
    ei
    ld e, l
    pop af
    ld d, e
    rst $10
    ld a, l
    or l
    ld [hl], c
    ld a, [hl]
    ld d, l
    rst $38
    ld d, a
    or a
    rst $10
    cp c
    ld e, a
    ld a, a
    ld b, c
    sbc c
    dec e
    rst $38
    jr @+$01

    ld e, l
    ei
    ld d, d
    db $dd
    ld l, a
    rst $38
    ld [hl], l
    ei
    ld d, c
    rst $28
    ld h, l
    ld hl, $ca5c
    ret nz

    dec l
    ld h, l
    cp $1d
    ld c, $b1
    db $fd
    dec d
    and [hl]
    ld [hl], l
    cp $6f
    rst $38
    sbc $ff
    ld d, l
    db $dd
    ld [hl], b
    rst $30
    ld [hl], l
    rst $28
    db $db
    ld e, a
    ld d, l
    ld hl, $1995
    dec h
    db $ed
    inc sp
    cp a
    ld e, a
    ld h, a
    ld d, a
    xor c
    push bc
    ld a, c
    dec c
    rst $38
    halt
    or $5c
    rst $18
    ld [hl], d
    rst $38
    ld [hl], b
    rst $18
    ld e, l
    rst $38
    ld d, a
    ld a, a
    ld l, c
    cp e
    push de
    rst $30
    ld d, l
    adc a
    ld d, l
    cp $60
    db $fd
    or l
    sbc [hl]
    ld d, [hl]
    ld a, a
    ld e, l
    db $d3
    ld b, l
    rst $30
    reti


    ei
    dec e
    sub a
    db $fc
    rst $30
    rst $30
    ld a, [hl]
    ld a, c
    rst $18
    ld d, a
    ccf
    ld e, c
    scf
    ld d, c
    ld e, a
    ld e, l
    ld e, a
    ld d, e
    rst $38
    ld [hl], l
    db $fc
    ld d, d
    rst $28
    add hl, de
    cp a
    push de
    db $db
    ld d, b
    ld h, a
    sub l
    rst $18
    rlca
    cp l
    ld e, e
    cp a
    ld [de], a
    cp $55
    ld l, l
    ld d, [hl]
    push af
    ld d, a
    ccf
    add l
    xor d
    sbc l
    adc d
    ld a, l
    rst $08
    ld a, [hl]
    or a
    dec d
    rst $28
    ld d, h
    ei
    dec e
    cp a
    push de
    rst $28
    halt
    ld c, [hl]
    ld a, l
    ld l, a
    call z, $546e
    ld h, d
    dec d
    rst $30
    rst $00
    ld a, a
    inc e
    rst $18
    ld b, l
    xor c
    rst $28
    or $b5
    cp a
    ld [hl], l
    and $77
    db $ed
    ld d, l
    dec a
    ld d, e
    cp e
    ld d, l
    rst $28
    ld d, h
    rst $38
    ld e, l
    rst $00
    ld [hl], c
    reti


    dec h
    push hl
    dec c
    jp Stage4MusicStream4 + $3e4


    ld d, e
    rst $38
    ld e, a
    db $eb
    rst $38
    or $41
    ei
    ld b, l
    ld a, l
    ld a, c
    ld [$db55], a
    dec b
    cp l
    rst $30
    di
    ld e, l
    cp [hl]
    rla
    xor a
    dec [hl]
    ld sp, hl
    ld d, l
    ld a, e
    ld [hl], l
    db $dd
    ld e, l
    ld l, e
    ld b, l
    ld [$075a], sp
    ld [hl], c
    ei
    ld d, [hl]
    rst $20
    ld c, c
    rst $38
    ld e, b
    rst $38
    db $fd
    db $eb
    ld e, l
    sub $05
    xor [hl]
    db $fd
    ld a, a
    ld d, l
    rst $38
    rst $30
    push hl
    ld a, l
    cp $5f
    or $71
    ld sp, hl
    add l
    rst $18
    sub [hl]
    sbc d
    pop bc
    rst $38
    pop de
    cp a
    ld e, l
    or l
    ld d, a
    rst $10
    rra
    jp c, $ff75

    db $d3
    rst $38
    ld b, l
    db $ed
    call nc, $ddfd
    rst $18
    ld e, a
    db $fd
    ldh [c], a
    rlca
    sub $6f
    ld [hl], b
    rst $30
    ld a, [hl]
    push hl
    ld c, l
    rst $38
    scf
    di
    ld d, a
    daa
    ld a, l
    rst $18
    ld b, l
    ld a, a
    push de
    rst $38
    ld e, a
    pop af
    sub a
    rst $38
    ld a, l
    ld [hl], a
    and a
    ld sp, hl
    ld l, a
    rst $10
    ld a, c
    rst $38
    sbc a
    ld a, b
    ld e, c
    ld a, a
    ld d, l
    ld e, [hl]
    ld e, h
    or e
    ld d, l
    db $fd
    ld b, l
    ei
    ld a, l
    rst $18
    ld b, e
    ld c, e
    db $dd
    ld b, c
    ld d, [hl]
    ld l, a
    ld d, l
    or $c4
    ld a, a
    ld d, c
    rst $18
    dec l
    call $e744
    sub [hl]
    rst $38
    cp $fd
    scf
    adc d
    ld e, a
    ld a, a
    reti


    rst $38
    inc d
    rst $38
    ld e, h
    xor a
    ld l, d
    ld l, a
    rst $10
    pop af
    push de
    ld a, e
    or c
    cp a
    inc d
    ei
    dec d
    rst $38
    ld [hl], l
    rst $10
    push de
    cp $e5
    ret nc

    ld d, l
    db $ed
    ld de, $45be
    ei
    ld e, l
    pop de
    inc b
    sbc e
    ld d, c
    ld l, h
    ld d, a
    ld d, a
    ld d, l
    ccf
    db $fd
    rst $18
    ld a, l

jr_001_7784:
    ld a, e
    dec h
    ei
    push de
    bit 2, l
    rst $38
    push af
    ld a, a
    ld d, c
    db $fd
    dec b
    rst $18
    ld d, l
    ld [hl], a
    ld b, h
    rst $30
    ld bc, $53fd
    pop de
    ld e, l
    call nz, $8e7d
    ld c, c
    cp l
    ld e, a
    rst $18
    ld d, l
    or $95
    xor $55
    call c, $bf41
    sbc l
    ei
    ld e, l
    pop af
    rla
    cp $0b
    ld a, a
    ld e, l
    rst $18
    ld d, c
    ld a, e
    ld d, [hl]
    or a
    ld c, h
    ld l, [hl]
    ld e, b
    db $fd
    push de
    ld a, l
    add hl, de
    cp $f5
    rst $28
    dec h
    rst $30
    ld e, l
    db $fd
    ld e, l
    dec sp
    ld b, h
    db $dd
    db $ed
    rst $38
    ld c, l
    jp hl


    sub [hl]
    ld l, l
    ld d, l
    push af
    ld b, l
    rst $18
    rst $30
    xor $fd
    cp e
    ld [hl], l
    cp a
    dec d
    pop de
    sub $df
    rla
    ei
    ld e, [hl]
    rst $38
    ld e, l
    ld e, a
    sub l
    rst $38
    ld d, l
    ld a, a
    ld d, l

jr_001_77e8:
    sub $d5
    db $e3
    ld a, l
    db $fd
    ld d, l
    rst $38
    db $dd
    xor a
    rst $30
    rst $30
    ld [hl], l
    ei
    ld b, l
    rst $18
    pop hl
    cp a
    ld d, l
    db $fd
    ld e, h
    rst $30
    rst $18
    rst $30
    rla
    ld [bc], a
    sub [hl]
    jr z, jr_001_7784

    add b
    ld de, $0400
    nop
    db $10
    add b
    ldh [rP1], a

jr_001_780d:
    ld b, d
    nop
    ld c, [hl]
    ld a, [bc]
    ld l, b
    ld [$0202], sp
    ld b, $28
    add $08
    ld e, $22
    add h
    nop
    adc b
    xor b
    ld [de], a
    jr z, jr_001_7864

    jr nz, jr_001_7898

    nop
    inc b
    jr z, jr_001_7838

    ld [hl+], a
    db $e4
    add b
    inc c
    ld [bc], a
    ld d, $2a
    ld b, h
    adc b
    sub d
    nop
    jr z, jr_001_7835

jr_001_7835:
    rra
    ld a, [bc]
    inc b

jr_001_7838:
    ld [bc], a
    jr z, jr_001_7843

    ld de, $c2a2
    adc b
    ld sp, hl
    nop
    add b
    nop

jr_001_7843:
    db $10
    inc b
    nop
    jr z, jr_001_7889

jr_001_7848:
    and b
    ld [hl+], a
    and b
    ld [de], a
    ld a, [bc]
    ld e, b
    jr nz, @-$3b

    add d
    dec de
    jr nz, jr_001_7848

    ld [hl+], a
    xor e
    jr nz, jr_001_77e8

    xor d
    ld [$e008], sp
    add b
    jr z, @+$24

    xor d
    nop
    nop

jr_001_7862:
    add b
    db $10

jr_001_7864:
    add b
    ld b, b
    ld [bc], a
    inc b
    nop
    ld [$b0a2], sp
    nop
    cp h
    and d
    db $ec
    add b
    ld c, d
    ld [$caa4], sp
    db $10
    ld a, [hl+]
    or h
    xor d
    db $fd
    jr z, jr_001_780d

    add b
    inc de
    ld [bc], a
    ld [$0820], sp
    nop
    ld de, $0600
    ld [$0006], sp

jr_001_7889:
    ld [$0188], sp
    ld [hl+], a
    ret nz

    nop
    or c
    nop
    db $10
    ld [$80c8], sp
    inc b
    add d
    inc c

jr_001_7898:
    add d
    or b
    ld [bc], a
    add d
    and d
    ld [$1c80], sp
    nop
    nop
    add d
    inc d
    ld [bc], a
    sbc b
    nop
    ld b, b
    jr nz, jr_001_78cf

    ld a, [bc]
    ld de, $02a8
    jr nz, @-$74

jr_001_78b0:
    and b
    dec bc
    ld a, [hl+]
    ld sp, hl
    add d
    db $fc
    adc b
    ld l, $20
    inc bc
    jr z, jr_001_78b0

    and b
    ld d, $28
    ld l, c
    nop
    add h
    jr nz, jr_001_78ea

    nop
    ld [$0000], sp
    jr nz, jr_001_7862

    jr z, jr_001_78ed

    ld [$88a0], sp

jr_001_78cf:
    ld b, [hl]
    jr z, @+$62

    nop
    ld d, d
    ld [bc], a
    ld b, l

jr_001_78d6:
    jr z, jr_001_78e8

    nop
    ret nz

    ld a, [hl+]
    ld [hl], a
    nop
    ld l, b
    jr nz, jr_001_78cf

    nop
    add l
    ld b, b
    sub $4a
    sbc a
    nop
    inc b

jr_001_78e8:
    add b
    add b

jr_001_78ea:
    nop
    inc [hl]
    adc b

jr_001_78ed:
    ld de, $5e00
    nop
    dec [hl]
    and b
    sbc h
    ld a, [bc]
    adc c
    ld [$0021], sp
    jr z, @+$22

    inc de
    nop
    add b
    ld [hl+], a
    ld a, [bc]
    ld [$a000], sp
    nop
    nop
    ld b, b
    nop
    add h
    add b
    sbc a
    adc b
    ld b, h
    ld a, [bc]
    ld b, e
    nop
    dec b
    nop
    ld b, $28
    ld [$6200], sp
    nop
    sub d
    jr nz, jr_001_798d

    jr nz, jr_001_7964

    nop
    add h
    ld a, [hl+]
    add hl, hl
    add b
    ldh [rSC], a
    ld [$6088], sp
    nop
    ld b, b
    add d
    and b
    nop
    and b
    adc d
    ld bc, $1320
    ld hl, $80a9
    ld e, h
    and b
    sbc e
    add d
    ld h, $88
    inc de
    ld [hl+], a
    ld c, d
    add b
    ret c

    ld [$80b3], sp
    jr jr_001_794b

    inc b
    jr z, jr_001_78d6

    jr nz, jr_001_7948

jr_001_7948:
    jr nz, jr_001_7957

    nop

jr_001_794b:
    inc c
    ld [bc], a
    stop
    xor l
    ld [hl+], a
    ret z

    nop
    pop bc
    jr nz, jr_001_78ea

    ld [bc], a

jr_001_7957:
    ld [$5f22], sp
    nop
    ret c

    nop
    ld h, l
    ld [hl+], a
    and d

jr_001_7960:
    ld [$0080], sp
    pop bc

jr_001_7964:
    and b
    nop
    xor b
    call nz, $c820
    jr nz, jr_001_79c1

    and b
    dec b
    ld [bc], a
    ld [hl-], a
    ld [$8235], sp
    ldh a, [$ff2a]
    inc c
    and d
    cp h
    xor b
    ld a, c
    jr nz, jr_001_7960

    ld [$8a5a], sp
    ld a, [bc]
    nop
    ld b, c
    jr z, jr_001_79c7

    add b
    ld b, d
    ld a, [hl+]
    nop
    nop
    ld b, b
    jr nz, @+$42

    xor b

jr_001_798d:
    ld bc, $8420
    add d
    add hl, bc
    nop
    sbc c

jr_001_7994:
    nop
    add h
    add h
    ld [hl], e
    ld [$0814], sp
    ret nz

    adc d
    ret nz

    ld a, [bc]
    jp hl


    nop
    ret nz

    add d
    ld d, h

jr_001_79a4:
    jr z, jr_001_79a8

    jr nz, jr_001_7a0c

jr_001_79a8:
    add b
    cp c
    nop
    ld a, [hl+]
    adc d
    add l
    nop
    inc [hl]

jr_001_79b0:
    jr nz, jr_001_79c2

    and d
    ldh [rP1], a
    add d
    ld [$804c], sp
    jr nc, jr_001_79db

    inc b
    xor b
    db $f4
    nop
    inc [hl]
    add b

jr_001_79c1:
    add b

jr_001_79c2:
    and b
    adc b
    ld a, [bc]

jr_001_79c5:
    or $80

jr_001_79c7:
    ld de, $e082
    nop
    ld bc, $a320
    jr z, @+$72

    add d
    nop
    adc b
    db $10
    jr z, jr_001_79d6

jr_001_79d6:
    ld [hl+], a
    ld [hl], b
    jr nz, @+$47

jr_001_79da:
    ld [bc], a

jr_001_79db:
    sbc b
    jr z, @+$07

    nop
    inc b
    ld [bc], a
    ld bc, $0082
    nop
    ld e, c
    ld [bc], a
    ld b, d
    add b
    pop bc
    nop
    or c
    add b
    add hl, bc
    ld a, [bc]
    jr nz, @+$0a

    add hl, bc
    ld a, [bc]
    add h
    adc d
    ld h, e
    ld a, [bc]
    jp nz, $e020

    ld a, [de]
    ld b, b
    jr z, @-$62

    add b
    sub c
    ld [hl+], a
    inc c
    nop
    ld [hl], b
    nop
    ld d, b
    ld [bc], a
    ld b, l
    nop
    inc sp
    jr nz, jr_001_79a4

jr_001_7a0c:
    nop
    ld a, [bc]

jr_001_7a0e:
    jr z, jr_001_79b0

    jr z, jr_001_7994

    add b

jr_001_7a13:
    jp Jump_000_168a


    and b
    ld h, h

jr_001_7a18:
    jr nz, jr_001_7a80

    ld [hl+], a
    ld b, b

jr_001_7a1c:
    adc d
    add c
    jr z, jr_001_79c5

    nop
    nop
    jr nz, jr_001_79a8

    nop
    ld c, b
    ld [bc], a
    nop
    jr nz, jr_001_7a2a

jr_001_7a2a:
    add d
    ld l, c
    jr z, jr_001_7a4a

    add d
    inc bc
    ld a, [hl+]
    ld l, h
    add b
    jr jr_001_7a35

jr_001_7a35:
    ld e, h
    and d
    ld h, d
    jr z, jr_001_7a7e

    adc d
    db $10
    jr z, jr_001_7a52

    ld [$0060], sp
    ld [bc], a
    nop
    add b
    nop
    cp b
    ld a, [bc]

jr_001_7a47:
    add b
    add d
    inc d

jr_001_7a4a:
    jr z, jr_001_79da

    nop
    dec d
    xor b
    ld hl, $a222

jr_001_7a52:
    ld [hl+], a
    nop
    nop
    adc h
    xor b
    ld h, $a0
    add b
    nop
    inc bc
    ld [bc], a
    ld e, c
    ld [$80b0], sp
    ret nz

    ld [hl+], a
    nop
    add b
    ld d, d
    nop
    sub h
    ld [$a00e], sp
    add b
    jr nz, jr_001_7a0e

    nop
    ret nc

    and b
    jr nc, jr_001_7a13

    dec c
    jr z, jr_001_7aa4

    jr z, jr_001_7a18

    and b
    ld h, h
    ld a, [bc]
    ld [hl], c
    add d
    xor h

jr_001_7a7e:
    jr z, jr_001_7a1c

jr_001_7a80:
    nop
    ld [$0808], sp
    ld [hl+], a
    ld b, d
    ld [hl+], a
    jr nz, @+$2a

jr_001_7a89:
    ld b, b
    nop
    jp nz, AudioVolumeSequence01 + 5

    ld a, [bc]
    sbc c
    add b
    inc sp
    adc b
    ld h, d
    add d
    rst $20
    jr nz, jr_001_7af8

    add d
    ld c, $20
    xor b
    nop
    cp d
    jr nz, jr_001_7aad

    add b
    add c
    adc b
    ld [de], a

jr_001_7aa4:
    ld a, [hl+]
    and $a0
    ld d, b
    ld [bc], a
    cp b
    nop
    ld b, [hl]
    add b

jr_001_7aad:
    ld l, b
    add d
    ld h, b

jr_001_7ab0:
    ld [$288c], sp
    and b
    sub d
    adc h
    adc b
    db $10
    ld l, b
    add hl, hl
    ld a, [hl+]
    ld b, b
    add d
    ld l, l
    adc b
    ld b, b
    ld [$0250], sp
    jr nz, jr_001_7a47

    add h
    jr nz, jr_001_7a89

    jr z, jr_001_7ab0

    and b
    ld [$9008], sp
    ld a, [bc]
    ld bc, $c180

jr_001_7ad2:
    ld [bc], a
    and d
    and b
    ld c, b
    nop
    and [hl]
    adc b
    jr nc, jr_001_7ae3

    ld c, b
    add b
    rla
    adc d
    adc b
    nop
    ld b, c
    nop

jr_001_7ae3:
    ld b, h
    adc b
    inc b
    nop
    jr @-$7e

    adc h
    nop
    nop
    xor d
    ld [$8b00], sp
    nop
    and b
    xor b
    add c
    nop
    inc l
    nop
    add h

jr_001_7af8:
    and d
    or d
    ld a, [bc]
    sub [hl]
    and b
    ldh [rNR23], a
    ld b, [hl]
    nop
    jr nz, @+$22

    ld h, c
    add b
    ld bc, $8100
    ld [bc], a
    adc b
    add b
    ret nz

    add d
    ld bc, $1000
    jr nz, jr_001_7b13

    add b

jr_001_7b13:
    add c
    ld a, [hl+]
    ld de, $5002
    add d
    ld hl, $6228
    ld a, [bc]
    add c
    and d
    nop
    ld [hl+], a
    add b
    jr nz, jr_001_7b28

    jr nz, jr_001_7b26

jr_001_7b26:
    add b
    add b

jr_001_7b28:
    add d
    ld l, [hl]

jr_001_7b2a:
    add b
    sub d
    add d
    ld e, b
    add d
    jr nz, jr_001_7ad2

    cp l
    add d
    nop
    adc b
    add l
    ld [bc], a
    sub [hl]
    add b
    dec hl
    xor d
    nop
    and b
    db $eb
    ld a, [bc]
    ret nz

    jr nz, jr_001_7b42

jr_001_7b42:
    jr nz, jr_001_7b7c

    nop
    rla
    ld [bc], a
    ld a, [bc]
    add b
    inc d
    adc b
    add l
    nop
    ld a, e
    nop
    jr c, jr_001_7b71

    res 4, b
    ld b, $00
    inc h
    nop
    sub d
    adc b
    inc d
    nop
    ld b, d
    add b
    ld d, $02
    nop
    and b
    add c
    nop
    add b
    xor b
    add c
    ld [bc], a
    db $10
    add b
    pop de
    ld [$a880], sp
    ret


    adc b
    sub l
    add b

jr_001_7b71:
    ret nc

    and b
    ld a, [bc]
    ld [bc], a
    db $10
    jr z, @+$81

    and d
    ld c, e
    xor d
    ld c, d

jr_001_7b7c:
    adc b
    sbc c
    ld [hl+], a
    jr @+$0c

    ld [hl-], a
    jr nz, jr_001_7b96

    ld [$0059], sp
    ld d, b
    add b
    ld [$04a2], sp
    jr nz, jr_001_7bae

    nop
    ld e, d
    ld [hl+], a
    inc b
    and d
    ld c, [hl]
    jr z, @+$3b

jr_001_7b96:
    inc b
    dec l
    add b
    dec b
    jr z, jr_001_7b2a

    ld [$0235], sp
    ld [hl+], a
    ld a, [hl+]
    db $10
    ld [$0026], sp
    ld b, h
    ld [$a262], sp
    ld b, $00
    ld d, b
    jr nz, @-$5c

jr_001_7bae:
    nop
    ld b, b
    nop
    ld h, d
    adc b
    jp nc, $1380

    adc d
    call nz, $410c
    jr nz, jr_001_7bbc

jr_001_7bbc:
    and b
    ld hl, $a008
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    add b
    ld [$a482], sp
    add b
    jp nz, $8408

    ld a, [bc]
    inc c
    add b
    or c
    nop
    ld h, b
    ld [hl+], a
    ld sp, $3082
    adc b
    ret nc

    ld [$0aa0], sp
    ld d, $00
    ld b, $02
    ld c, b
    ld [$8220], sp
    sub d
    nop
    ld hl, $00a8
    add d
    ld h, l
    ld a, [hl+]
    ld b, h
    ld [hl+], a
    add d
    jr z, jr_001_7c14

    add b
    cp b
    jr nz, jr_001_7c58

    ld [$28f0], sp
    nop
    ld [bc], a
    sub d
    sbc e
    ret c

    nop
    nop
    stop
    nop
    nop
    and b
    nop
    nop
    nop
    nop
    nop
    ld bc, $4000
    nop
    inc b
    nop
    nop
    nop

jr_001_7c14:
    add hl, bc
    nop
    add b
    ld b, b
    add b
    db $10
    jr nz, jr_001_7c1c

jr_001_7c1c:
    nop
    nop
    nop
    nop
    ld [bc], a
    nop
    ld d, b
    nop
    nop
    inc b
    inc b
    nop
    nop
    nop
    ld [$0604], sp
    nop
    nop
    nop
    jr z, jr_001_7c32

jr_001_7c32:
    add d
    nop
    nop
    ld bc, $0040
    inc b
    ld de, $1000
    nop
    nop
    nop
    nop
    nop
    nop
    stop
    nop
    nop
    jr nz, jr_001_7c48

jr_001_7c48:
    nop
    ld b, b
    nop
    nop
    ld bc, $0400
    nop
    ld bc, $0800
    nop
    ld a, [hl+]
    nop
    nop
    nop

jr_001_7c58:
    nop
    nop
    ld h, b
    nop
    nop
    nop
    nop
    nop
    jr z, jr_001_7c62

jr_001_7c62:
    add b
    nop
    and d
    db $10
    ld [$0900], sp
    nop
    nop
    nop
    nop
    nop
    ld [bc], a
    nop
    jr nz, jr_001_7c72

jr_001_7c72:
    adc b
    inc b
    nop
    nop
    ret nz

    inc d
    ld [bc], a
    nop
    ld [bc], a
    nop
    nop
    nop
    inc b
    nop
    nop
    nop
    nop
    nop
    nop
    ld b, c
    ret nz

    nop
    nop
    nop
    ld a, [bc]
    nop
    ld [bc], a
    ld bc, $0008
    nop
    nop
    inc b
    nop
    nop
    nop
    adc b
    nop
    nop
    ld bc, $0102
    nop
    inc b
    ld bc, $0000
    nop
    nop
    nop
    nop
    nop
    ld hl, $0200
    nop
    nop
    nop
    stop
    nop
    inc b
    nop
    nop
    jr nz, jr_001_7cb4

jr_001_7cb4:
    nop
    db $10
    inc b
    stop
    nop
    jr nz, jr_001_7cbc

jr_001_7cbc:
    nop
    nop
    ld bc, $8040
    nop
    nop
    ld b, b
    ld [hl-], a
    nop
    add b
    nop
    nop
    ld bc, $0040
    nop
    nop
    ld [$0000], sp
    nop
    ld bc, $0100
    nop
    nop
    inc b
    ld bc, $0020
    nop
    ld bc, $0000
    nop
    ld bc, $0040
    nop
    ld hl, $0000
    nop
    nop
    nop
    nop
    nop
    ld b, b
    nop
    nop
    nop
    nop
    nop
    stop
    ld [bc], a
    nop
    nop
    nop
    nop
    ld b, b
    ld bc, $0000
    nop
    ld bc, $0804
    nop
    nop
    nop
    nop
    nop
    stop
    ld [$0000], sp
    nop
    nop
    nop
    nop
    db $10
    jr nz, jr_001_7d12

jr_001_7d12:
    nop
    nop
    ld bc, $0400
    db $10
    ld hl, $1000
    nop
    ld [de], a
    nop
    nop
    nop
    nop
    nop
    stop
    stop
    nop
    nop
    nop
    ld bc, $4000
    ld [bc], a
    nop
    ld b, c
    nop
    nop
    nop
    nop
    nop
    nop
    stop
    ld bc, $0402
    nop
    nop
    add h
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    ld [$0000], sp
    nop
    inc b
    inc b
    nop
    nop
    nop
    nop
    add hl, hl
    nop
    nop
    nop
    stop
    ld [$0000], sp
    nop
    nop
    inc b
    nop
    nop
    nop
    inc b
    nop
    nop
    nop
    nop
    nop
    ld b, b
    jr nz, jr_001_7d66

jr_001_7d66:
    nop
    ld bc, $0000
    ld bc, $0400
    ld bc, $1001
    nop
    nop
    jr nc, jr_001_7d74

jr_001_7d74:
    ld [HeaderNewLicenseeCode], sp
    inc b
    inc b
    nop
    nop
    ld b, b
    ld de, $0004
    nop
    nop
    nop
    add b
    inc b
    ld [bc], a
    nop
    add b
    nop
    nop
    nop
    nop
    nop
    inc b
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
    ld [bc], a
    inc b
    sub b
    nop
    nop
    nop
    nop
    ld bc, $0000
    inc b
    nop
    ld h, c
    nop
    nop
    nop
    nop
    inc b
    ld c, b
    nop
    nop
    ld bc, $0040
    stop
    nop
    ld bc, $1001
    ld [bc], a
    nop
    ld b, b
    nop
    nop
    dec b
    jr jr_001_7dbf

    nop

jr_001_7dbf:
    nop
    nop
    nop
    nop
    nop
    nop
    db $10
    inc bc
    dec b
    nop
    nop
    nop
    ld bc, $0000
    ld [$0200], sp
    nop
    adc b
    ld b, b
    ld b, b
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
    stop
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
    ld [$0080], sp
    nop
    db $10
    db $10
    stop
    nop
    db $10
    ld [$0010], sp
    nop
    ld [bc], a
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
    dec b
    ld [$0200], sp
    nop
    nop
    nop
    nop
    ld bc, $1110
    nop
    db $10
    add b
    nop
    ld [bc], a
    nop
    nop
    nop
    nop
    nop
    ld [$4050], sp
    ld b, b
    nop
    nop
    jr nz, jr_001_7e2a

jr_001_7e2a:
    nop
    nop
    nop
    nop
    ld b, b
    nop
    nop
    nop
    stop
    db $10
    inc b
    nop
    nop
    nop
    nop
    nop
    ld bc, $0121
    nop
    nop
    nop
    nop
    ld [$0000], sp
    ld bc, $0004
    inc b
    nop
    nop
    nop
    nop
    inc b
    nop
    ld de, $1030
    nop
    nop
    nop
    nop
    add b
    stop
    nop
    nop
    nop
    nop
    nop
    nop
    ld bc, $1040
    adc b
    dec b
    jr nz, jr_001_7e66

jr_001_7e66:
    nop
    ld bc, $0024
    nop
    nop
    ld [$4000], sp
    ld bc, $0080
    nop
    nop
    add d
    ld de, $0019
    jr nz, jr_001_7e7a

jr_001_7e7a:
    ld [$0000], sp
    ld d, b
    nop
    nop
    nop
    nop
    add b
    inc b
    inc bc
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    ld bc, $0004
    nop
    add c
    nop
    nop
    nop
    nop
    nop
    ld b, b
    ld bc, $4001
    jr nz, jr_001_7e9f

    nop

jr_001_7e9f:
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    ld [hl+], a
    nop
    jr jr_001_7eac

jr_001_7eac:
    nop
    nop
    nop
    nop
    nop
    nop
    ld b, d
    nop
    stop
    ld [$0100], sp
    ld bc, $0402
    nop
    ld bc, $0008
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    inc b
    jr nz, jr_001_7eca

jr_001_7eca:
    ld [$0000], sp
    nop
    nop
    nop
    ld bc, $0001
    nop
    inc b
    nop
    add b
    nop
    nop
    nop
    nop
    db $10
    ld bc, $0000
    nop
    jr nz, jr_001_7f22

    ld bc, $0800
    nop
    nop
    nop
    ld [$0804], sp
    nop
    nop
    nop
    ld d, d
    nop
    db $10
    stop
    ld b, b
    ld [$0000], sp
    nop
    nop
    nop
    add d
    nop
    ld bc, $0010
    nop
    ld [$0040], sp
    nop
    nop
    inc b
    jr nz, jr_001_7f08

jr_001_7f08:
    nop
    nop
    nop
    nop
    inc b
    nop
    nop
    nop
    add b
    db $10
    ld [$1000], sp
    nop
    ld bc, $1400
    nop
    inc c
    inc b
    inc d
    nop
    nop
    nop
    add h
    nop

jr_001_7f22:
    nop
    ld de, $0001
    nop
    nop
    nop
    nop
    nop
    nop
    inc b
    nop
    ld h, h
    inc b
    nop
    ld bc, $1004
    nop
    nop
    nop
    nop
    nop
    nop
    inc b
    nop
    add b
    ld bc, $0000
    ld b, b
    nop
    nop
    nop
    nop
    nop
    jr nz, jr_001_7f48

jr_001_7f48:
    nop
    nop
    ld d, b
    nop
    db $10
    ld b, b
    nop
    nop
    nop
    nop
    add b
    nop
    nop
    nop
    ld bc, $0000
    nop
    nop
    nop
    nop
    inc b
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    inc b
    ld [$0000], sp
    nop
    ld c, b
    nop
    nop
    nop
    nop
    nop
    nop
    ld b, b
    inc b
    nop
    ld de, $4000
    ld b, l
    nop
    add hl, bc
    jr jr_001_7f8c

    ld b, l
    nop
    nop
    ld b, $00
    nop
    nop
    ld b, b
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop

jr_001_7f8c:
    nop
    nop
    ld [bc], a
    nop
    nop
    inc b
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    inc b
    add b
    nop
    nop
    nop
    inc b
    nop
    inc b
    nop
    jr jr_001_7fa4

jr_001_7fa4:
    nop
    stop
    nop
    jr nz, jr_001_7fba

    add b
    nop
    nop
    nop
    ld bc, $0000
    nop
    jr nz, @+$04

    ld [$8000], sp
    nop
    db $10
    inc b

jr_001_7fba:
    add c
    inc b
    ld [bc], a
    nop
    ld d, b
    nop
    nop
    ld b, b
    nop
    nop
    ld [$0001], sp
    nop
    stop
    stop
    nop
    nop
    nop
    ld bc, $0000
    inc d
    nop
    stop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    inc b
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
    inc b
    nop
    nop
    nop
    nop
    nop
    jr nz, jr_001_7ff2

jr_001_7ff2:
    nop
    ld bc, $0010
    ld bc, $0000
    nop
    nop
    nop
    nop
    inc b
    sbc l
    ld d, b
