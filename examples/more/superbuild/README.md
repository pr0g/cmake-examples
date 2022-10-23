# How to setup a superbuild

## Overview

This example is an evolution of [external-project-add](/examples/more/external-project-add/README.md). It takes roughly the same format but adds a new option to build the external library and main application in one step.

The trick is to define a 'pseudo' external project for the repo that uses the local source directory to build. It depends on the required external dependencies to ensure they're downloaded and built first.

This example ensures the external dependencies go to a separate build folder in the external folder (otherwise we might as well use `FetchContent`). It also handles different configurations (Debug/Release etc...), using separate folders to store the intermediate build files. Both are installed to the same folder but use a debug postfix (`d`) to ensure debug and release libraries don't stomp on each other.

[CMakeLists.txt](CMakeLists.txt), [external/CMakeLists.txt](external/CMakeLists.txt) and [superbuild.cmake](superbuild.cmake) are fully commented to help explain each step of the process.

## Instructions

- Run `./configure.sh` (or `configure.bat` on Windows)
- Run `./build.sh` (or `build.bat` on Windows)
- Run either `./build/<config>/superbuild-example` (or `build\<config>\superbuild-example.exe` on Windows)

## References

- [Sarcasm/cmake-superbuild](https://github.com/Sarcasm/cmake-superbuild) - another simple example of using a superbuild with CMake.
- [Better support for CMake superbuild pattern](https://youtrack.jetbrains.com/issue/CPP-11484/Better-support-for-CMake-superbuild-pattern) - this question (and attached 'awesome-project' attachment) also has a nice example of using a superbuild.
