cmake_minimum_required(VERSION 3.15)

project(
    color-app
    VERSION 0.0.1
    LANGUAGES CXX)

find_package(favorite-color REQUIRED CONFIG)

add_executable(${PROJECT_NAME})
target_sources(${PROJECT_NAME} PRIVATE main.cpp)

# this is the important line where we set the defines for the project
target_compile_definitions(${PROJECT_NAME} PRIVATE COLOR_BLUE)

target_link_libraries(${PROJECT_NAME} PUBLIC favorite-color::favorite-color)
