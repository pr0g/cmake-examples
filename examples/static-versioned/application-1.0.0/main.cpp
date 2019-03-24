#include <iostream>

#include "useless/calculator.h"
#include "useless/writer.h"

int main(int argc, char** argv)
{
    std::cout << calc::square(4) << "\n";
    wrtr::print("hello from the console\n");
    return 0;
}