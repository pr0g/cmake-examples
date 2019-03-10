# Modern CMake Examples

## Overview

This repository is a collection of as-simple-as-possible CMake projects (with a focus on __installing__).

The idea is to try and help understand exactly what each part of a `CMakeLists.txt` file does and why it is needed.

This is basically intended as a series of reminders to help me remember how to use CMake 🤦

Please see the [Examples README](examples/README.md) for steps on using the example libraries.

## Background

For the longest time I just didn't grok __installing__ in CMake<sup>1</sup>. I first didn't understand _why_ you'd ever want to do it, or _what_ it was useful for. When I then started looking into _how_ to do it I could not make head nor tail of all the various __install__ commands. While trying to figure all this stuff out I was immersing myself in trying to learn Modern CMake (targets, targets targets...) and how these two things are related.

The examples in this repo are the culmination of many months of sporadic research to try and understand CMake more fully and write better CMake scripts.

I'm sharing my journey so far to hopefully help some other poor sod who is in the same boat I'm in. With any luck there will be something someone finds useful here.

1. I recently discovered a kindred spirit - <https://www.reddit.com/r/cpp/comments/6m7sp6/cmake_and_c_whats_the_deal_with_installing/>

## CMake Resources

I've been attempting learn CMake for a while and have built up quite a list of articles/blogs/documentation that have helped inform my understanding up to this point. Please see them listed below (mainly for my benefit so I have them all in one place).

### Articles

* <https://cliutils.gitlab.io/modern-cmake/>
* <https://codingnest.com/basic-cmake/>
* <https://codingnest.com/basic-cmake-part-2/>
* <https://pabloariasal.github.io/2018/02/19/its-time-to-do-cmake-right/>
* <https://steveire.wordpress.com/2017/11/05/embracing-modern-cmake/>
* <https://gitlab.kitware.com/cmake/community/wikis/doc/tutorials/How-To-Find-Libraries>
* <https://gitlab.kitware.com/cmake/community/wikis/doc/tutorials/Exporting-and-Importing-Targets>
* <https://gitlab.kitware.com/cmake/community/wikis/doc/tutorials/How-to-create-a-ProjectConfig.cmake-file>
* <https://foonathan.net/blog/2016/03/03/cmake-install.html>
* <https://foonathan.net/blog/2016/07/07/cmake-dependency-handling.html>
* <https://coderwall.com/p/y3zzbq/use-cmake-enabled-libraries-in-your-cmake-project>
* <https://coderwall.com/p/qk2eog/use-cmake-enabled-libraries-in-your-cmake-project-ii>
* <https://coderwall.com/p/qej45g/use-cmake-enabled-libraries-in-your-cmake-project-iii>
* <https://arne-mertz.de/2018/06/cmake-project-structure/>
* <https://arne-mertz.de/2018/07/cmake-properties-options/>
* <https://rix0r.nl/blog/2015/08/13/cmake-guide/>
* <https://steveire.wordpress.com/2016/08/09/opt-in-header-only-libraries-with-cmake/>
* <https://crascit.com/2015/03/28/enabling-cxx11-in-cmake/>
* <https://crascit.com/2015/02/02/cmake-target-dependencies/>
* <https://gist.github.com/mbinna/c61dbb39bca0e4fb7d1f73b0d66a4fd1>
* <https://llvm.org/docs/CMakePrimer.html>
* <https://devdocs.io/cmake~3.8/>
* <https://www.jetbrains.com/help/clion/quick-cmake-tutorial.html>
* <https://visualgdb.com/tutorials/linux/cmake/find_package/>
* <https://ecrafter.wordpress.com/2012/06/16/cmake-tutorial-part-5/>
* <http://www.kdab.com/modern-cmake-with-qt-and-boost/>
* <https://cognitivewaves.wordpress.com/cmake-and-visual-studio/>
* <http://mariobadr.com/creating-a-header-only-library-with-cmake.html>
* <https://www.reddit.com/r/cpp/comments/96zm16/new_educational_video_series_how_to_cmake_good/>
* <https://archive.fosdem.org/2013/schedule/event/moderncmake/attachments/slides/258/export/events/attachments/moderncmake/slides/258/cmake_fosdem_2013.pdf>
* <https://fedetft.wordpress.com/2010/03/07/cmake-part-3-finding-libraries/>
* <https://github.com/boostcon/cppnow_presentations_2017/blob/master/05-19-2017_friday/effective_cmake__daniel_pfeifer__cppnow_05-19-2017.pdf>
* <https://cmake.org/pipermail/cmake/2010-June/037461.html>
* <https://blogs.kde.org/2008/12/12/how-get-cmake-find-what-you-want-it>

### Documentation

* <https://cmake.org/cmake/help/latest/command/target_include_directories.html>
* <https://cmake.org/cmake/help/latest/manual/cmake-buildsystem.7.html>
* <https://cmake.org/cmake/help/latest/manual/cmake-packages.7.html>
* <https://cmake.org/cmake/help/v3.4/module/ExternalProject.html>
* <https://cmake.org/cmake/help/latest/command/find_package.html>
* <https://cmake.org/cmake/help/latest/variable/CMAKE_PREFIX_PATH.html#variable:CMAKE_PREFIX_PATH>
* <https://cmake.org/cmake/help/latest/variable/CMAKE_INSTALL_PREFIX_INITIALIZED_TO_DEFAULT.html>
* <https://cmake.org/cmake/help/latest/command/install.html>

### Stack Overflow

* <https://stackoverflow.com/questions/31537602/how-to-use-cmake-to-find-and-link-to-a-library-using-install-export-and-find-pac>
* <https://stackoverflow.com/questions/33534115/preferred-cmake-project-structure>
* <https://stackoverflow.com/questions/31512485/cmake-how-to-set-up-source-library-and-cmakelists-txt-dependencies>
* <https://stackoverflow.com/questions/33443164/cmake-share-library-with-multiple-executables>
* <https://stackoverflow.com/questions/39481958/setting-cmake-install-prefix-from-cmakelists-txt-file/39485990>
* <https://stackoverflow.com/questions/45955272/modern-way-to-set-compiler-flags-in-cross-platform-cmake-project>
* <https://stackoverflow.com/questions/46567646/cmake-usefulness-of-aliases>
* <https://stackoverflow.com/questions/23832339/package-vs-library>

### Videos

* <https://youtu.be/bsXLMQ6WgIk>
* <https://youtu.be/7W4Q-XLnMaA>
* <https://youtu.be/6sWec7b0JIc>
* <https://youtu.be/eC9-iRN2b04>
* <https://youtu.be/JsjI5xr1jxM>
* <https://youtu.be/HPMvU64RUTY>
* <https://www.youtube.com/playlist?list=PLK6MXr8gasrGmIiSuVQXpfFuE1uPT615s>

### Books

* <https://crascit.com/professional-cmake/>
* <https://www.amazon.co.uk/dp/1788470710/ref=cm_sw_em_r_mt_dp_U_BZ-GCbYRNW0Q3>
* <https://www.amazon.co.uk/dp/1930934319/ref=cm_sw_em_r_mt_dp_U_mY-GCbPZFT63A>

### Other

* Cpplang Slack __#cmake__ channel - <https://cpplang.now.sh/> - some super helpful people in there, the search functionality is great too.
* vector-of-bool https://github.com/vector-of-bool - was incredibly kind in answering some of my dumb cmake questions - thank you!