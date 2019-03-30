cmake_minimum_required(VERSION 3.8)

project(cmake-application-example VERSION 0.0.1 LANGUAGES CXX)

# optionally set this variable to the absolute path of the library
# being developed instead of passing it at the command line
# set(DEV_LIB_DIR "path/to/library/in/development")

# inform the user if a valid library path has not been set
if (NOT DEFINED DEV_LIB_DIR)
    message(
        FATAL_ERROR "Please provide the path to the library in active development.
Example: cmake -DDEV_LIB_DIR=\"path/to/library/in/development\" ..")
endif()

# bring in autoinstall.cmake helper file
include(autoinstall.cmake)
# invoke `install_it` function from autoinstall.cmake to build and
# install the library being actively developed alongside the application
install_it(${DEV_LIB_DIR})

find_package(calculator-static REQUIRED)

add_executable(calculator-app main.cpp)

target_link_libraries(calculator-app PUBLIC calculator-static::calculator-static)