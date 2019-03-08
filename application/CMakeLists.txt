cmake_minimum_required(VERSION 3.8)

project(cmake-application-example VERSION 0.0.1 LANGUAGES CXX)

find_package(CMakeLibExample REQUIRED)

add_executable(CMakeAppExample main.cpp)
target_link_libraries(CMakeAppExample PUBLIC CMakeLibExample::calculator)