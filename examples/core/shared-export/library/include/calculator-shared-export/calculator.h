#pragma once

#include <stdint.h>

#include "calc_export.h"

extern "C"
{
    CALC_EXPORT int64_t calc_add(int64_t lhs, int64_t rhs);
    CALC_EXPORT int64_t calc_substract(int64_t lhs, int64_t rhs);
    CALC_EXPORT int64_t calc_multiply(int64_t lhs, int64_t rhs);
    CALC_EXPORT int64_t calc_divide(int64_t lhs, int64_t rhs);
    CALC_EXPORT int64_t calc_square(int64_t value);
    CALC_EXPORT int64_t calc_pow(int64_t value, int64_t exponent);
}
