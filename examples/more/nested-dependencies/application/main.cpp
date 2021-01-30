#include "lib-b/lib-b.h"

#include <iostream>

int main(int /*argc*/, char** /*argv*/)
{
    std::vector<std::string> strs = {
        "   this   ",
        "   will ",
        "  all   ",
        "   wind  ",
        " up   ",
        "smushed",
        "    together     "
    };

    std::cout << lib_b::flattened(strs) << '\n';
    return 0;
}
