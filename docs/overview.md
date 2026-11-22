## Overview

This document serves as a general overview to the game and its underlying systems. It contains some high level information about the project, its purpose, and links to more detailed documentation. Along the way, various features of Game Boy development itself will also be explained. As such, readers with previous knowledge of Game Boy hardware architecture and software development will find some information that they already know. An excellent resource for those wanting to learn more is the [PanDocs](https://gbdev.io/pandocs/). This resource was a constant companion to the author throughout this process!

# Introduction

The project started as a way for the author to learn dissasembly and Game Boy development. It is intended to be clear enough and simple enough for someone else to use it as a learning tool as well, and provide an established basis to allow for modifications (i.e., ROM hacking). 

SolarStriker was released on January 26th, 1990 in Japan, shortly afterwards on February 2nd in North America, and finally on September 28th, 1990 in Europe. It generally was not well received critically at the time, with the best reviews calling it at best average or "adequate".

However its simplicity serves as a good intro to dissasembly. Its not so expansive that it would require a team and years of time to properly document, but its also not so small that it is trivial. The ROM is 64kb which puts it among the smallest Game Boy games but not in the smallest size class (32kb) meaning that it still made use of bank switching (more on that later), a key feature of Game Boy development.

This projects existence owes it self to [mgbdis](https://github.com/mattcurrie/mgbdis) by author Matt Currie. This tool provided the initial raw assembly that was then carefully traced and labelled into what is present today.


# Project Structure

As previously mentioned SolarStriker is a simple game and so project structure has also been kept simple. Game Boy games are separated into 16kb "banks". While the game is running the first of these banks can be accessed at memory address: `0000 - 3FFF`, with another being located at `4000 - 7FFF`. Note that these and all addresses in the project and documentation are expressed in hexadecimal. In SolarStriker the second bank can be switched by writing a value specifying the bank to any address in the range of `2000 - 3FFF`. In this project the developers chose address `2100`.

Each bank has a generally well defined purpose:

| Bank Number | Purpose |
|---|---|
| `000` | General game logic |
| `001` | Some boss logic and audio engine |
| `002` | Tile graphic data |
| `003` | Stage data |

During most gameplay, because only two banks can be loaded at once SolarStriker has banks 0 and 1 loaded in RAM. The game switches to bank 2 and 3 to load data as needed per stage but once loaded into another persistent RAM location such as VRAM (video ram), the game can switch back to bank 1 for actual gameplay.

While the original intent or project structure the developers used in unknown, the banks here have been maintained instead of splitting out into separate modules to show how the final game actually had its ROM data organized on the cartridge.

Memory addresses that have had their purpose defined have received a label and have been placed in [memory.asm](/ram/memory.asm).

Constants have been defined and placed in their respective files in the [constants](/constants/) folder.

Some graphics that the original tool was able to turn into viewable images live in [gfx](/gfx/).

A standard file called hardware.inc is also included. This file is a collection of Game Boy hardware definitions that has been in use since the 1990s.


# Game Startup

Before reading further a good reference to understand what certain memory address and region names mean can be found [here](https://gbdev.io/pandocs/Memory_Map.html). The information described below is intentionally general and the other documentation goes into more detail about the specifics.

On start up, like every Game Boy game, after the boot ROM has run the code in ROM bank 0 starts executing at `0100`, however because cartridge header data starts at `0104`, SolarStriker, like most (all?) commercial Game Boy games performs a `nop` and then a `jp` to address `0150` which starts after the header data. Initial setup disables the LCD, initializes the audio engine and sets the starting high score to `20000`. It also crucially performs a standard practice of copying a DMA routine to HRAM that will be used to copy data to OAM. More information on this can be found [here](https://gbdev.io/pandocs/OAM_DMA_Transfer.html). 

After this initial setup the game begins to initialize the title screen. SolarStriker has no copyright screen so to the player, after starting the game the title screen appears "instantly", ready to play. The game starts reading from bank 2 and copies some common tile graphics to VRAM at address `8000`, and graphics specific to the title screen to VRAM at address `9000`. Then, the bank is switched to bank 3 and definitions that specify how the tile graphics should be used to assemble the image on screen are copied to WRAM at `D000` and `D200`. The game then clears some memory, sets some flags and checks if the player has unlocked hard mode. This code runs at game startup but is also entered when the player continues after beating the game or after a game over. If hard mode has been unlocked text saying to press the select button is written to the screen, otherwise the start button is mentioned. The current high score is drawn to the screen and then execution continues to finish the title screen initilization.

SolarStriker specifies that an LCD interrupt should run when drawing reaches scanline 136. This will become apparant later but its purpose is to toggle sprite drawing off so that sprites can not display above the persistent HUD. Since there are no sprites on the title screen it is safe to set this up here even though the HUD is not active yet. Interrupts are essentially conditions that "interrupt" normal program flow and jump to specific addresses, run the code located there, before control is returned to the main program. More information on interrupts can be found [here](https://gbdev.io/pandocs/Interrupts.html).

Then a "handler" is registered that handles input on the title screen. SolarStriker stores up to 32 handlers as memory addresses in a table starting in RAM at `C700`. Every frame the table is scanned and if a slot has a valid address, program control jumps to that address and executes the code, before moving to the next handler. This is a key concept in understanding how SolarStriker is architectured and runs. Handlers are the core of how the game updates from frame to frame. Handlers can and often do also schedule other handlers or overwrite themselves with a new address if their work is done but there is more to do in a specific sequence. For example a handler is often registered to spawn an enemy, which then assigns itself a new address after initial object setup is complete. The new code might handle the enemy movement and update lifecycle from frame to frame.

After starting audio playback for the title screen and specifying it should repeat indefinetely, the game enters a loop while it "waits" for the player to hit start (or select). The loop does three main things, after a VBLANK interrupt occurs the loop runs: The joypad is read for player input, handlers are run, and the "shadow" OAM is built. Starting from the top, the joypad routine sets certain addresses based on if buttons are being held by the player. Then the previously registered handler is run which checks if a button press was detected and branches accordingly based on if start or select was pressed. Finally `BuildShadowOAM` scans object records and turns it into a sprite list that lives in RAM. This RAM location is then read and copied from by the previously mentioned DMA routine. There are no objects to process on the title screen though.

The loop also checks for a "soft reset" which can be triggered by holding A/B/START/SELECT all at once. A soft reset returns the player to the title screen with their high score retained. Triggering on the title screen is somewhat redundant but supported.

# Stage Setup

Once the game detects the player has hit start (or select with hard mode unlocked) the game moves to initialize a new game. Stage 1 tile graphics are loaded into VRAM, while required stage data is moved into various locations in WRAM. The HUD is drawn onto the window and the window position is set to create a non moving HUD location at the bottom of the screen. The Game Boy has two tile maps, one of these can be thought of as the "main" background and the other is the "window". The window can be positioned on top of the other background and does not scroll even if the main background is scrolled. Just like many other games this is why SolarStriker uses it to create a stationary HUD. The LCDC register setting determines which tile map is used as the background or the window. In SolarStriker the tile map starting at `9C00` is used for the HUD. The other tile map starts at `9800`. 

After this several handlers are registers that persist throughout the game. These are mostly related to the player but importantly the stage event reader is also set up here. This is expanded upon in another section of the documentation. Stage music is started and the game moves to the main game loop.

# Game Loop

The main game loop is structured similarly to the title screen loop. Four main routines are run every frame, it checks if various conditions have occurred, and listens for soft reset. First it scrolls the background. The back ground scroll routine also tracks a persistent stage timer that is used to trigger events (like enemy spawns) at certain times. Then just like the title screen it reads the joypad, runs handlers and builds the shadow OAM. The difference here is that many more handlers are going to be registered during a stage than the title screen. After these routines run the loop checks for: game over, pause requested, next stage triggered, and if the screen needs to shake (this happens during some bosses). 

The pause screen and game over screen also have loops. The pause screen causes the game to appear paused by essentially: stopping audio playback, preventing background scroll, and not running the WRAM handlers.

The game over screen sets up a different background and text on screen and waits for the player to hit start which is sort of like a "quick" soft reset that sends the player back to the title screen.


# Further Reading

Other documentation goes into substantially more detail about these systems. This document should be seen as a starting point. Many of the routines and variables should be labelled well enough to facilitate a general understanding from just reading the code at this point but for a much more detailed look at SolarStriker please read the rest of the documentation. A good starting point is [docs/handlers](/docs/handlers.md)