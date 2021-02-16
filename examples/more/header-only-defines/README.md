# Setting preprocessor directives

## Overview

I found myself needing this recently and decided it'd be a good idea to document it before I forget it.

Sometimes you want to set a define that is provided by a library in the consuming application. To do this with modern CMake you can use the `target_compile_definitions` command. Please see [color.h](library/include/color.h) for where the defines are used and [CMakeLists.txt](application/CMakeLists.txt) for where we use `target_compile_definitions`. All the define does is decide whether our favorite color is blue or green 🙂 (blue is obviously the correct choice, and apologies to British readers for using _color_ and _favorite_ instead of __colour__ and __favourite__ - I decided to use American English as it's less typing 😉)

I also snuck in another unrelated but useful command which is `target_compile_features`. You can use it to set a number of things but one of the most useful is specifying the version of c++ the library is using. In this case I've chosen c++ 17. To check I added a `std::byte` variable in the color.h file, a type which was only added in c++ 17. If you try installing the library with that commented out and then attempt to use the library you'll get a compile error that `std::byte` is not defined.
