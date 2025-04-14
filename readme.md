
# GoBo 🧱 Godot Boilerplate 

_Hopefully: a modular foundation for building future Godot games._

## Overview

This is a **work-in-progress Godot project** designed to act as a reusable base for my future games. The focus is on solving some common game architecture patterns once and reusing them cleanly to relieve tedium and try fun stuff faster.

Goals include:

- Dynamic **state machine system** to define and manage scene behavior of any level of scene
- Decoupled **global event bus** make it easy for nodes to listen or trigger global events
- Automated **testing suite coverage** of core classes for QA and CI/CD
- Thoughtful **project structure** to foster good design patterns
- A unified **main scene** setup for rapid prototyping

## Project Structure

Directories look something like this:

```
res://
├── addons/ # See Addons section
├── scenes/
│   ├── main/main.tscn # Entry point, and root of the node tree
│   └── sample/sample.tscn
│              sample_root.gd
│              sample_data.tres 
├── scripts/
│   ├── core/ # Abstract classes for scenes to extend, eg 'PlayerData'
│   └── singletons/ # Autoloads, for Globals and Factories
├── tests/
│   ├── core/ # Abstract classes for scenes to extend, eg 'PlayerData'
│   └── singletons/ # Autoloads, for Globals and Factories
└── main.tscn # The entry point of the game
readme.md # <- you are here
```

### **Scenes Folder**
All the scene files are located in the `scenes/` directory.
Each scene is self-contained with its associated files (such as scripts, shaders, etc.).
There are **no external script dependencies**, except for the core functionality provided in the `scripts/` folder and the globals.
The idea is to promote encapsulation and resusability of scenes.

### **Scripts Folder**
The `scripts/` folder contains the core functionality and singleton systems:
- **`core/`**: This subdirectory houses the abstract base classes that other game systems will extend. These will rarely be instantiated themselves.
- **`singletons/`**: This is where autoloads (singletons) are stored for global access throughout the game, handling persistent global behavior and services.

### **~~Assets Folder~~**

Until I figure out why this is a bad idea, **there is no global assets folder!** 
All art assets, including images, sounds, and animations, are neatly organized under the `assets/` directory... *in their own scene!* This keeps resources near the code that cares about them, and (*idealistically*) lets scenes be mostly drag-and-drop between GoBo projects

## Features and Systems (WIP, ITYW)

### State Machine & State

The core StateMachine class itself helps us do a few things, but mostly its there to **control which state gets to decide what process this frame.**

This means it has to:

- Dynamically 'connect()' to the 'state_wants_to_change()' signal of State type child nodes.
	- The SM keeps the signals in a dictionary with
- Initialize the state, which can be chosen in the Inspector.
	- If its not chosen before runtime, then it will use the first State child in the tree.
	- If there are no State children, we perish. Perhaps handle more gracefully later. But that's illegal!
- Facilitate the state change itself, calling the exit and enter functions appropriately
- Track state history, maybe for something like previous_state() on null... or just "prev"?
- This is still needs work right now, but manage sleeping/waking so we can pause/unpause processing
	- pausing the game (menus, dialog, changing levels)
	- 

### Event Bus & Event

A global signal-based event system for decoupling node dependencies.

```gdscript
EventBus.emit("player_died", player_id)
```

### Main Scene

Acts as the entry point, bootstraps stuff, and manages game-level state.

## Roadmap

- [x] Set up basic project structure
- [x] Implement basic state machine
- [x] Implement basic global EventBus
- [ ] Implement Root node as scene manager
- [ ] More features for state machine:
	- [ ] Manage Sleep and Awaken - for pausing processing
- [ ] State Factory?
- [ ] Rules engine for states?
- [ ] Should this project be an Addon? Template?
- [ ] Build demo scene (title screen + basic gameplay... fireside scene?)
- [ ] Rewrite documentation & dev guide

## Try It Out

Clone the project and open it in Godot 4.x:

```bash
git clone https://github.com/Shurmn/gobo.git
```

Then run the `main.tscn` scene to see the current setup in action.

## License

MIT — free to use, modify, and build cool things with.

---

> _"Did this goof really just put a footer on a readme file? Why?"_  
> — You, probably
