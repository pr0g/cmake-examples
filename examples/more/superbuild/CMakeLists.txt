cmake_minimum_required(VERSION 3.15)

option(SUPERBUILD "Perform a superbuild (or not)" OFF)

project(superbuild-example LANGUAGES CXX)

if(SUPERBUILD)
    include(external/CMakeLists.txt)
    include(superbuild.cmake)
    return()
endif()

# normal find_package command (no explicit reference to
# ExternalProject_Add at all)
find_package(SDL2 REQUIRED CONFIG)

add_executable(${PROJECT_NAME})
target_sources(${PROJECT_NAME} PRIVATE main.cpp)
target_link_libraries(${PROJECT_NAME} PRIVATE SDL2::SDL2-static SDL2::SDL2main)

if(WIN32)
    # copy the SDL2.dll to the same folder as the executable
    add_custom_command(
        TARGET ${PROJECT_NAME}
        POST_BUILD
        COMMAND ${CMAKE_COMMAND} -E copy_if_different $<TARGET_FILE:SDL2::SDL2>
                $<TARGET_FILE_DIR:${PROJECT_NAME}>
        VERBATIM)
endif()
