# Modern CMake Examples [![Mentioned in Awesome CMake](https://awesome.re/mentioned-badge.svg)](https://github.com/onqtam/awesome-cmake)

## Overview

This repository is a collection of as simple as possible CMake projects (with a focus on __installing__). The idea is to try and help understand exactly what each part of a `CMakeLists.txt` file does and why it is needed.

This is basically intended as a series of reminders to help me remember how to use CMake 🤦

Please see the [Core Example README](examples/core/README.md) for steps on using the example libraries and the [Installing README](installing/README.md) for an overview of installing CMake libraries. The [More Example](examples/more/) section contains slightly more complex examples and will continue to grow.

## Disclaimer

I am __NOT__ a CMake expert - these examples may contain gaffs, faux pas, mistakes etc etc.. Please take everything with a pinch of salt and if you recognize a blatant error or mistake please feel free to create an issue or PR.

## Background

For the longest time I just didn't grok __installing__ in CMake<sup>1</sup>.

I didn't understand _why_ you'd ever want to do it, or _what_ it was useful for. When I started looking into _how_ to do it I could not make head nor tail of all the various __install__ commands. While trying to figure all this stuff out I was immersing myself in trying to learn Modern CMake (targets, targets targets...) and how these two things are related.

The examples in this repo are the culmination of many months of sporadic research to try and understand CMake more fully and write better CMake scripts.

I'm sharing my journey so far to hopefully help some other poor soul who is in the same boat I'm in. With any luck there will be something someone finds useful here.

For an explanation<sup>2</sup> of _what_ (in the context of CMake) __installing__  is, please see the [installing](installing/README.md) section and take a look at the various [example](examples/core) projects for context.

1. I recently discovered a kindred spirit on [reddit](https://www.reddit.com/r/cpp/comments/6m7sp6/cmake_and_c_whats_the_deal_with_installing/)
2. My interpretation?

## Miscellaneous

While using CMake over the last several months I've stumbled across a few useful little bits and bobs that I feel are worth recording/sharing.

### Less `cd`-ing

To run CMake from your source directory (instead of having to `mkdir build && cd build`) you can pass `-S` and the path to your source folder (most likely just `.` for where you currently are) and `-B` to specify the build folder.

```bash
cd <project/root>
cmake -S . -B build/
```

You then just need to remember to call

```bash
cmake --build build/
```

to actually build your project.

> Note: The `-S` option was added to CMake in version `3.13`. Before then you could use the undocumented `-H` option. I'd recommend sticking with `-S` now if you can 🙂.

### compile_commands.json

You should absolutely use `-DCMAKE_EXPORT_COMPILE_COMMANDS=ON` when generating your project to have CMake create a `compile_commands.json` file for you. This is useful for all sorts of tools (`clang-tidy`, `cppcheck`, `oclint`, `include-what-you-use` etc. etc...).

```bash
# when configuring from the root CMakeLists.txt of your project
cmake -S . -B build/ -DCMAKE_EXPORT_COMPILE_COMMANDS=ON
```

> Note: `CMAKE_EXPORT_COMPILE_COMMANDS` is only supported for _Make_ and _Ninja_ generators. The good news is it's pretty simple to use _Ninja_ on Windows in place of _Visual Studio_/_MSBuild_ - for instructions please see [this repo](https://github.com/pr0g/clang-experiments#ninja).
>
> __TLDR__: Add `-G Ninja` to the above command to use _Ninja_.

### Defines

Sometimes it's really useful to be able to set defines at the command line when running the CMake generator. An easy way to do this is to add a simple generator expression to your `CMakeLists.txt` file in `target_compile_definitions`.

```bash
target_compile_definitions(
    ${PROJECT_NAME} PRIVATE
    $<$<BOOL:${YOUR_DEFINE}>:YOUR_DEFINE>)
```

In your code you can then use this define for some sort of conditional compilation.

```c++
#ifdef YOUR_DEFINE
// something useful
#endif // YOUR_DEFINE
```

And when invoking `cmake` you can pass a CMake variable like so if you want that macro to be defined.

```bash
# from the src/ (root) folder
cmake -S . -B build/ -DYOUR_DEFINE
```

If you don't pass the variable then the generator expression will evaluate to false and no define will be added.

### Extra Output

Sometimes when building with CMake to diagnose an issue you might want more info about exactly what's being compiled. You can see everything that's passed to the compiler when building with the `--verbose` (`-v`) flag.

```bash
# from the src/ (root) folder
cmake --build build/ -v
```

This works for an array of generators (_Make, Visual Studio, Ninja_ etc.).

### CONFIG

You'll notice all of the `find_package` commands include the `CONFIG` keyword after the package name (and `REQUIRED`). This is to let CMake know we're explicitly using a CMake `<package>-config.cmake` file and not a FindModule command (all these examples use the more modern config approach so including `CONFIG` in the `find_package` command should be preferred).

### DEBUG_POSTFIX

It is possible to set a property called `DEBUG_POSTFIX` on a given target to have a string appended to the name of the debug version of the library (usually `d` or `-debug`, but as far as I know it can be anything).

```cmake
set_target_properties(
    ${PROJECT_NAME} PROPERTIES DEBUG_POSTFIX "d")
```

This is incredibly useful when installing libraries as it means if you build and install the `Debug` configuration and then build and install the `Release` configuration, the `Debug` version of the library won't be overridden (you'll just have `your-libraryd.lib` and `your-library.lib`) in the `lib/` folder. This works for single and multi-config generators.

### FetchContent

Check out the [fetch-content](examples/more/fetch-content) example for a simple demonstration using the commands and see the links below by Sascha Offe, Kuba Sejdak and Michael Hirsch for more information.

### ExternalProject_Add

Check out the [external-project-add](examples/more/external-project-add) example for an (_opinionated_) introduction on how to take advantage of the command.

### cmake-helpers

I've put together some little wrappers to reduce the amount of boilerplate needed when installing libraries. These can be pulled in using `FetchContent`. Please see [cmake-helpers](https://github.com/pr0g/cmake-helpers) for more details.

### Project Structure

When creating a library that is going to be used via installing (`find_package`) and/or `add_subdirectory`/`FetchContent`, it is wise to ensure the include paths for files are the same for both. For this reason it's (_in my humble opinion_) best to format your directory structure like so:

```bash
|-- <library-name>/
    |-- include/
        |-- <library-name>/
            |-- file1.h
            |-- file2.h
            |-- etc...
    |-- src/
        |-- file1.cpp
        |-- file2.cpp
        |-- etc...
    |-- CMakeLists.txt
```

When you specify `target_include_directories` (see below), have it point to the `include/` folder so all includes wind up looking like `#include "library-name/file1.h"` as opposed to just `#include "file1.h"`. This helps to compartmentalize the library files (similar to a `namespace`).

```cmake
target_include_directories(
    ${PROJECT_NAME}
    INTERFACE $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include>
              $<INSTALL_INTERFACE:${CMAKE_INSTALL_INCLUDEDIR}>)
```

The install command for the interface (`.h`) files then looks like this:

```cmake
install(DIRECTORY ${CMAKE_CURRENT_LIST_DIR}/include/${PROJECT_NAME}
        DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}/${PROJECT_NAME})
```

Now the include paths for the library will always be consistent whether using `find_package` or `FetchContent`.

_Aside: For more information on approaches to project structure checkout out [Pitchfork](https://github.com/vector-of-bool/pitchfork) by [vector-of-bool](https://github.com/vector-of-bool)._

## CMake Resources

I've been attempting to learn CMake for a while and have built up quite a list of articles/blogs/documentation that have helped inform my understanding up to this point. Please see them listed below (mainly for my benefit so I have them all in one place).

### Articles

* CLIUtils
  * [An Introduction to Modern CMake](https://cliutils.gitlab.io/modern-cmake/)
* The Coding Nest
  * [Basic CMake usage](https://codingnest.com/basic-cmake/)
  * [Basic CMake, part 2: libraries](https://codingnest.com/basic-cmake-part-2/)
* Pablo Arias
  * [It's Time To Do CMake Right](https://pabloariasal.github.io/2018/02/19/its-time-to-do-cmake-right/)
* steveire
  * [Opt-in header-only libraries with CMake](https://steveire.wordpress.com/2016/08/09/opt-in-header-only-libraries-with-cmake/)
  * [Embracing Modern CMake](https://steveire.wordpress.com/2017/11/05/embracing-modern-cmake/)
* GitLab.Kitware - CMake
  * [How To Find Libraries](https://gitlab.kitware.com/cmake/community/wikis/doc/tutorials/How-To-Find-Libraries)
  * [Exporting and Importing Targets](https://gitlab.kitware.com/cmake/community/wikis/doc/tutorials/Exporting-and-Importing-Targets)
  * [How to create a ProjectConfig.cmake file](https://gitlab.kitware.com/cmake/community/wikis/doc/tutorials/How-to-create-a-ProjectConfig.cmake-file)
* Foonathan
  * [Tutorial: Easily supporting CMake install and find_package()](https://foonathan.net/blog/2016/03/03/cmake-install.html)
  * [Tutorial: Easy dependency management for C++ with CMake and Git](https://foonathan.net/blog/2016/07/07/cmake-dependency-handling.html)
* Coderwall
  * [Use CMake-enabled libraries in your CMake project](https://coderwall.com/p/y3zzbq/use-cmake-enabled-libraries-in-your-cmake-project)
  * [Use CMake-enabled libraries in your CMake project (II)](https://coderwall.com/p/qk2eog/use-cmake-enabled-libraries-in-your-cmake-project-ii)
  * [Use CMake-enabled libraries in your CMake project (III)](https://coderwall.com/p/qej45g/use-cmake-enabled-libraries-in-your-cmake-project-iii)
* Arne Mertz
  * [CMake Project Structure](https://arne-mertz.de/2018/06/cmake-project-structure/)
  * [CMake – Properties and Options](https://arne-mertz.de/2018/07/cmake-properties-options/)
* rix0r
  * [The Ultimate Guide to Modern CMake](https://rix0r.nl/blog/2015/08/13/cmake-guide/)
* Crascit
  * [Enabling C++11 And Later In CMake](https://crascit.com/2015/03/28/enabling-cxx11-in-cmake/)
  * [CMake targets with detailed dependencies](https://crascit.com/2015/02/02/cmake-target-dependencies/)
* Mario Badr
  * [Creating a Header-Only Library with CMake](http://mariobadr.com/creating-a-header-only-library-with-cmake.html)
* mbinna
  * [Effective Modern CMake](https://gist.github.com/mbinna/c61dbb39bca0e4fb7d1f73b0d66a4fd1)
* LLVM
  * [CMake Primer](https://llvm.org/docs/CMakePrimer.html)
* devdocs
  * [CMake](https://devdocs.io/cmake/)
* Jetbrains - CLion
  * [Quick CMake Tutorial](https://www.jetbrains.com/help/clion/quick-cmake-tutorial.html)
* SysProgs - visualgdb
  * [Exporting and importing CMake packages with find_package](https://visualgdb.com/tutorials/linux/cmake/find_package/)
* ecrafter
  * [Exporting and importing CMake packages with find_package](https://ecrafter.wordpress.com/2012/06/16/cmake-tutorial-part-5/)
* KDAB
  * [Modern CMake with Qt and Boost](http://www.kdab.com/modern-cmake-with-qt-and-boost/)
* Cognitive Waves
  * [CMAKE AND VISUAL STUDIO](https://cognitivewaves.wordpress.com/cmake-and-visual-studio/)
* Reddit - How to CMake good
  * [New Educational Video Series: How to CMake Good](https://www.reddit.com/r/cpp/comments/96zm16/new_educational_video_series_how_to_cmake_good/)
* Fosdem - Alexander Neundorf
  * [Installing and Finding packages, Exporting and
Importing targets](https://archive.fosdem.org/2013/schedule/event/moderncmake/attachments/slides/258/export/events/attachments/moderncmake/slides/258/cmake_fosdem_2013.pdf)
* fede.tft
  * [CMake part 3: Finding libraries](https://fedetft.wordpress.com/2010/03/07/cmake-part-3-finding-libraries/)
* Daniel Pfeifer
  * [Effective CMake](https://github.com/boostcon/cppnow_presentations_2017/blob/master/05-19-2017_friday/effective_cmake__daniel_pfeifer__cppnow_05-19-2017.pdf)
* kde
  * [How to get CMake find what you want it to](https://blogs.kde.org/2008/12/12/how-get-cmake-find-what-you-want-it)
* Schneide Blog - Marius Elvert
  * [Modern CMake with target_link_libraries](https://schneide.blog/2016/04/08/modern-cmake-with-target_link_libraries/)
* Jeff Preshing
  * [Learn CMake's Scripting Language in 15 Minutes](https://preshing.com/20170522/learn-cmakes-scripting-language-in-15-minutes/)
* Sam Thursfield
  * [CMake: dependencies between targets and files and custom commands](https://samthursfield.wordpress.com/2015/11/21/cmake-dependencies-between-targets-and-files-and-custom-commands/)
* Sascha Offe
  * [Using CMake with External Projects](http://www.saoe.net/blog/using-cmake-with-external-projects/)
* Kuba Sejdak
  * [How to join repositories in CMake](https://kubasejdak.com/how-to-join-repositories-in-cmake)
* Michael Hirsch, Ph.D.
  * [CMake FetchContent vs. ExternalProject](https://www.scivision.dev/cmake-fetchcontent-vs-external-project/)

### Documentation

* [cmake-buildsystem](https://cmake.org/cmake/help/latest/manual/cmake-buildsystem.7.html)
* [cmake-packages](https://cmake.org/cmake/help/latest/manual/cmake-packages.7.html)
* [cmake-properties](https://cmake.org/cmake/help/latest/manual/cmake-properties.7.html)
* [cmake-generator-expressions](https://cmake.org/cmake/help/latest/manual/cmake-generator-expressions.7.html)
* [install](https://cmake.org/cmake/help/latest/command/install.html)
* [find_package](https://cmake.org/cmake/help/latest/command/find_package.html)
* [target_include_directories](https://cmake.org/cmake/help/latest/command/target_include_directories.html)
* [target_compile_definitions](https://cmake.org/cmake/help/latest/command/target_compile_definitions.html)
* [project](https://cmake.org/cmake/help/latest/command/project.html)
* [macro](https://cmake.org/cmake/help/latest/command/macro.html)
* [function](https://cmake.org/cmake/help/latest/command/function.html)
* [set](https://cmake.org/cmake/help/latest/command/set.html)
* [ExternalProject](https://cmake.org/cmake/help/latest/module/ExternalProject.html)
* [FetchContent](https://cmake.org/cmake/help/latest/module/FetchContent.html)
* [CMakePackageConfigHelpers](https://cmake.org/cmake/help/latest/module/CMakePackageConfigHelpers.html)
* [CMAKE_PREFIX_PATH](https://cmake.org/cmake/help/latest/variable/CMAKE_PREFIX_PATH.html#variable:CMAKE_PREFIX_PATH)
* [CMAKE_INSTALL_PREFIX](https://cmake.org/cmake/help/latest/variable/CMAKE_INSTALL_PREFIX.html)
* [CMAKE_INSTALL_PREFIX_INITIALIZED_TO_DEFAULT](https://cmake.org/cmake/help/latest/variable/CMAKE_INSTALL_PREFIX_INITIALIZED_TO_DEFAULT.html)

### Stack Overflow

* [How to use CMake to find and link to a library using install-export and find_package?](https://stackoverflow.com/questions/31537602/how-to-use-cmake-to-find-and-link-to-a-library-using-install-export-and-find-pac)
* [preferred cmake project structure](https://stackoverflow.com/questions/33534115/preferred-cmake-project-structure)
* [CMake: How to set up source, library and CMakeLists.txt dependencies?](https://stackoverflow.com/questions/31512485/cmake-how-to-set-up-source-library-and-cmakelists-txt-dependencies)
* [CMake share library with multiple executables](https://stackoverflow.com/questions/33443164/cmake-share-library-with-multiple-executables)
* [Setting CMAKE_INSTALL_PREFIX from CMakeLists.txt file](https://stackoverflow.com/questions/39481958/setting-cmake-install-prefix-from-cmakelists-txt-file/39485990)
* [Modern way to set compiler flags in cross-platform cmake project](https://stackoverflow.com/questions/45955272/modern-way-to-set-compiler-flags-in-cross-platform-cmake-project)
* [cmake usefulness of aliases](https://stackoverflow.com/questions/46567646/cmake-usefulness-of-aliases)
* [Package vs Library](https://stackoverflow.com/questions/23832339/package-vs-library)
* [After CMake install, I can't find a package with find_package](https://stackoverflow.com/questions/50687477/after-cmake-install-i-cant-find-a-package-with-find-package)
* [cmake add_library, followed by install library destination](https://stackoverflow.com/questions/22278381/cmake-add-library-followed-by-install-library-destination)
* [CMake install is not installing libraries on Windows](https://stackoverflow.com/questions/21592361/cmake-install-is-not-installing-libraries-on-windows)
* [How to copy DLL files into the same folder as the executable using CMake?](https://stackoverflow.com/questions/10671916/how-to-copy-dll-files-into-the-same-folder-as-the-executable-using-cmake)
* [Path to target output file](https://stackoverflow.com/questions/4346281/path-to-target-output-file)
* [Building of executable and shared library with cmake, runtimelinker does not find dll](https://stackoverflow.com/questions/23323741/building-of-executable-and-shared-library-with-cmake-runtimelinker-does-not-fin)
* [https://stackoverflow.com/questions/28692896/how-to-use-cmake-generator-expression-target-filetgt](https://stackoverflow.com/questions/28692896/how-to-use-cmake-generator-expression-target-filetgt)
* [A simple example of using cmake to build a Windows DLL](https://stackoverflow.com/questions/24872225/a-simple-example-of-using-cmake-to-build-a-windows-dll)
* [CMake run custom command before build?](https://stackoverflow.com/questions/37862072/cmake-run-custom-command-before-build)
* [How to change the build type to Release mode in cmake?](https://stackoverflow.com/questions/19024259/how-to-change-the-build-type-to-release-mode-in-cmake?rq=1)

### YouTube

* [Oh No! More Modern CMake - Deniz Bahadir - Meeting C++ 2019](https://youtu.be/y9kSr5enrSk)
* [More Modern CMake - Deniz Bahadir - Meeting C++ 2018](https://youtu.be/y7ndUhdQuU8)
* [CppCon 2019: Craig Scott “Deep CMake for Library Authors”](https://www.youtube.com/watch?v=m0DwB4OvDXk)
* [C++Now 2017: Daniel Pfeifer “Effective CMake"](https://youtu.be/bsXLMQ6WgIk)
* [CMake for Dummies](https://youtu.be/7W4Q-XLnMaA)
* [C++Now 2018: Mateusz Pusz “Git, CMake, Conan: How to Ship and Reuse our C++ Projects”](https://youtu.be/6sWec7b0JIc)
* [CppCon 2017: Mathieu Ropert “Using Modern CMake Patterns to Enforce a Good Modular Design”](https://youtu.be/eC9-iRN2b04)
* [Embracing Modern CMake](https://youtu.be/JsjI5xr1jxM)
* [C++ Weekly - Ep 78 - Intro to CMake](https://youtu.be/HPMvU64RUTY)
* [How to CMake Good - Recommended Order](https://www.youtube.com/playlist?list=PLK6MXr8gasrGmIiSuVQXpfFuE1uPT615s)

### Books

* [Professional CMake:
A Practical Guide](https://crascit.com/professional-cmake/)
* [CMake Cookbook: Building, testing, and packaging modular software with modern CMake](https://www.amazon.co.uk/dp/1788470710/ref=cm_sw_em_r_mt_dp_U_BZ-GCbYRNW0Q3)
* [Mastering CMake](https://www.amazon.co.uk/dp/1930934319/ref=cm_sw_em_r_mt_dp_U_mY-GCbPZFT63A) (I haven't read this personally)

### Other

* [Cpplang Slack](https://cpplang.now.sh/) __#cmake__ channel
  * There's some super helpful people on there, the search functionality is great too (someone likely will have had your problem before 😉).
* [vector-of-bool](https://github.com/vector-of-bool)
  * Was incredibly kind in answering some of my dumb CMake questions - thank you!
