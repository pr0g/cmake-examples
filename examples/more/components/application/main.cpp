#include <iostream>

#include "phrases/hello/hello.h"
#include "phrases/hey/hey.h"
#include "phrases/goodbye/goodbye.h"

int main(int argc, const char** argv) {
    std::cout << hey_message() << " "
              << hello_message() << " "
              << goodbye_message() << "\n";
    return 0;
}
