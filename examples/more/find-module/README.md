# Writing a find module file

This is a short example showing how to craft a simple find module file to search for a library. This can be useful if the library you're trying to integrate does not come with CMake install support.

This example takes the `calculator-static` library from the `examples/core` section and brings it into the build using a find module file instead of relying on the generated CMake config files. The find module file itself can be found in the `cmake` folder in this directory. To ensure the library is found, we have to make two small changes to our CMake configure command (see `application/configure.bat/.sh`). We add `calculator-static_PATH` to set where to find the include and library files for our project, and `CMAKE_MODULE_PATH` so CMake knows where to find our `Findcalculator-static.cmake` file.

Hand crafting a find module file can be tricky, so if you're able to update the dependency to use CMake (and its `install` commands) this can sometimes be a simpler option. This will depend on the build complexity of the dependency however, so using a find module file might be the fastest option in some cases. The downside is it's necessary to independently maintain the CMake find module file separate from the dependency itself. Keeping them in sync can be come a maintenance headache over time.
