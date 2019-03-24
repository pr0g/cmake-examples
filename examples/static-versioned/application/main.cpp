#include <iostream>

#include "useless/calculator.h"
#include "useless/writer.h"

int main(int argc, char** argv)
{
    int64_t out;
    calc::square(4, out);
    std::cout << out << "\n";
    // std::cout << calc::square(4) << "\n";
    wrtr::print("a pointless message to no one\n");

    return 0;
}
