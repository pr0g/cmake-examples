cmake_minimum_required(VERSION 3.15)

project(external-dependencies)

# make the ExternalProject commands available
include(ExternalProject)

# download, configure, build and install the dependency
# note: The install location is set to the build folder
ExternalProject_Add(
    bec
    GIT_REPOSITORY https://github.com/pr0g/bit-field-enum-class.git
    GIT_TAG origin/main
    INSTALL_DIR ${CMAKE_CURRENT_BINARY_DIR}
    CMAKE_ARGS -DCMAKE_INSTALL_PREFIX=<INSTALL_DIR>)
