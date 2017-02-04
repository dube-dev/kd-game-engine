KD Game Engine
==============
This is a 2D game engine written for JavaScript platforms.
It uses HTML Canvas for rendering and the `matter-js`
physics engine.

### Work in Progress

- This repository has just been posted and more documentation
  will be available over the next couple weeks!

- Additionally, there's much that has already implemented
  but not yet refactored into this repository.

- There will be a manual testing repository under `kd-game-engine-test'

### What's Planned?
- Multiplayer capability
- Awesome logic system
- Game modules can be imported from other npm modules

### What Could Happen?
- Subsystem for tile-based games
- Manager for multiple game servers (separate repo)
- Website for sharing game modules
- Universal level editor

Installation
============
This project is in early development; this will be updated later.

Game Engine Development
=======================

Getting Started
---------------

### Prerequisites

* Install packages `coffee-script`, `browserify` globally

  ```
  (sudo) npm install -g coffee-script
  (sudo) npm install -g browserify
  ```

### Basic Setup

```
npm install
```

### Building JavaScript source from CoffeeScript

```
npm build
```
This will need to be done before any testing!

Code Conventions
----------------

### depends.coffee file
Each package (folder) has a module called depends which calls all
the necessary require() functions. This makes it much easier to
manage dependancies between packages. (circular dependancies
result in very confusing results when using browserify!)

The depends file may include parent depencancies by extending the
object returned by the parent depends file.
