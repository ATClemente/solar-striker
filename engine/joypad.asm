ReadJoypad:
    ld a, $20
    ldh [rP1], a
    ldh a, [rP1]
    ldh a, [rP1]
    cpl
    and $0f
    swap a
    ld b, a
    ld a, $10
    ldh [rP1], a
    ldh a, [rP1]
    ldh a, [rP1]
    ldh a, [rP1]
    ldh a, [rP1]
    ldh a, [rP1]
    ldh a, [rP1]
    cpl
    and $0f
    or b
    ld c, a
    ld a, [wJoypadHeld]
    xor c
    and c
    ld [wJoypadPressed], a
    ld a, c
    ld [wJoypadHeld], a
    ld a, $30
    ldh [rP1], a
    ret