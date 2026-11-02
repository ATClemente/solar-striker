; Disassembly of "SolarStriker (World).gb"
; This file was created with:
; mgbdis v3.0 - Game Boy ROM disassembler by Matt Currie and contributors.
; https://github.com/mattcurrie/mgbdis

; Stage data loaded by LoadStageDataToWram (formerly Call_000_0e16).
; Background sources come from StageBackgroundDataTable ($0E5D); event sources from $0EA5.
; Sizes below are fixed copy lengths, not boundaries of the individual data sets.
; Some copied ranges overlap neighboring data; many bytes remain disassembled as instructions.
;
SECTION "ROM Bank $003", ROMX[$4000], BANK[$3]

    ; $4000: stages 0/1/2 background block definitions (four tile IDs per 2x2 block).
    ; StageBackgroundDataTable selects this source; copy $0200 bytes to WRAM $D000.
    db $00, $00, $00, $00, $01, $00, $00, $00, $00, $00, $00, $02, $00, $00, $02, $00
    db $00, $03, $00, $00, $00, $04, $00, $05, $04, $00, $06, $00, $07, $08, $0b, $0c
    db $09, $0a, $0d, $0e, $0f, $10, $11, $12, $00, $00, $00, $13, $04, $00, $14, $00
    db $00, $04, $00, $14, $00, $00, $13, $00, $07, $15, $0b, $0c, $16, $00, $0d, $19
    db $17, $15, $1a, $1b, $16, $18, $1c, $1a, $00, $15, $19, $0c, $16, $0a, $0d, $0e
    db $00, $1d, $00, $13, $1e, $1f, $13, $1d, $20, $21, $1e, $0c, $22, $1f, $0d, $1d
    db $20, $23, $1e, $24, $1e, $00, $13, $00, $00, $14, $00, $25, $14, $13, $25, $00
    db $13, $14, $00, $25, $14, $00, $25, $00, $26, $27, $00, $00, $00, $00, $28, $00
    db $29, $2a, $31, $32, $2b, $2c, $33, $34, $2d, $2e, $00, $00, $2f, $30, $00, $00
    db $bf, $f7, $5a, $ff, $fe, $fd, $b6, $7a, $bc, $fe, $9e, $be, $a6, $fb, $62, $ff
    db $aa, $dd, $ab, $df, $ab, $ff, $ee, $ee, $7f, $e9, $bb, $ef, $2a, $fe, $ab, $f3
    db $a3, $f9, $bb, $ff, $aa, $ff, $eb, $ff, $ea, $ff, $ae, $f7, $aa, $ff, $a3, $ff
    db $fc, $f3, $bf, $ff, $3f, $ff, $ac, $ff, $f6, $7f, $ea, $fa, $ef, $ff, $ec, $ef
    db $32, $ff, $2a, $ff, $aa, $fd, $ec, $db, $eb, $ff, $fa, $fb, $96, $bf, $ee, $ff
    db $aa, $ff, $e7, $bf, $f7, $ef, $ea, $ff, $ee, $5b, $fa, $ff, $ab, $bf, $2e, $ff
    db $8b, $ff, $ce, $fb, $6b, $ef, $be, $ff, $b3, $7f, $2f, $ff, $e1, $ef, $f8, $6f
    db $2a, $f3, $ba, $ff, $fb, $df, $ea, $fb, $6a, $7f, $fb, $be, $8e, $f7, $ee, $f7
    db $2b, $57, $f9, $ff, $ab, $6f, $ee, $ed, $eb, $f3, $bb, $8d, $cb, $3f, $fb, $fb
    db $de, $ff, $ea, $ff, $ab, $f3, $ae, $df, $e6, $df, $fb, $e6, $ea, $7f, $ce, $ff
    db $bf, $ff, $ae, $fb, $fb, $bf, $ba, $7f, $fb, $ff, $fe, $7f, $eb, $ff, $2a, $df
    db $2a, $79, $be, $fe, $eb, $fb, $8b, $fb, $be, $ff, $ba, $ff, $f2, $bf, $86, $7f
    db $ef, $df, $fe, $f9, $e9, $bf, $eb, $f6, $bf, $fb, $a0, $ff, $bb, $bf, $ae, $ff
    db $f8, $ff, $ff, $ff, $ff, $bf, $a7, $bf, $b6, $ff, $7e, $af, $df, $bb, $7b, $fc
    db $eb, $fe, $ee, $ff, $e9, $be, $e7, $bb, $bb, $ff, $ea, $ff, $36, $fe, $ea, $7e
    db $fa, $dd, $e4, $bf, $bf, $fd, $be, $de, $fb, $ff, $b7, $fd, $bb, $ff, $eb, $eb
    db $9f, $ff, $bc, $ff, $1d, $fc, $9f, $f7, $be, $eb, $bf, $fb, $be, $df, $fe, $ff
    db $ba, $bb, $ea, $f7, $3f, $f7, $b2, $17, $ae, $f5, $bf, $ff, $fe, $bb, $c7, $76
    ; $41B0: stage 0 background map (block IDs); copy $0550 bytes to WRAM $D200.
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $01
    db $00, $01, $00, $01, $01, $09, $00, $00, $00, $01, $00, $00, $01, $00, $00, $00
    db $01, $00, $00, $00, $01, $00, $00, $01, $00, $00, $00, $00, $00, $00, $00, $04
    db $00, $00, $00, $00, $00, $00, $00, $01, $00, $01, $00, $00, $01, $00, $01, $00
    db $00, $01, $01, $00, $00, $01, $00, $00, $01, $00, $00, $00, $00, $00, $00, $00

    nop
    nop
    inc b
    nop
    nop
    nop
    ld bc, $0000
    ld bc, $0000
    ld bc, $0001
    nop
    ld bc, $0100
    nop
    nop
    ld bc, $0000
    nop
    nop
    nop
    nop
    nop
    nop
    ld bc, $0400
    nop
    nop
    ld bc, $1a00
    dec de
    inc e
    dec e
    nop
    ld bc, $0000
    nop
    ld bc, $0000
    nop
    inc d
    dec d
    ld d, $17
    jr jr_003_4251

    nop
    nop
    add hl, bc
    nop
    nop
    nop
    nop
    ld bc, $0f0e
    db $10
    ld de, $1312
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    ld a, [bc]
    dec bc
    rlca

jr_003_4251:
    ld [$0d0c], sp
    nop
    nop
    nop
    nop
    ld bc, $0900
    nop
    nop
    inc bc
    rlca
    ld [$0002], sp
    nop
    ld bc, $0004
    nop
    nop
    ld bc, $0000
    nop
    rlca
    ld [$0000], sp
    ld bc, $0000
    nop
    ld bc, $0100
    nop
    ld bc, $0504
    ld b, $01
    nop
    nop
    nop
    nop
    ld bc, $0000
    nop
    ld bc, $0001
    ld [bc], a
    inc bc
    nop
    nop
    nop
    nop
    ld bc, $ff01
    rst $38
    adc e
    cp a
    and e
    rst $38
    rst $08
    ei
    xor $ef
    ld hl, sp-$01
    cp d
    ld a, a
    xor [hl]
    rst $38

    ; $42A0: stage 1 background map (block IDs); copy $0550 bytes to WRAM $D200.
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $01
    db $00, $01, $00, $01, $01, $09, $00, $00, $00, $01, $00, $00, $01, $00, $00, $00
    db $01, $00, $00, $00, $01, $00, $00, $01, $00, $00, $00, $00, $00, $00, $00, $04
    db $00, $00, $00, $00, $00, $00, $00, $01, $00, $01, $00, $00, $01, $00, $01, $00
    db $00, $01, $01, $00, $00, $01, $00, $00, $01, $00, $00, $00, $00, $00, $00, $00
    db $00, $00, $04, $00, $00, $00, $01, $00, $00, $01, $00, $00, $01, $01, $00, $00
    db $01, $00, $01, $00, $00, $01, $00, $00, $00, $00, $00, $00, $00, $00, $01, $00
    db $04, $00, $00, $01, $00, $00, $01, $00, $01, $00, $01, $00, $00, $00, $01, $00
    db $00, $00, $00, $00, $00, $01, $00, $00, $00, $00, $09, $00, $00, $00, $00, $01
    db $00, $00, $01, $00, $04, $00, $00, $00, $00, $00, $00, $00, $00, $00, $04, $00
    db $00, $00, $00, $01, $00, $00, $00, $00, $01, $00, $09, $00, $00, $00, $00, $01
    db $00, $00, $00, $01, $04, $00, $00, $00, $01, $00, $00, $00, $00, $00, $00, $00
    db $01, $00, $00, $00, $01, $00, $01, $00, $01, $04, $00, $00, $01, $00, $00, $00
    db $00, $01, $00, $00, $00, $01, $01, $00, $00, $01, $00, $00, $00, $00, $01, $01
    db $ff, $bd, $ae, $7c, $e8, $ff, $8a, $bf, $6c, $ff, $4f, $fd, $ca, $ff, $ae, $db
    ; $4390: stage 2 background map (block IDs); copy $0550 bytes to WRAM $D200.
    db $00, $1e, $1f, $00, $00, $00, $00, $1e, $1f, $00, $00, $00, $00, $1e, $00, $00
    db $00, $00, $00, $1f, $00, $00, $00, $20, $21, $22, $00, $00, $20, $21, $22, $00
    db $00, $00, $00, $1f, $00, $00, $00, $00, $00, $1f, $00, $00, $00, $00, $1f, $00
    db $00, $00, $00, $1f, $00, $1f, $00, $00, $00, $1f, $00, $00, $00, $00, $23, $1f
    db $00, $00, $00, $00, $1e, $1f, $00, $00, $00, $1f, $00, $00, $00, $00, $00, $1e
    db $1f, $00, $00, $00, $00, $1e, $1f, $00, $1e, $00, $1f, $00, $1f, $00, $20, $21
    db $22, $1e, $00, $00, $00, $00, $00, $1f, $00, $00, $00, $00, $1e, $00, $00, $00
    db $1e, $20, $21, $22, $00, $00, $00, $1f, $1e, $00, $00, $00, $1f, $00, $00, $00
    db $00, $00, $1f, $00, $00, $00, $00, $00, $1f, $00, $00, $00, $00, $1f, $00, $00
    db $00, $00, $00, $1f, $00, $00, $00, $1f, $1e, $1f, $00, $00, $1f, $00, $1e, $00
    db $00, $00, $1e, $1f, $00, $00, $00, $00, $1e, $00, $00, $00, $00, $00, $00, $1f
    db $00, $00, $00, $00, $00, $00, $00, $00, $1e, $00, $1f, $00, $00, $00, $00, $00
    db $00, $1f, $00, $00, $00, $00, $20, $21, $22, $00, $23, $1f, $00, $00, $00, $00
    db $1e, $1f, $1e, $00, $00, $00, $00, $1f, $00, $00, $00, $1e, $00, $00, $00, $00
    db $ff, $74, $75, $51, $5b, $d7, $fb, $fd, $ff, $9e, $73, $65, $ad, $d5, $ff, $ed
    ; $4480: stages 3/4 background block definitions; copy $0200 bytes to WRAM $D000.
    db $00, $00, $00, $00, $01, $02, $03, $04, $03, $04, $0d, $0e, $05, $06, $05, $06
    db $07, $08, $0f, $10, $09, $0a, $11, $12, $0b, $0c, $09, $0a, $00, $13, $00, $18
    db $14, $00, $19, $00, $00, $15, $00, $00, $00, $16, $00, $1a, $17, $00, $1b, $00
    db $1c, $1d, $00, $20, $00, $00, $21, $00, $00, $00, $22, $00, $00, $00, $00, $23
    db $1e, $1f, $24, $25, $00, $26, $00, $00, $27, $00, $29, $2a, $00, $28, $2b, $2c
    db $2d, $00, $00, $00, $00, $15, $22, $00, $00, $2e, $00, $00, $2f, $00, $00, $00
    db $00, $00, $00, $30, $00, $00, $31, $00, $00, $00, $00, $32, $00, $32, $00, $00
    db $32, $00, $00, $00, $00, $00, $32, $00, $33, $34, $37, $38, $00, $00, $39, $3a
    db $35, $36, $3b, $3c, $3d, $3e, $4b, $4c, $3f, $40, $4d, $4e, $41, $42, $4f, $50
    db $43, $44, $51, $52, $45, $46, $53, $54, $47, $48, $55, $56, $49, $4a, $57, $58
    db $59, $5a, $5f, $60, $5b, $5c, $61, $61, $5d, $5e, $62, $63, $2b, $1d, $aa, $55
    ; $4530: stage 3 background map (block IDs); copy $0550 bytes to WRAM $D200.
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
    db $00, $03, $03, $00, $03, $03, $00, $03, $03, $00, $00, $00, $02, $00, $00, $03
    db $03, $00, $03, $03, $00, $03, $03, $00, $00, $05, $01, $02, $00, $03, $03, $00
    db $03, $03, $00, $03, $03, $00, $05, $06, $00, $01, $00, $03, $03, $00, $03, $03
    db $00, $03, $03, $00, $06, $00, $02, $00, $00, $03, $03, $04, $03, $03, $04, $03
    db $03, $00, $00, $05, $01, $02, $00, $03, $03, $00, $03, $03, $00, $03, $03, $00
    db $05, $06, $00, $01, $00, $03, $03, $00, $03, $03, $00, $03, $03, $00, $06, $00
    db $02, $00, $00, $03, $03, $00, $03, $03, $00, $03, $03, $00, $00, $05, $01, $02
    db $00, $03, $03, $00, $03, $03, $00, $03, $03, $00, $05, $06, $00, $01, $00, $03
    db $03, $04, $03, $03, $04, $03, $03, $00, $06, $00, $02, $00, $00, $03, $03, $00
    db $03, $03, $00, $03, $03, $00, $00, $05, $01, $02, $00, $03, $03, $00, $03, $03
    db $00, $03, $03, $00, $05, $06, $00, $01, $00, $03, $03, $00, $03, $03, $00, $03
    db $03, $00, $06, $00, $02, $00, $00, $03, $03, $00, $03, $03, $00, $03, $03, $00
    db $00, $05, $01, $00, $00, $03, $03, $04, $03, $03, $04, $03, $03, $00, $00, $06
    db $00, $00, $00, $03, $03, $00, $03, $03, $00, $03, $03, $00, $00, $00, $ff, $43
    ; $4620: stage 4 background map (block IDs); copy $0550 bytes to WRAM $D200.
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $0c
    db $0d, $16, $17, $15, $11, $12, $00, $00, $00, $07, $08, $11, $0c, $0d, $11, $12
    db $13, $14, $0f, $10, $00, $00, $00, $07, $08, $0f, $08, $15, $0a, $0b, $00, $13
    db $14, $0a, $0b, $00, $00, $0c, $0d, $00, $08, $00, $0a, $0b, $00, $0c, $0d, $0a
    db $0b, $00, $0c, $0d, $09, $11, $0d, $11, $12, $00, $07, $08, $09, $0f, $10, $07
    db $08, $15, $0e, $0a, $0e, $0f, $10, $00, $00, $13, $14, $09, $0a, $0b, $13, $14
    db $11, $12, $15, $11, $12, $00, $00, $00, $13, $14, $0a, $0b, $0c, $0d, $0a, $0b
    db $11, $12, $00, $00, $00, $00, $07, $08, $0f, $10, $13, $14, $0f, $10, $0a, $0b
    db $00, $00, $00, $00, $07, $08, $0e, $0a, $0b, $13, $14, $0a, $0a, $0b, $00, $00
    db $00, $00, $0c, $0d, $11, $12, $00, $07, $08, $0a, $12, $00, $00, $00, $00, $0c
    db $0d, $11, $12, $00, $00, $07, $08, $0f, $0b, $00, $00, $00, $07, $08, $00, $0a
    db $0b, $00, $00, $00, $13, $14, $00, $00, $00, $00, $0c, $0d, $11, $12, $00, $00
    db $00, $00, $00, $13, $00, $00, $00, $0c, $0d, $0e, $0f, $10, $00, $00, $00, $00
    db $00, $07, $00, $00, $07, $08, $00, $00, $09, $0a, $0b, $00, $00, $00, $00, $00
    db $00, $00, $07, $08, $0e, $00, $00, $0f, $10, $00, $00, $00, $00, $00, $00, $00
    db $0c, $0d, $16, $17, $00, $00, $0f, $10, $00, $00, $00, $00, $00, $07, $08, $11
    db $12, $13, $14, $15, $00, $0a, $0b, $00, $00, $00, $00, $0c, $0d, $0a, $0b, $00
    db $13, $14, $11, $12, $00, $00, $00, $0c, $00, $13, $14, $0a, $0b, $00, $07, $08
    db $0a, $0b, $00, $00, $07, $08, $00, $0c, $0d, $0a, $0b, $00, $0c, $0d, $0a, $0b
    db $00, $00, $0c, $0d, $0c, $0d, $11, $12, $00, $07, $08, $11, $12, $00, $00, $07
    db $08, $09, $08, $15, $0f, $10, $00, $07, $08, $0a, $0b, $00, $00, $0c, $0d, $09
    db $13, $14, $0e, $0a, $0b, $07, $08, $0f, $10, $00, $07, $08, $0e, $00, $00, $13
    db $14, $0f, $10, $0c, $0d, $00, $0a, $0b, $07, $08, $00, $11, $00, $0c, $0d, $0e
    db $18, $19, $00, $15, $0f, $10, $0c, $0d, $15, $0a, $07, $08, $00, $00, $15, $0e
    db $00, $00, $00, $18, $19, $00, $00, $0a, $0c, $0d, $15, $0e, $00, $00, $09, $00
    db $00, $00, $00, $15, $11, $12, $08, $0e, $00, $00, $00, $00, $00, $00, $00, $00
    db $00, $00, $0a, $0b, $13, $14, $00, $00, $00, $00, $00, $00, $0e, $00, $00, $11
    db $12, $00, $00, $13, $14, $00, $15, $00, $00, $00, $00, $00, $09, $0a, $0b, $00
    db $00, $07, $08, $00, $00, $09, $16, $17, $00, $00, $00, $0a, $0b, $00, $00, $00
    db $13, $14, $0e, $11, $12, $13, $14, $00, $15, $0f, $10, $00, $10, $00, $07, $08
    db $00, $0a, $0b, $00, $13, $14, $00, $00, $0a, $0b, $0a, $0b, $07, $08, $00, $0f
    db $10, $00, $07, $08, $15, $11, $12, $00, $0f, $10, $0c, $0d, $15, $00, $0a, $0b
    db $07, $08, $0e, $0a, $0b, $00, $14, $18, $19, $00, $00, $11, $12, $00, $0c, $0d
    db $11, $12, $00, $0c, $13, $14, $00, $00, $11, $12, $00, $07, $08, $0e, $0a, $0b
    db $07, $08, $00, $13, $14, $15, $0a, $0b, $00, $00, $13, $14, $0f, $10, $00, $13
    db $00, $07, $08, $11, $12, $00, $00, $00, $00, $13, $14, $0a, $0b, $00, $00, $0c
    db $0d, $0a, $0b, $00, $00, $00, $00, $07, $08, $0f, $10, $00, $07, $08, $11, $12
    db $00, $00, $00, $00, $00, $0c, $0d, $09, $0a, $0b, $07, $08, $0a, $0b, $00, $00
    db $00, $00, $07, $08, $15, $11, $12, $00, $0c, $0d, $0a, $0b, $00, $00, $00, $00
    db $0c, $0d, $00, $0a, $0b, $00, $0d, $0e, $0a, $0b, $00, $00, $00, $0c, $0d, $00
    db $11, $12, $00, $00, $15, $11, $12, $00, $00, $00, $07, $08, $00, $09, $0a, $0b
    db $00, $00, $11, $12, $00, $00, $00, $00, $0c, $0d, $15, $11, $12, $00, $00, $00
    db $0a, $0b, $00, $00, $00, $07, $08, $00, $09, $0a, $0b, $00, $00, $00, $0a, $0b
    db $00, $00, $00, $00, $13, $14, $0e, $0f, $10, $00, $00, $00, $12, $00, $00, $00

    nop
    nop
    rlca
    ld [$0000], sp
    rrca
    stop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    inc de
    inc d
    dec d
    ld c, $0a
    dec bc
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    inc c
    dec c
    nop
    nop
    ld a, [bc]
    dec bc
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    rlca
    ld [$0000], sp
    ld de, $0012
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    inc c
    dec c
    nop
    nop
    rrca
    stop
    nop
    stop
    nop
    nop
    nop
    rlca
    ld [$0000], sp
    nop
    nop
    ld a, [bc]
    dec bc
    nop
    rrca
    stop
    nop
    nop
    rlca
    ld [$0000], sp
    ld c, $00
    rrca
    stop
    dec d
    ld a, [bc]
    dec bc
    nop
    nop
    nop
    inc de
    inc d
    dec d
    ld c, $00
    nop
    rrca
    db $10
    ld de, $0012
    nop
    nop
    nop
    nop
    inc de
    inc d
    nop
    nop
    nop
    nop
    ld a, [bc]
    rrca
    stop
    nop
    nop
    nop
    nop
    rlca
    ld [$0000], sp
    nop
    nop
    rrca
    add hl, bc
    ld a, [bc]
    dec bc
    nop
    nop
    nop
    nop
    rlca
    ld [$0009], sp
    nop
    nop
    ld c, $11
    ld [de], a
    nop
    nop
    nop
    nop
    nop
    nop
    inc de
    inc d
    nop
    nop
    nop
    add hl, bc
    ld [de], a
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    inc c
    dec c
    nop
    nop
    nop
    ld c, $0b
    nop
    nop
    nop
    nop
    nop
    nop
    rlca
    ld [$0015], sp
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
    inc c
    dec c
    nop
    dec d
    ld d, $17
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    inc c
    dec c
    nop
    nop
    ld de, $1312
    inc d
    nop
    nop
    nop
    nop
    nop
    rlca
    ld [$000e], sp
    nop
    ld a, [bc]
    dec bc
    rlca
    ld [$0000], sp
    nop
    nop
    nop
    inc c
    dec c
    nop
    nop
    ld de, $0012
    nop
    inc de
    nop
    nop
    nop
    nop
    inc c
    dec c
    nop
    nop
    nop
    ld a, [bc]
    dec bc
    nop
    nop
    rlca
    nop
    nop
    nop
    rlca
    ld [$0015], sp
    nop
    ld c, $0a
    dec bc
    nop
    nop
    rlca
    inc d
    nop
    nop
    nop
    inc de
    inc d
    nop
    nop
    ld de, $0012
    nop
    nop
    inc c
    ld [$0000], sp
    nop
    inc c
    dec c
    nop
    nop
    ld a, [bc]
    dec bc
    nop
    nop
    rlca
    ld [$000d], sp
    nop
    inc c
    dec c
    ld d, $17
    nop
    ld a, [bc]
    dec bc
    nop
    nop
    nop
    inc de
    nop
    nop
    rlca
    ld [$1211], sp
    inc de
    inc d
    rrca
    stop
    nop
    nop
    rlca
    nop
    nop
    rlca
    ld [$0b0a], sp
    nop
    inc de
    inc d
    ld a, [bc]
    dec bc
    nop
    nop
    nop
    nop
    nop
    inc c
    dec c
    ld a, [bc]
    dec bc
    nop
    inc c
    dec c
    rrca
    stop
    nop
    nop
    nop
    inc c
    dec c
    nop
    rrca
    db $10
    inc c
    dec c
    nop
    dec d
    rrca
    stop
    nop
    rlca
    ld [$0000], sp
    nop
    jr jr_003_4a76

    nop
    nop
    nop
    nop
    rrca
    stop
    inc c
    dec c
    nop
    nop
    nop
    dec d
    nop
    nop
    nop
    ld c, $00
    nop
    rrca
    db $10
    dec c
    add hl, bc
    nop
    nop

jr_003_4a76:
    ld c, $00
    nop
    nop
    add hl, bc
    nop
    nop
    dec d
    nop
    rrca
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
    dec de
    ld a, [de]
    nop
    dec e
    inc e
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    inc e
    dec e
    nop
    jr z, jr_003_4b12

    ld a, [hl+]
    nop
    ld a, [de]
    dec de
    nop
    nop
    nop
    nop
    nop
    nop
    ld hl, $2322
    inc h
    dec h
    ld h, $27
    nop
    nop
    nop
    nop
    nop
    nop
    dec e
    inc e
    nop
    ld e, $1f
    jr nz, jr_003_4b07

jr_003_4b07:
    dec de
    ld a, [de]
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    ld a, [de]
    dec de

jr_003_4b12:
    nop
    inc e
    dec e
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
    rst $38
    sub b
    nop
    db $10
    ld c, b
    nop
    nop
    nop
    jr nz, jr_003_4b6a

jr_003_4b6a:
    nop
    ld b, b
    jr nz, @+$42

    add b
    ld h, [hl]
    ; $4B70: stages 5/6 background block definitions; copy $0200 bytes to WRAM $D000.
    nop
    nop
    nop
    nop
    ld bc, $0000
    nop
    nop
    ld [bc], a
    nop
    nop
    inc bc
    inc bc
    nop
    nop
    inc bc
    inc b
    nop
    rlca
    dec b
    ld b, $05
    ld b, $00
    rlca
    nop
    rlca
    ld [$0008], sp
    nop
    add hl, bc
    ld a, [bc]
    dec b
    ld b, $00
    ld bc, $0000
    nop
    nop
    nop
    dec bc
    nop
    nop
    inc c
    inc c
    nop
    nop
    dec c
    nop
    ld c, $00
    ld c, $00
    ld c, $00
    rrca
    inc c
    nop
    stop
    db $10
    ld [$0001], sp
    stop
    rlca
    inc c
    dec d
    ld de, $1612
    rla
    inc de
    inc de
    jr @+$1a

    inc de
    inc d
    jr jr_003_4bdd

    nop
    nop
    nop
    ld bc, $0000
    ld [$0008], sp
    db $10
    ld [$1001], sp
    nop
    stop
    inc d
    inc de
    add hl, de
    jr @+$03

    ld [$0000], sp
    ld a, [de]

jr_003_4bdd:
    inc bc
    ld c, $00
    dec de
    nop
    nop
    nop
    inc e
    inc e
    nop
    nop
    ld [$0001], sp
    nop
    ld bc, $1008
    nop
    inc b
    nop
    rlca
    nop
    dec e
    nop
    ld e, $1f
    nop
    nop
    rra
    rra
    nop
    nop
    rra
    jr nz, jr_003_4c01

jr_003_4c01:
    ld a, [de]
    rra
    ld c, $01
    ld bc, $0000
    rlca
    nop
    rlca
    nop
    nop
    dec e
    nop
    dec e
    dec e
    nop
    dec e
    nop
    nop
    ld c, $00
    ld c, $00
    nop
    ld bc, $0001
    nop
    ld bc, $0000
    dec e
    rra
    ld e, $07
    nop
    dec d
    nop
    nop
    ld c, $00
    rrca
    ld bc, $1000
    nop
    nop
    nop
    jr nz, jr_003_4c34

jr_003_4c34:
    nop
    ld a, [de]
    nop
    ld c, $07
    nop
    rlca
    rra
    nop
    ld c, $1f
    ld c, $1d
    ld c, $1d
    ld c, $1d
    ld c, $1d
    rrca
    ld hl, $2122
    ld [hl+], a
    ld hl, $2123
    inc hl
    ld [hl+], a
    inc h
    jr z, jr_003_4c7c

    inc h
    ld [hl+], a
    add hl, hl
    add hl, hl
    dec h
    ld hl, $2125
    inc hl
    ld [hl+], a
    inc hl
    ld [hl+], a
    ld h, $27
    ld a, [hl+]
    dec hl
    ld [hl+], a
    dec h
    ld [hl+], a
    dec h
    ld [hl+], a
    inc h
    add hl, hl
    add hl, hl
    inc h
    ld [hl+], a
    jr z, jr_003_4c98

    ld [hl+], a
    ld hl, $2122
    ld hl, $3722
    scf
    inc l
    dec l
    dec l
    nop

jr_003_4c7c:
    ld l, $2e
    jr c, jr_003_4cb8

    cpl
    jr nc, @+$3b

    ld a, [hl-]
    dec h
    ld hl, $2225
    inc hl
    ld [hl+], a
    inc hl
    dec sp
    ld sp, $2832
    inc a
    inc sp
    inc [hl]
    dec a
    jr z, @+$24

    dec h
    jr z, jr_003_4cbd

jr_003_4c98:
    ld hl, $2223
    inc hl
    dec [hl]
    ld [hl], $00
    dec [hl]
    ld [hl+], a
    ld hl, $3737
    inc h
    nop
    ld b, e
    ld b, h
    ld a, $3f
    ld b, l
    ld b, [hl]
    dec [hl]
    jr z, jr_003_4ccc

    ld l, $2d
    ld l, $00
    jr c, jr_003_4ce3

    ld b, b
    jr c, jr_003_4ce7

jr_003_4cb8:
    ld b, c
    ld l, $30
    jr c, jr_003_4ceb

jr_003_4cbd:
    dec [hl]
    jr c, jr_003_4cc0

jr_003_4cc0:
    dec sp
    dec l
    ld b, a
    nop
    nop
    ld b, d
    ld b, e
    ld b, h
    dec e
    jr c, jr_003_4ce8

    nop

jr_003_4ccc:
    nop
    add hl, sp
    nop
    ld a, $3a
    nop
    ccf
    nop
    ld c, b
    nop
    nop
    nop
    nop
    ld b, l
    jr nz, jr_003_4cdc

jr_003_4cdc:
    ld b, [hl]
    nop
    nop
    nop
    ld c, c
    ld c, c
    ld c, c

jr_003_4ce3:
    ld c, c
    ld c, c
    ld c, d
    ld c, d

jr_003_4ce7:
    nop

jr_003_4ce8:
    ld c, e
    nop
    ld c, h

jr_003_4ceb:
    ld c, e
    ld c, e
    ld c, h
    ld c, h
    nop
    ld c, l
    ld c, [hl]
    nop
    ld c, l
    ld c, e
    ld c, h
    nop
    ld c, e
    nop
    ld c, h
    ld c, h
    nop
    ld c, a
    ld d, b
    ld d, d
    ld d, e
    ld d, c
    ld c, c
    ld d, c
    ld c, c
    nop
    ld c, h
    ld c, h
    ld c, e
    ld c, e
    nop
    nop
    ld c, e
    nop
    ld d, h
    ld d, h
    ld c, c
    ld c, c
    ld d, l
    ld c, c
    ld d, l
    ld d, [hl]
    nop
    ld c, c
    ld d, [hl]
    ld d, a
    ld d, b
    ld d, d
    ld d, e
    nop
    nop
    ld e, b
    ld e, c
    nop
    nop
    ld e, d
    ld e, e
    nop
    nop
    nop
    ld h, b
    ld e, h
    ld e, l
    ld h, c
    ld h, d
    ld e, [hl]
    ld e, a
    ld h, e
    ld h, h
    nop
    nop
    ld h, l
    nop
    nop
    ld h, [hl]
    nop
    nop
    ld h, a
    ld h, [hl]
    ld h, [hl]
    nop
    ld l, b
    ld l, c
    nop
    ld l, b
    ld l, b
    nop
    nop
    nop
    stop
    nop
    nop
    nop
    ld bc, $0000
    nop
    nop
    db $10
    ; $4D50: stage 5 background map (block IDs); copy $0550 bytes to WRAM $D200.
    ; Source begins at byte offset +1 in the following instruction encoding.
    ld bc, $0000
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
    dec d
    ld d, $16
    ld d, $17
    nop
    dec b
    nop
    ld [de], a
    inc de
    ld [de], a
    nop
    ld c, $0b
    ld de, $1200
    inc de
    inc d
    inc de
    ld [de], a
    nop
    add hl, bc
    rlca
    ld [$0d07], sp
    nop
    ld b, $07
    ld [$1007], sp
    nop
    nop
    nop
    rrca
    nop
    dec b
    nop
    dec c
    nop
    ld b, $00
    dec b
    nop
    rrca
    nop
    add hl, bc
    rlca
    ld c, $0b
    dec bc
    dec bc
    inc c
    nop
    ld b, $00
    dec b
    nop
    rrca
    nop
    rrca
    nop
    dec c
    nop
    nop
    nop
    nop
    nop
    ld b, $00
    dec b
    nop
    ld c, $0b
    dec bc
    dec bc
    inc c
    nop
    nop
    nop
    nop
    nop
    ld b, $00
    dec b
    nop
    dec c
    nop
    nop
    nop
    nop
    nop
    ld bc, $0101
    nop
    ld a, [bc]
    dec bc
    dec bc
    dec bc
    inc c
    nop
    nop
    nop
    nop
    nop
    add hl, bc
    add hl, bc
    add hl, bc
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
    ld bc, $0101
    ld bc, $0101
    ld bc, $0000
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    add hl, bc
    add hl, bc
    add hl, bc
    add hl, bc
    add hl, bc
    add hl, bc
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
    ld bc, $0101
    ld bc, $0000
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
    ld [bc], a
    inc bc
    inc bc
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
    nop
    ld b, $07
    ld [$0007], sp
    ld bc, $0000
    nop
    nop
    nop
    nop
    ld [bc], a
    inc bc
    inc b
    nop
    dec b
    nop
    nop
    add hl, bc
    nop
    add hl, bc
    nop
    nop
    nop
    nop
    ld b, $07
    ld e, $07
    ld [$0007], sp
    add hl, bc
    nop
    add hl, bc
    nop
    nop
    nop
    nop
    ld b, $00
    rrca
    nop
    dec b
    nop
    nop
    add hl, bc
    nop
    add hl, bc
    nop
    nop
    nop
    nop
    ld b, $13
    inc d
    inc de
    ld [de], a
    nop
    nop
    add hl, bc
    nop
    add hl, bc
    nop
    nop
    nop
    nop
    ld b, $00
    rrca
    nop
    nop
    nop
    nop
    nop
    nop
    add hl, bc
    nop
    nop
    nop
    nop
    ld a, [bc]
    dec bc
    dec bc
    ld de, $1d1d
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
    ld b, $00
    nop
    nop
    nop
    nop
    nop
    nop
    add hl, bc
    add hl, bc
    add hl, bc
    add hl, bc
    nop
    nop
    ld a, [bc]
    dec bc
    dec bc
    inc bc
    inc bc
    inc bc
    inc e
    nop
    ld bc, $0101
    ld bc, $0000
    nop
    nop
    nop
    nop
    nop
    nop
    dec c
    nop
    nop
    add hl, bc
    add hl, bc
    nop
    nop
    nop
    nop
    nop
    nop
    inc de
    ld [de], a
    nop
    dec c
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
    nop
    dec de
    inc bc
    inc e
    nop
    nop
    nop
    nop
    add hl, bc
    add hl, bc
    add hl, bc
    nop
    rlca
    ld [$1007], sp
    nop
    dec c
    nop
    nop
    nop
    nop
    ld bc, $0101
    ld bc, $0500
    nop
    ld a, [de]
    rlca
    dec c
    nop
    nop
    nop
    nop
    add hl, bc
    add hl, bc
    add hl, bc
    nop
    nop
    dec b
    nop
    jr jr_003_4eeb

jr_003_4eeb:
    dec c
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    ld [de], a
    inc de
    add hl, de
    inc de
    dec c
    nop
    nop
    nop
    nop
    add hl, bc
    nop
    add hl, bc
    nop
    nop
    nop
    nop
    jr jr_003_4f07

jr_003_4f07:
    dec c
    nop
    nop
    nop
    nop
    add hl, bc
    nop
    add hl, bc
    nop
    dec bc
    dec bc
    dec bc
    dec bc
    dec bc
    inc c
    nop
    nop
    nop
    nop
    add hl, bc
    nop
    add hl, bc
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
    add hl, bc
    nop
    ld bc, $0101
    ld bc, $0000
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    add hl, bc
    add hl, bc
    nop
    nop
    nop
    nop
    add hl, bc
    add hl, bc
    add hl, bc
    nop
    nop
    nop
    ld [bc], a
    inc bc
    ld bc, $0101
    nop
    nop
    nop
    ld bc, $0001
    nop
    nop
    nop
    ld b, $00
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    ld [bc], a
    inc bc
    inc bc
    inc bc
    inc e
    ld b, $00
    inc bc
    inc bc
    inc e
    nop
    nop
    nop
    nop
    ld b, $00
    nop
    dec b
    dec c
    ld b, $07
    nop
    dec b
    dec c
    nop
    nop
    nop
    nop
    ld b, $00
    nop
    dec b
    dec de
    inc b
    nop
    nop
    dec b
    dec c
    nop
    ld [bc], a
    inc bc
    inc bc
    inc b
    nop
    nop
    dec b
    nop
    nop
    nop
    nop
    dec b
    dec de
    inc bc
    inc b
    nop
    jr jr_003_4f96

jr_003_4f96:
    nop
    nop
    dec b
    nop
    nop
    nop
    rlca
    ld [$0107], sp
    nop
    nop
    rra
    rlca
    rlca
    ld bc, $0005
    ld [de], a
    inc de
    nop
    dec b
    nop
    jr jr_003_4faf

jr_003_4faf:
    nop
    nop
    nop
    nop
    jr jr_003_4fba

    nop
    dec b
    nop
    nop
    ld [de], a

jr_003_4fba:
    inc de
    add hl, de
    inc de
    ld [de], a
    inc de
    inc de
    inc de
    add hl, de
    ld [de], a
    nop
    dec b
    nop
    nop
    nop
    nop
    jr jr_003_4fcb

jr_003_4fcb:
    dec b
    nop
    nop
    nop
    jr jr_003_4fd1

jr_003_4fd1:
    nop
    dec b
    nop
    nop
    nop
    nop
    jr jr_003_4fd9

jr_003_4fd9:
    dec b
    nop
    ld a, [de]
    rlca
    rra
    rlca
    rlca
    ld [$1307], sp
    ld [de], a
    nop
    jr jr_003_4fe7

jr_003_4fe7:
    dec b
    nop
    jr jr_003_4feb

jr_003_4feb:
    nop
    nop
    nop
    dec b
    nop
    nop
    dec b
    nop
    jr jr_003_4ff5

jr_003_4ff5:
    ld [de], a
    inc de
    add hl, de
    inc de
    ld [de], a
    inc de
    inc de
    ld [de], a
    nop
    rlca
    ld [$2f07], sp
    nop
    nop
    nop
    jr jr_003_5007

jr_003_5007:
    dec b
    nop
    nop
    nop
    nop
    nop
    dec b
    nop
    jr jr_003_5011

jr_003_5011:
    nop
    nop
    jr jr_003_5015

jr_003_5015:
    dec b
    nop
    nop
    nop
    ld c, $13
    ld [de], a
    nop
    jr jr_003_502d

    dec bc
    dec bc
    ld de, $0500
    nop
    nop
    nop
    dec c
    nop
    nop
    nop
    jr jr_003_503a

jr_003_502d:
    nop
    nop
    ld b, $00
    dec b
    nop
    nop
    nop
    dec c
    nop
    ld c, $0b
    dec bc

jr_003_503a:
    inc c
    ld bc, $0601
    nop
    dec b
    nop
    ld c, $0b
    inc c
    nop
    dec c
    nop
    nop
    add hl, bc
    add hl, bc
    add hl, bc
    ld a, [bc]
    dec bc
    dec bc
    dec bc
    inc c
    nop
    nop
    dec bc
    inc c
    nop
    nop
    ld bc, $0101
    nop
    nop
    nop
    add hl, bc
    add hl, bc
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
    ld bc, $0101
    nop
    nop
    dec bc
    ld de, $0000
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    ld c, $0b
    nop
    ld b, $22
    ld [hl+], a
    ld [hl+], a
    jr z, jr_003_5083

jr_003_5083:
    nop
    nop
    nop
    nop
    nop
    dec c
    nop
    nop
    ld b, $00
    nop
    nop
    jr z, jr_003_5091

jr_003_5091:
    nop
    ld hl, $2222
    ld [hl+], a
    dec c
    nop
    nop
    ld a, [bc]
    dec bc
    dec l
    nop
    jr z, jr_003_509f

jr_003_509f:
    nop
    jr z, jr_003_50a2

jr_003_50a2:
    ld l, $0b
    inc c
    nop
    ld a, [hl+]
    ld a, [hl+]
    dec hl
    ld h, $00
    ld [hl+], a
    inc l
    ld [hl+], a
    ld [hl+], a
    jr z, jr_003_50da

    dec d
    ld a, [hl+]
    ld a, [hl+]
    dec h
    dec h
    ld bc, $0026
    nop
    daa
    nop
    nop
    jr z, jr_003_50e8

    add hl, bc
    dec h
    dec h
    nop
    ld [bc], a
    inc bc
    jr nz, jr_003_50e8

    ld [hl+], a
    inc hl
    nop
    nop
    ld [hl+], a
    inc h
    inc bc
    inc e
    nop
    nop
    ld b, $00
    nop
    jr z, jr_003_50d6

jr_003_50d6:
    nop
    nop
    nop
    nop

jr_003_50da:
    ld hl, $0d22
    nop
    nop
    ld b, $00
    nop
    ld hl, $2222
    jr z, jr_003_50e7

jr_003_50e7:
    nop

jr_003_50e8:
    jr z, jr_003_50ea

jr_003_50ea:
    dec c
    nop
    nop
    ld b, $22
    ld [hl+], a
    jr nc, jr_003_50f2

jr_003_50f2:
    nop
    jr z, jr_003_50f5

jr_003_50f5:
    nop
    jr z, jr_003_50f8

jr_003_50f8:
    dec c
    nop
    nop
    ld a, [bc]
    dec bc
    dec l
    nop
    nop
    nop
    jr z, jr_003_5103

jr_003_5103:
    nop
    dec [hl]
    dec bc
    inc c
    nop
    ld a, [hl+]
    ld a, [hl+]
    dec hl
    ld h, $00
    ld hl, $222c
    ld [hl+], a
    jr z, jr_003_5147

    dec d
    ld a, [hl+]
    ld a, [hl+]
    dec h
    dec h
    ld bc, $2232
    nop
    daa
    nop
    nop
    ld hl, $0933
    dec h
    dec h
    nop
    ld [bc], a
    inc bc
    jr nz, jr_003_5129

jr_003_5129:
    nop
    daa
    nop
    nop
    jr z, jr_003_5160

    inc bc
    inc e
    nop
    nop
    ld b, $00
    nop
    nop
    nop
    daa
    nop
    nop
    jr z, jr_003_513d

jr_003_513d:
    nop
    dec c
    nop
    nop
    ld b, $00
    nop
    ld hl, $2728

jr_003_5147:
    nop
    nop
    ld [hl+], a
    ld hl, $0d22
    nop
    nop
    ld b, $00
    nop
    jr z, jr_003_5176

    ld [hl+], a
    ld [hl+], a
    ld hl, $3022
    nop
    dec c
    nop
    nop
    ld a, [bc]
    dec bc
    dec l

jr_003_5160:
    jr z, jr_003_5162

jr_003_5162:
    nop
    nop
    jr z, jr_003_5166

jr_003_5166:
    ld l, $0b
    inc c
    nop
    ld a, [hl+]
    ld a, [hl+]
    dec hl
    ld h, $21
    ld [hl+], a
    jr z, jr_003_5172

jr_003_5172:
    jr z, jr_003_5174

jr_003_5174:
    add hl, hl
    dec d

jr_003_5176:
    ld a, [hl+]
    ld a, [hl+]
    dec h
    dec h
    ld bc, $3032
    nop
    jr z, jr_003_5180

jr_003_5180:
    ld hl, $3321
    add hl, bc
    dec h
    dec h
    nop
    ld [bc], a
    inc bc
    jr nz, jr_003_518b

jr_003_518b:
    nop
    ld hl, $3022
    jr z, @+$33

    inc bc
    inc e
    nop
    nop
    ld b, $00
    nop
    ld hl, $0022
    nop
    nop
    jr z, jr_003_519f

jr_003_519f:
    nop
    dec c
    nop
    nop
    ld b, $00
    nop
    jr z, jr_003_51a8

jr_003_51a8:
    nop
    nop
    nop
    jr z, jr_003_51ad

jr_003_51ad:
    nop
    dec c
    nop
    nop
    ld b, $00
    nop
    jr z, jr_003_51b6

jr_003_51b6:
    nop
    nop
    nop
    ld hl, $2222
    dec c
    nop
    nop
    ld a, [bc]
    ld de, $2100
    ld [hl+], a
    ld hl, $2222
    jr nc, jr_003_51c9

jr_003_51c9:
    ld c, $0c
    nop
    dec h
    dec h
    ld b, $22
    jr nc, jr_003_51d2

jr_003_51d2:
    jr z, jr_003_51d4

jr_003_51d4:
    nop
    nop
    nop
    dec c
    dec h
    dec h
    nop
    nop
    ld a, [bc]
    dec bc
    ld de, $2800
    nop
    nop
    ld c, $0b
    inc c
    nop
    nop
    ld a, [hl+]
    ld a, [hl+]
    ld a, [hl+]
    ld a, [hl+]
    ld b, $00
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    dec c
    ld a, [hl+]
    ld a, [hl+]
    ld a, [hl+]
    ld a, [hl+]
    nop
    nop
    nop
    nop
    ld a, [bc]
    dec bc
    dec bc
    dec bc
    dec bc
    inc c
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
    ld b, e
    nop
    nop
    ld hl, $2822
    nop
    nop
    nop
    nop
    ld hl, $0028
    ld b, e
    inc a
    ld [hl+], a
    jr z, jr_003_524c

    nop
    ld hl, $2222
    ld [hl+], a
    jr z, jr_003_5253

    ld [hl+], a
    ld [hl+], a
    inc a
    ld c, l
    nop
    ld [hl+], a
    jr z, jr_003_5233

jr_003_5233:
    ld [hl+], a
    jr z, jr_003_5236

jr_003_5236:
    nop
    jr z, jr_003_5261

    ld hl, $5528
    inc a
    nop
    ld hl, $2822
    nop
    ld hl, $2222
    ld [hl+], a
    jr z, jr_003_5270

    jr z, jr_003_5286

    ld c, l
    nop

jr_003_524c:
    jr z, jr_003_524e

jr_003_524e:
    ld hl, $5a22
    ld e, e
    nop

jr_003_5253:
    nop
    jr z, jr_003_527e

    ld [hl+], a
    ld d, l
    inc a
    ld [hl+], a
    jr nc, jr_003_525c

jr_003_525c:
    ld d, [hl]
    nop
    ld d, a
    ld e, b
    nop

jr_003_5261:
    ld e, c
    ld hl, $0030
    inc a
    ld c, l
    nop
    nop
    ld c, [hl]
    ld c, a
    ld d, b
    ld d, c
    ld d, d
    ld d, e
    ld d, h

jr_003_5270:
    ld c, [hl]
    nop
    nop
    ld d, l
    ld b, c
    ld b, d
    ld b, e
    ld b, h
    ld b, l
    ld b, [hl]
    ld b, a
    ld c, b
    ld c, c
    ld c, d

jr_003_527e:
    ld b, h
    ld b, e
    ld c, e
    ld c, h
    ld [hl], $37
    jr c, jr_003_52bf

jr_003_5286:
    ld a, [hl-]
    dec sp
    inc a
    inc a
    dec a
    scf
    ld a, $3f
    ld a, [hl-]
    ld b, b
    rst $38
    rst $38
    xor [hl]
    xor $e2
    rst $38
    xor [hl]
    ld a, e
    xor a
    rst $30
    xor [hl]
    reti


    cp d
    cp l
    db $fc
    ld sp, hl
    ; $52A0: stage 6 background map (block IDs); copy $0550 bytes to WRAM $D200.
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
    ld e, l
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
    ld e, h
    ld e, l
    ld h, c

jr_003_52bf:
    nop
    nop
    ld e, [hl]
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    ld h, b
    ld e, h
    ld e, h
    ld e, l
    ld e, [hl]
    ld h, e
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    ld h, b
    ld e, h
    ld e, h
    ld e, h
    ld l, b
    ld h, c
    ld e, [hl]
    ld h, l
    nop
    nop
    ld h, d
    nop
    nop
    ld h, [hl]
    ld h, a
    ld e, h
    ld e, h
    ld e, h
    ld l, c
    ld h, l
    ld h, c
    nop
    nop
    nop
    ld h, l
    ld h, c
    ld e, [hl]
    ld h, l
    ld e, [hl]
    ld h, a
    ld e, h
    ld l, c
    ld h, l
    ld h, e
    nop
    nop
    nop
    nop
    nop
    ld h, e
    nop
    nop
    ld e, a
    nop
    ld e, h
    ld e, l
    ld h, c
    nop
    ld e, [hl]
    nop
    nop
    nop
    ld h, c
    ld h, l
    nop
    ld h, c
    nop
    ld h, b
    ld e, h
    ld l, b
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    ld h, e
    nop
    ld e, a
    ld h, h
    ld e, h
    ld e, h
    ld e, l
    nop
    nop
    nop
    nop
    nop
    nop
    ld h, [hl]
    ld h, l
    ld h, l
    ld h, b
    ld e, h
    ld e, h
    ld e, h
    ld l, c
    ld h, l
    nop
    nop
    nop
    nop
    nop
    nop
    ld h, c
    ld h, b
    ld e, h
    ld e, h
    ld e, h
    ld l, c
    ld h, l
    ld h, c
    ld h, [hl]
    nop
    nop
    nop
    nop
    nop
    ld h, b
    ld e, h
    ld e, h
    ld e, h
    ld l, b
    nop
    nop
    ld h, e
    nop
    ld h, c
    nop
    nop
    nop
    ld e, a
    ld h, a
    ld e, h
    ld e, h
    ld e, h
    ld e, h
    ld e, l
    ld e, [hl]
    nop
    ld h, l
    nop
    nop
    nop
    ld h, l
    ld h, c
    ld h, [hl]
    ld h, a
    ld e, h
    ld e, h
    ld e, h
    ld e, h
    ld e, l
    nop
    ld h, c
    ld h, d
    nop
    nop
    nop
    ld h, e
    nop
    nop
    ld h, h
    ld e, h
    ld e, h
    ld e, h
    ld e, h
    ld e, l
    nop
    nop
    nop
    nop
    ld e, [hl]
    nop
    ld e, a
    ld h, b
    ld e, h
    ld e, h
    ld e, h
    ld e, h
    ld e, h
    ld l, c
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    ld h, h
    ld e, h
    ld e, h
    ld e, h
    ld e, h
    ld l, c
    nop
    ld h, l
    ld e, a
    ld h, [hl]
    nop
    nop
    nop
    ld e, [hl]
    ld h, h
    ld e, h
    ld e, h
    ld e, h
    ld e, h
    ld e, l
    ld h, d
    nop
    ld l, d
    ld e, [hl]
    nop
    nop
    ld h, c
    nop
    ld h, a
    ld e, h
    ld e, h
    ld e, h
    ld e, h
    ld l, c
    ld h, c
    ld h, l
    nop
    ld e, a
    nop
    ld h, l
    nop
    ld e, [hl]
    ld e, a
    ld h, a
    ld e, h
    ld e, h
    ld l, b
    ld h, c
    nop
    nop
    ld h, [hl]
    nop
    nop
    nop
    ld h, e
    ld e, a
    nop
    ld h, b
    ld e, h
    ld e, h
    ld l, b
    nop
    nop
    nop
    nop
    nop
    nop
    ld h, [hl]
    nop
    ld e, a
    ld h, b
    ld e, h
    ld e, h
    ld e, h
    ld e, h
    ld e, l
    nop
    nop
    nop
    nop
    nop
    nop
    ld h, c
    ld h, l
    ld h, a
    ld e, h
    ld e, h
    ld e, h
    ld e, h
    ld e, h
    ld e, l
    nop
    nop
    ld h, l
    ld h, c
    nop
    nop
    ld h, l
    ld h, b
    ld e, h
    ld e, h
    ld e, h
    ld e, h
    ld e, h
    ld l, c
    ld h, d
    nop
    ld h, l
    nop
    nop
    nop
    ld h, b
    ld e, h
    ld e, h
    ld e, h
    ld e, h
    ld e, h
    ld l, c
    ld h, l
    ld h, c
    nop
    nop
    nop
    nop
    ld h, l
    ld h, a
    ld e, h
    ld e, h
    ld e, h
    ld e, h
    ld l, c
    nop
    nop
    ld h, e
    ld e, [hl]
    nop
    nop
    ld h, d
    ld h, c
    nop
    ld h, a
    ld e, h
    ld e, h
    ld e, h
    ld e, l
    nop
    ld h, c
    nop
    ld h, l
    nop
    ld e, a
    nop
    ld e, [hl]
    nop
    nop
    ld h, h
    ld e, h
    ld e, h
    ld e, h
    ld e, l
    nop
    ld h, c
    ld h, c
    ld h, d
    ld h, c
    ld h, e
    ld e, a
    nop
    nop
    ld h, h
    ld e, h
    ld e, h
    ld e, h
    ld l, c
    nop
    ld h, c
    nop
    ld h, [hl]
    nop
    ld h, c
    ld h, d
    nop
    ld h, b
    ld e, h
    ld e, h
    ld e, h
    ld l, b
    nop
    ld h, [hl]
    nop
    nop
    nop
    nop
    nop
    ld h, d
    ld h, b
    ld e, h
    ld e, h
    ld e, h
    ld e, h
    ld l, b
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    ld h, a
    ld e, h
    ld e, h
    ld e, h
    ld e, h
    ld e, h
    ld e, l
    nop
    nop
    nop
    ld h, [hl]
    nop
    nop
    nop
    nop
    ld h, a
    ld e, h
    ld e, h
    ld e, h
    ld e, h
    ld e, h
    ld e, l
    ld e, a
    ld e, [hl]
    ld e, a
    nop
    nop
    nop
    nop
    ld h, b
    ld e, h
    ld e, h
    ld e, h
    ld e, h
    ld e, h
    ld l, c
    nop
    ld h, e
    ld e, [hl]
    nop
    nop
    nop
    nop
    ld h, a
    ld e, h
    ld e, h
    ld e, h
    ld e, h
    ld l, b
    nop
    ld h, l
    nop
    ld e, a
    nop
    nop
    nop
    nop
    ld e, [hl]
    ld h, a
    ld e, h
    ld e, h
    ld e, h
    ld l, c
    ld h, l
    ld e, [hl]
    ld h, d
    nop
    nop
    nop
    ld e, [hl]
    ld h, [hl]
    ld h, d
    nop
    ld h, h
    ld e, h
    ld e, h
    ld e, l
    ld h, c
    nop
    nop
    nop
    nop
    ld h, l
    ld h, e
    ld e, a
    nop
    nop
    ld h, h
    ld e, h
    ld e, h
    ld l, c
    nop
    nop
    nop
    nop
    nop
    ld h, c
    nop
    ld e, [hl]
    ld h, l
    ld h, b
    ld e, h
    ld e, h
    ld l, c
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    ld h, d
    nop
    ld h, b
    ld e, h
    ld e, h
    ld l, b
    ld e, a
    ld e, [hl]
    nop
    nop
    ld h, l
    nop
    ld e, [hl]
    nop
    nop
    ld h, b
    ld e, h
    ld e, h
    ld e, h
    ld l, b
    nop
    ld h, d
    nop
    nop
    ld h, c
    ld h, e
    ld e, a
    nop
    nop
    ld h, a
    ld e, h
    ld e, h
    ld e, h
    ld e, h
    ld e, l
    nop
    nop
    ld h, [hl]
    nop
    ld h, c
    ld h, d
    nop
    nop
    nop
    ld h, a
    ld e, h
    ld e, h
    ld e, h
    ld e, h
    ld e, l
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    ld h, h
    ld e, h
    ld e, h
    ld e, h
    ld e, h
    ld e, l
    ld h, d
    nop
    ld h, c
    nop
    nop
    ld h, d
    ld h, [hl]
    nop
    ld h, h
    ld e, h
    ld e, h
    ld e, h
    ld e, h
    ld l, c
    ld h, c
    ld h, e
    nop
    nop
    nop
    ld h, l
    ld e, a
    nop
    ld h, a
    ld e, h
    ld e, h
    ld e, h
    ld l, c
    ld h, [hl]
    nop
    ld e, [hl]
    ld h, l
    nop
    nop
    ld h, [hl]
    nop
    nop
    ld h, b
    ld e, h
    ld e, h
    ld l, b
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    ld h, b
    ld e, h
    ld e, h
    ld e, h
    ld e, h
    ld e, l
    nop
    ld h, c
    nop
    nop
    nop
    nop
    nop
    nop
    ld h, a
    ld e, h
    ld e, h
    ld e, h
    ld e, h
    ld l, c
    ld h, l
    ld e, a
    nop
    nop
    nop
    nop
    nop
    ld h, [hl]
    nop
    ld h, h
    ld e, h
    ld e, h
    ld e, h
    ld e, l
    ld h, [hl]
    nop
    nop
    nop
    nop
    ld h, l
    ld h, e
    ld e, a
    ld h, b
    ld e, h
    ld e, h
    ld e, h
    ld e, h
    ld e, h
    ld e, l
    nop
    nop
    nop
    nop
    nop
    ld e, a
    ld h, b
    ld e, h
    ld e, h
    ld e, h
    ld e, h
    ld e, h
    ld e, h
    ld l, c
    nop
    nop
    nop
    nop
    nop
    nop
    ld h, a
    ld e, h
    ld e, h
    ld e, h
    ld e, h
    ld e, h
    ld l, b
    nop
    nop
    nop
    ld h, [hl]
    nop
    nop
    nop
    nop
    ld h, a
    ld e, h
    ld e, h
    ld e, h
    ld e, h
    ld l, c
    ld h, l
    nop
    ld e, [hl]
    ld e, a
    nop
    nop
    nop
    nop
    nop
    ld h, a
    ld e, h
    ld e, h
    ld l, b
    nop
    ld h, [hl]
    ld h, l
    ld h, e
    nop
    nop
    nop
    ld h, d
    nop
    ld h, [hl]
    nop
    ld h, h
    ld e, h
    ld e, h
    ld e, l
    nop
    ld h, c
    nop
    ld h, l
    nop
    ld h, l
    nop
    ld e, [hl]
    ld e, a
    ld h, b
    ld e, h
    ld e, h
    ld e, h
    ld e, h
    ld e, l
    nop
    nop
    nop
    nop
    ld h, c
    ld h, e
    nop
    ld h, b
    ld e, h
    ld e, h
    ld e, h
    ld e, h
    ld e, h
    ld l, c
    nop
    nop
    nop
    nop
    ld h, [hl]
    ld h, l
    ld h, d
    ld h, a
    ld e, h
    ld e, h
    ld e, h
    ld e, h
    ld l, c
    nop
    nop
    ld h, [hl]
    nop
    ld h, c
    ld h, d
    nop
    nop
    ld h, l
    ld h, h
    ld e, h
    ld e, h
    ld l, b
    ld h, d
    nop
    ld h, c
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    ld h, h
    ld e, h
    ld e, h
    ld e, h
    ld e, l
    ld h, l
    ld e, a
    ld h, c
    nop
    nop
    nop
    nop
    nop
    ld h, b
    ld e, h
    ld e, h
    ld e, h
    ld e, h
    ld l, b
    ld h, l
    ld h, e
    nop
    nop
    nop
    nop
    nop
    ld h, b
    ld e, h
    ld e, h
    ld e, h
    ld e, h
    ld e, h
    ld l, c
    ld h, [hl]
    nop
    ld h, l
    nop
    nop
    nop
    nop
    ld h, a
    ld e, h
    ld e, h
    ld e, h
    ld e, h
    ld l, b
    ld e, a
    ld h, [hl]
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    ld h, a
    ld e, h
    ld e, h
    ld e, h
    ld e, h
    ld e, l
    ld h, l
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    ld h, b
    ld e, h
    ld e, h
    ld e, h
    ld e, h
    ld e, h
    ld e, l
    nop
    nop
    nop
    nop
    nop
    ld h, c
    ld h, [hl]
    ld h, a
    ld e, h
    ld e, h
    ld e, h
    ld e, h
    ld e, h
    ld l, c
    nop
    nop
    ld h, [hl]
    nop
    nop
    ld h, l
    ld h, e
    ld h, l
    ld h, h
    ld e, h
    ld e, h
    ld e, h
    ld l, b
    ld h, d
    ld h, d
    ld h, c
    nop
    nop
    nop
    ld h, c
    nop
    ld e, [hl]
    ld h, a
    ld e, h
    ld e, h
    ld e, h
    ld l, b
    ld h, l
    ld h, e
    ld e, [hl]
    nop
    nop
    nop
    nop
    nop
    ld e, [hl]
    ld h, b
    ld e, h
    ld e, h
    ld e, h
    ld l, c
    ld e, [hl]
    ld e, a
    ld h, d
    ld h, [hl]
    nop
    nop
    nop
    nop
    nop
    ld h, h
    ld e, h
    ld e, h
    ld e, h
    ld e, l
    nop
    nop
    ld h, l
    nop
    nop
    ld h, c
    ld h, [hl]
    nop
    ld h, b
    ld e, h
    ld e, h
    ld e, h
    ld e, h
    ld e, h
    ld e, l
    nop
    nop
    nop
    ld h, l
    ld h, e
    ld e, a
    ld e, [hl]
    ld h, a
    ld e, h
    ld e, h
    ld e, h
    ld e, h
    ld e, h
    ld l, c
    nop
    ld h, d
    nop
    ld h, c
    nop
    ld e, a
    nop
    nop
    ld h, h
    ld e, h
    ld e, h
    ld e, h
    ld l, c
    nop
    nop
    ld h, c
    nop
    nop
    ld h, d
    nop
    nop
    nop
    ld h, h
    ld e, h
    ld e, h
    ld l, c
    nop
    nop
    ld h, l
    nop
    ld e, [hl]
    nop
    nop
    nop
    nop
    ld h, b
    ld e, h
    ld e, h
    ld e, h
    ld e, l
    nop
    ld h, l
    ld h, c
    ld h, e
    nop
    nop
    nop
    nop
    ld h, b
    ld e, h
    ld e, h
    ld e, h
    ld e, h
    ld e, h
    ld e, l
    nop
    ld h, c
    nop
    ld e, a
    ld e, a
    nop
    nop
    ld h, a
    ld e, h
    ld e, h
    ld e, h
    ld e, h
    ld e, h
    ld l, b
    nop
    nop
    nop
    nop
    ld h, d
    nop
    nop
    ld h, c
    ld h, a
    ld e, h
    ld e, h
    ld e, h
    ld e, h
    ld e, h
    ld e, l
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    ld h, h
    ld e, h
    ld e, h
    ld e, h
    ld e, h
    ld l, c
    ld e, [hl]
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    ld h, a
    ld e, h
    ld e, h
    ld e, h
    ld l, c
    ld h, l
    ld h, d
    nop
    nop
    nop
    nop
    nop
    nop
    ld h, c
    ld h, [hl]
    ld h, h
    ld e, h
    ld l, c
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    ld h, [hl]
    ld e, a
    ld h, a
    ld l, c
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
    ld h, d
    nop
    nop
    ld h, [hl]
    nop
    nop
    nop
    nop
    nop
    nop
    ld h, d
    nop
    nop
    ld h, [hl]
    nop
    ld h, e
    nop
    ld e, a
    nop
    ld h, [hl]
    nop
    nop
    ld h, d
    nop
    ld h, c
    nop
    ld h, e
    nop
    nop
    nop
    ld h, l
    nop
    ld e, [hl]
    nop
    nop
    nop
    nop
    ld h, l
    nop
    ld e, [hl]
    nop
    nop
    nop
    nop
    nop
    ld h, e
    nop
    nop
    nop
    nop
    nop
    nop
    ld h, e
    nop
    nop
    nop
    nop
    nop
    ld h, l
    nop
    ld e, a
    nop
    nop
    nop
    nop
    ld h, c
    nop
    ld e, [hl]
    nop
    nop
    nop
    nop
    nop
    ld e, a
    nop
    ld h, [hl]
    nop
    nop
    ld h, d
    nop
    ld h, c
    nop
    nop
    nop
    nop
    ld h, [hl]
    ld h, l
    nop
    ld e, [hl]
    nop
    nop
    nop
    nop
    ld h, l
    nop
    ld e, [hl]
    ld h, d
    nop
    ld h, e
    nop
    nop
    ld h, l
    nop
    ld h, [hl]
    nop
    nop
    ld h, d
    nop
    ld e, [hl]
    nop
    nop
    ld h, e
    ld e, l
    nop
    nop
    ld h, c
    ld h, e
    nop
    nop
    nop
    nop
    ld h, e
    ld e, a
    nop
    nop
    ld h, b
    ld e, h
    ld e, l
    nop
    nop
    ld e, a
    ld [hl], c
    ld [hl], d
    ld [hl], e
    ld [hl], h
    ld h, c
    nop
    nop
    ld h, b
    ld e, h
    ld e, h
    ld e, h
    ld e, l
    ld h, b
    ld e, l
    ld l, l
    ld l, [hl]
    ld l, a
    ld [hl], b
    ld h, b
    ld e, l
    ld h, b
    ld e, h
    ld e, h
    ld e, h
    ld e, h
    ld e, h
    ld e, h
    ld e, h
    ld e, l
    ld l, e
    ld l, h
    ld h, b
    ld e, h
    ld e, h
    ld e, h
    ld e, h
    ld e, h
    rst $38
    rst $30
    rst $38
    ld e, h
    dec a
    ld a, a
    db $eb
    ld e, l
    or $31
    add hl, sp
    ld b, l
    cp c
    dec l
    ; $57F0: stage 8 background block definitions; copy $0200 bytes to WRAM $D000.
    ; Source begins at byte offset +2 in the following instruction encoding.
    ld [$007e], a
    nop
    nop
    nop
    ld bc, $0201
    ld [bc], a
    inc bc
    inc bc
    nop
    nop
    nop
    nop
    inc b
    dec b
    nop
    nop
    ld b, $07
    nop
    ld [$0e00], sp
    add hl, bc
    ld a, [bc]
    rrca
    nop
    dec bc
    inc c
    nop
    db $10
    dec c

Jump_003_5811:
    nop
    ld de, $1200
    inc de
    ld d, $17
    inc d
    dec d
    jr jr_003_5835

    ld [bc], a
    ld h, d
    db $10
    ; $5820: stage 8 background map (block IDs); copy $0550 bytes to WRAM $D200.
    ; Source begins at byte offset +1 in the following instruction encoding.
    ld bc, $0000
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

jr_003_5835:
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
    nop
    nop
    add hl, bc
    ld a, [bc]
    add hl, bc
    ld a, [bc]
    add hl, bc
    ld a, [bc]
    add hl, bc
    ld a, [bc]
    add hl, bc
    ld a, [bc]
    add hl, bc
    ld a, [bc]
    add hl, bc
    ld a, [bc]
    nop
    nop
    nop
    nop
    nop
    nop
    dec b
    ld b, $07
    ld [$0000], sp
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    inc bc
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
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    ld [bc], a
    ld [bc], a
    ld [bc], a
    ld [bc], a
    ld [bc], a
    ld [bc], a
    ld [bc], a
    ld [bc], a
    ld [bc], a
    ld [bc], a
    ld [bc], a
    ld [bc], a
    ld [bc], a
    ld [bc], a
    ld bc, $0101
    ld bc, $0101
    ld bc, $0101
    ld bc, $0101
    ld bc, $0001
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
    rst $38

Data_003_58b0:
    db $00, $00, $00, $00, $01, $02, $02, $01, $03, $03, $00, $00, $00, $04, $13, $14
    db $05, $06, $15, $16, $07, $08, $17, $18, $09, $0a, $19, $1a, $0b, $0c, $1b, $1c
    db $0d, $0e, $1d, $1e, $0f, $10, $1f, $20, $11, $12, $21, $22, $23, $24, $32, $33
    db $25, $26, $34, $35, $27, $28, $36, $37, $29, $2a, $38, $39, $2b, $2c, $3a, $3b
    db $2d, $2e, $3c, $3d, $2f, $30, $3e, $3f, $31, $00, $40, $41, $42, $43, $52, $53
    db $44, $45, $00, $54, $46, $47, $00, $55, $48, $49, $56, $57, $4a, $4b, $58, $59
    db $4c, $4d, $00, $00, $4e, $4f, $5a, $5b, $50, $51, $00, $00, $5c, $5d, $62, $62
    db $5e, $5f, $62, $62, $60, $61, $62, $62, $48, $09, $00, $04, $00, $00, $00, $00
    ; End of startup data copied to $D000–$D07F (2×2 block tile definitions?)
Data_003_5930:
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $1b, $1c, $1b, $1b, $1b, $1c, $1c
    db $1b, $1d, $1b, $00, $00, $00, $00, $00, $13, $14, $15, $16, $17, $18, $19, $1a
    db $00, $00, $00, $00, $00, $00, $0b, $0c, $0d, $0e, $0f, $10, $11, $12, $00, $00
    db $00, $00, $00, $00, $03, $04, $05, $06, $07, $08, $09, $0a, $00, $00, $00, $00
    db $00, $02, $02, $02, $02, $02, $02, $02, $02, $02, $02, $00, $00, $00, $00, $01
    db $01, $01, $01, $01, $01, $01, $01, $01, $01, $00, $00, $00, $ff, $50, $0a, $12
    ; End of startup data copied to $D200–$D28F (Map of block IDs?)
    db $00, $00, $00, $00, $00, $00, $00, $03, $01, $02, $04, $05, $06, $07, $0a, $0b
    db $08, $09, $0c, $0d, $0e, $0f, $12, $13, $10, $11, $14, $15, $00, $00, $00, $19
    db $00, $16, $1a, $1b, $17, $18, $1c, $00, $1d, $1e, $22, $23, $1f, $20, $24, $25
    db $21, $00, $00, $00, $26, $27, $2c, $2d, $28, $29, $2e, $2f, $2a, $2b, $30, $31
    db $00, $00, $00, $02, $00, $00, $00, $00, $00, $08, $00, $10, $40, $40, $00, $00
    db $a6, $14, $00, $80, $00, $0c, $00, $10, $04, $4c, $00, $01, $80, $80, $00, $00
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
    db $00, $00, $0d, $0e, $0f, $0d, $0e, $0f, $0d, $0e, $0f, $0d, $00, $00, $00, $00
    db $00, $00, $00, $00, $00, $00, $0a, $0b, $0c, $00, $00, $00, $00, $00, $00, $00
    db $00, $00, $00, $00, $07, $08, $09, $00, $00, $00, $00, $00, $00, $00, $00, $00
    db $00, $00, $00, $00, $05, $06, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
    db $00, $00, $03, $04, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
    db $01, $02, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $ff, $80, $20, $90
    db $a1, $60, $08, $04, $02, $14, $80, $00, $20, $a1, $00, $06, $a0, $00, $00, $01
    db $00, $88, $8a, $02, $00, $02, $02, $00, $80, $10, $20, $28, $00, $00, $00, $12
    ; $5AD0: stage 7 background block definitions; copy $0200 bytes to WRAM $D000.
    db $00, $00, $00, $00, $00, $00, $05, $06, $01, $02, $07, $08, $03, $04, $00, $00
    db $00, $09, $0a, $0b, $00, $00, $10, $11, $0c, $0d, $12, $13, $0e, $0f, $14, $15
    db $00, $00, $00, $1d, $00, $00, $1e, $1f, $00, $00, $20, $21, $01, $16, $22, $23
    db $17, $18, $24, $25, $19, $1a, $26, $27, $1b, $1c, $28, $29, $00, $2a, $3d, $3e
    db $2b, $2c, $3f, $40, $2d, $2e, $41, $42, $2f, $30, $43, $44, $31, $32, $45, $46
    db $33, $34, $47, $48, $35, $36, $49, $4a, $37, $38, $4b, $4c, $39, $3a, $4d, $4e
    db $3b, $3c, $4f, $50, $00, $18, $00, $80, $00, $90, $00, $00, $28, $00, $00, $2d
    db $00, $07, $00, $0c, $20, $08, $00, $00, $00, $00, $00, $88, $00, $08, $00, $20
    ; $5B50: stage 7 background map (block IDs); copy $0550 bytes to WRAM $D200.
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
    db $00, $00, $0f, $10, $11, $12, $13, $14, $15, $16, $17, $18, $00, $00, $00, $00
    db $00, $00, $00, $08, $09, $0a, $0b, $0c, $0d, $0e, $00, $00, $00, $00, $00, $00
    db $00, $00, $00, $00, $00, $05, $06, $07, $00, $00, $00, $00, $00, $00, $00, $00
    db $00, $00, $00, $00, $00, $04, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $01, $02, $03, $00
    db $00, $00, $00, $00, $00, $00, $00, $01, $02, $03, $00, $00, $00, $00, $00, $00

    nop
    nop
    nop
    ld bc, $0302
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
    ld bc, $0302
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    ld bc, $0302
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
    nop
    rst $38
    nop
    jr z, jr_003_5c34

jr_003_5c34:
    ld bc, $0000
    nop
    nop
    nop
    jr nz, jr_003_5c3c

jr_003_5c3c:
    nop
    nop
    nop
    nop
    nop
    dec b
    nop
    nop
    ld [bc], a
    inc d
    nop
    nop
    nop
    nop
    nop
    ld bc, $0041
    nop
    ld bc, $0040
    ld b, b
    inc b
    nop
    nop
    ld b, b
    stop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    add c
    stop
    nop
    nop
    nop
    ld bc, $4000
    nop
    nop
    nop
    ld bc, $0010
    nop
    nop
    stop
    nop
    ld b, b
    nop
    nop
    nop
    nop
    nop
    add b
    nop
    nop
    stop
    ld b, b
    nop
    nop
    ld [$2000], sp
    ld bc, $0400
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
    ld [$1000], sp
    nop
    nop
    nop
    jr nz, jr_003_5c9a

jr_003_5c9a:
    ld [$0004], sp
    nop
    ld [$0000], sp
    nop
    add b
    nop
    nop
    nop
    nop
    nop
    ld b, b
    nop
    adc b
    nop
    inc b
    db $10
    ld [$0800], sp
    nop
    inc b
    nop
    jr nz, jr_003_5cf6

    nop
    nop
    ld [bc], a
    db $10
    and c
    nop
    ld [bc], a
    nop
    nop
    nop
    add b
    nop
    inc c
    nop
    nop
    nop
    ld bc, $0050
    nop
    nop
    nop
    nop
    nop
    nop
    dec b
    nop
    nop
    nop
    nop
    ld bc, $0004
    inc b
    nop
    nop
    nop
    nop
    nop
    nop
    inc b
    nop
    nop
    db $10
    db $10
    ld b, b
    inc h
    nop
    nop
    nop
    nop
    nop
    ld b, b
    nop
    jr nz, jr_003_5cee

jr_003_5cee:
    nop
    nop
    inc b
    nop
    nop
    nop
    nop
    nop

jr_003_5cf6:
    ld bc, $0200
    nop
    nop
    nop
    nop
    nop
    ld [$2000], sp
    ld b, b
    nop
    ld b, b
    inc b
    nop
    stop
    nop
    nop
    nop
    nop
    nop
    ld bc, $0000
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
    add b
    nop
    nop
    nop
    inc b
    nop
    nop
    nop
    jr nz, jr_003_5d26

jr_003_5d26:
    ld b, b
    nop
    ld b, h
    ld d, b
    db $10
    inc b
    inc b
    ld bc, $0000
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
    ld b, b
    nop
    ld [bc], a
    ld b, b
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
    add b
    inc b
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    stop
    ld [$0000], sp
    ld bc, $0000
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
    inc b
    nop
    ld h, h
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
    ld b, h
    nop
    add hl, bc
    ld bc, $0042
    inc b
    nop
    add b
    nop
    nop
    nop
    nop
    dec b
    inc b
    nop
    ld [de], a
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
    db $10
    stop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    ld [bc], a
    stop
    nop
    jr nz, jr_003_5dac

jr_003_5dac:
    ld a, [bc]
    nop
    nop
    nop
    nop
    nop
    jr nz, jr_003_5db4

jr_003_5db4:
    dec b
    nop
    stop
    add b
    stop
    ld bc, $0042
    nop
    nop
    add b
    inc b
    and b
    nop
    nop
    nop
    ld [bc], a
    nop
    db $10
    ld b, b
    inc b
    db $10
    ld b, l
    ld bc, $0040
    nop
    nop
    nop
    db $10
    ld b, b
    nop
    nop
    nop
    add hl, bc
    nop
    nop
    nop
    nop
    ld b, b
    ld bc, $1000
    ld bc, $0082
    nop
    nop
    inc b
    inc b
    inc b
    nop
    nop
    ld bc, $0109
    nop
    nop
    nop
    nop
    nop
    stop
    nop
    nop
    ld b, b
    nop
    ld b, b
    ld [bc], a
    nop
    inc b
    nop
    nop
    nop
    inc b
    nop
    ld [bc], a
    inc b
    jr nz, jr_003_5e0a

    ld [bc], a
    nop
    nop
    nop

jr_003_5e0a:
    jp nz, RST_00

    ld bc, $0004
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
    nop
    nop
    nop
    nop
    nop
    nop
    ld bc, $0008
    nop
    nop
    ld c, b
    nop
    nop
    inc b
    nop
    db $10
    jr nz, jr_003_5e76

    nop
    db $10
    ld [bc], a
    nop
    jr nz, @+$12

    ld b, b
    nop
    nop
    nop
    nop
    inc b
    ld de, $0000
    nop
    ld b, b
    stop
    nop
    ld bc, $0000
    nop
    nop
    nop
    nop
    db $10
    add b
    ld b, b
    ld [$0000], sp
    nop
    nop
    nop
    inc bc
    nop
    nop
    ld bc, $0010
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    ld bc, $0004
    ld [$0000], sp
    inc b
    nop
    inc b
    ld b, b
    nop
    nop
    nop
    nop
    nop

jr_003_5e76:
    nop
    db $10
    ld b, b
    ld bc, $0000
    nop
    nop
    inc b
    ld bc, $0020
    inc bc
    nop
    nop
    ld b, b
    inc bc
    nop
    inc b
    ld bc, $0000
    nop
    ld bc, $0000
    jr nz, jr_003_5ea2

    ld bc, $0000
    nop
    ld [de], a
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    ld bc, $0000
    nop

jr_003_5ea2:
    nop
    nop
    nop
    nop
    inc b
    nop
    nop
    nop
    jr nz, jr_003_5eac

jr_003_5eac:
    nop
    ld bc, $0000
    nop
    stop
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
    nop
    nop
    jr nz, jr_003_5ec8

jr_003_5ec8:
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    ld b, b
    nop
    ld b, b
    nop
    inc b
    nop
    ld b, b
    nop
    nop
    inc b
    ld [$0004], sp
    ld b, b
    nop
    ld b, b
    ld bc, $0000
    nop
    nop
    nop
    nop
    inc b
    nop
    nop
    ld [$0000], sp
    nop
    ld b, b
    nop
    nop
    inc b
    add b
    nop
    nop
    nop
    nop
    inc b
    ld bc, $0000
    nop
    nop
    nop
    nop
    nop
    ld [$0000], sp
    nop
    ld bc, $0400
    nop
    nop
    ld b, b
    nop
    nop
    ld h, b
    nop
    add b
    nop
    ret nz

    ld bc, $0000
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
    nop
    nop
    ld bc, $0000
    nop
    nop
    ld bc, $4000
    ld bc, $1000
    ld b, b
    inc b
    nop
    nop
    nop
    nop
    nop
    inc b
    add b
    nop
    ld bc, $0000
    ld b, b
    nop
    nop
    nop
    db $10
    ld bc, $4000
    nop
    stop
    inc b
    nop
    nop
    ld b, b
    nop
    nop
    nop
    nop
    nop
    nop
    ld a, [bc]
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    ld [$0200], sp
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    ld bc, $0040
    nop
    nop
    ld b, b
    nop
    nop
    nop
    nop
    ld l, b
    nop
    nop
    nop
    and b
    nop
    inc b
    ld d, b
    nop
    nop
    nop
    db $10
    jr nz, jr_003_5f78

jr_003_5f78:
    nop
    nop
    ld [$0000], sp
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
    ld bc, $0010
    ld b, b
    nop
    inc b
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    ld b, b
    ld [bc], a
    nop
    ld bc, $0001
    nop
    nop
    inc b
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
    inc b
    inc b
    ld bc, $0000
    nop
    nop
    nop
    nop
    nop
    ld bc, $0000
    nop
    ld bc, $0000
    nop
    ld [$0100], sp
    nop
    stop
    ld a, [de]
    nop
    ld b, b
    nop
    inc b
    nop
    nop
    nop
    nop
    ld bc, $5028
    nop
    nop
    inc b
    nop
    ld b, b
    dec b
    nop
    nop
    ld h, b
    stop
    nop
    add b
    ld bc, $0020
    nop
    nop
    nop
    nop
    nop
    stop
    nop
    stop
    jr nz, jr_003_5fec

jr_003_5fec:
    nop
    ld b, b
    add b
    ld b, b
    nop
    nop
    ld de, $0000
    ld b, b
    nop
    nop
    nop
    nop
    nop
    stop
    nop
    nop
    nop
    ; $6000: stage 0 source; table at $0EA5 selects this address.
    ; LoadStageDataToWram copies $0400 bytes to WRAM $D800.
    ; Grouped in five-byte lines for readability; event structure/use unconfirmed.
    db $b6, $85, $26, $e6, $bf
    db $ff, $ae, $ef, $ee, $fd
    db $b4, $ef, $8a, $df, $aa
    db $ff, $89, $ff, $b6, $fc
    db $e2, $ff, $ea, $ff, $a7
    db $fb, $bb, $db, $9b, $6f
    db $aa, $ff

    ; $6020: stage 1 event stream; table at $0EA5 selects this source.
    ; Copy $0400 bytes to WRAM $D800; the event reader uses these records to schedule handlers.
    ; Tick low, tick high, event type, packed parameters (two bytes).
    db $04, $00, $04, $00, $00
    db $20, $00, $13, $00, $00
    db $40, $00, $07, $60, $00
    db $48, $00, $07, $70, $00
    db $50, $00, $07, $80, $00
    db $58, $00, $07, $90, $00
    db $60, $00, $07, $a0, $00
    db $68, $00, $07, $b0, $00
    db $70, $00, $07, $c0, $00
    db $78, $00, $07, $d0, $00
    db $90, $00, $07, $80, $10
    db $98, $00, $07, $70, $10
    db $a0, $00, $07, $60, $10
    db $a8, $00, $07, $50, $10
    db $b0, $00, $07, $40, $10
    db $b8, $00, $07, $30, $10
    db $c0, $00, $07, $20, $10
    db $c8, $00, $07, $10, $10
    db $e0, $00, $05, $10, $00
    db $e8, $00, $05, $20, $00
    db $f0, $00, $05, $30, $00
    db $f8, $00, $05, $40, $00
    db $00, $01, $05, $41, $00
    db $08, $01, $05, $32, $00
    db $10, $01, $05, $23, $00
    db $18, $01, $05, $14, $00
    db $30, $01, $05, $d0, $10
    db $38, $01, $05, $c0, $10
    db $40, $01, $05, $b0, $10
    db $48, $01, $05, $a0, $10
    db $50, $01, $05, $a1, $10
    db $58, $01, $05, $b2, $10
    db $60, $01, $05, $c3, $10
    db $68, $01, $05, $d4, $10
    db $70, $01, $0b, $70, $00
    db $a0, $01, $07, $10, $10
    db $a8, $01, $0a, $d0, $02
    db $b0, $01, $07, $20, $10
    db $b8, $01, $0a, $d0, $02
    db $c0, $01, $07, $31, $10
    db $c8, $01, $0a, $d2, $02
    db $d0, $01, $07, $43, $10
    db $d8, $01, $0a, $d4, $02
    db $e0, $01, $05, $d0, $10
    db $e8, $01, $0a, $10, $12
    db $f0, $01, $05, $c0, $10
    db $f8, $01, $0a, $10, $12
    db $00, $02, $05, $b1, $10
    db $08, $02, $0a, $12, $12
    db $10, $02, $05, $a3, $10
    db $18, $02, $0a, $14, $12
    db $30, $02, $07, $10, $10
    db $34, $02, $07, $d0, $00
    db $38, $02, $07, $20, $10
    db $3c, $02, $07, $c0, $00
    db $40, $02, $07, $31, $10
    db $44, $02, $07, $b2, $00
    db $48, $02, $07, $43, $10
    db $4c, $02, $07, $a4, $00
    db $50, $02, $07, $50, $10
    db $54, $02, $07, $90, $00
    db $58, $02, $07, $60, $10
    db $5c, $02, $07, $80, $00
    db $60, $02, $07, $71, $10
    db $64, $02, $07, $72, $00
    db $68, $02, $07, $83, $10
    db $6c, $02, $07, $64, $00
    db $70, $02, $0b, $70, $00
    db $90, $02, $05, $11, $00
    db $94, $02, $07, $d4, $00
    db $98, $02, $05, $12, $00
    db $9c, $02, $07, $d3, $00
    db $a0, $02, $05, $13, $00
    db $a4, $02, $07, $d2, $00
    db $a8, $02, $05, $14, $00
    db $ac, $02, $07, $d1, $00
    db $d0, $02, $07, $11, $10
    db $d4, $02, $06, $d2, $11
    db $d8, $02, $07, $13, $10
    db $dc, $02, $06, $d4, $11
    db $e0, $02, $07, $11, $10
    db $e4, $02, $06, $d2, $11
    db $e8, $02, $07, $13, $10
    db $ec, $02, $06, $d4, $11
    db $10, $03, $06, $11, $01
    db $18, $03, $06, $20, $01
    db $20, $03, $06, $34, $01
    db $28, $03, $06, $40, $01
    db $40, $03, $06, $d2, $11
    db $48, $03, $06, $c0, $11
    db $50, $03, $06, $b3, $11
    db $58, $03, $06, $a0, $11
    db $70, $03, $06, $11, $01
    db $74, $03, $06, $d2, $11
    db $78, $03, $06, $23, $01
    db $7c, $03, $06, $c4, $11
    db $80, $03, $06, $31, $01
    db $84, $03, $06, $b2, $11
    db $88, $03, $06, $43, $01
    db $8c, $03, $06, $a4, $11
    db $90, $03, $0b, $70, $00
    db $a0, $03, $0a, $20, $02
    db $a8, $03, $0a, $c1, $02
    db $b0, $03, $0a, $40, $02
    db $b8, $03, $0a, $a2, $02
    db $c0, $03, $0a, $10, $02
    db $c8, $03, $0a, $d3, $02
    db $d0, $03, $0a, $30, $02
    db $d8, $03, $0a, $b4, $02
    db $e0, $03, $0a, $50, $02
    db $e8, $03, $0a, $95, $02
    db $f0, $03, $0a, $20, $02
    db $f8, $03, $0a, $c6, $02
    db $10, $04, $05, $00, $00
    db $18, $04, $0a, $d0, $02
    db $20, $04, $05, $20, $00
    db $28, $04, $0a, $d0, $02
    db $30, $04, $05, $40, $00
    db $38, $04, $0a, $d0, $02
    db $50, $04, $05, $81, $10
    db $58, $04, $0a, $12, $12
    db $60, $04, $05, $a3, $10
    db $68, $04, $0a, $14, $12
    db $70, $04, $05, $c1, $10
    db $78, $04, $0a, $12, $12
    db $80, $04, $0b, $70, $00
    db $a0, $04, $06, $10, $01
    db $a8, $04, $06, $d0, $11
    db $b0, $04, $06, $30, $01
    db $b8, $04, $06, $b0, $11
    db $c0, $04, $06, $51, $01
    db $c8, $04, $06, $92, $11
    db $d0, $04, $06, $23, $01
    db $d8, $04, $06, $c4, $11
    db $e0, $04, $07, $12, $10
    db $e4, $04, $07, $d3, $00
    db $e8, $04, $07, $24, $10
    db $ec, $04, $07, $c5, $00
    db $f0, $04, $07, $36, $10
    db $f4, $04, $07, $b7, $00
    db $f8, $04, $07, $48, $10
    db $fc, $04, $07, $a9, $00
    db $00, $05, $1d, $00, $00
    db $10, $05, $1c, $00, $00
    db $20, $05, $0e, $6b, $00
    db $30, $05, $00, $00, $00

    ; Bytes following the end-of-stream record.
    db $fa, $bf, $de, $f7, $fb, $ff
    db $ea, $ff, $fb, $fe, $8e, $ef, $7e, $b7, $be, $ff, $6c, $e7, $fe, $ff, $eb, $f1
    db $a8, $df, $3a, $5f, $c2, $7f, $ab, $7d, $fb, $fb, $bf, $ce, $fa, $ff, $8b, $e7
    db $ab, $fe, $af, $7f, $f9, $ef, $be, $f6, $bb, $cb, $ef, $ff, $86, $df, $f2, $fe
    db $ae, $f7, $7c, $d7, $ea, $79, $ef, $b1, $ee, $ff, $6c, $df, $ef, $9d, $ee, $7f
    db $da, $9b, $c5, $ff, $fa, $af, $7a, $ff, $b7, $ff, $ba, $fe, $bf, $fd, $eb, $bf
    db $aa, $bd, $2b, $f0, $ba, $b7, $a2, $7f, $ab, $d7, $ec, $7f, $ab, $ff, $ea, $ff
    db $1a, $f7, $aa, $fb, $ab, $df, $7e, $bf, $ff, $ef, $9f, $7f, $ae, $de, $aa, $ff
    db $6b, $fb, $7b, $e7, $6b, $fb, $ff, $f7, $ef, $77, $ef, $ff, $a7, $fc, $f6, $ff
    db $aa, $df, $fb, $ff, $6b, $ff, $c3, $ff, $ae, $be, $7e, $ef, $af, $ef, $cd, $7f
    db $ae, $f9, $db, $fc, $ff, $af, $bf, $bc, $ee, $f9, $3e, $5f, $da, $ff, $fb, $ff
    db $be, $bd, $f9, $be, $bb, $ef, $fa, $ef, $f7, $db, $fa, $5f, $73, $fe, $ee, $ff
    db $bb, $7f, $ef, $ff, $bf, $ef, $eb, $ff, $be, $fb, $af, $7f, $af, $bf, $ab, $ff
    db $ae, $7f, $ea, $fe, $eb, $ef, $7b, $ff, $ae, $ed, $0e, $ae, $af, $ff, $ea, $f9
    db $e7, $bd, $89, $8f, $da, $ff, $da, $fd, $7f, $b7, $3a, $bf, $fe, $bd, $ba, $ff
    db $b4, $ef, $6b, $fb, $bb, $a7, $ab, $ff, $8f, $ff, $9f, $ff, $c5, $d7, $7b, $ee
    db $2b, $fe, $e3, $ff, $ce, $fb, $be, $ff, $8a, $fb, $fe, $fe, $bb, $ff, $f7, $7b
    db $7f, $56, $d3, $75, $bd, $5f, $d8, $54, $ed, $7f, $df, $46, $94, $7f, $ae, $d5
    db $ee, $78, $d2, $fd, $c7, $50, $cf, $34, $98, $11, $da, $84, $3f, $15, $f5, $57
    ; $6420: stage 2 event stream; table at $0EA5 selects this source.
    ; Copy $0400 bytes to WRAM $D800; the event reader uses these records to schedule handlers.
    ; Tick low, tick high, event type, packed parameters (two bytes).
    db $04, $00, $04, $00, $00
    db $20, $00, $13, $00, $00
    db $30, $00, $07, $70, $00
    db $34, $00, $07, $90, $00
    db $38, $00, $07, $b0, $00
    db $3c, $00, $07, $d0, $00
    db $40, $00, $07, $70, $10
    db $44, $00, $07, $50, $10
    db $48, $00, $07, $30, $10
    db $4c, $00, $07, $10, $10
    db $50, $00, $07, $70, $00
    db $54, $00, $07, $90, $00
    db $58, $00, $07, $b0, $00
    db $5c, $00, $07, $d0, $00
    db $60, $00, $07, $70, $10
    db $64, $00, $07, $50, $10
    db $68, $00, $07, $30, $10
    db $6c, $00, $07, $10, $10
    db $80, $00, $08, $d1, $10
    db $88, $00, $08, $12, $00
    db $90, $00, $08, $d3, $10
    db $98, $00, $08, $14, $00
    db $a0, $00, $08, $d5, $10
    db $a8, $00, $08, $16, $00
    db $b0, $00, $0a, $d0, $12
    db $b8, $00, $0a, $10, $02
    db $c0, $00, $08, $71, $00
    db $c8, $00, $08, $72, $10
    db $d0, $00, $0a, $10, $02
    db $d8, $00, $0a, $d0, $12
    db $e0, $00, $08, $75, $00
    db $e8, $00, $08, $76, $10
    db $f0, $00, $0a, $10, $02
    db $f8, $00, $0a, $d0, $12
    db $00, $01, $08, $79, $00
    db $08, $01, $08, $77, $10
    db $10, $01, $0a, $10, $02
    db $18, $01, $0a, $d0, $12
    db $30, $01, $0b, $70, $00
    db $34, $01, $09, $d1, $00
    db $38, $01, $09, $12, $00
    db $3c, $01, $09, $d3, $00
    db $40, $01, $09, $14, $00
    db $44, $01, $09, $d1, $00
    db $48, $01, $09, $12, $00
    db $4c, $01, $09, $d3, $00
    db $60, $01, $07, $00, $10
    db $64, $01, $07, $11, $10
    db $68, $01, $07, $20, $10
    db $6c, $01, $07, $32, $10
    db $70, $01, $07, $40, $10
    db $74, $01, $07, $53, $10
    db $78, $01, $07, $60, $10
    db $7c, $01, $07, $74, $10
    db $80, $01, $07, $81, $00
    db $84, $01, $07, $92, $00
    db $88, $01, $07, $a3, $00
    db $8c, $01, $07, $b4, $00
    db $90, $01, $07, $c5, $00
    db $94, $01, $07, $d6, $00
    db $98, $01, $07, $e7, $00
    db $b0, $01, $07, $15, $10
    db $b4, $01, $07, $d9, $00
    db $b8, $01, $07, $51, $00
    db $bc, $01, $07, $99, $10
    db $c0, $01, $07, $12, $10
    db $c4, $01, $07, $d7, $00
    db $c8, $01, $07, $53, $00
    db $cc, $01, $07, $95, $10
    db $d0, $01, $07, $14, $10
    db $d4, $01, $07, $d5, $00
    db $d8, $01, $07, $55, $00
    db $dc, $01, $07, $93, $10
    db $e0, $01, $07, $11, $10
    db $e4, $01, $07, $d2, $00
    db $e8, $01, $07, $53, $00
    db $ec, $01, $07, $94, $10
    db $f0, $01, $0b, $70, $00
    db $00, $02, $06, $12, $01
    db $08, $02, $06, $19, $01
    db $10, $02, $06, $14, $01
    db $18, $02, $06, $17, $01
    db $20, $02, $06, $d6, $11
    db $28, $02, $06, $d5, $11
    db $30, $02, $06, $d8, $11
    db $38, $02, $06, $d4, $11
    db $40, $02, $06, $12, $01
    db $48, $02, $06, $d9, $11
    db $50, $02, $06, $14, $01
    db $58, $02, $06, $d7, $11
    db $60, $02, $06, $16, $01
    db $68, $02, $06, $d5, $11
    db $70, $02, $06, $18, $01
    db $78, $02, $06, $d3, $11
    db $90, $02, $07, $12, $10
    db $94, $02, $07, $d9, $00
    db $98, $02, $07, $24, $10
    db $9c, $02, $07, $c7, $00
    db $a0, $02, $07, $36, $10
    db $a4, $02, $07, $b5, $00
    db $a8, $02, $07, $48, $10
    db $ac, $02, $07, $a3, $00
    db $b0, $02, $25, $00, $00
    db $c0, $02, $08, $12, $00
    db $c4, $02, $08, $12, $00
    db $c8, $02, $08, $10, $00
    db $cc, $02, $08, $13, $00
    db $d0, $02, $08, $10, $00
    db $d4, $02, $08, $14, $00
    db $d8, $02, $08, $10, $00
    db $dc, $02, $08, $15, $00
    db $00, $03, $08, $d0, $10
    db $04, $03, $08, $d6, $10
    db $08, $03, $08, $d0, $10
    db $0c, $03, $08, $d7, $10
    db $10, $03, $08, $d0, $10
    db $14, $03, $08, $d8, $10
    db $18, $03, $08, $d0, $10
    db $1c, $03, $08, $d9, $10
    db $40, $03, $08, $40, $00
    db $44, $03, $0a, $d3, $12
    db $48, $03, $08, $34, $00
    db $4c, $03, $0a, $d5, $12
    db $50, $03, $08, $26, $00
    db $54, $03, $0a, $d7, $12
    db $58, $03, $08, $18, $00
    db $5c, $03, $0a, $d9, $12
    db $60, $03, $0b, $70, $00
    db $80, $03, $08, $a6, $10
    db $84, $03, $0a, $13, $02
    db $88, $03, $08, $b6, $10
    db $8c, $03, $0a, $15, $02
    db $90, $03, $08, $c6, $10
    db $94, $03, $0a, $17, $02
    db $98, $03, $08, $d6, $10
    db $9c, $03, $0a, $19, $02
    db $b0, $03, $1d, $00, $00
    db $c0, $03, $1c, $00, $00
    db $e0, $03, $0c, $6c, $00
    db $f0, $03, $00, $00, $00

    ; Bytes following the end-of-stream record.
    db $2f, $54, $2f, $d0
    db $e7, $5d, $bb, $5f, $6e, $91, $ff, $4e, $b4, $56, $6f, $51, $96, $3c, $9b, $55
    db $c3, $f1, $ae, $d5, $a7, $55, $5f, $f4, $be, $7e, $d7, $51, $ca, $d3, $5a, $54
    db $fd, $b2, $ef, $21, $df, $75, $7d, $67, $fa, $56, $f9, $cd, $7e, $d5, $ed, $10
    db $ff, $57, $f6, $24, $b6, $41, $fa, $19, $7c, $3b, $ef, $5d, $4f, $74, $eb, $56
    db $cf, $2c, $f7, $75, $cf, $61, $fc, $1f, $eb, $77, $af, $01, $ff, $54, $7e, $57
    db $bf, $e5, $db, $17, $fb, $75, $bf, $77, $df, $42, $f7, $05, $f6, $45, $df, $77
    db $e7, $5d, $df, $c5, $7e, $fd, $c7, $67, $df, $55, $ef, $7d, $e5, $50, $62, $93
    db $ff, $65, $3f, $d4, $79, $51, $d9, $4f, $0a, $57, $cb, $cd, $f3, $c9, $ff, $99
    db $f7, $5d, $ff, $11, $7a, $04, $18, $4d, $d9, $c5, $cf, $4d, $ff, $43, $df, $54
    db $af, $54, $ff, $e0, $ec, $05, $68, $ce, $fb, $75, $af, $15, $ee, $57, $ab, $45
    db $37, $67, $ff, $95, $bf, $41, $ea, $ad, $ff, $7b, $66, $94, $ff, $47, $f9, $9f
    db $fd, $71, $df, $f3, $3f, $dd, $3f, $f5, $f9, $13, $5f, $53, $4f, $5d, $ff, $70
    db $3b, $74, $c3, $53, $6e, $d4, $77, $0b, $ff, $61, $df, $75, $f7, $4d, $ab, $31
    db $f7, $19, $9f, $53, $b3, $f1, $db, $d5, $19, $3d, $ff, $75, $f7, $50, $af, $c5
    db $fb, $5f, $57, $5f, $fb, $05, $ef, $dd, $ae, $4e, $9e, $4c, $fb, $55, $ff, $dc
    db $ba, $54, $a1, $37, $6b, $91, $ff, $95, $a3, $20, $f9, $53, $f9, $56, $7f, $57
    db $7d, $35, $ab, $56, $2f, $17, $8f, $4c, $5a, $95, $ff, $26, $65, $cf, $7f, $1e
    db $f8, $74, $2f, $07, $7a, $5d, $ef, $70, $ff, $43, $7f, $47, $f2, $5b, $3f, $f7
    db $00, $90, $00, $20, $0a, $00, $00, $04, $08, $00, $20, $00, $08, $04, $80, $00
    db $00, $01, $20, $08, $0a, $80, $02, $18, $02, $c0, $08, $20, $00, $01, $00, $0c

    ; $6820: stage 3 event stream; table at $0EA5 selects this source.
    ; Copy $0400 bytes to WRAM $D800; the event reader uses these records to schedule handlers.
    ; Tick low, tick high, event type, packed parameters (two bytes).
    db $04, $00, $04, $00, $00
    db $20, $00, $13, $00, $00
    db $40, $00, $16, $12, $00
    db $48, $00, $16, $b9, $00
    db $50, $00, $16, $63, $00
    db $58, $00, $16, $d8, $00
    db $60, $00, $16, $34, $00
    db $68, $00, $16, $87, $00
    db $70, $00, $16, $16, $00
    db $78, $00, $16, $b2, $00
    db $80, $00, $16, $69, $00
    db $88, $00, $16, $d7, $00
    db $90, $00, $16, $14, $00
    db $98, $00, $16, $39, $00
    db $a0, $00, $16, $65, $00
    db $a8, $00, $16, $88, $00
    db $b0, $00, $16, $b5, $00
    db $b8, $00, $16, $d1, $00
    db $c0, $00, $0b, $79, $00
    db $d0, $00, $16, $14, $00
    db $d8, $00, $16, $d2, $00
    db $e0, $00, $21, $59, $00
    db $e8, $00, $21, $94, $10
    db $f0, $00, $16, $62, $00
    db $f8, $00, $16, $83, $00
    db $00, $01, $21, $17, $00
    db $08, $01, $21, $d1, $10
    db $10, $01, $16, $38, $00
    db $18, $01, $16, $b4, $00
    db $20, $01, $21, $59, $10
    db $28, $01, $21, $95, $00
    db $30, $01, $16, $68, $00
    db $38, $01, $16, $82, $00
    db $40, $01, $21, $16, $00
    db $48, $01, $21, $d3, $10
    db $50, $01, $16, $15, $00
    db $54, $01, $16, $d1, $00
    db $58, $01, $21, $53, $00
    db $5c, $01, $21, $98, $10
    db $60, $01, $16, $65, $00
    db $64, $01, $16, $88, $00
    db $68, $01, $21, $15, $00
    db $6c, $01, $21, $d9, $10
    db $70, $01, $16, $15, $00
    db $74, $01, $16, $d1, $00
    db $78, $01, $21, $53, $00
    db $7c, $01, $21, $98, $10
    db $80, $01, $16, $65, $00
    db $84, $01, $16, $88, $00
    db $88, $01, $21, $15, $00
    db $8c, $01, $21, $d9, $10
    db $90, $01, $0b, $70, $00
    db $a0, $01, $28, $37, $03
    db $a8, $01, $28, $89, $03
    db $b0, $01, $28, $d4, $03
    db $b8, $01, $16, $19, $00
    db $c0, $01, $16, $62, $00
    db $c8, $01, $16, $b7, $00
    db $d0, $01, $28, $15, $03
    db $d8, $01, $28, $62, $03
    db $e0, $01, $28, $b8, $03
    db $00, $02, $21, $91, $00
    db $04, $02, $21, $82, $00
    db $08, $02, $21, $93, $00
    db $0c, $02, $21, $84, $00
    db $10, $02, $21, $95, $00
    db $14, $02, $21, $86, $00
    db $18, $02, $21, $97, $00
    db $1c, $02, $21, $88, $00
    db $30, $02, $21, $51, $10
    db $34, $02, $21, $62, $10
    db $38, $02, $21, $53, $10
    db $3c, $02, $21, $64, $10
    db $40, $02, $21, $55, $10
    db $44, $02, $21, $66, $10
    db $48, $02, $21, $57, $10
    db $4c, $02, $21, $68, $10
    db $60, $02, $16, $61, $00
    db $64, $02, $16, $82, $00
    db $68, $02, $16, $66, $00
    db $6c, $02, $16, $87, $00
    db $70, $02, $16, $63, $00
    db $74, $02, $16, $84, $00
    db $78, $02, $16, $68, $00
    db $7c, $02, $16, $89, $00
    db $90, $02, $16, $18, $00
    db $94, $02, $16, $d4, $00
    db $98, $02, $16, $19, $00
    db $9c, $02, $16, $d5, $00
    db $a0, $02, $16, $18, $00
    db $a4, $02, $16, $d4, $00
    db $a8, $02, $16, $17, $00
    db $ac, $02, $16, $d5, $00
    db $b0, $02, $0b, $76, $00
    db $c0, $02, $28, $68, $03
    db $c8, $02, $16, $14, $00
    db $d0, $02, $16, $b6, $00
    db $d8, $02, $28, $89, $03
    db $e0, $02, $16, $37, $00
    db $e8, $02, $16, $d3, $00
    db $f0, $02, $28, $68, $03
    db $f8, $02, $16, $15, $00
    db $00, $03, $16, $b9, $00
    db $08, $03, $28, $89, $03
    db $10, $03, $16, $36, $00
    db $18, $03, $16, $d5, $00
    db $20, $03, $14, $11, $00
    db $30, $03, $14, $d2, $00
    db $40, $03, $14, $33, $00
    db $50, $03, $14, $b1, $00
    db $60, $03, $14, $62, $00
    db $70, $03, $14, $83, $00
    db $80, $03, $14, $12, $00
    db $90, $03, $14, $d3, $00
    db $b0, $03, $0b, $70, $00
    db $10, $04, $21, $50, $10
    db $14, $04, $21, $91, $00
    db $18, $04, $21, $52, $00
    db $1c, $04, $21, $93, $10
    db $20, $04, $21, $56, $10
    db $24, $04, $21, $97, $00
    db $28, $04, $21, $58, $00
    db $2c, $04, $21, $91, $10
    db $30, $04, $21, $52, $10
    db $34, $04, $21, $93, $00
    db $38, $04, $21, $56, $00
    db $3c, $04, $21, $97, $10
    db $40, $04, $21, $58, $10
    db $44, $04, $21, $91, $00
    db $48, $04, $21, $52, $00
    db $4c, $04, $21, $93, $10
    db $60, $04, $16, $16, $00
    db $64, $04, $16, $67, $00
    db $68, $04, $16, $b8, $00
    db $6c, $04, $16, $21, $00
    db $70, $04, $16, $82, $00
    db $74, $04, $16, $d3, $00
    db $78, $04, $16, $17, $00
    db $7c, $04, $16, $d8, $00
    db $90, $04, $28, $11, $03
    db $98, $04, $28, $d7, $03
    db $a0, $04, $16, $82, $00
    db $a8, $04, $16, $66, $00
    db $b0, $04, $16, $33, $00
    db $b8, $04, $16, $b5, $00
    db $c0, $04, $28, $84, $03
    db $c8, $04, $28, $64, $03
    db $d0, $04, $16, $15, $00
    db $d8, $04, $16, $d3, $00
    db $e0, $04, $21, $56, $00
    db $e8, $04, $21, $92, $10
    db $f0, $04, $21, $17, $00
    db $f8, $04, $21, $d1, $10
    db $00, $05, $1d, $00, $00
    db $10, $05, $1c, $00, $00
    db $40, $05, $2b, $6c, $00
    db $50, $05, $00, $00, $00

    ; Bytes following the end-of-stream record.
    db $05, $00, $a2, $02, $00, $04, $83, $28, $00, $00, $40, $80, $90, $28, $00, $00
    db $02, $20, $04, $00, $40, $20, $02, $00, $00, $02, $20, $28, $2c, $00, $10, $00
    db $00, $02, $00, $00, $10, $00, $00, $82, $00, $00, $40, $00, $00, $20, $00, $00
    db $00, $00, $5a, $84, $00, $00, $10, $80, $02, $00, $98, $80, $84, $02, $00, $22
    db $00, $88, $03, $00, $00, $00, $32, $06, $09, $20, $20, $00, $42, $a0, $00, $04
    db $40, $00, $00, $00, $80, $80, $00, $00, $40, $00, $20, $00, $04, $00, $02, $00
    db $21, $00, $40, $00, $42, $00, $24, $00, $05, $00, $00, $00, $04, $00, $82, $00
    db $98, $80, $90, $00, $44, $00, $20, $00, $06, $00, $00, $00, $40, $20, $10, $00
    db $44, $08, $00, $08, $a0, $08, $00, $00, $32, $00, $60, $00, $a2, $a2, $00, $00
    db $00, $18, $04, $08, $11, $08, $00, $00, $08, $00, $24, $00, $02, $00, $08, $00
    db $00, $08, $08, $00, $03, $02, $01, $21, $00, $00, $10, $00, $30, $80, $08, $20
    db $40, $00, $00, $08, $80, $00, $00, $00, $00, $80, $04, $00, $02, $00, $50, $02
    db $80, $20, $1c, $08, $00, $02, $20, $00, $00, $00, $04, $00, $51, $00, $64, $00
    db $10, $00, $00, $00, $00, $48, $40, $04, $00, $00, $00, $00, $40, $00, $00, $c0
    db $00, $00, $00, $00, $00, $00, $00, $80, $00, $01, $44, $00, $00, $00, $01

    ; $6C20: stage 4 event stream; table at $0EA5 selects this source.
    ; Copy $0400 bytes to WRAM $D800; the event reader uses these records to schedule handlers.
    ; Tick low, tick high, event type, packed parameters (two bytes).
    db $04, $00, $04, $00, $00
    db $20, $00, $13, $00, $00
    db $40, $00, $29, $02, $01
    db $48, $00, $29, $e3, $11
    db $50, $00, $29, $14, $01
    db $58, $00, $29, $d5, $11
    db $60, $00, $29, $26, $01
    db $68, $00, $29, $c7, $11
    db $70, $00, $29, $38, $01
    db $78, $00, $29, $b9, $11
    db $80, $00, $29, $72, $01
    db $88, $00, $29, $73, $11
    db $90, $00, $29, $54, $01
    db $98, $00, $29, $95, $11
    db $a0, $00, $29, $76, $01
    db $a8, $00, $29, $77, $11
    db $b0, $00, $29, $18, $01
    db $b8, $00, $29, $d9, $11
    db $c0, $00, $0b, $70, $00
    db $e0, $00, $20, $14, $00
    db $e8, $00, $20, $15, $00
    db $f0, $00, $20, $16, $00
    db $f8, $00, $20, $17, $00
    db $00, $01, $20, $18, $00
    db $08, $01, $20, $19, $00
    db $20, $01, $20, $d4, $10
    db $28, $01, $20, $d5, $10
    db $30, $01, $20, $d6, $10
    db $38, $01, $20, $d7, $10
    db $40, $01, $20, $d8, $10
    db $48, $01, $20, $d9, $10
    db $60, $01, $20, $11, $00
    db $64, $01, $20, $d2, $10
    db $68, $01, $20, $13, $00
    db $6c, $01, $20, $d4, $10
    db $70, $01, $20, $15, $00
    db $74, $01, $20, $d6, $10
    db $78, $01, $20, $17, $00
    db $7c, $01, $20, $d8, $10
    db $a0, $01, $0a, $42, $02
    db $a4, $01, $0a, $a3, $02
    db $a8, $01, $0a, $44, $02
    db $ac, $01, $0a, $a5, $02
    db $b0, $01, $0a, $46, $02
    db $b4, $01, $0a, $a7, $02
    db $b8, $01, $0a, $48, $02
    db $bc, $01, $0a, $a9, $02
    db $c0, $01, $0b, $70, $00
    db $f0, $01, $09, $15, $00
    db $f4, $01, $09, $d6, $00
    db $f8, $01, $09, $27, $00
    db $fc, $01, $09, $c8, $00
    db $00, $02, $09, $35, $00
    db $04, $02, $09, $b6, $00
    db $08, $02, $09, $47, $00
    db $0c, $02, $09, $a8, $00
    db $20, $02, $26, $72, $01
    db $28, $02, $26, $73, $11
    db $30, $02, $26, $74, $01
    db $38, $02, $26, $75, $11
    db $40, $02, $26, $76, $01
    db $48, $02, $26, $77, $11
    db $70, $02, $07, $12, $10
    db $78, $02, $07, $d3, $00
    db $80, $02, $07, $74, $00
    db $88, $02, $07, $75, $10
    db $90, $02, $07, $36, $10
    db $98, $02, $07, $b7, $00
    db $a0, $02, $07, $78, $00
    db $a8, $02, $07, $79, $10
    db $c0, $02, $07, $12, $10
    db $c4, $02, $07, $d9, $00
    db $c8, $02, $07, $54, $00
    db $cc, $02, $07, $97, $10
    db $d0, $02, $07, $15, $10
    db $d4, $02, $07, $d5, $00
    db $d8, $02, $07, $58, $00
    db $dc, $02, $07, $93, $10
    db $00, $03, $29, $12, $01
    db $08, $03, $29, $23, $01
    db $10, $03, $29, $34, $01
    db $18, $03, $29, $45, $01
    db $20, $03, $29, $56, $01
    db $28, $03, $29, $67, $01
    db $30, $03, $29, $78, $01
    db $38, $03, $29, $89, $01
    db $50, $03, $29, $d2, $11
    db $58, $03, $29, $c3, $11
    db $60, $03, $29, $b4, $11
    db $68, $03, $29, $a5, $11
    db $70, $03, $29, $96, $11
    db $78, $03, $29, $87, $11
    db $80, $03, $29, $78, $11
    db $88, $03, $29, $69, $11
    db $90, $03, $0b, $70, $00
    db $a0, $03, $0f, $67, $00
    db $c0, $03, $07, $1f, $10
    db $e0, $03, $07, $df, $00
    db $00, $04, $07, $1f, $10
    db $20, $04, $07, $df, $00
    db $40, $04, $07, $1f, $10
    db $60, $04, $07, $df, $00
    db $70, $04, $0b, $70, $00
    db $80, $04, $26, $34, $01
    db $88, $04, $26, $b5, $11
    db $90, $04, $26, $36, $01
    db $98, $04, $26, $b7, $11
    db $a0, $04, $26, $38, $01
    db $a8, $04, $26, $b9, $11
    db $c8, $04, $1d, $00, $00
    db $d0, $04, $1c, $00, $00
    db $20, $05, $17, $70, $00
    db $28, $05, $02, $00, $00
    db $3a, $05, $12, $20, $00
    db $3c, $05, $00, $00, $00

    ; Bytes following the end-of-stream record.
    db $00, $00, $00, $84, $00, $00, $00, $00, $00, $60, $00, $00, $00, $00, $00, $06
    db $00, $00, $00, $00, $04, $00, $01, $00, $00, $00, $00, $00, $00, $08, $00, $06
    db $00, $03, $01, $00, $10, $00, $00, $00, $00, $00, $00, $00, $00, $04, $10, $04
    db $00, $00, $00, $00, $04, $00, $00, $40, $00, $00, $10, $00, $00, $00, $00, $20
    db $00, $00, $00, $04, $00, $22, $10, $00, $01, $00, $00, $00, $01, $00, $00, $14
    db $40, $00, $00, $20, $00, $00, $00, $00, $00, $00, $00, $00, $10, $12, $00, $00
    db $00, $00, $00, $02, $40, $00, $40, $02, $00, $00, $00, $00, $00, $10, $00, $00
    db $00, $80, $04, $08, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
    db $00, $80, $00, $20, $01, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $01
    db $04, $20, $00, $01, $00, $00, $00, $40, $00, $00, $01, $00, $01, $00, $00, $00
    db $04, $11, $00, $00, $00, $00, $10, $02, $00, $30, $00, $00, $40, $00, $01, $00
    db $00, $01, $00, $80, $00, $00, $14, $00, $00, $08, $00, $08, $00, $00, $00, $00
    db $00, $00, $00, $00, $00, $01, $01, $00, $00, $00, $04, $02, $00, $00, $00, $40
    db $00, $00, $00, $00, $10, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
    db $00, $81, $00, $80, $40, $00, $01, $00, $50, $00, $00, $00, $00, $21, $10, $00
    db $00, $04, $00, $00, $00, $00, $40, $00, $00, $00, $00, $00, $00, $00, $00, $20
    db $40, $00, $04, $08, $00, $08, $00, $01, $01, $00, $00, $10, $00, $00, $00, $00
    db $00, $00, $00, $10, $00, $00, $00, $20, $00, $00, $00, $00, $00, $00, $00, $00
    db $00, $80, $00, $00, $00, $80, $00, $00, $00, $00, $14, $24, $00, $00, $00, $00
    db $00, $01, $00, $00, $00, $00, $01, $c0, $00, $00, $00, $10, $05, $00, $40, $01
    db $00, $80, $00, $02, $44, $00, $00, $08, $00, $00, $00, $10, $04, $00, $01, $08
    db $04, $00, $00, $00, $00, $00, $01, $04, $00, $00, $00, $00, $00, $00, $11, $01
    db $00, $00, $00, $00, $00, $90, $04, $00, $00, $80, $00, $00, $00, $08, $00, $00
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $c0, $00, $00, $01, $00, $04, $00
    db $00, $00, $00, $06, $00, $02, $01, $00, $00, $84, $00, $00, $00, $00, $04, $00
    db $10, $00, $01, $a0, $00, $00, $00, $00, $00, $00, $04, $00, $00, $40, $10, $00
    db $00, $af, $ff, $bf, $fc, $fe, $ff, $bf, $7f, $ac, $ef, $ae, $ff, $aa, $ff, $aa
    db $ef, $2f, $fb, $ef, $fe, $ba, $ff, $ba, $ff, $ff, $ff, $ba, $9b, $aa, $ff, $b2
    db $bf

    ; $7020: stage 5 event stream; table at $0EA5 selects this source.
    ; Copy $0400 bytes to WRAM $D800; the event reader uses these records to schedule handlers.
    ; Tick low, tick high, event type, packed parameters (two bytes).
    db $04, $00, $04, $00, $00
    db $20, $00, $13, $00, $00
    db $40, $00, $07, $16, $10
    db $44, $00, $07, $d7, $00
    db $48, $00, $07, $18, $10
    db $4c, $00, $07, $d9, $00
    db $50, $00, $07, $16, $10
    db $54, $00, $07, $d7, $00
    db $58, $00, $07, $18, $10
    db $5c, $00, $07, $d9, $00
    db $60, $00, $0b, $70, $00
    db $70, $00, $22, $00, $03
    db $78, $00, $22, $00, $13
    db $80, $00, $22, $00, $03
    db $88, $00, $22, $00, $13
    db $90, $00, $22, $00, $03
    db $98, $00, $22, $00, $13
    db $a0, $00, $22, $00, $03
    db $a8, $00, $22, $00, $03
    db $b0, $00, $22, $00, $13
    db $b4, $00, $22, $00, $03
    db $b8, $00, $22, $00, $03
    db $bc, $00, $22, $00, $03
    db $c0, $00, $22, $00, $13
    db $c4, $00, $22, $00, $03
    db $c8, $00, $22, $00, $13
    db $cc, $00, $22, $00, $03
    db $d0, $00, $22, $00, $13
    db $d4, $00, $22, $00, $03
    db $d8, $00, $22, $00, $13
    db $dc, $00, $22, $00, $03
    db $e0, $00, $0b, $70, $10
    db $f0, $00, $27, $22, $02
    db $f8, $00, $27, $c3, $12
    db $00, $01, $27, $24, $02
    db $08, $01, $27, $c5, $12
    db $10, $01, $27, $26, $02
    db $18, $01, $27, $c7, $12
    db $20, $01, $27, $28, $02
    db $28, $01, $27, $c9, $12
    db $40, $01, $10, $65, $00
    db $60, $01, $22, $00, $03
    db $80, $01, $22, $00, $03
    db $a0, $01, $22, $00, $03
    db $b0, $01, $22, $00, $03
    db $c0, $01, $22, $00, $03
    db $d0, $01, $22, $00, $03
    db $e0, $01, $22, $00, $03
    db $f0, $01, $22, $70, $03
    db $00, $02, $0b, $70, $00
    db $10, $02, $24, $16, $01
    db $18, $02, $24, $d7, $11
    db $20, $02, $24, $18, $01
    db $28, $02, $24, $d9, $11
    db $30, $02, $24, $16, $01
    db $38, $02, $24, $d7, $11
    db $40, $02, $24, $18, $01
    db $48, $02, $24, $d9, $11
    db $50, $02, $24, $38, $01
    db $58, $02, $24, $b9, $11
    db $60, $02, $24, $6e, $01
    db $68, $02, $24, $8f, $11
    db $70, $02, $22, $40, $03
    db $78, $02, $22, $c0, $13
    db $80, $02, $22, $70, $03
    db $88, $02, $22, $70, $13
    db $90, $02, $22, $40, $03
    db $98, $02, $22, $c0, $13
    db $a0, $02, $22, $70, $03
    db $a8, $02, $22, $70, $13
    db $b0, $02, $23, $12, $00
    db $b8, $02, $23, $33, $00
    db $c0, $02, $23, $54, $00
    db $c8, $02, $23, $75, $00
    db $d0, $02, $23, $d6, $10
    db $d8, $02, $23, $b7, $10
    db $e0, $02, $23, $98, $10
    db $e8, $02, $23, $79, $10
    db $00, $03, $23, $16, $00
    db $04, $03, $23, $de, $10
    db $08, $03, $23, $38, $00
    db $0c, $03, $23, $bf, $10
    db $10, $03, $23, $9d, $00
    db $14, $03, $23, $57, $10
    db $18, $03, $22, $a0, $03
    db $1c, $03, $22, $40, $13
    db $30, $03, $27, $26, $02
    db $38, $03, $27, $c7, $12
    db $40, $03, $27, $28, $02
    db $48, $03, $27, $c9, $12
    db $50, $03, $27, $22, $02
    db $58, $03, $27, $c3, $12
    db $60, $03, $27, $24, $02
    db $68, $03, $27, $c5, $12
    db $70, $03, $0b, $70, $00
    db $80, $03, $09, $19, $00
    db $84, $03, $09, $d5, $00
    db $88, $03, $09, $33, $00
    db $8c, $03, $09, $b6, $00
    db $90, $03, $09, $54, $00
    db $94, $03, $09, $98, $00
    db $a0, $03, $22, $00, $03
    db $a4, $03, $22, $00, $03
    db $a8, $03, $22, $00, $03
    db $ac, $03, $22, $00, $03
    db $b0, $03, $22, $00, $03
    db $b4, $03, $22, $00, $03
    db $b8, $03, $22, $00, $03
    db $bc, $03, $22, $00, $03
    db $c0, $03, $0b, $70, $00
    db $e0, $03, $07, $42, $10
    db $e4, $03, $07, $a9, $00
    db $e8, $03, $07, $33, $10
    db $ec, $03, $07, $b8, $00
    db $f0, $03, $07, $24, $10
    db $f4, $03, $07, $c7, $00
    db $f8, $03, $07, $15, $10
    db $fc, $03, $07, $d6, $00
    db $00, $04, $07, $46, $10
    db $04, $04, $07, $a5, $00
    db $08, $04, $07, $37, $10
    db $0c, $04, $07, $b4, $00
    db $10, $04, $07, $28, $10
    db $14, $04, $07, $c3, $00
    db $18, $04, $07, $19, $10
    db $1c, $04, $07, $d2, $00
    db $30, $04, $23, $12, $00
    db $34, $04, $22, $d0, $13
    db $38, $04, $23, $d4, $10
    db $3c, $04, $22, $d0, $13
    db $40, $04, $23, $86, $00
    db $44, $04, $22, $d0, $13
    db $48, $04, $23, $68, $10
    db $4c, $04, $22, $d0, $13
    db $70, $04, $24, $12, $01
    db $74, $04, $22, $d0, $13
    db $78, $04, $24, $d4, $11
    db $7c, $04, $22, $d0, $13
    db $80, $04, $24, $86, $01
    db $84, $04, $22, $d0, $13
    db $88, $04, $24, $68, $11
    db $8c, $04, $22, $d0, $13
    db $a0, $04, $0b, $70, $00
    db $b0, $04, $27, $32, $12
    db $b8, $04, $27, $b3, $02
    db $c0, $04, $27, $24, $12
    db $c8, $04, $27, $c5, $02
    db $d0, $04, $27, $4e, $12
    db $d8, $04, $27, $af, $02
    db $e0, $04, $27, $36, $12
    db $e8, $04, $27, $b7, $02
    db $00, $05, $23, $15, $00
    db $04, $05, $23, $d6, $10
    db $08, $05, $23, $87, $00
    db $0c, $05, $23, $68, $10
    db $10, $05, $22, $50, $03
    db $14, $05, $22, $90, $13
    db $18, $05, $22, $60, $03
    db $1c, $05, $22, $80, $13
    db $20, $05, $1d, $00, $00
    db $28, $05, $1c, $00, $00
    db $68, $05, $02, $00, $00
    db $70, $05, $18, $70, $00
    db $7a, $05, $12, $20, $00
    db $c0, $05, $00, $00, $00

    ; Bytes following the end-of-stream record.
    db $f7, $fe, $7f, $eb, $bd, $fb, $f3, $fa, $be, $bb, $f9, $6c, $f6, $c7, $6f, $88
    db $fd, $ef, $de, $de, $f7, $9e, $f9, $eb, $ff, $bf, $ff, $ff, $fe, $ee, $ff, $ea
    db $fe, $df, $fb, $ea, $7f, $ad, $e7, $fa, $ff, $a3, $fb, $ba, $ff, $e6, $fd, $ae
    db $ff, $be, $fe, $ef, $fe, $9e, $cf, $ae, $97, $5e, $ff, $6a, $ff, $b8, $ef, $bf
    db $eb, $ae, $f9, $aa, $cf, $9e, $ff, $fe, $f5, $f8, $7f, $9f, $f7, $e7, $d7, $fd
    db $bf, $f8, $ff, $ff, $f9, $aa, $fb, $b6, $bd, $2a, $6f, $be, $ff, $af, $fa, $ea
    db $df, $fe, $ff, $fa, $ff, $fa, $de, $ee, $dd, $f0, $ff, $3c, $fb, $eb, $ce, $aa
    db $af, $aa, $ff, $be, $ff, $ba, $ef, $f8, $fe, $7a, $f7, $be, $f7, $0e, $f6, $b6
    db $ff, $7c, $fa, $ec, $7f, $8b, $f9, $92, $ff, $bb, $b5, $af, $ff, $0f, $ff, $ef
    db $ff, $fa, $ff, $e8, $ff, $bf, $7f, $ee, $ff, $af, $fe, $ff, $df, $ee, $7f, $aa
    db $ff, $9f, $7f, $ee, $ef, $fa, $ff, $bf, $15, $ef, $7d, $ef, $1c, $fb, $4f, $fc
    db $41, $1f, $5f, $e7, $55, $df, $fd, $7b, $74, $ed, $41, $8e, $56, $ef, $57, $ba
    db $fb, $bc, $57, $a8, $23, $a9, $57

    ; $7420: stage 6 event stream; table at $0EA5 selects this source.
    ; Copy $0400 bytes to WRAM $D800; the event reader uses these records to schedule handlers.
    ; Tick low, tick high, event type, packed parameters (two bytes).
    db $04, $00, $04, $00, $00
    db $20, $00, $13, $00, $00
    db $40, $00, $0d, $16, $02
    db $48, $00, $0d, $d7, $12
    db $50, $00, $0d, $88, $02
    db $58, $00, $0d, $69, $12
    db $60, $00, $0d, $15, $02
    db $68, $00, $0d, $d6, $12
    db $70, $00, $0d, $8e, $02
    db $78, $00, $0d, $6f, $12
    db $90, $00, $2a, $18, $01
    db $94, $00, $2a, $d9, $11
    db $98, $00, $2a, $9c, $01
    db $9c, $00, $2a, $5d, $11
    db $a0, $00, $2a, $16, $01
    db $a4, $00, $2a, $d7, $11
    db $a8, $00, $2a, $8e, $01
    db $ac, $00, $2a, $6f, $11
    db $b0, $00, $0b, $70, $00
    db $d0, $00, $23, $17, $00
    db $d8, $00, $23, $d8, $10
    db $e0, $00, $23, $9d, $00
    db $e8, $00, $23, $5e, $10
    db $00, $01, $11, $65, $00
    db $10, $01, $22, $00, $03
    db $20, $01, $0a, $7f, $02
    db $30, $01, $22, $00, $03
    db $40, $01, $0a, $7f, $02
    db $50, $01, $22, $00, $03
    db $60, $01, $0a, $7f, $02
    db $70, $01, $22, $00, $03
    db $80, $01, $0a, $70, $02
    db $90, $01, $22, $00, $03
    db $a0, $01, $0b, $70, $02
    db $b0, $01, $22, $00, $03
    db $b4, $01, $22, $00, $03
    db $b8, $01, $22, $00, $03
    db $bc, $01, $22, $00, $03
    db $d0, $01, $2a, $36, $01
    db $d4, $01, $2a, $47, $01
    db $d8, $01, $2a, $58, $01
    db $dc, $01, $2a, $69, $01
    db $e0, $01, $2a, $7c, $01
    db $e4, $01, $2a, $8d, $01
    db $e8, $01, $2a, $9e, $01
    db $ec, $01, $22, $00, $03
    db $00, $02, $2a, $b0, $11
    db $04, $02, $2a, $a0, $11
    db $08, $02, $2a, $90, $11
    db $0c, $02, $2a, $80, $11
    db $10, $02, $2a, $70, $11
    db $14, $02, $2a, $60, $11
    db $18, $02, $2a, $50, $11
    db $1c, $02, $22, $00, $13
    db $20, $02, $0b, $70, $00
    db $30, $02, $07, $26, $10
    db $34, $02, $07, $37, $10
    db $38, $02, $07, $48, $10
    db $3c, $02, $07, $59, $10
    db $40, $02, $07, $64, $10
    db $44, $02, $07, $75, $10
    db $48, $02, $07, $86, $10
    db $4c, $02, $07, $97, $10
    db $60, $02, $07, $d6, $00
    db $64, $02, $07, $c7, $00
    db $68, $02, $07, $b8, $00
    db $6c, $02, $07, $a9, $00
    db $70, $02, $07, $94, $00
    db $74, $02, $07, $85, $00
    db $78, $02, $07, $76, $00
    db $7c, $02, $07, $67, $00
    db $90, $02, $05, $16, $00
    db $98, $02, $05, $d7, $10
    db $a0, $02, $05, $38, $00
    db $a8, $02, $05, $b9, $10
    db $b0, $02, $05, $26, $00
    db $b8, $02, $05, $c7, $10
    db $c0, $02, $05, $58, $00
    db $c8, $02, $05, $99, $10
    db $d0, $02, $0b, $70, $00
    db $e0, $02, $08, $12, $00
    db $e4, $02, $08, $13, $00
    db $e8, $02, $08, $14, $00
    db $ec, $02, $08, $15, $00
    db $f0, $02, $08, $16, $00
    db $f4, $02, $08, $17, $00
    db $f8, $02, $22, $00, $03
    db $fc, $02, $22, $00, $03
    db $20, $03, $08, $d2, $10
    db $24, $03, $08, $d3, $10
    db $28, $03, $08, $d4, $10
    db $2c, $03, $08, $d5, $10
    db $30, $03, $08, $d6, $10
    db $34, $03, $08, $d7, $10
    db $38, $03, $22, $00, $13
    db $3c, $03, $22, $00, $13
    db $50, $03, $0a, $16, $02
    db $58, $03, $0a, $d7, $12
    db $60, $03, $0a, $38, $02
    db $68, $03, $0a, $b9, $12
    db $70, $03, $0a, $5c, $02
    db $78, $03, $0a, $ad, $12
    db $80, $03, $0a, $2e, $02
    db $88, $03, $0a, $cf, $12
    db $90, $03, $0b, $70, $00
    db $a0, $03, $27, $22, $02
    db $a4, $03, $27, $c3, $12
    db $a8, $03, $27, $24, $02
    db $ac, $03, $27, $c5, $12
    db $b0, $03, $27, $26, $02
    db $b4, $03, $27, $c7, $12
    db $b8, $03, $27, $28, $02
    db $bc, $03, $27, $c9, $12
    db $d0, $03, $20, $72, $00
    db $d4, $03, $20, $73, $10
    db $d8, $03, $20, $74, $00
    db $dc, $03, $20, $75, $10
    db $e0, $03, $20, $76, $00
    db $e4, $03, $20, $77, $10
    db $e8, $03, $20, $78, $00
    db $ec, $03, $22, $00, $13
    db $10, $04, $29, $72, $01
    db $18, $04, $29, $73, $11
    db $20, $04, $29, $74, $01
    db $28, $04, $29, $75, $11
    db $30, $04, $29, $76, $01
    db $38, $04, $29, $77, $11
    db $40, $04, $29, $78, $01
    db $48, $04, $22, $00, $13
    db $50, $04, $0b, $70, $00
    db $60, $04, $07, $52, $10
    db $64, $04, $07, $93, $00
    db $68, $04, $07, $44, $10
    db $6c, $04, $07, $a5, $00
    db $70, $04, $07, $36, $10
    db $74, $04, $07, $b7, $00
    db $78, $04, $07, $28, $10
    db $7c, $04, $07, $c9, $00
    db $90, $04, $22, $00, $13
    db $94, $04, $22, $00, $03
    db $98, $04, $22, $00, $13
    db $9c, $04, $22, $00, $03
    db $a0, $04, $22, $00, $03
    db $a4, $04, $22, $00, $03
    db $a8, $04, $22, $00, $03
    db $ac, $04, $22, $00, $03
    db $c0, $04, $1d, $00, $00
    db $c8, $04, $1c, $00, $00
    db $d0, $04, $29, $13, $01
    db $d8, $04, $29, $d7, $11
    db $e0, $04, $29, $34, $01
    db $e8, $04, $29, $b6, $11
    db $f0, $04, $29, $55, $01
    db $f8, $04, $29, $95, $11
    db $00, $05, $29, $26, $01
    db $04, $05, $02, $62, $00
    db $08, $05, $29, $b4, $11
    db $20, $05, $22, $20, $03
    db $28, $05, $22, $b0, $13
    db $70, $05, $0f, $67, $00
    db $90, $05, $22, $00, $03
    db $b0, $05, $22, $00, $03
    db $d0, $05, $22, $00, $03
    db $f0, $05, $22, $00, $03
    db $10, $06, $22, $00, $03
    db $30, $06, $22, $00, $03
    db $50, $06, $0b, $70, $00
    db $80, $06, $10, $65, $00
    db $a0, $06, $22, $00, $03
    db $c0, $06, $22, $00, $03
    db $e0, $06, $22, $00, $03
    db $00, $07, $0b, $70, $00
    db $50, $07, $11, $65, $00
    db $70, $07, $22, $00, $03
    db $80, $07, $22, $00, $03
    db $90, $07, $22, $00, $03
    db $a0, $07, $22, $00, $03
    db $b0, $07, $22, $00, $03
    db $c0, $07, $22, $00, $03
    db $c4, $07, $15, $00, $00
    db $d0, $07, $0b, $70, $00
    db $10, $08, $1d, $00, $00
    db $28, $08, $1e, $00, $00
    db $2c, $08, $02, $00, $00
    db $30, $08, $19, $7c, $00
    db $34, $08, $12, $20, $00
    db $38, $08, $00, $00, $00

    ; Bytes following the end-of-stream record.
    db $55, $f7, $54, $e9, $89, $3e, $51, $d4, $d5, $a3, $6b, $b7, $55, $2d, $1c, $fd
    db $71, $71, $d8, $3d, $15, $f4, $d5, $8a, $55, $ef, $51, $ff, $53, $5f, $d6, $5f
    db $51, $d5, $58, $ff, $23, $fd, $55, $bf, $e5, $f9, $57, $fb, $37, $4a, $35, $9f
    db $9f, $df, $ff, $fd, $11, $7e, $6d, $19, $16, $00, $04, $00, $02, $00, $02, $80
    db $00, $02, $84, $00, $00, $80, $00, $02, $00, $08, $08, $09, $d0, $00, $0b, $00
    db $00, $00, $00, $00, $00, $02, $00, $20, $00

    ; $7820: stage 7 event stream; table at $0EA5 selects this source.
    ; Copy $0400 bytes to WRAM $D800; the event reader uses these records to schedule handlers.
    ; Tick low, tick high, event type, packed parameters (two bytes).
    db $00, $00, $02, $00, $00
    db $08, $00, $13, $00, $00
    db $20, $00, $00, $00, $00

    ; Bytes following the end-of-stream record.
    db $23, $00, $00, $00, $00, $00, $01, $a0, $21, $02, $10, $20, $c0, $00, $48, $00
    db $80

    ; $7840: stage 8 event stream; table at $0EA5 selects this source.
    ; Copy $0400 bytes to WRAM $D800; the event reader uses these records to schedule handlers.
    ; Tick low, tick high, event type, packed parameters (two bytes).
    db $00, $00, $02, $00, $00
    db $10, $00, $13, $00, $00
    db $20, $00, $00, $00, $00

    ; Bytes following the end-of-stream record.
    db $12, $20, $00, $00, $08, $00, $08, $82, $02, $20, $10, $a0, $01, $20, $01, $00
    db $80, $00, $00, $02, $00, $00, $40, $00, $04, $20, $00, $80, $10, $80, $04, $00
    db $04, $00, $04, $20, $50, $02, $10, $00, $20, $0a, $00, $08, $01, $00, $18, $00
    db $80, $00, $00, $80, $0d, $00, $42, $20, $04, $02, $20, $00, $80, $08, $00, $00
    db $80, $00, $00, $20, $10, $00, $10, $00, $51, $00, $41, $00, $00, $80, $00, $00
    db $00, $00, $0c, $00, $04, $80, $00, $80, $04, $00, $24, $00, $10, $02, $10, $00
    db $40, $20, $10, $01, $21, $00, $c0, $00, $18, $08, $01, $00, $32, $02, $00, $00
    db $0c, $00, $00, $00, $01, $00, $02, $20, $00, $00, $20, $00, $08, $08, $00, $00
    db $04, $24, $81, $20, $00, $00, $11, $20, $0c, $00, $00, $02, $98, $00, $80, $00
    db $30, $20, $11, $00, $00, $00, $9c, $02, $86, $08, $80, $00, $80, $00, $81, $20
    db $20, $80, $90, $82, $80, $80, $a8, $00, $40, $00, $04, $00, $00, $00, $34, $20
    db $40, $00, $00, $00, $10, $00, $20, $00, $00, $80, $20, $00, $00, $20, $20, $00
    db $00, $20, $00, $a8, $c2, $00, $00, $00, $21, $22, $08, $00, $00, $00, $00, $00
    db $42, $00, $08, $80, $a4, $00, $00, $00, $10, $04, $00, $00, $00, $00, $00, $02
    db $24, $80, $c0, $02, $00, $20, $84, $80, $40, $00, $00, $80, $05, $00, $00, $20
    db $60, $08, $10, $00, $05, $a0, $08, $02, $40, $00, $01, $88, $00, $08, $00, $00
    db $00, $00, $08, $80, $82, $00, $80, $00, $11, $02, $80, $80, $00, $22, $00, $00
    db $02, $00, $00, $80, $20, $0a, $a0, $00, $81, $00, $41, $02, $80, $00, $08, $40
    db $20, $00, $00, $08, $40, $80, $40, $80, $00, $a0, $40, $00, $01, $02, $04, $00
    db $1e, $02, $00, $00, $40, $08, $00, $80, $01, $20, $00, $00, $60, $00, $04, $80
    db $00, $20, $02, $08, $20, $00, $01, $08, $00, $00, $90, $02, $82, $02, $10, $20
    db $30, $80, $40, $30, $08, $00, $00, $00, $00, $00, $04, $08, $08, $00, $0c, $80
    db $50, $00, $10, $84, $40, $00, $65, $02, $a0, $28, $87, $20, $0c, $00, $41, $00
    db $40, $00, $40, $00, $00, $82, $00, $00, $00, $00, $40, $00, $10, $08, $00, $00
    db $18, $08, $00, $00, $00, $20, $00, $00, $00, $00, $14, $00, $00, $80, $32, $02
    db $09, $00, $0c, $00, $00, $00, $04, $08, $05, $02, $32, $00, $30, $0a, $60, $00
    db $24, $00, $06, $00, $03, $00, $90, $00, $28, $20, $08, $20, $80, $00, $98, $00
    db $86, $00, $00, $00, $02, $00, $08, $00, $00, $00, $02, $20, $80, $00, $00, $80
    db $00, $00, $00, $00, $20, $00, $00, $00, $20, $00, $10, $00, $10, $00, $90, $00
    db $10, $00, $00, $00, $20, $00, $00, $08, $04, $00, $10, $00, $00, $00, $04, $00
    db $a0, $20, $00, $88, $02, $00, $0c, $82, $18, $80, $23, $02, $00, $00, $13, $00
    db $40, $00, $00, $20, $00, $80, $00, $00, $04, $00, $20, $00, $00, $20, $00, $80
    db $10, $00, $00, $02, $84, $00, $80, $00, $02, $10, $00, $00, $40, $02, $04, $0a
    db $00, $00, $80, $00, $b0, $00, $00, $00, $00, $80, $00, $02, $0a, $00, $20, $00
    db $22, $00, $49, $80, $20, $08, $92, $02, $41, $00, $64, $00, $00, $22, $81, $00
    db $01, $00, $00, $00, $02, $00, $00, $20, $20, $02, $00, $08, $08, $00, $08, $80
    db $00, $28, $00, $00, $40, $00, $00, $00, $90, $80, $00, $00, $40, $00, $10, $02
    db $24, $00, $00, $00, $40, $20, $50, $00, $20, $82, $50, $00, $00, $00, $00, $00
    db $00, $00, $00, $00, $41, $00, $20, $80, $04, $02, $12, $08, $08, $00, $03, $02
    db $a0, $00, $38, $00, $80, $08, $00, $02, $00, $20, $00, $00, $00, $02, $02, $00
    db $00, $00, $14, $00, $08, $00, $82, $08, $80, $02, $00, $00, $10, $00, $10, $00
    db $00, $08, $00, $00, $40, $02, $18, $02, $00, $00, $08, $00, $00, $00, $00, $00
    db $10, $00, $00, $20, $11, $82, $00, $80, $10, $00, $08, $00, $20, $00, $00, $00
    db $48, $00, $00, $80, $00, $a0, $00, $00, $00, $00, $00, $00, $00, $02, $02, $00
    db $00, $00, $00, $02, $00, $02, $74, $02, $20, $00, $20, $a0, $00, $08, $12, $00
    db $20, $00, $04, $00, $05, $20, $00, $02, $10, $00, $00, $00, $10, $82, $40, $00
    db $10, $20, $30, $00, $00, $00, $00, $80, $20, $20, $98, $08, $d1, $00, $86, $00
    db $1b, $00, $00, $00, $00, $00, $01, $00, $00, $02, $00, $00, $08, $00, $00, $00
    db $00, $80, $00, $00, $50, $00, $20, $00, $a8, $00, $00, $20, $18, $80, $20, $00
    db $06, $08, $00, $00, $80, $80, $00, $02, $00, $00, $00, $22, $02, $00, $00, $00
    db $88, $80, $40, $00, $00, $00, $18, $08, $08, $80, $00, $00, $05, $00, $1a, $00
    db $06, $80, $00, $00, $08, $08, $00, $00, $09, $80, $21, $00, $60, $00, $80, $00
    db $04, $28, $04, $00, $00, $00, $21, $00, $00, $80, $00, $10, $80, $00, $04, $00
    db $20, $00, $80, $00, $20, $00, $00, $00, $80, $02, $00, $02, $88, $00, $00, $00
    db $40, $00, $08, $00, $08, $48, $08, $18, $01, $02, $00, $00, $50, $00, $20, $02
    db $00, $00, $00, $80, $80, $00, $00, $00, $00, $02, $00, $00, $00, $00, $09, $00
    db $05, $00, $10, $08, $0a, $20, $80, $82, $40, $00, $c0, $00, $10, $a8, $00, $00
    db $01, $02, $00, $00, $02, $22, $00, $08, $80, $00, $c0, $00, $11, $20, $10, $08
    db $00, $00, $00, $00, $06, $02, $00, $02, $02, $00, $00, $00, $00, $20, $00, $00
    db $40, $81, $00, $00, $01, $00, $00, $10, $01, $80, $00, $00, $00, $00, $40, $10
    db $10, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $20, $00
    db $00, $00, $00, $00, $00, $00, $00, $08, $40, $00, $00, $04, $00, $00, $00, $00
    db $00, $00, $00, $18, $40, $00, $00, $82, $10, $00, $00, $00, $00, $10, $00, $00
    db $00

    nop
    nop
    nop
    nop
    add b
    ld b, b
    nop
    nop
    adc b
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
    ld b, b
    nop
    nop
    nop
    nop
    inc b
    dec b
    nop
    sub b
    nop
    ld bc, $0000
    nop
    and b
    nop
    jr nz, jr_003_7ca6

    add b
    nop
    nop
    nop
    ld a, [bc]
    ld b, c
    jr nz, jr_003_7c6e

jr_003_7c6e:
    nop
    nop
    ld b, b
    ld bc, $0000

jr_003_7c74:
    nop
    nop
    nop
    nop
    nop
    db $10
    stop
    ld de, $0000
    nop
    nop
    db $10
    db $10
    db $10
    add b
    nop
    ret nz

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
    db $10
    inc b
    nop
    nop
    ld b, b
    nop
    nop
    nop
    inc b
    inc b
    nop
    inc d
    nop
    nop
    nop
    stop
    nop
    stop
    nop

jr_003_7ca6:
    nop
    nop
    nop
    nop
    inc b
    nop
    ld [$0000], sp
    nop
    add b
    ld d, b
    nop
    ld bc, $0000
    ld [bc], a
    nop
    jr nz, jr_003_7cba

jr_003_7cba:
    nop
    nop
    nop
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
    nop
    ld bc, $0082
    nop
    nop
    inc h
    nop
    nop
    nop
    nop
    nop
    add b
    ld bc, $0000
    ld c, b
    nop
    inc b
    nop
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
    inc b
    inc b
    nop
    inc b
    ld b, b
    nop
    ld [$0010], sp
    ld b, b
    ld b, b
    inc b
    nop
    nop
    ld b, b
    nop
    add b
    nop
    jr nz, jr_003_7cfa

jr_003_7cfa:
    nop
    nop
    nop
    nop
    nop
    nop
    inc b
    nop
    ld [bc], a
    nop
    inc d
    nop
    nop
    stop
    nop
    ld bc, $0000
    nop
    ld bc, $0440
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    jr nz, jr_003_7d1a

jr_003_7d1a:
    nop
    nop
    nop
    nop
    ld [bc], a
    nop
    ld bc, $0000
    nop
    nop
    nop
    add b
    db $10
    ld [$0000], sp
    nop
    nop
    nop
    inc b
    inc b
    adc b
    ld bc, $0080
    nop
    nop
    ld [bc], a
    nop
    nop
    nop
    ld [bc], a
    nop
    nop
    nop
    ld [$0000], sp
    db $10
    ld b, b
    ld bc, $0000
    nop
    stop
    nop
    stop
    ld b, h
    nop
    nop
    nop
    nop
    nop
    ld a, [bc]
    nop
    nop
    nop
    nop
    ld de, $0000
    nop
    nop
    dec b
    nop
    nop
    ld b, b
    nop
    nop
    nop
    inc b
    nop
    nop
    stop
    ld [bc], a
    nop
    nop
    nop
    nop
    nop
    nop
    inc d
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    ld b, b
    inc d
    nop
    nop
    stop
    ld bc, $0100
    inc c
    nop
    nop
    nop
    jr nz, jr_003_7d86

jr_003_7d86:
    nop
    nop
    nop
    ld b, h
    nop
    stop
    ld bc, $0000
    inc bc
    nop
    nop
    nop
    add b
    nop
    ld [bc], a
    stop
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
    jr nz, jr_003_7da6

jr_003_7da6:
    ld [$0100], sp
    nop
    add b
    nop
    dec b
    nop
    nop
    nop
    nop
    nop
    ld b, b
    nop
    nop
    ld bc, $0009
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
    inc b
    nop
    ld [hl+], a
    nop
    nop
    nop
    inc b
    nop
    nop
    nop
    nop
    ld b, b
    add b
    nop
    nop
    nop
    ld [$0000], sp
    nop
    nop
    nop
    ld b, d
    nop
    nop
    ld b, b
    nop
    nop
    nop
    nop
    ld [$0201], sp
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    ld [hl-], a
    nop
    nop
    nop
    stop
    nop
    nop
    nop
    ld bc, $0000
    ld [$0004], sp
    nop
    nop
    nop
    nop
    ld bc, $0004
    nop
    nop
    nop
    nop
    ld de, $0000
    nop
    ld de, $0000
    nop
    inc b
    nop
    inc b
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
    ld b, b
    ld bc, $2000
    nop
    ld [$1004], sp
    nop
    nop
    inc b
    ld b, b
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
    ld [hl+], a
    nop
    add b
    nop
    nop
    ld bc, $0000
    nop
    nop
    nop
    nop
    nop
    nop
    ld b, h
    nop
    ld [bc], a
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    ld [bc], a
    nop
    add b
    nop
    nop
    ld b, b
    nop
    ld bc, $0100
    jr jr_003_7e56

jr_003_7e56:
    stop
    inc b
    nop
    nop
    nop
    nop
    ld bc, $0000
    ld c, b
    nop
    nop
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
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    db $10
    stop
    nop
    stop
    nop
    nop
    db $10
    ld bc, $1400
    inc b
    stop
    inc c
    nop
    add b
    db $10
    add b
    nop
    ld [bc], a
    nop
    nop
    nop
    nop
    inc b
    add e
    nop
    nop
    nop
    nop
    nop
    ld bc, $0000
    nop
    nop
    nop
    nop
    stop
    nop
    nop
    ld b, c
    nop
    nop
    dec l
    nop
    inc h
    nop
    nop
    nop
    and b
    nop
    nop
    ld bc, $0000
    inc b
    nop
    nop
    nop
    db $10
    inc d
    ld b, b
    nop
    inc b
    nop
    jr nz, jr_003_7ebe

jr_003_7ebe:
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
    jr nz, jr_003_7ece

jr_003_7ece:
    nop
    nop
    ld bc, $0800
    nop
    nop
    ld bc, $0040
    ld b, b
    nop
    add b
    nop
    nop
    nop
    jr z, jr_003_7ee0

jr_003_7ee0:
    nop
    nop
    nop
    ld b, b
    stop
    add b
    nop
    ld bc, $0000
    nop
    rlca
    nop
    nop
    inc b
    ld [bc], a
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    ld [bc], a
    ld b, h
    nop
    nop
    nop
    nop
    nop
    ld bc, $0041
    nop
    nop
    ld c, b
    nop
    nop
    nop
    nop
    ld bc, $4400
    ld [$1000], sp
    stop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    jr nz, jr_003_7f1a

jr_003_7f1a:
    nop
    nop
    add b
    nop
    nop
    inc b
    inc h
    nop
    nop
    nop
    nop
    ld b, b
    nop
    nop
    jr nz, jr_003_7f2a

jr_003_7f2a:
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
    stop
    ld bc, $0000
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
    ld [bc], a
    inc bc
    nop
    nop
    nop
    inc b
    stop
    nop
    nop
    nop
    inc b
    ld b, b
    nop
    inc b
    stop
    nop
    nop
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
    inc d
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
    ld b, b
    nop
    nop
    nop
    inc d
    inc b
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
    inc b
    jr nz, jr_003_7f8a

jr_003_7f8a:
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
    ld bc, $0000
    jr nz, jr_003_7f9b

    nop

jr_003_7f9b:
    nop
    ld b, b
    nop
    nop
    nop
    ld bc, $0010
    nop
    nop
    stop
    nop
    nop
    nop
    ld [de], a
    nop
    ld b, b
    nop
    nop
    nop
    ld [hl], b
    inc b
    nop
    ld b, b
    nop
    nop
    nop
    db $10
    ld b, b
    db $10
    ld [bc], a
    nop
    ret nz

    ld b, h
    ld [$0001], sp
    nop
    nop
    nop
    add b
    nop
    ld b, d
    nop
    nop
    db $10
    ld b, d
    nop
    nop
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
    ld bc, $0188
    add b
    inc b
    nop
    nop
    ld bc, $0000
    nop
    nop
    nop
    nop
    nop
    add d
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
    ld [$0000], sp
    nop
    ld e, h
    nop
    db $11
    ld [bc], a
