cmake_minimum_required(VERSION 3.15)

project(app LANGUAGES CXX)
add_executable(${PROJECT_NAME})
target_sources(${PROJECT_NAME} PRIVATE main.cpp)

find_package(lib-b CONFIG REQUIRED)

target_compile_features(${PROJECT_NAME} PUBLIC cxx_std_17)
target_link_libraries(${PROJECT_NAME} PRIVATE lib-b::lib-b)
