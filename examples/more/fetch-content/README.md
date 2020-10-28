# Using `FetchContent` for fun and profit

## Overview

`FetchContent` is a relatively new addition to CMake and seems like in certain contexts it can be extremely useful.

Instead of downloading, building and installing a library as an entirely separate project, you can use `FetchContent` to make the dependency part of your build. In my limited experience this seems super useful for small libraries where the time to build them is pretty small or non-existent (e.g. a header-only library) but perhaps less so for a large dependency.

The problem with using `FetchContent` for a larger library is if you want to do a clean build for your project, you'll have to build all dependencies again too (as the library gets added to a `_deps` folder in your `build/` folder). You might not always want this so use with care, however it does seem like a useful tool for certain situations.

## Instructions

- Just run `configure.bat/sh` followed by `build.bat/sh` and then run the executable with `build/<debug/release>/fetch-content-example`.
