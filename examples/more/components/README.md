# CMake `find_package` COMPONENTS

This is a small example of adding support for components to CMake libraries.

This is the functionality where you can specify individual components after the CMake `find_package` command.

```bash
find_package(CoolLib REQUIRED CONFIG COMPONENTS shades leather-jacket)
```

The way it works is through carefully configuring the `<package>-config.cmake` files.

In the example I intentionally use a different name for the component than for the library to show it's possible but it can also be the same (which might make more sense depending on the situation).

Be sure to check out `phrases-config.cmake.in` to see how the sub-components are setup.

It's possible to test out the examples by first building and installing the library (`configure.bat` and `build.bat` in the library folder) and then building the application (`configure.bat` and `build.bat` in the application folder).

__Note__: The `COMPONENTS` keyword in the context of the `find_package` command (in the _application_) is orthogonal to `COMPONENT` in the `install` command (in the _library_). They _can_/_may_ be related, but this is not required. I found (find?) this quite confusing so I hope this helps clarify things for anyone reading this.

## Miscellaneous

To help understand how the `find_package` command works we could make a couple of changes to the _library_ `CMakeLists.txt` file.

Suppose when we call `install(EXPORT greetings-config...)`, if instead of setting the location to be `${CMAKE_INSTALL_LIBDIR}/cmake/${PROJECT_NAME}`, we set it to be `${CMAKE_INSTALL_LIBDIR}/cmake/greetings`. In our application we could then just call `find_package(greetings REQUIRED CONFIG)` and use `hello` and `hey` as we do now instead of using `find_package(phrases REQUIRED CONFIG COMPONENTS greetings)`.

The top level `phrases-config.cmake` (from what I can tell) appears to just be an organizational construct to group logically related ~~features~~ components.

## Special Thanks

Special thanks to Mark Eastwood for his GitHub project [nomnoms](https://github.com/markeastwood82/nomnoms) and his Stack Overflow [question](https://stackoverflow.com/questions/54702582/how-to-configure-project-with-components-in-cmake) for helping me better understand components in CMake.

Also a big thank you to [Craig Scott](https://github.com/Crascit) ([@crascit](https://twitter.com/crascit)) and [Deniz Bahadir](https://github.com/Bagira80) ([@DenizThatMenace](https://twitter.com/DenizThatMenace)) who kindly responded to my e-mails asking about the `COMPONENT` keyword.
