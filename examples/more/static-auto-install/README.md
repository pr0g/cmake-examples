# (EXPERIMENT) Auto-install library during app development

## Overview

GitHub user [maluramichael](https://github.com/maluramichael) made an interesting observation about the overhead of having to continually install a library while working on it and an application together. I've been thinking about this over the last several weeks and have created a small experiment to try and improve this process a little.

The idea is, (after a small amount of initial setup) to provide the ability for the application to automatically build and install the library it depends on each time it is built itself.

I'm not sure if this is really the best idea or how useful it might be (I've yet to use it in anger) but am sharing this example as a proof of concept.

## Details

Hunting around the CMake docs I discovered the command `execute_process`. This runs during the configure stage (when you invoke `cmake ..`) which is necessary to ensure the library is installed so `find_package` works from the application's `CMakeLists.txt` file.

The idea is you provide the path to the root `CMakeLists.txt` file of the library you wish to work on at the same time as the application. The application `CMakeLists.txt` file will then invoke the appropriate CMake commands to build and install the library each time you configure the application.

If you take a look at the `CMakeLists.txt` file in this directory there are some comments to try and explain what's going on. I'm just providing the application in this folder, it depends on the existing `calculator-static` library. The one additional step required is to pass `-DDEV_LIB_DIR` to `cmake` at the command line (or just update the variable in the `CMakeLists.txt` file) to provide the path to the library.

## Usage

```bash
cd <root>/examples/more/static-auto-install/application/
# if *nix/macOS
cmake -S . -B build -DDEV_LIB_DIR="<root>/examples/core/static/library/"
# elseif Windows
cmake -S . -B build -G "Visual Studio 16 2019" -A x64 -DDEV_LIB_DIR="<root>/examples/core/static/library/" # or whatever VS version you have
# endif
cmake --build build
```

## Caveats

* At the moment the build/install step only happens during configure (`cmake ..`), not during build (`cmake --build .`) which means you have to run both commands to have the library rebuilt and installed. This might be okay, but it also might be nice to have it happen during `cmake --build .` as well. I might come back to this...
* The approach is a little heavy handed (installing the library over and over again during development might seem like overkill, and might be slow depending on the size of the library? YMMV)
* `add_submodule` might well be a fine alternative - I will add an example of that soon, if not just for my reference 🙂
