# Stage Events

## Introduction

Stage events are how SolarStriker "scripts" stages. Almost everything that happens in a stage is the result of an event being scheduled and then processed. This includes enemy spawns, background scroll speed changes (speeding up and stopping), spawning power-ups, and spawning bosses. Understanding this system is crucial if one wanted to design a new stage or modify an existing stage to behave differently.

## Timing and Scheduling

Event timing is managed by a stage ticker that is tracked and updated in [`ScrollBackground`](../bank_000.asm#L3349). This routine is called every frame of the game loop and has a number of different responsibilities. Every six frames, ScrollBackground increments the 16-bit `wStageTickCounter`. When its low byte wraps from `$FF` to `$00`, the high byte is incremented. With the Game Boy running at ~60 Hz, this allows for approximately 1 hour and 49 minutes before the full timer would overflow. In practice no stage is anywhere near this long, giving substantial room for a dedicated (eccentric?) developer to script a much longer level! Each event specifies the tick at which it occurs.


During new-game and stage setup, [`InitializeStageEventReader`](../bank_000.asm#L2323) initializes the event pointer to `D800`, where the stage’s event stream has been copied into WRAM. It then replaces itself with [`ScheduleStageEvents`](../bank_000.asm#L2333), which checks the next event each frame. It compares the event’s timestamp with `wStageTickCounter` and `wStageTickCounter` + 1. If not it simply advances to the next handler. If the ticks match then it finds the requested event in [`StageEventHandlerTable`](../bank_000.asm#L2596) and uses [`StoreAddressInFreeWramSlot`](../bank_000.asm#L1661) to schedule that event/handler to run. It then unpacks some event parameters that are part of the event record and stores them at `wStageEventParams`, an array of 4 bytes that a later handler can read to store/process its own parameters. `wStageEventParams` is shared temporary storage. Handlers that need parameters for later updates must copy them into their own persistent state. 

During object initialization, [`CopyStageEventParamsToHandlerData`](../bank_000.asm#L1492) copies four bytes starting at `wStageEventParams` + 1. Only three parameter bytes remain at that address, so the copy also includes the adjacent `wEnableQuickSoftReset` byte. This appears unintended; whether it matters depends on how the handler uses the copied data.

Events are read sequentially and should be arranged in chronological order. The scheduler waits for an exact match between the next event’s timestamp and the stage tick counter; it does not search ahead or automatically process overdue events.

The stage tick counter continues advancing when background scrolling is disabled, because `ScrollBackground` updates the counter before checking the scroll-disable flag.

## Event Structure

Events are five-byte entries in an event stream defined in Bank 3. Looking at [`Stage1EventStream`](../bank_003.asm#L585) as an example, here is the very first Rotomech spawn of the game:

```asm
db $40, $00, $07, $60, $00
```

Read as: Low tick, High tick, Event Type, Packed Param 1, Packed Param 2

This means: low tick must equal `$40` and high tick must be `$00` (so about 6.4 seconds into the stage). The event requested is `$07`: [`InitializeRotomech`](../bank_000.asm#L4643). Each of the final two bytes contains two parameter nibbles, giving four parameters in total. The parameters for this particular spawn are: 

| Parameter | Value |
|---|---|
| `wStageEventParams` | `$06` |
| `wStageEventParams + 1` | `$00` |
| `wStageEventParams + 2` | `$00` |
| `wStageEventParams + 3` | `$00` |

These parameters mean different things based on the event. In this example the parameters mean: 

| Nibble | Purpose | Value |
|---|---|---|
| `6` | Spawn X position index | X = `$48` (72), plus horizontal scroll offset |
| `0` | Firing timing index | Fire at count `$E0`; reset at `$F0` |
| `0` | Movement script index | Script A: down → down-left → down → down-right → down |
| `0` | Defeat sound index | Sound entry 0 |

For this Rotomech spawn, the initial Y position is `$00`. After the event is scheduled, the new handler manages its own lifecycle and updates. The event scheduler then waits for the next event. A full list of event types can be found in the associated table: [`StageEventHandlerTable`](../bank_000.asm#L2596). Note some entries are odd in that they are either unused or are never referenced in an event stream but instead are called directly.

Two of these entries are special event types and are handled directly by the scheduler:

| Event type | Behavior |
|---|---|
| `$00` | Removes the stage-event reader, ending event processing. |
| `$01` | Requests the next stage and removes the stage-event reader. |