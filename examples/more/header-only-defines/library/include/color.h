#pragma once

#include <cstddef>

// ensure we define one or the other but not both
#if (!defined(COLOR_BLUE) && !defined(COLOR_GREEN))
    static_assert(false, "Must define your favorite color COLOR_BLUE or COLOR_GREEN");
#elif (defined(COLOR_BLUE) && defined(COLOR_GREEN))
    static_assert(false, "Must define only COLOR_GREEN or COLOR_BLUE");
#endif // COLOR_BLUE ? COLOR_GREEN

namespace color
{
    inline std::byte b { 0xff }; // c++ 17 test

    const char* favorite()
    {
#ifdef COLOR_BLUE
        return "blue";
#elif defined COLOR_GREEN
        return "green";
#endif
    }
} // namespace color
