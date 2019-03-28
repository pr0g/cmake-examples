# Installing and using versioned libraries in CMake

## Overview

One potential problem with installing libraries in `CMake` is you might have multiple versions of a library you'd like to install at the same time.

For example say you have designed, built and installed a library to elegantly solve the well established `FizzBuzz` programming problem. You build an app that uses this library to print the output of the `FizzBuzz` up to 100 digits, and everything is good.

You decide to start improving the `FizzBuzz` library and have an idea about using an iterator to produce an infinite sequence of `"Fizz"`, `"Buzz"` or `"FizzBuzz"`. The problem is this totally breaks the interface of your original `FizzBuzz` implementation which your first app is  relying on. To take advantage of your new and improved library you decide to move on from your first app and create a new interactive app that uses the updated `FizzBuzz` library. The problem is you don't really want to have to go and update the old app, and it'd sure be nice if it kept building in the future if you ever had to go back and fix a bug in it.

Versioning to the rescue!

It's possible to install `FizzBuzz 1.0.0` to your system (with a little care when setting up the folder structure for the install location) that can be used by app #1 and also install `FizzBuzz 2.0.0` to be used by your new and improved interactive app!

To achieve this in CMake there's a few things you need to do.

The first is to include `CMakePackageConfigHelpers` to to provide the `write_basic_package_version_file` command

```cmake
include(CMakePackageConfigHelpers)

write_basic_package_version_file(
    "${CMAKE_CURRENT_BINARY_DIR}/${PROJECT_NAME}/${PROJECT_NAME}-config-version.cmake"
    VERSION ${PROJECT_VERSION}
    COMPATIBILITY SameMajorVersion)
```

Here we write the `*-config-version.cmake` file to the directory where the built library files will end up. We've decided to use the `PROJECT_VERSION` for the config version file (though this could be a separate variable if you wished). There are a number of values you can pass to `COMPATIBILITY` but `SameMajorVersion` seems fairly sensible to me (this means the major version number must be the same as the requested one - so version `1.0.0` will not be compatible with version `2.0.0`).

This new file will need to be installed (copied) later. The rest of the `CMakeLists.txt` stays almost exactly the same apart from all of the install paths. To ensure installing a different version doesn't inadvertently overwrite the previously installed library we include the name and version in the path of the install location.

```cmake
${CMAKE_INSTALL_LIBDIR}/${PROJECT_NAME}-${PROJECT_VERSION}/${PROJECT_NAME}/
${CMAKE_INSTALL_LIBDIR}/cmake/${PROJECT_NAME}-${PROJECT_VERSION}/
${CMAKE_INSTALL_INCLUDEDIR}/${PROJECT_NAME}-${PROJECT_VERSION}/${PROJECT_NAME}/
# etc
```

The final step is to make sure we also install the `*-config-version.cmake` file to the `cmake` folder, the same location where the standard `*-config.cmake` file is located.

```cmake
install(
    FILES "${CMAKE_CURRENT_BINARY_DIR}/${PROJECT_NAME}/${PROJECT_NAME}-config-version.cmake"
    DESTINATION ${CMAKE_INSTALL_LIBDIR}/cmake/${PROJECT_NAME}-${PROJECT_VERSION})
```

And that's pretty much it!

Running something roughly equivalent to:

```cmake
cmake ..
cmake --build . --target install
```

from the command line in the build/ directory will produce this:

```bash
-- Install configuration: ""
-- Installing: /usr/local/lib/fizzbuzz-1.0.0/fizzbuzz/libfizzbuzz.a
-- Installing: /usr/local/lib/cmake/fizzbuzz-1.0.0/fizzbuzz-config.cmake
-- Installing: /usr/local/lib/cmake/fizzbuzz-1.0.0/fizzbuzz-config-noconfig.cmake
-- Installing: /usr/local/include/fizzbuzz-1.0.0/fizzbuzz
-- Installing: /usr/local/include/fizzbuzz-1.0.0/fizzbuzz/fizzbuzz.h
-- Installing: /usr/local/lib/cmake/fizzbuzz-1.0.0/fizzbuzz-config-version.cmake
```

If you did the same thing from the `2.0.0` library you'd see this:

```bash
-- Install configuration: ""
-- Installing: /usr/local/lib/fizzbuzz-2.0.0/fizzbuzz/libfizzbuzz.a
-- Installing: /usr/local/lib/cmake/fizzbuzz-2.0.0/fizzbuzz-config.cmake
-- Installing: /usr/local/lib/cmake/fizzbuzz-2.0.0/fizzbuzz-config-noconfig.cmake
-- Installing: /usr/local/include/fizzbuzz-2.0.0/fizzbuzz
-- Installing: /usr/local/include/fizzbuzz-2.0.0/fizzbuzz/fizzbuzz.h
-- Installing: /usr/local/lib/cmake/fizzbuzz-2.0.0/fizzbuzz-config-version.cmake
```

Now in the app when using `find_project` to locate the library you simply use `find_package(fizzbuzz 1.0.0 REQUIRED)`, making sure to include the version number of the library.

Now both versions of the app (one using `1.0.0` and the other using `2.0.0`) can both work at the same time!

I'm not sure how useful this actually is in practice and you may be able to work around this issue by making use of `CMAKE_INSTALL_PREFIX` when installing and `CMAKE_PREFIX_PATH` when searching for an installed project/library but this versioning technique may come in handy on certain occasions.