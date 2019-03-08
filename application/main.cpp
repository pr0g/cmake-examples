#include <iostream>

#include "cmake-lib/calculator.h"

int main(int argc, char** argv)
{
    int64_t result = add(4, 6);
    std::cout << result << "\n";

    return 0;
}