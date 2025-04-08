# GoBo 🧱 A Godot 4 base for building structured, scalable games faster 

_Hopefully: a modular foundation for building future Godot games._

## Overview

This is a **work-in-progress Godot project** designed to act as a reusable base for my future games. The focus is on solving common game architecture patterns once and reusing them cleanly.

Goals include:

- Modular and extensible **state machine system**
- Decoupled **event bus** for flexible communication
- Well-organized **project structure**
- A unified **main scene** setup for rapid prototyping

## Project Structure

```
res://
├── scenes/
│   ├── menu/       # Main menu
├── scripts/
│   ├── core/       # Core logic modules
│   └── singletons/ # Autoloads, global systems
└── main.tscn       # The entry point of the game
```

This project is organized into three main folders, each serving a distinct purpose to keep everything modular and self-contained:

### **Scenes Folder**
All the scene files are located in the `scenes/` directory. Each scene is self-contained with its associated files (such as scripts, shaders, etc.). There are **no external script dependencies**, except for the core functionality provided in the `scripts/` folder. This ensures that each scene can be easily worked on and reused without additional external links.

### **Scripts Folder**
The `scripts/` folder contains the core functionality and singleton systems:
- **`core/`**: This subdirectory houses the base classes, stators, states, and data structures that other game systems will extend.
- **`singletons/`**: This is where autoloads (singletons) are stored for global access throughout the game, handling persistent global behavior and services.

### **Assets Folder**
All art assets, including images, sounds, and animations, are neatly organized under the `assets/` directory. This keeps resources structured and easy to manage.

This structure ensures that each part of the project is modular, easily extendable, and maintainable.

## Systems (WIP)

### State Machine

A reusable state machine node system.

### Event Bus

A global signal-based event system for decoupling node dependencies.

```gdscript
EventBus.emit("player_died", player_id)
```

### Main Scene

Acts as the entry point, bootstraps stuff, and manages game-level state.

## Roadmap

- [x] Set up project structure
- [x] Implement basic state machine
- [ ] Integrate global EventBus
- [ ] Add example game logic
- [ ] Build demo scene (title screen + basic gameplay)
- [ ] Write documentation & dev guide

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
