@echo off

cmake -B build/debug -G Ninja -DCMAKE_BUILD_TYPE=Debug ^
  -Dcalculator-static_PATH=%cd%/../library/install ^
  -DCMAKE_MODULE_PATH=%cd%/../cmake
  
cmake -B build/release -G Ninja -DCMAKE_BUILD_TYPE=Release ^
  -Dcalculator-static_PATH=%cd%/../library/install ^
  -DCMAKE_MODULE_PATH=%cd%/../cmake
