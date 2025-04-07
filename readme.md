
# GoBo 🧱 A Godot 4 base for building structured, scalable games faster 

_Hopefully: a modular foundation for building future Godot games._

## ✨ Overview

This is a **work-in-progress Godot project** designed to act as a reusable base for my future games. The focus is on solving common game architecture patterns once and reusing them cleanly.

Goals include:

- 🔁 Modular and extensible **state machine system**
- 📨 Decoupled **event bus** for flexible communication
- 🏗 Well-organized **project structure**
- 🎮 A unified **main scene** setup for rapid prototyping

## 📂 Project Structure

```
res://
├── scenes/         
├── scripts/
│   ├── core/       # Core logic modules
│   └── singletons/ # Autoloads, global systems
└── main.tscn       # The entry point of the game
```

## ⚙️ Systems (WIP)

### 🧠 State Machine

A reusable state machine node system.

### 🛰 Event Bus

A global signal-based event system for decoupling node dependencies.

```gdscript
EventBus.emit("player_died", player_id)
```

### 🌐 Main Scene

Acts as the entry point, bootstraps stuff, and manages game-level state.

## 📈 Roadmap

- [x] Set up project structure
- [x] Implement basic state machine
- [ ] Integrate global EventBus
- [ ] Add example game logic
- [ ] Build demo scene (title screen + basic gameplay)
- [ ] Write documentation & dev guide

## 🧪 Try It Out

Clone the project and open it in Godot 4.x:

```bash
git clone https://github.com/Shurmn/gobo.git
```

Then run the `main.tscn` scene to see the current setup in action.

## 🪪 License

MIT — free to use, modify, and build cool things with.


> _"Did this goof really just put a footer on a readme file? Why?"_  
> — You, probably
