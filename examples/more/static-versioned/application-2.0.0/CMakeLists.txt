cmake_minimum_required(VERSION 3.15)

project(
    calculator-app
    VERSION 0.0.1
    LANGUAGES CXX)

find_package(useless 2.0.0 REQUIRED CONFIG)

add_executable(${PROJECT_NAME})
target_sources(${PROJECT_NAME} PRIVATE main.cpp)

target_link_libraries(${PROJECT_NAME} PUBLIC useless::calculator-static
                                             useless::writer-static)
