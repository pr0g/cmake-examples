#include <iostream>

#include "greetings/hello/hello.h"
#include "greetings/goodbye/goodbye.h"

int main(int argc, const char** argv) {
    std::cout << hello_message() << " "
              << goodbye_message() << "\n";
    return 0;
}
