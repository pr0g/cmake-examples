@echo off

cmake -B build -G Ninja -DCMAKE_BUILD_TYPE=Debug
cmake --build build

cmake -B build -G Ninja -DCMAKE_BUILD_TYPE=RelWithDebInfo
cmake --build build
