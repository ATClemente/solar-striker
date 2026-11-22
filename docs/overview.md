# Overview

This document serves as a general overview of the game and its underlying systems. It contains some high-level information about the project, its purpose, and links to more detailed documentation. Along the way, various features of Game Boy development itself will also be explained. As such, readers with previous knowledge of Game Boy hardware architecture and software development will find some information that they already know. An excellent resource for those wanting to learn more is the [Pan Docs](https://gbdev.io/pandocs/). This resource was a constant companion to the author throughout this process!

## Introduction

The project started as a way for the author to learn disassembly and Game Boy development. It is intended to be clear enough and simple enough for someone else to use it as a learning tool as well and to provide an established basis to allow for modifications (i.e., ROM hacking).

SolarStriker was released on January 26th, 1990 in Japan, shortly afterwards on February 2nd in North America, and finally on September 28th, 1990 in Europe. It generally was not well received critically at the time, with the best reviews calling it at best average or "adequate". Source: [SolarStriker on Wikipedia](https://en.wikipedia.org/wiki/SolarStriker).

However, its simplicity serves as a good intro to disassembly. It's not so expansive that it would require a team and years of time to properly document, but it's also not so small that it is trivial. The ROM is 64 KiB which puts it among the smallest Game Boy games but not in the smallest size class (32 KiB) meaning that it still made use of bank switching (more on that later), a key feature of Game Boy development.

This project owes its existence to [mgbdis](https://github.com/mattcurrie/mgbdis) by author Matt Currie. This tool provided the initial raw assembly that was then carefully traced and labelled into what is present today.


## Project Structure

As previously mentioned, SolarStriker is a simple game and so project structure has also been kept simple. Game Boy games are separated into 16 KiB "banks". While the game is running the first of these banks can be accessed at the address range: `0000 - 3FFF`, with another being located at `4000 - 7FFF`. Note that these and all addresses in the project and documentation are expressed in hexadecimal. In SolarStriker the second bank can be switched by writing a value specifying the bank to any address in the range of `2000 - 3FFF`. In this project the developers chose address `2100`.

Each bank has a generally well-defined purpose:

| Bank Number | Purpose |
|---|---|
| `000` | General game logic |
| `001` | Some boss logic and audio engine |
| `002` | Tile graphic data |
| `003` | Stage data |

During normal gameplay, ROM bank 0 is mapped at `0000–3FFF`, and bank 1 is mapped at `4000–7FFF`. The game temporarily switches the latter range to bank 2 or 3 to copy graphics and stage data into VRAM or WRAM, then switches back to bank 1.

While the original intent or project structure the developers used is unknown, the banks here have been maintained instead of splitting out into separate modules to show how the final game actually had its ROM data organized on the cartridge.

Memory addresses that have had their purpose defined have received a label and have been placed in [memory.asm](../ram/memory.asm).

Constants have been defined and placed in their respective files in the [constants](../constants/) folder.

Some graphics that the original tool was able to turn into viewable images live in [gfx](../gfx/).

A standard file called [hardware.inc](../hardware.inc) is also included. This file is a collection of Game Boy hardware definitions that has been in use since the 1990s.

## Glossary

While the Pan Docs will be a much better reference for general information about the Game Boy hardware and architecture, the following terms are important for reading the documentation and understanding the repository.

- **ROM (Read-Only Memory):** Cartridge memory containing the game’s code, graphics, and other data.
- **Bank switching:** Changing which ROM bank is accessible through a particular address range.
- **WRAM (Work RAM):** Memory used for changing game state, such as scores, object records, and handler data.
- **VRAM (Video RAM):** Memory containing tile graphics and tile maps used to draw the screen.
- **HRAM (High RAM):** A small memory region used here to run the OAM DMA routine.
- **OAM (Object Attribute Memory):** Memory containing sprite positions, tile numbers, and display attributes.
- **Shadow OAM:** A copy of the sprite display data prepared in WRAM before being transferred to OAM.
- **DMA (Direct Memory Access):** A hardware transfer mechanism used here to copy shadow OAM into OAM.
- **HUD (Heads-Up Display):** The fixed area at the bottom of the screen showing information such as the player’s score and remaining lives.
- **VBlank (Vertical Blank):** The interval between drawing one frame and starting the next, when the game can safely update display memory.
- **Interrupt:** A hardware-triggered diversion of CPU execution to a designated routine, after which the interrupted code resumes.
- **Handler:** This project’s term for a registered routine that runs during each gameplay update to manage input, objects, or other game logic.

Before reading further a good reference to understand what certain memory address and region names mean can be found [here](https://gbdev.io/pandocs/Memory_Map.html). The information described below is intentionally general and the other documentation goes into more detail about the specifics.


## Game Startup

After the boot ROM finishes, execution begins at `0100` in ROM bank 0. Because cartridge header data begins at `0104`, SolarStriker executes a `nop` followed by a `jp` to `0150`, immediately after the header. Initial setup in [`Start`](../bank_000.asm#L116) disables the LCD, initializes the audio engine and sets the starting high score to `20000`. It also crucially performs a standard practice of [copying a DMA routine to HRAM](../bank_000.asm#L1200) that will be used to copy data to OAM. More information on this can be found [here](https://gbdev.io/pandocs/OAM_DMA_Transfer.html).

After this initial setup, the game begins to initialize the title screen in [`InitTitleScreen`](../bank_000.asm#L131). SolarStriker has no copyright screen so to the player, after starting the game the title screen appears "instantly", ready to play. The game starts reading from bank 2 and copies some common tile graphics to VRAM at address `8000`, and graphics specific to the title screen to VRAM at address `9000`. Then, the bank is switched to bank 3 and definitions that specify how the tile graphics should be used to assemble the image on screen are copied to WRAM at `D000` and `D200`. The game then clears some memory, sets some flags and checks if the player has unlocked hard mode. This code runs at game startup but is also entered when the player continues after beating the game or after a game over. If hard mode has been unlocked, text prompting the player to press Select is displayed; otherwise, the prompt mentions Start. The current high score is drawn to the screen and then execution continues to finish the title screen initialization.

SolarStriker specifies that [`HandleLCDInterrupt`](../bank_000.asm#L369) should run when drawing reaches scanline 136. This will become apparent later but its purpose is to toggle sprite drawing off so that sprites cannot overlap the persistent HUD at the bottom of the screen. The VBlank handler enables sprite rendering again for the next frame. Since there are no sprites on the title screen it is safe to set this up here even though the HUD is not active yet. Interrupts are essentially conditions that "interrupt" normal program flow and jump to specific addresses, run the code located there, before control is returned to the main program. More information on interrupts can be found [here](https://gbdev.io/pandocs/Interrupts.html).

Then a "handler", [`HandleTitleScreenInput`](../bank_000.asm#L739), is registered through [`StoreAddressInFreeWramSlot`](../bank_000.asm#L1661) to handle input on the title screen. SolarStriker stores up to 32 handlers as memory addresses in a table starting in RAM at `C700`. Every frame [`RunWramHandlers`](../bank_000.asm#L603) scans the table and if a slot has a valid address, program control jumps to that address and executes the code, before moving to the next handler. This is a key concept in understanding how SolarStriker is structured and runs. Handlers are the core of how the game updates from frame to frame. Handlers can and often do also schedule other handlers or overwrite themselves with a new address if their work is done but there is more to do in a specific sequence. For example, a handler is often registered to spawn an enemy, which then assigns itself a new address after initial object setup is complete. The new code might handle the enemy's movement and lifecycle from frame to frame.

After starting audio playback for the title screen and specifying it should repeat indefinitely, the game enters [`TitleScreenLoop`](../bank_000.asm#L234) while it "waits" for the player to hit Start (or Select). After each VBlank interrupt, the loop reads joypad input, runs handlers, and builds shadow OAM. Starting from the top, [`ReadJoypad`](../bank_000.asm#L1168) updates input state in RAM to record which buttons the player is holding. The previously registered handler then checks that state and responds according to whether Start or Select was pressed. Finally [`BuildShadowOAM`](../bank_000.asm#L3618) scans object records and turns them into a sprite list that lives in RAM. This RAM location is then read and copied from by the previously mentioned DMA routine. There are no objects to process on the title screen though.

The loop also calls [`CheckForSoftReset`](../bank_000.asm#L390) to check for a "soft reset" which can be triggered by holding A/B/START/SELECT all at once. A soft reset returns the player to the title screen with their high score retained. Triggering on the title screen is somewhat redundant but supported.

## Stage Setup

Once the game detects the player has hit Start (or Select with hard mode unlocked) the game moves to [`InitializeNewGame`](../bank_000.asm#L786). Stage 1 tile graphics are loaded into VRAM, while required stage data is moved into various locations in WRAM. The HUD is drawn onto the window and the window position is set to create a fixed HUD position at the bottom of the screen. The Game Boy provides two tile maps. LCDC settings select which map supplies the scrolling background and which supplies the window. The window can be positioned on top of the other background and does not scroll even if the main background is scrolled. Just like many other games this is why SolarStriker uses it to create a stationary HUD. In SolarStriker the tile map starting at `9C00` is used for the HUD. The other tile map starts at `9800`.

After this several handlers are registered that persist throughout the game. These are mostly related to the player but importantly the stage event reader, [`InitializeStageEventReader`](../bank_000.asm#L2323), is also set up here. This is expanded upon in another section of the documentation. See [Stage Events](../docs/stage-events.md) for details. Stage music is started and the game moves to the main game loop.

## Game Loop

Each frame, the main game loop, [`GameLoop`](../bank_000.asm#L261), runs four routines: background scrolling, joypad input, handler dispatch, and shadow OAM construction. It then checks for state changes and soft reset. First it scrolls the background. The background scroll routine, [`ScrollBackground`](../bank_000.asm#L3349), also tracks a persistent stage timer that is used to trigger events (like enemy spawns) at certain times. The difference here is that many more handlers are going to be registered during a stage than the title screen. After these routines run, the loop checks for game over, pause requests, stage transitions, and screen-shake requests during certain boss encounters.

Some work happens in interrupt routines alongside the main loop. During VBlank, [`HandleVBlank`](../bank_000.asm#L341) transfers prepared shadow OAM data into OAM, updates background tiles and the HUD, and sets a flag that allows the main loop to process another frame. It also enables sprite rendering again after the LCD interrupt disabled it for the HUD area.

Audio updates are driven by a timer interrupt. [`HandleTimerOverflow`](../bank_000.asm#L378) calls [`UpdateAudio`](../bank_001.asm#L1854) to advance music and sound effects, so normal gameplay does not need to call the audio engine directly each frame.

The pause screen and game over screen also have loops. See [`PauseScreenLoop`](../bank_000.asm#L467) for the pause loop. The pause screen causes the game to appear paused by stopping the current music, preventing background scroll, and not running the WRAM handlers.

The game over screen sets up a different background and text on screen and waits for the player to hit Start which is sort of like a "quick" soft reset that sends the player back to the title screen.


## Further Reading

Other documentation goes into substantially more detail about these systems. This document should be seen as a starting point. Many of the routines and variables should be labelled well enough to facilitate a general understanding from just reading the code at this point but for a much more detailed look at SolarStriker please read the rest of the documentation.

Handlers are a good starting point because they drive much of the game’s logic.

- [Handlers](handlers.md): How the game registers, runs, replaces, and removes routines that manage behavior from frame to frame.
- [Objects](objects.md): How the game represents and manages players, enemies, projectiles, and other objects.
- [Stage Events](stage-events.md): How stage data schedules enemy spawns, boss encounters, and other events as a stage progresses.
- [Sprite Rendering](sprite-rendering.md): How object records become sprite display data, including shadow OAM construction and DMA transfers.
- [Background Drawing](background-drawing.md): How tile graphics and map data build the backgrounds, support scrolling, and display the HUD.
- [Audio](audio.md): How the audio engine processes music and sound effects.