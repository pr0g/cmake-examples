@echo off

REM Depends on the excellent 'fd' by David 'sharkdp' Peter
REM (https://github.com/sharkdp/fd) and the brilliant cmake-format
REM by cheshirekow (https://github.com/cheshirekow/cmake_format)
fd -0 CMakeLists.txt -a | xargs -0 cmake-format -i
