@echo off

cmake -B build/debug -G Ninja -DCMAKE_BUILD_TYPE=Debug -DSUPERBUILD=ON
cmake -B build/release -G Ninja -DCMAKE_BUILD_TYPE=Release -DSUPERBUILD=ON
