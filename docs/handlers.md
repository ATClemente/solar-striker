## Introduction

SolarStriker allows for up to 32 general routines to be registered as an address that the program will jump to and run the code located there every frame. This project refers to these routines/code blocks as "handlers". The handler table is a location in WRAM that is located from: `C700 - C73F`. Because each handler is identified by a memory address which takes two bytes to express, this table takes up 64 bytes of memory. Pointers are stored in "little-endian" format meaning the low byte of the address comes first. For example the address: `1234` would be stored at the beginning of the table as:

```text
$C700    $34   ; low byte
$C701    $12   ; high byte
```

Handler registration initially ocurrs through the routine `StoreAddressInFreeWramSlot`. This routine scans the `wHandlerTable` and looks for the first two byte entry that equals `0000`. This signals an open slot and the game stores the address originally passed in the `DE` register at this location in the table. The next time `RunWramHandlers` runs this address, along with any others will have the code at those locations executed.


# Handler State

Each handler is given a persistent location in WRAM to store data. In general it is free to use this data however it wants but certain offsets are reused by different handlers if they are managing something similar. For example all enemy projectiles track their Y velocity in offset `$08`.

The handler data table spans addresses `C100 – C4FF`. Each handler gets 32 bytes of data, for a total of 1024 bytes. Identified offsets are recorded in [constants/handlers.asm](/constants/handlers.asm).


# Dispatch

Handlers are dispatched through `RunWramHandlers` which runs once every frame. The current handler is tracked via `wCurrentHandlerIndex` which is moved forward by two bytes at a time. If it encounters a two byte block of zeros it moves to the next slot. The game does not and cannot assume that an empty spot means the rest of the table is empty. Although table entries are filled in order, a handler registered earlier than another one may have removed itself, so the whole table still needs to be checked. Using the current handler index a pointer to the current handlers data table entry is set in `wCurrentHandlerDataPointer`. The handler uses this pointer to access the data it "owns" during its running. The address of the handler is loaded into `HL` and the game jumps to this address and the code there starts executing.

# Advancing

After execution a handler can do one of three things: advance to the next handler, replace themselves, or finish and remove themselves. Advancing to the next handler is done by calling `AdvanceToNextHandler`. It increments the `wCurrentHandlerIndex` and moves to the next handler or returns if we have processed all 32 slots. This is called for handlers that need to persist and run every frame but are done with their work for the current frame.

Handlers can also replace themselves. This is done by calling `SetCurrentHandlerAddress`. This routine replaces the current handler pointer with a new address, supplied by the caller. This guarantees that a slot in the table is available since the handler simple replaces the one that is currently running. This is used for sequences of actions. An initial handler might spawn an enemy and then set another handler to configure the new enemy, and then another handler to manage the movement, etc. These chains can get quite long and sometimes complex. Often their are "loops" of handlers where a specific enemy updates some aspect of its lifecycle every other frame so the handlers switch back and forth. Handler A might run and set Handler B which will run and then set Handler A again and so forth.

When a handler is done and does not need to persist and does not need to schedule another handler it can call `RemoveCurrentHandler`. This clears the current pointer in the handler table and also clears the memory region that corresponds to the handler in the handler data table.

Handlers are essentially where all of the game logic frame to frame is ocurring. Enemy spawning, enemy movement, enemy firing, player movement, player firing, etc is all ocurring inside handlers.