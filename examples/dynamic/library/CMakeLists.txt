cmake_minimum_required(VERSION 3.8)

project(cmake-library-example VERSION 0.0.1 LANGUAGES CXX)

add_library(calculator-dynamic SHARED src/calculator.cpp)

include(GNUInstallDirs)

target_include_directories(
    calculator-dynamic PUBLIC
    $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include/>
    $<INSTALL_INTERFACE:${CMAKE_INSTALL_INCLUDEDIR}>)

# sets the _EXPORT #define for the target (library)
# to ensure the functions are exported (visible)
target_compile_definitions(
    calculator-dynamic PRIVATE -D_EXPORT
)

# specify the target to install (calculator library defined above)
# set the export name <name>-config (does not need to match target name)
# also specify where the .dylib/.so/.dll file should be installed
install(
    TARGETS calculator-dynamic
    EXPORT calculator-dynamic-config
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR})

install(
    EXPORT calculator-dynamic-config
    NAMESPACE calculator-dynamic::
    DESTINATION ${CMAKE_INSTALL_LIBDIR}/cmake/calculator-dynamic)

install(
    DIRECTORY ${CMAKE_CURRENT_LIST_DIR}/include/
    DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}/calculator-dynamic)