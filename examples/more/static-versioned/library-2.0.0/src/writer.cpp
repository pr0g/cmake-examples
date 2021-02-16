#include "useless/writer.h"

#include <stdio.h>
#include <stdarg.h>

namespace wrtr
{
    void print(const char* format, ...)
    {
        va_list args;
        va_start(args, format);
        vprintf(format, args);
        va_end(args);
    }
} // namespace wrtr
