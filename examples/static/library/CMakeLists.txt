cmake_minimum_required(VERSION 3.8)

project(cmake-library-example VERSION 0.0.1 LANGUAGES CXX)

add_library(calculator-lib src/calculator.cpp)

include(GNUInstallDirs)

# sets the search paths for the include files after installation
# as well as during when building the library (as these may differ)
# this allows the library itself and users to #include the library headers
target_include_directories(
    calculator-lib PUBLIC
    $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include/>
    $<INSTALL_INTERFACE:${CMAKE_INSTALL_INCLUDEDIR}>)

# specify the target to install (calculator-lib library defined above)
# set the export name <name>-config (does not need to match target name)
# also specify where the .lib file should be installed
install(
    TARGETS calculator-lib
    EXPORT calculator-lib-config
    ARCHIVE DESTINATION ${CMAKE_INSTALL_LIBDIR})

install(
    EXPORT calculator-lib-config
    NAMESPACE calculator-lib::
    DESTINATION ${CMAKE_INSTALL_LIBDIR}/cmake/calculator-lib)

install(
    DIRECTORY ${CMAKE_CURRENT_LIST_DIR}/include/
    DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}/calculator-lib)