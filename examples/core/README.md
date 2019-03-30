# The Examples

## Overview

There are four folders, each containing a library, and an application that uses that library (each top level folder is completely distinct).

The lion's share of the comments are in the _header-only_ folder as that's the first of the four I created and the simplest of the bunch. Each `CMakeLists.txt` file for each library (_header-only_, _static_, _shared_ and _shared\_export_) contain a bunch of the same commands so I only explain them during their first use (mostly...) so do start with _header-only_ if you want to read through them. The recommended order would be _header-only_, _static_, _shared_/_shared\_export_.

_NOTE_: The fourth project, _shared-export_, is very similar to _shared_ except it makes use of the `generate_export_header` command. This generates a file containing the export macros required when exporting functions from a _dll_. The `CMakeLists.txt` file for the library is modified slightly as well as the sample application which uses different macros/defines.

## Disclaimer

I'm not (yet) including info about how to specify build configurations (Debug/Release etc...). By default all these projects will build in Debug both on *nix/macOS and Windows. Expect an updated project to detail these steps hopefully in the not too distant future. I do mention build configurations in the [installing](/installing/README.md) section so there's some information regarding it there.

## Usage

All of the examples work identically with respect to install and/or build time.

Taking _header-only_ as an example:

```bash
cd <root>/examples/core/header-only/library/
mkdir build && cd build
# if *nix/macOS
cmake ..
# elseif Windows
cmake -G "Visual Studio 15 2017 Win64" .. # or whatever VS version you have
# endif
cmake --build . --target install
```

This will install the library to the default location (e.g. `/usr/local/include/calculator` for *nix/macOS or `C:\Program Files\calculator` on Windows). If you want to install the library to a custom location you must use `CMAKE_INSTALL_PREFIX`.

```bash
cd <root>/examples/core/header-only/library/
mkdir build && cd build
# if *nix/macOS
cmake -DCMAKE_INSTALL_PREFIX="<path/to/install/>" ..
# elseif Windows
cmake -G "Visual Studio 15 2017 Win64" -DCMAKE_INSTALL_PREFIX="<path/to/install/>" ..
# endif
cmake --build . --target install
```

To then build the application, `cd` to the _application_ folder and run these commands

```bash
cd <root>/examples/core/header-only/application/
mkdir build && cd build
# if *nix/macOS
cmake ..
# elseif Windows
cmake -G "Visual Studio 15 2017 Win64" .. # or whatever VS version you have
# endif
cmake --build .
# if *nix/macOS
./calculator-app
# elseif Windows
.\Debug\calculator-app.exe
# endif
10
```

If you had previously changed the install location, you must tell CMake where to look for the library using `CMAKE_PREFIX_PATH`

```bash
cd <root>/examples/core/header-only/application/
mkdir build && cd build
# if *nix/macOS
cmake -DCMAKE_PREFIX_PATH=<absolute/path/to/installed/lib/> ..
# elseif Windows
cmake -G "Visual Studio 15 2017 Win64" -DCMAKE_PREFIX_PATH=<absolute/path/to/installed/lib/> ..
# endif
cmake --build .
# as before for running...
```

Notice for `CMAKE_PREFIX_PATH` you must use an absolute path not a relative path from the build folder you're in. You can use a relative path when setting `CMAKE_INSTALL_PREFIX` if you wish.

### Miscellaneous

Some additional notes about the `CMakeLists.txt` files and CMake in general that might be useful.

#### Windows

- When installing to the default location on Windows (`C:\Program Files\<lib>`) you'll need to run `cmd.exe` (or [`cmder.exe`]((https://cmder.net/)) because it's 100% more awesome) as Administrator, or you'll get a bunch of errors about permissions and not being able to create new files in that location.

- On Windows, the folder name where the library gets installed to will be the CMake project name

```bash
# e.g.
# CMakeLists.txt
project(a-useful-library VERSION 0.0.1 LANGUAGES CXX)
...

# location after install
C:\Program Files\a-useful-library\
```

It's therefore best to keep the `project` name the same as the `export` name to ensure `find_package` works correctly.

#### Aliases

The namespace alias does not have to be the same name as the library or export name

- e.g. export: calculator-config, library: calculator, namespace: bob

#### Install Interface

In the `CMakeLists.txt` file

- `INCLUDES DESTINATION include`

does the same job as...

- `$<INSTALL_INTERFACE:${CMAKE_INSTALL_INCLUDEDIR}>`

Both set `INTERFACE_INCLUDE_DIRECTORIES`

```bash
#example

target_include_directories(
    calculator-lib PUBLIC
    $<INSTALL_INTERFACE:${CMAKE_INSTALL_INCLUDEDIR}>)

install(
    TARGETS calculator-lib
    EXPORT calculator-lib-config
    INCLUDES DESTINATION include)
```

In the examples I've opted for the generator expression and omitted the `INCLUDES` statement.