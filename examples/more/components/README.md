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

__Note__: `COMPONENTS` in the context of the `find_package` command (in the _application_) is something completely different to `COMPONENT` in the `install` command (in the _library_). This really confused me so I hope this helps clarify things for anyone else.

## Special Thanks

Special thanks to Mark Eastwood for his GitHub project [nomnoms](https://github.com/markeastwood82/nomnoms) and his Stack Overflow [question](https://stackoverflow.com/questions/54702582/how-to-configure-project-with-components-in-cmake) for helping me better understand components in CMake.
