cmake_minimum_required(VERSION 3.8)

project(cmake-application-example VERSION 0.0.1 LANGUAGES CXX)

find_package(useless 2.0.0 REQUIRED)

add_executable(calculator-app main.cpp)

target_link_libraries(calculator-app PUBLIC useless::calculator-static useless::writer-static)