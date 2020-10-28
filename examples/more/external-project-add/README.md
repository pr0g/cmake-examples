# How best to use `ExternalProject_Add` (_in my opinion_)

## Overview

For the longest time I just didn't understand how to effectively use `ExternalProject_Add` (me not understanding things is a common theme in this repo...).

I tried dabbling with it a little and spent some time searching for idiomatic examples but couldn't find anything particularly helpful. After I discovered `FetchContent` (example [here](../fetch-content)) I didn't really understand the use of `ExternalProject_Add` outside of esoteric circumstances (dealing with different platforms/toolchain files/compilers etc.)... until now 🙂

The realization I had was that `ExternalProject_Add` has no business being in the same `CMakeLists.txt` file as your project! It should be off in its own `CMakeLists.txt` file to automate the process of downloading/building/installing libraries you depend on.

All `ExternalProject_Add` does is automate the manual steps of say, going to GitHub, cloning a project, configuring/building and installing it. You can just have `ExternalProject_Add` do all of this for you, and then simply use `find_package` in your `CMakeLists.txt` (optionally paired with `-DMAKE_INSTALL_PREFIX` if the libraries were installed to a custom location).

By doing this you don't have to mess around with any of the properties in the external dependency (e.g. `ExternalProject_Get_Property` to manually extract include paths etc...). You just do `find_package(<your-dependency>)` like in the other examples (making sure to link against it in `target_link_libraries`) and you're away!

## Instructions

- First navigate to the `external/` folder and run `configure_and_build.bat/sh` (this will download, configure, build and install the external dependency to the `build/` folder in `external/`).
- Next, `cd` up to `external-project-add` (this folder) and run `configure.bat/sh` and then `build.bat/sh` (please do take a look inside to see what's going on - the only really important thing is how we set `CMAKE_PREFIX_PATH` to know to look in the `external/build/` folder).
- Run `build/<debug/release>/external-project-add-example`.
