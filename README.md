# SolarStriker Disassembly

A documented disassembly of SolarStriker for the Nintendo Game Boy, created to learn Game Boy development and understand how the game works.

The project includes labelled assembly, named memory locations and constants, and documentation covering gameplay, rendering, stage scripting, and audio. It is intended as a learning resource and a starting point for modifications and ROM hacking.

Some labels and explanations remain provisional. Corrections and additional findings are welcome.

## Getting Started

Start with the [Overview](docs/overview.md) for the project structure and an introduction to the game's systems. Then read [Game Flow](docs/game-flow.md) to follow the player lifecycle, stage transitions, and ending sequences.

## Building

Requirements:

- [RGBDS](https://rgbds.gbdev.io/docs/v1.0.4/)
- GNU Make
- A Unix-like shell environment with standard command-line utilities
- `sha1sum` or `shasum` for checksum verification

On Windows, use an environment such as WSL or MSYS2 with the required tools installed.

From the repository root:

```sh
make
```

The output is `game.gb`. To build and verify it against the expected SHA-1:

```sh
make verify
```

Expected SHA-1:

```text
a8d6acb026b0d0a8a2bcaea094951e915a3deb80
```

To remove generated files:

```sh
make clean
```

## Documentation

- [Overview](docs/overview.md): Project structure and system introduction.
- [Game Flow](docs/game-flow.md): Startup, player behavior, death, progression, and endings.
- [Handlers](docs/handlers.md): Dispatch and persistent handler state.
- [Objects](docs/objects.md): Object allocation, movement, collisions, and damage.
- [Stage Events](docs/stage-events.md): Event timing, formats, and parameters.
- [Sprite Rendering](docs/sprite-rendering.md): Shadow OAM construction and DMA.
- [Background Drawing](docs/background-drawing.md): Tile maps, blocks, tile packets, and scrolling.
- [Audio](docs/audio.md): Playback management, streams, and hardware channel updates.

## Acknowledgements

The initial disassembly was generated using [mgbdis](https://github.com/mattcurrie/mgbdis) by Matt Currie and contributors.

[Pan Docs](https://gbdev.io/pandocs/) was a primary reference for understanding the Game Boy hardware.

[BGB](https://bgb.bircd.org/) was used to debug the game, trace code execution, and identify the purpose of memory locations.