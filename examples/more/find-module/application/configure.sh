#!/bin/bash

cmake -B build/debug -G Ninja -DCMAKE_BUILD_TYPE=Debug \
  -Dcalculator-static_PATH=$(pwd)/../library/install \
  -DCMAKE_MODULE_PATH=$(pwd)/../cmake
  
cmake -B build/release -G Ninja -DCMAKE_BUILD_TYPE=Release \
  -Dcalculator-static_PATH=$(pwd)/../library/install \
  -DCMAKE_MODULE_PATH=$(pwd)/../cmake
