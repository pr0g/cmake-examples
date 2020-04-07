cmake_minimum_required(VERSION 3.15)
project(greeter LANGUAGES CXX)

find_package(greetings REQUIRED CONFIG COMPONENTS hello goodbye)

add_executable(${PROJECT_NAME})
target_sources(${PROJECT_NAME} PRIVATE main.cpp)

target_link_libraries(
    ${PROJECT_NAME} PRIVATE greetings::hello greetings::goodbye)
