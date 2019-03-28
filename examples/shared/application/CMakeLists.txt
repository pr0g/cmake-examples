cmake_minimum_required(VERSION 3.8)

project(cmake-application-example VERSION 0.0.1 LANGUAGES CXX)

find_package(calculator-shared REQUIRED)

add_executable(calculator-app main.cpp)

target_link_libraries(calculator-app PUBLIC calculator-shared::calculator-shared)

if (WIN32)
# copy the .dll file to the same folder as the executable
add_custom_command(
    TARGET calculator-app POST_BUILD
    COMMAND ${CMAKE_COMMAND} -E copy_directory
    $<TARGET_FILE_DIR:calculator-shared::calculator-shared>
    $<TARGET_FILE_DIR:calculator-app>
    VERBATIM)
endif()