# Audio

## Introduction

The audio engine of SolarStriker is the way the game processes a list of bytes into what is ultimately copied into the Game Boy's audio registers. The Game Boy creates sound by having values written to certain hardware registers that correspond to different parts of the various hardware channels. These audio registers are defined like this:

| Address | Register | Channel | Function |
|---|---|---|---|
| `$FF10` | `NR10` | Pulse 1 | Pitch sweep: rate, direction, and amount |
| `$FF11` | `NR11` | Pulse 1 | Wave duty cycle and length timer |
| `$FF12` | `NR12` | Pulse 1 | Initial volume and volume envelope |
| `$FF13` | `NR13` | Pulse 1 | Pitch value, low 8 bits |
| `$FF14` | `NR14` | Pulse 1 | Pitch high 3 bits, length enable, and trigger |
| `$FF16` | `NR21` | Pulse 2 | Wave duty cycle and length timer |
| `$FF17` | `NR22` | Pulse 2 | Initial volume and volume envelope |
| `$FF18` | `NR23` | Pulse 2 | Pitch value, low 8 bits |
| `$FF19` | `NR24` | Pulse 2 | Pitch high 3 bits, length enable, and trigger |
| `$FF1A` | `NR30` | Wave | Enable or disable the wave DAC |
| `$FF1B` | `NR31` | Wave | Length timer |
| `$FF1C` | `NR32` | Wave | Output level: mute, 100%, 50%, or 25% |
| `$FF1D` | `NR33` | Wave | Pitch value, low 8 bits |
| `$FF1E` | `NR34` | Wave | Pitch high 3 bits, length enable, and trigger |
| `$FF20` | `NR41` | Noise | Length timer |
| `$FF21` | `NR42` | Noise | Initial volume and volume envelope |
| `$FF22` | `NR43` | Noise | Noise clock rate and 7-bit/15-bit generator mode |
| `$FF23` | `NR44` | Noise | Length enable and trigger |
| `$FF24` | `NR50` | Global | Left/right master volume and external VIN routing |
| `$FF25` | `NR51` | Global | Route each channel to left and/or right output |
| `$FF26` | `NR52` | Global | Master audio power and channel activity status |
| `$FF30–$FF3F` | Wave RAM | Wave | 16 bytes holding 32 packed 4-bit waveform samples |

Writing to these registers is what actually creates the sound. SolarStriker does not just directly define values that get written straight to these registers though. A more complete reference of Game Boy audio can be found [here](https://gbdev.io/pandocs/Audio.html).

## Model

SolarStriker supports up to 4 audio "playbacks" at once. A playback is the actual sound or music the player actually hears. Stage music, the player shot sound, enemy defeat sound, these would all be playbacks. A free playback slot must be available for a requested audio to be able to play. Playbacks are made up of up to 4 audio streams which map to the different hardware channels. There are 6 "software" audio channels. Each channel can process one stream at a time. This allows for 6 streams across 4 different playbacks to be used at once. Only the selected stream for each hardware channel controls its output. Stage music can use 3 for example, while other sounds might only use 1. Then of course all of this maps to 4 actual hardware channels that make the sound the player hears.

A software channel is a 43-byte record that manages the current state of a stream. Offsets indicating which bytes hold what data can be found in [/constants/audio.asm](../constants/audio.asm).

A playback record is a three-byte record that stores the repeat count, the tick interval and the current tick countdown.

Each hardware channel has a four-entry list of software channel IDs. IDs range from 1 to 6, and `$00` marks an empty entry. The first entry selects the software channel currently controlling that hardware channel.

## Playback Structure

As previously mentioned an audio playback can have multiple streams. A playback header defines information about the playback that the audio engine uses to properly set it up. Using [`TitleScreenMusic`](../bank_001.asm#L3731) as an example: 

```asm
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
```

The first byte specifies how often the playback should update. The header stores the interval minus one. For title-screen music, `$03` becomes an interval of four audio updates. At 64 updates per second, its playback tick advances 16 times per second. The second byte specifies the playback priority. Higher numeric priority values take precedence when playbacks request the same software channel. An incoming request can replace an existing playback with equal or lower priority. Then the header can define up to four, three-byte entries. These entries contain a pointer to an audio stream (2 bytes), and a byte specifying which software channel the stream should be assigned to. A stream is the actual notes and musical commands that make up a song or sound effects. Software-channel selectors in the header range from 0 to 5; runtime software-channel IDs range from 1 to 6.


## Playback Setup

Requesting a playback is done via [`SetupAudioPlayback`](../bank_001.asm#L1284). The caller sets HL to a pointer to an audio playback and sets the A register to how many times the sound should play. A 0 gets converted to $FF and means repeat indefinitely. First [`CheckAndReleaseAudioChannels`](../bank_001.asm#L1315) is called to check if the software channels requested by the playback are occupied by a higher priority. If so the incoming playback request is rejected. Incoming playback requests with equal priority "win" the tie. Then playbacks that own a specific software channel are stopped. This releases the playback's entire set of channels. After this [`FindFreePlaybackSlot`](../bank_001.asm#L1601) is used to find if a free playback slot is available. If available the playback can be set up by [`InitAudioSlot`](../bank_001.asm#L1415). Two tables, 1 tracking playback slot activity and one tracking playback slot priority are set accordingly. Then a free audio slot record is found with [`GetAudioSlotRecord`](../bank_001.asm#L1561). The record is cleared and filled with the new playback's data: repeat, tick interval, and current tick (set to 1).

The bulk of work is then performed by [`InitializeAudioEntries`](../bank_001.asm#L1453) which sets up each required software channel. It establishes a working record for the stream and initializes startup data such as the audio stream pointer. It then prepends the software channel to the hardware list and copies the working record to its designated position in WRAM, specified by the [`AudioChannelRecordAddressTable`](../bank_001.asm#L1597). Note that only the first 6 entries are used.

## Update

Audio updates are performed by [`UpdateAudio`](../bank_001.asm#L1854) whenever the hardware timer interrupt is triggered. This occurs whenever the TIMA register overflows and interrupts are enabled. SolarStriker sets the TAC register to $07 and the TMA register to $00. The TIMA register is reloaded from TMA when overflowed. This means the timer is enabled at 16,384 increments/second. The timer is set to zero after overflow so there are 256 increments per interrupt. This produces an interrupt every 15.625 ms for a total of 64 interrupts per second. Reference can be found [here](https://gbdev.io/pandocs/Timer_and_Divider_Registers.html). The interrupt causes the [`HandleTimerOverflow`](../bank_000.asm#L378) routine to run which temporarily masks timer interrupts before calling [`UpdateAudio`](../bank_001.asm#L1854).

This routine calls three subroutines which each have their own, possibly complex, call chain. The three main subroutines are: [`ProcessPlaybackSlots`](../bank_001.asm#L1882), [`UpdateChannelVolumeSequences`](../bank_001.asm#L2777), and finally [`WritePendingAudioRegisters`](../bank_001.asm#L3056). [`ProcessPlaybackSlots`](../bank_001.asm#L1882) advances playback timing and processes each audio stream's notes and commands. [`UpdateChannelVolumeSequences`](../bank_001.asm#L2777) advances volume envelopes and updates each stream's volume. [`WritePendingAudioRegisters`](../bank_001.asm#L3056) is what writes actual data to the hardware registers causing sound to be produced. All setup and updates are to make sure the bytes copied to the registers are in the correct format to produce the desired sound for that audio update.

[`ProcessPlaybackSlots`](../bank_001.asm#L1882) loops through each playback slot and checks for activity via `wPlaybackSlotActiveTable`. Inactive playback slots are skipped. Once an active playback is found a working record of its playback is created for processing. The engine decrements the countdown at `wCurrentPlaybackRecord + 2`. If the result is nonzero, it skips further processing for that playback. Otherwise, it reloads the countdown from the tick interval and processes the playback.

[`CheckPlaybackCompletion`](../bank_001.asm#L3208) returns without restarting or releasing the playback if any software channel owned by that playback is still active. Once all owned streams are inactive, it checks the repeat count. Zero releases the playback, $FF restarts it indefinitely, and other values are decremented before restarting. When a playback is released its activity and priority are set to 0 and all of its software channels are removed from the hardware lists. The hardware channel is also silenced if the head of the list is being removed. Note that the software channel's 43-byte record is actually not cleared. Clearing is handled by initialization or restarting a playback. Otherwise the channel being marked as inactive is what prevents it from being processed. 

When a completed playback needs to repeat [`RestartPlaybackSlotChannels`](../bank_001.asm#L3253) is called to restart the current audio playback. This routine finds the relevant software channel records and essentially reinitializes them. The restarted streams can be processed during the same audio update. The channel record is loaded to the working area and various operations are carried out to set up the stream again. The CHANNEL_AUDIO_STREAM_POINTER_OFFSET is reset to the start, a large portion of the record is cleared before certain offsets are set with defaults. After processing the record is copied back to its place in WRAM from the working record.

At this point the next entry in the stream is actually processed by [`TickAudioChannelStream`](../bank_001.asm#L1961). This is where the main bulk of work is done by the audio engine to produce the desired sound. Several different conditions can cause a tick to be skipped, namely a timer (CHANNEL_STREAM_TIMER_OFFSET) which can indicate that even if a current playback "ticked" the specific point in the sound effect/song might not need to change yet. Otherwise a table index in `wSoftwareChannelRegisterUpdatePending` is marked since a stream tick is about to be processed which means the audio registers will need new values written to them. Using a pointer tracked in the channel record, the next two bytes of the audio stream are read by [`ReadNextAudioStreamEntry`](../bank_001.asm#L1996). The first byte is a command or a note to play while the second byte is an argument to be used for the current command or note. The code then has 4 branches it can take at this point based upon the first byte that was read: 

```asm
    cp $b0
    jp nc, DispatchAudioCommand ; byte was $B0-$FF

    cp $a0
    jp nc, HandleCountedAudioJump ; byte was $A0-$AF

    cp $90
    jp nc, HandleAudioLoop ; byte was $90-$9F

    ; byte was $00-$8F
    ld e, $80
    ld hl, CHANNEL_LENGTH_MODE_OFFSET
    add hl, bc
    ld a, [hl]
    or a
    jr z, .setPeriodHigh ; jump if byte there is zero

    ld e, $c0
```

[`DispatchAudioCommand`](../bank_001.asm#L2461) uses the byte and current hardware channel this software channel is using to find a command from [`AudioCommandTables`](../bank_001.asm#L2502). It should be noted that bytes `$B0–$EC`, while in the range to reach this branch, are actually skipped: 

```asm
AudioCommandTables:
    dw AudioCommandHandlers_1, AudioCommandHandlers_2
    dw AudioCommandHandlers_3, AudioCommandHandlers_4
```

For example hardware channel 1 (pulse) with a byte of $FE means to set the base volume:

```asm
dw AudioCmd_SetBaseVolume
```

[`AudioCmd_SetBaseVolume`](../bank_001.asm#L2613) is actually relatively simple. In this case the A register will hold the second byte that was read from the stream which is the argument:

```asm
AudioCmd_SetBaseVolume:
    and $0f
    ld hl, CHANNEL_BASE_VOLUME_OFFSET
    add hl, bc
    ld [hl], a ; store low nibble of the second byte
    ret
```

In this case `ret` actually sends execution back to [`ReadNextAudioStreamEntry`](../bank_001.asm#L1996). This means that multiple two-byte entries can be read in an update until one of them is a note or rest that sets a duration, or the stream end is read (byte $FF).


[`HandleCountedAudioJump`](../bank_001.asm#L2280) moves the audio stream pointer by a relative signed offset using a single repeat counter to limit how many times the jump can occur.

[`HandleAudioLoop`](../bank_001.asm#L2331) performs a similar function but can track up to three separate loops each being identified by its stream position and with its own counter. Both of these routines also continue at [`ReadNextAudioStreamEntry`](../bank_001.asm#L1996). They allow a sound or song to repeat "passages" without storing duplicate notes in ROM space. [`HandleAudioLoop`](../bank_001.asm#L2331) allows for potentially nested repetitions.

Finally if a byte was $00-$8F, these are what can be thought of as "notes" or "rests". For note and rest entries, the first byte identifies the note or channel-specific sound setting, while the second supplies its duration. The engine combines this with the channel’s current settings to prepare register values, then returns from stream processing for that update. Processing of these bytes does not return to [`ReadNextAudioStreamEntry`](../bank_001.asm#L1996).


After all of this, [`UpdateChannelVolumeSequences`](../bank_001.asm#L2777) is called. This routine adjusts a channel's volume envelope, checks the current volume and flags any changes for writing to the hardware. It allows notes to fade in or fade out or even follow a changing volume pattern without additional commands in the audio stream. This is made possible by the [`AudioVolumeSequenceTable`](../bank_001.asm#L1103) which contains various byte sequences that can be referenced to adjust a channel's volume after an initial sequence is chosen.

Then, the last step of the audio update involves [`WritePendingAudioRegisters`](../bank_001.asm#L3056). After all of the work done by the previous routines to set up or change any offsets in the channel record necessary, here the values are actually written to the Game Boy's audio registers. This routine uses [`HardwareChannelRegisterCopyTable`](../bank_001.asm#L3194) to determine where and how many bytes from the channel record to copy:

```asm
HardwareChannelRegisterCopyTable:
    dw rNR10
    db $05 ; bytes to copy

    dw rNR21
    db $04

    dw rNR30
    db $05

    dw rNR41
    db $04
```

When 4 bytes are needed the copy begins at offset $27, otherwise it begins at offset $26. In other words the last 4 or 5 bytes of the record are copied in order into the audio registers for the given channel. Register-buffer copies are performed only for the selected software channel on each hardware channel when its update flag is set.