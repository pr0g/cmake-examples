#include "calculator.h"

int64_t add(int64_t lhs, int64_t rhs)
{
    return lhs + rhs;
}

int64_t substract(int64_t lhs, int64_t rhs)
{
    return lhs - rhs;
}

int64_t multiply(int64_t lhs, int64_t rhs)
{
    return lhs * rhs;
}

int64_t divide(int64_t lhs, int64_t rhs)
{
    return lhs / rhs;
}

int64_t square(int64_t value)
{
    return value * value;
}

int64_t pow(int64_t value, int64_t exponent)
{
    int64_t result = value;
    for (int64_t i = 1; i < exponent; ++i)
    {
        result *= value;
    }

    return result;
}