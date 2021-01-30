cmake_minimum_required(VERSION 3.15)

project(lib-a LANGUAGES CXX)
add_library(${PROJECT_NAME} INTERFACE)

include(GNUInstallDirs)

target_include_directories(
    ${PROJECT_NAME} INTERFACE
    $<INSTALL_INTERFACE:${CMAKE_INSTALL_INCLUDEDIR}>
    $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include>)

target_compile_features(${PROJECT_NAME} INTERFACE cxx_std_17)

install(
    TARGETS ${PROJECT_NAME}
    EXPORT ${PROJECT_NAME}-config)

install(
    EXPORT ${PROJECT_NAME}-config
    NAMESPACE ${PROJECT_NAME}::
    DESTINATION ${CMAKE_INSTALL_LIBDIR}/cmake/${PROJECT_NAME})

install(
    DIRECTORY ${CMAKE_CURRENT_LIST_DIR}/include/${PROJECT_NAME}/
    DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}/${PROJECT_NAME})
