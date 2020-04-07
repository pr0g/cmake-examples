cmake_minimum_required(VERSION 3.15)
project(greetings LANGUAGES CXX)

include(GNUInstallDirs)

add_library(hello)
target_sources(hello PRIVATE hello/hello.cpp)

add_library(goodbye)
target_sources(goodbye PRIVATE goodbye/goodbye.cpp)

target_include_directories(
    hello PUBLIC
    $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/hello/include/>
    $<INSTALL_INTERFACE:${CMAKE_INSTALL_INCLUDEDIR}>)

target_include_directories(
    goodbye PUBLIC
    $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/goodbye/include/>
    $<INSTALL_INTERFACE:${CMAKE_INSTALL_INCLUDEDIR}>)

install(
    TARGETS hello
    EXPORT ${PROJECT_NAME}-hello-config
    ARCHIVE DESTINATION ${CMAKE_INSTALL_LIBDIR})

install(
    TARGETS goodbye
    EXPORT ${PROJECT_NAME}-goodbye-config
    ARCHIVE DESTINATION ${CMAKE_INSTALL_LIBDIR})

install(
    DIRECTORY ${CMAKE_CURRENT_LIST_DIR}/hello/include/
    DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}/${PROJECT_NAME}/hello)

install(
    DIRECTORY ${CMAKE_CURRENT_LIST_DIR}/goodbye/include/
    DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}/${PROJECT_NAME}/goodbye)

install(
    EXPORT ${PROJECT_NAME}-hello-config
    NAMESPACE ${PROJECT_NAME}::
    DESTINATION ${CMAKE_INSTALL_LIBDIR}/cmake/${PROJECT_NAME})

install(
    EXPORT ${PROJECT_NAME}-goodbye-config
    NAMESPACE ${PROJECT_NAME}::
    DESTINATION ${CMAKE_INSTALL_LIBDIR}/cmake/${PROJECT_NAME})

configure_file(
  ${PROJECT_NAME}-config.cmake.in ${PROJECT_NAME}-config.cmake @ONLY)

install(
  FILES "${CMAKE_BINARY_DIR}/${PROJECT_NAME}-config.cmake"
  DESTINATION ${CMAKE_INSTALL_LIBDIR}/cmake/${PROJECT_NAME})
