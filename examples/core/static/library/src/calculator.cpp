#include "calculator-static/calculator.h"

namespace calc
{
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
} // namespace calc
