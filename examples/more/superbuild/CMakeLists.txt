cmake_minimum_required(VERSION 3.15)

# option to be passed at configure time to CMake
# use '-DSUPERBUILD=ON' to enable the superbuild, default is off
option(SUPERBUILD "Perform a superbuild (or not)" OFF)

# top level project command is the same for a normal build or superbuild
project(superbuild-example LANGUAGES CXX)

# if superbuild is enabled, we first include the external dependencies
# CMakeLists.txt file so it's in scope, and then in superbuild.cmake, we
# depend on the external target (in this case SDL2) in the superbuild of
# this project. We then halt further processing and process this file again
# with SUPERBUILD disabled (see superbuild.cmake for details)
if(SUPERBUILD)
    include(external/CMakeLists.txt)
    include(superbuild.cmake)
    return()
endif()

# normal find_package command
# note: If we already have SDL2 installed somewhere else, so long as we know
# where it is (we can use -DCMAKE_PREFIX_PATH to specify the search location)
# we can skip the whole superbuild step
find_package(SDL2 REQUIRED CONFIG)

# standard project commands for creating an executable and setting dependencies
add_executable(${PROJECT_NAME})
target_sources(${PROJECT_NAME} PRIVATE main.cpp)
target_link_libraries(${PROJECT_NAME} PRIVATE SDL2::SDL2-static SDL2::SDL2main)

# this is specific to the SDL2 library we're using in this example
# SDL2.dll needs to be next to the main application .exe when running so this
# custom command will copy the build artifact to the executable folder
if(WIN32)
    add_custom_command(
        TARGET ${PROJECT_NAME}
        POST_BUILD
        COMMAND ${CMAKE_COMMAND} -E copy_if_different $<TARGET_FILE:SDL2::SDL2>
                $<TARGET_FILE_DIR:${PROJECT_NAME}>
        VERBATIM)
endif()
