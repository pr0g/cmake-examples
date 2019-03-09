# The Examples

## Overview

There are three folders, each containing a library, and an application that uses that library (each top level folder is completely distinct).

The lion's share of the comments are in the _header-only_ folder as that's the first of the three I created and the simplest of the bunch. Each _CMakeLists.txt_ file for each library (_header-only_, _static_ and _dynamic_) contain a bunch of the same commands so I only explain them in their first use (mostly...) so do start with _header-only_ if you want to read through them. The recommended order would be _header-only_, _static_, _dynamic_.

## Usage

All of the examples work identically with respect to install and/or build time.

Taking _header-only_ as an example:

```bash
cd <root>/examples/header-only/library/
mkdir build && cd build
cmake ..
cmake --build . --target install
```

This will install the library to the default location (e.g. `/usr/local/include/calculator` for *nix/macOS or `C:\Program Files\calculator` on Windows). If you want to install the library to a custom location you must use `CMAKE_INSTALL_PREFIX`.

```bash
cd <root>/examples/header-only/library/
mkdir build && cd build
cmake -DCMAKE_INSTALL_PREFIX="<path/to/install/>" ..
cmake --build . --target install
```

To then build the application, `cd` to the _application_ folder and run these commands

```bash
cd <root>/examples/header-only/application/
mkdir build && cd build
cmake ..
cmake --build .
./calculator-app
10
```

If you had previously changed the install location, you must tell CMake where to look for the library using `CMAKE_PREFIX_PATH`

```bash
cd <root>/examples/header-only/application/
mkdir build && cd build
cmake -DCMAKE_PREFIX_PATH=<absolute/path/to/installed/lib/> ..
cmake --build .
```

Notice for `CMAKE_PREFIX_PATH` you must use an absolute path not a relative path from the build folder you're in. You can use a relative path when setting `CMAKE_INSTALL_PREFIX` if you wish.