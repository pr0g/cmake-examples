# CMake Components

This is a small example of adding support for components to CMake libraries.

This is the functionality where you can specify individual components after the CMake `find_package` command.


```bash
find_package(CoolLib REQUIRED CONFIG COMPONENTS shades)
```

After doing a bunch of reading about the `COMPONENT` keyword in the `install` command and after doing a number of experiments I can't seem to see how it makes any difference whatsoever (if you're a CMake expert reading this please let me know! 😆) so I'm not currently using it in these examples.

The way it works is through carefully configuring the `-config.cmake` files.

In the example I intentionally use a different name for the component than for the library to show it's possible but it can also be the same (which might make more sense depending on the situation).

Be sure to check out `phrases-config.cmake.in` to see how the sub-components are setup.

It's possible to test out the examples by first building and installing the library (`configure.bat` and `build.bat` in the library folder) and then building the application (`configure.bat` and `build.bat` in the application folder).

## Special Thanks

Special thanks to Mark Eastwood for his GitHub project [nomnoms](https://github.com/markeastwood82/nomnoms) and his Stack Overflow [question](https://stackoverflow.com/questions/54702582/how-to-configure-project-with-components-in-cmake) for helping me better understand components in CMake.
