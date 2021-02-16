#include "calculator-shared/calculator.h"

int64_t calc_add(int64_t lhs, int64_t rhs)
{
    return lhs + rhs;
}

int64_t calc_substract(int64_t lhs, int64_t rhs)
{
    return lhs - rhs;
}

int64_t calc_multiply(int64_t lhs, int64_t rhs)
{
    return lhs * rhs;
}

int64_t calc_divide(int64_t lhs, int64_t rhs)
{
    return lhs / rhs;
}

int64_t calc_square(int64_t value)
{
    return value * value;
}

int64_t calc_pow(int64_t value, int64_t exponent)
{
    int64_t result = value;
    for (int64_t i = 1; i < exponent; ++i)
    {
        result *= value;
    }

    return result;
}
