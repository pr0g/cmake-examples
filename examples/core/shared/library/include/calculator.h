#pragma once

#include <stdint.h>

#include "exporting.h"

extern "C"
{
    DLL_API int64_t calc_add(int64_t lhs, int64_t rhs);
    DLL_API int64_t calc_substract(int64_t lhs, int64_t rhs);
    DLL_API int64_t calc_multiply(int64_t lhs, int64_t rhs);
    DLL_API int64_t calc_divide(int64_t lhs, int64_t rhs);
    DLL_API int64_t calc_square(int64_t value);
    DLL_API int64_t calc_pow(int64_t value, int64_t exponent);
}
