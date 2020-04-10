@echo off

cmake -S . -B build -DCMAKE_PREFIX_PATH=%cd%/../library/install
