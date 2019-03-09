#pragma once

#include <stdint.h>

#include "exporting.h"

extern "C"
{
    DLL_API int64_t add(int64_t lhs, int64_t rhs);
    DLL_API int64_t substract(int64_t lhs, int64_t rhs);
    DLL_API int64_t multiply(int64_t lhs, int64_t rhs);
    DLL_API int64_t divide(int64_t lhs, int64_t rhs);
    DLL_API int64_t square(int64_t value);
    DLL_API int64_t pow(int64_t value, int64_t exponent);
}