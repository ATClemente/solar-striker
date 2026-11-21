## Introduction

Stage events are how SolarStriker "scripts" stages. Almost every thing that happens in a stage is the result of an event being scheduled and then processed. This includes enemy spawns, background scroll speed changes (speeding up and stopping), spawning power ups, and spawning bosses. Understanding this system is crucial if one wanted to design a new stage or modify an existing stage to behave differently.

# Timing and Scheduling

Event timing is managed by a stage ticker that is tracked and updated in `ScrollBackground`. This routine is called every frame of the game loop and has a number of different responsibilites. Every 6 frames it ticks a `wStageTickCounter`. When this counter overflows (> $FF), it carries over into the next byte. Together this allows for a 16 bit counter that counts up once every 6 frames. With the Game Boy running at ~60 Hz, this allows for approximately 1 hour, 49 minutes, and 13.5 seconds before the full timer would overflow. In practice no stage is anywhere near this long, giving substantial room for a dedicated (eccentric?) developer to script a much longer level! Events then specify at what tick (low and high) they ocurr at.

Events are scheduled by a handler that is setup during new game and every new stage called `InitializeStageEventReader`. This handler does some brief set up before scheduling `ScheduleStageEvents`. During stage setup stage events were copied to address `D800` and a pointer starts here, waiting for the first event. Every frame it checks the current event and checks if the defined timing ticks match the current ticks in `wStageTickCounter` and `wStageTickCounter + 1`. If not it simply advances to the next handler. If the ticks match then it find the requested event in `StageEventHandlerTable` and uses `StoreAddressInFreeWramSlot` to schedule that event/handler to run. It then unpacks some event parameters that are part of the event record and stores them at `wStageEventParams` an array of 4 bytes that a later handler can read to store/process its own parameters. Interestingly there seems to be a harmless bug here where, the first event param is used directly but 4 bytes starting at `wStageEventParams + 1` is still copied, pulling in the next byte in memory `wEnableQuickSoftReset` into the handler data. This doesn't seem intentional, but also doesn't seem to have a harmful effect.

# Event Structure

Events are 5 byte entries in an event stream defined in Bank 3. Looking at `Stage1EventStream` as an example, here is the very first Rotomech spawn of the game:

```code
db $40, $00, $07, $60, $00
```

Read as: Low tick, High tick, Event Type, Packed Param 1, Packed Param 2

This means: low tick must equal $40 and high tick must be $00 (so about 6.4 seconds in to the stage). The event requested is $07: `InitializeRotomech`. The parameters are two nibbles packed into bytes so the parameters for this particular spawn is: 

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

Note that spawn Y is always `$00`. After the event is scheduled the new handler is then responsible for handling its own lifecycle and updates, the event scheduler is free to focus on waiting for and scheduling the next event. A full list of event types can be found in the associated table: `StageEventHandlerTable`. Note some entries are odd in that they are either unused or are never referenced in an event stream but instead are called directly.