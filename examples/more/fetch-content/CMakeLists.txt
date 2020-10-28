cmake_minimum_required(VERSION 3.15)

project(fetch-content-example LANGUAGES CXX)

# make the FetchContent commands available
include(FetchContent)

# download the project to be made part of the build
# note: SOURCE_DIR and a local path to a project can be used instead
# of GIT_REPOSITORY - this is very useful for local iterative development
# if you are working on the libary and application together
FetchContent_Declare(
    bec
    GIT_REPOSITORY https://github.com/pr0g/bit-field-enum-class.git
    GIT_TAG origin/main)
# utility to setup the downloaded library for use
FetchContent_MakeAvailable(bec)

add_executable(${PROJECT_NAME})
target_sources(${PROJECT_NAME} PRIVATE main.cpp)

# add the fetched library as a dependency
target_link_libraries(${PROJECT_NAME} PRIVATE bec)
