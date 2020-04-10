#include <iostream>

#include "phrases/greetings/hello/hello.h"
#include "phrases/greetings/hey/hey.h"
#include "phrases/farewells/goodbye/goodbye.h"

int main(int argc, const char** argv) {
    std::cout << hey_message() << " "
              << hello_message() << " "
              << goodbye_message() << "\n";
    return 0;
}
