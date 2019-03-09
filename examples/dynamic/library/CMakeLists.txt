cmake_minimum_required(VERSION 3.8)

project(cmake-library-example VERSION 0.0.1 LANGUAGES CXX)

add_library(calculator-lib SHARED src/calculator.cpp)

include(GNUInstallDirs)

target_include_directories(
    calculator-lib PUBLIC
    $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include/>
    $<INSTALL_INTERFACE:${CMAKE_INSTALL_INCLUDEDIR}>)

# sets the _EXPORT #define for the target (library)
# to ensure the functions are exported (visible)
target_compile_definitions(
    calculator-lib PRIVATE -D_EXPORT
)

# specify the target to install (calculator library defined above)
# set the export name <name>-config (does not need to match target name)
# also specify where the .dylib/.so/.dll file should be installed
install(
    TARGETS calculator-lib
    EXPORT calculator-lib-config
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR})

install(
    EXPORT calculator-lib-config
    NAMESPACE calculator-lib::
    DESTINATION ${CMAKE_INSTALL_LIBDIR}/cmake/calculator-lib)

install(
    DIRECTORY ${CMAKE_CURRENT_LIST_DIR}/include/
    DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}/calculator-lib)