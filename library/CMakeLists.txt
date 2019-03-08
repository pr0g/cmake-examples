cmake_minimum_required(VERSION 3.8)

project(cmake-library-example VERSION 0.0.1 LANGUAGES CXX)

add_library(calculator INTERFACE)

include(GNUInstallDirs)

target_include_directories(
    calculator INTERFACE
    $<INSTALL_INTERFACE:${CMAKE_INSTALL_INCLUDEDIR}>)

install(
    TARGETS calculator
    EXPORT CMakeLibExample-config)

install(
    EXPORT CMakeLibExample-config
    NAMESPACE CMakeLibExample::
    DESTINATION ${CMAKE_INSTALL_LIBDIR}/CMakeLibExample/cmake)

install(
    DIRECTORY ${CMAKE_CURRENT_LIST_DIR}/include/
    DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}/CMakeLibExample)