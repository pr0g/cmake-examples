# Handling nested (or transitive) dependencies

## Overview

In the vast majority of these example projects we get away without having to write our own `<project>-config.cmake` files and can rely on CMake to generate them for us with the various `install` commands. For simple cases this is fine, but there are situations where you will need to write one (luckily they're pretty short and simple) and here I'm going to try and explain why and how.

> Note: For more information on this please see [this post](https://discourse.cmake.org/t/propagation-of-fetchcontent-targets-when-installing/2559) on the CMake Discourse forum - there's a great response by Craig Scott ([@crasit](https://twitter.com/crascit)) who helped describe the solution to me.
>
> This [Stack Overflow answer](https://stackoverflow.com/a/50064639/1947066) also captures the solution quite nicely but it still didn't click for me on my first reading.

## The problem

I first ran into this issue while mixing the use of `FetchContent` and `find_package`.

We start with a simple header-only library with no dependencies (in this example `lib-a`). `lib-b` wants to use `lib-a`, and as `lib-a` is a header-only library there's no real advantage to installing it separately. Using `FetchContent` is a quick and simple way to bring that dependency in cleanly.

`lib-b` is a static library so can be built on its own. As it might grow in complexity in future, it would be nice if `app` can link against an existing `lib-b` without needing to build it itself (if we used `FetchContent` then `lib-b` would wind-up in the build tree of `app`, and if we deleted the `app` build folder we'd wind up having to build `lib-b` again unnecessarily). So we go ahead and build and install `lib-b` to a local folder (see the `configure-build-install.sh/bat` script in the `lib-b` folder) and then in `app` set `CMAKE_PREFIX_PATH` to point to the `lib-b` `install/` folder when configuring.

If we try and build `app` now (without a custom `<project>-config.cmake` file) we are confronted with this error:

```bash
Found package configuration file:

    <path>/<to>/cmake-examples/examples/more/nested-dependencies/library/lib-b/install/lib/cmake/lib-b/lib-b-config.cmake

but it set lib-b_FOUND to FALSE so package "lib-b" is considered to be NOT FOUND.  Reason given by package:

The following imported targets are referenced, but are missing:
lib-a::lib-a
```

I was stumped when I first saw this. It seemed to me like everything should _just work_ and I couldn't figure out what I was missing. After much gnashing of teeth I discovered that you have to explicitly specify your dependencies in your own `<proj>-config.cmake` file like so:

```cmake
include(CMakeFindDependencyMacro)
find_dependency(lib-a)
```

You also need to then `include` the new file we'll have CMake generate for us called `<proj>-targets.cmake`:

```cmake
include(${CMAKE_CURRENT_LIST_DIR}/lib-b-targets.cmake) 
# note: ${CMAKE_CURRENT_LIST_DIR} will be the directory where this ends up in the install folder (lib/cmake/lib-b/)
```

 `<proj>-targets.cmake` contains pretty much the same stuff as what the auto-generated `<proj>-config.cmake` file did before. By including it as shown above, we basically are just combining our hand-written file with the generated one once it ends up in the install directory.

The `CMakeLists.txt` file has to be updated slightly. In the `install EXPORT` command we have to install the newly generated `<proj>-targets.cmake` file (see line `35 `of `lib-b` `CMakeLists.txt` file) and then we have to install (essentially just copy) our hand-written `<proj>-config.cmake` file to the same directory (see lines `41`-`43`). The actual `<proj>-config.cmake` has a `.in` post-fix which allows us to introduce variables in the file that will be expanded later. This isn't strictly necessary but is useful for future updates. The `configure_file` command on line `40` does this simple transformation.

That's it! It's a bit of a pain CMake can't figure this out on its own and needs a little more information from us but it's not too bad in the grand scheme of things.

As I got a bit tired of typing out all these commands I created a little set of helpers to eliminate the boilerplate. Checkout [cmake-helpers](/README.md#cmake-helpers) for more information.
