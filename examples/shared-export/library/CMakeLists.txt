cmake_minimum_required(VERSION 3.8)

project(calculator-shared-export VERSION 0.0.1 LANGUAGES CXX)

add_library(calculator-shared-export SHARED src/calculator.cpp)

include(GNUInstallDirs)

# BUILD_INTERFACE specifies where to find includes during build time
# here we set the include directory to be our src include directory
# as well as CMAKE_CURRENT_BINARY_DIR, which is where the generated
# calc_exported.h file is located.
# the command must be included in double quotes so the two directories,
# separated by a ';' can both be used (cmake needs it to be a string)
target_include_directories(
    calculator-shared-export PUBLIC
    "$<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include/;${CMAKE_CURRENT_BINARY_DIR}/>"
    $<INSTALL_INTERFACE:${CMAKE_INSTALL_INCLUDEDIR}>)

# generates header to provide export macros for library
include(GenerateExportHeader)
generate_export_header(
    calculator-shared-export
    BASE_NAME Calc)

# specify the target to install (calculator library defined above)
# set the export name <name>-config (does not need to match target name)
# also specify where the .dylib/.so/.dll file should be installed
install(
    TARGETS calculator-shared-export
    EXPORT calculator-shared-export-config
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR})

install(
    EXPORT calculator-shared-export-config
    NAMESPACE calculator-shared-export::
    DESTINATION ${CMAKE_INSTALL_LIBDIR}/cmake/calculator-shared-export)

install(
    DIRECTORY ${CMAKE_CURRENT_LIST_DIR}/include/
    DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}/calculator-shared-export)

# copy the generated export file to the include install location
install(
    FILES ${CMAKE_CURRENT_BINARY_DIR}/calc_export.h
    DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}/calculator-shared-export
)