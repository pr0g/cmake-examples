cmake_minimum_required(VERSION 3.15)

project(
    calculator-app
    VERSION 0.0.1
    LANGUAGES CXX)

# note: No use of CONFIG in find_package command
find_package(calculator-static REQUIRED)

add_executable(${PROJECT_NAME})
target_sources(${PROJECT_NAME} PRIVATE main.cpp)

target_link_libraries(${PROJECT_NAME}
                      PUBLIC calculator-static::calculator-static)
