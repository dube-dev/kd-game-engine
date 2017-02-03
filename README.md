KD Game Engine
==============
This is a 2D game engine written for JavaScript platforms.

Installation
============
This project is in early development; this will be updated later.

Game Engine Development
=======================

Prerequisites
-------------

* Install packages `coffee-script`, `browserify` globally

  ```
  (sudo) npm install -g coffee-script
  (sudo) npm install -g browserify
  ```

Code Conventions
----------------

### depends.coffee file
Each package (folder) has a module called depends which calls all
the necessary require() functions. This makes it much easier to
manage dependancies between packages. (circular dependancies
result in very confusing results when using browserify!)

The depends file may include parent depencancies by extending the
object returned by the parent depends file.
