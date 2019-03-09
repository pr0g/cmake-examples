cmake_minimum_required(VERSION 3.8)

project(calculator-static VERSION 0.0.1 LANGUAGES CXX)

add_library(calculator-static src/calculator.cpp)

include(GNUInstallDirs)

# sets the search paths for the include files after installation
# as well as during when building the library (as these may differ)
# this allows the library itself and users to #include the library headers
target_include_directories(
    calculator-static PUBLIC
    $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include/>
    $<INSTALL_INTERFACE:${CMAKE_INSTALL_INCLUDEDIR}>)

# specify the target to install (calculator-static library defined above)
# set the export name <name>-config (does not need to match target name)
# also specify where the .lib file should be installed
install(
    TARGETS calculator-static
    EXPORT calculator-static-config
    ARCHIVE DESTINATION ${CMAKE_INSTALL_LIBDIR})

install(
    EXPORT calculator-static-config
    NAMESPACE calculator-static::
    DESTINATION ${CMAKE_INSTALL_LIBDIR}/cmake/calculator-static)

install(
    DIRECTORY ${CMAKE_CURRENT_LIST_DIR}/include/
    DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}/calculator-static)