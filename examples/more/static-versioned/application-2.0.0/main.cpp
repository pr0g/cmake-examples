#include <iostream>

#include "useless/calculator.h"
#include "useless/writer.h"

int main(int argc, char** argv)
{
    const int64_t in = 4;
    int64_t out;
    calc::square(in, out);
    wrtr::print("the square of %d is %d\n", in, out);
    return 0;
}