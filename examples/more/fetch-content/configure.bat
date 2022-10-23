@echo off

cmake -B build/debug -G Ninja -DCMAKE_BUILD_TYPE=Debug
cmake -B build/release -G Ninja -DCMAKE_BUILD_TYPE=RelWithDebInfo
