cmake_minimum_required(VERSION 3.15)

project(lib-b LANGUAGES CXX)
add_library(${PROJECT_NAME})
target_sources(${PROJECT_NAME} PRIVATE src/lib-b.cpp)

include(FetchContent)
FetchContent_Declare(
    lib-a
    SOURCE_DIR ../../lib-a)
FetchContent_MakeAvailable(lib-a)

include(GNUInstallDirs)

target_include_directories(
    ${PROJECT_NAME} PUBLIC
    $<INSTALL_INTERFACE:${CMAKE_INSTALL_INCLUDEDIR}>
    $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include>)

target_compile_features(${PROJECT_NAME} PUBLIC cxx_std_17)
target_link_libraries(${PROJECT_NAME} PUBLIC lib-a)

install(
    TARGETS ${PROJECT_NAME}
    EXPORT lib-b-config
    ARCHIVE DESTINATION ${CMAKE_INSTALL_LIBDIR})

install(
    DIRECTORY ${CMAKE_CURRENT_LIST_DIR}/include/${PROJECT_NAME}/
    DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}/${PROJECT_NAME})

install(
    EXPORT lib-b-config
    NAMESPACE ${PROJECT_NAME}::
    FILE lib-b-targets.cmake # New: Required when writing our own
                             # <proj>-config.cmake file
    DESTINATION ${CMAKE_INSTALL_LIBDIR}/cmake/lib-b)

# New: Required when writing our own <proj>-config.cmake file
configure_file(lib-b-config.cmake.in lib-b-config.cmake @ONLY)
install(
    FILES "${CMAKE_CURRENT_BINARY_DIR}/lib-b-config.cmake"
    DESTINATION ${CMAKE_INSTALL_LIBDIR}/cmake/lib-b)
