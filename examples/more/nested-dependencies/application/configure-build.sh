#!/bin/bash

cmake -S . -B build -DCMAKE_PREFIX_PATH=../library/lib-b/install
cmake --build build
