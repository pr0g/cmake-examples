cmake_minimum_required(VERSION 3.15)

project(
    useless
    VERSION 2.0.0
    LANGUAGES CXX)

add_library(calculator-static)
target_sources(calculator-static PRIVATE src/calculator.cpp)
set_target_properties(calculator-static PROPERTIES DEBUG_POSTFIX "d")

add_library(writer-static)
target_sources(writer-static PRIVATE src/writer.cpp)
set_target_properties(writer-static PROPERTIES DEBUG_POSTFIX "d")

include(GNUInstallDirs)
include(CMakePackageConfigHelpers)

write_basic_package_version_file(
    "${CMAKE_CURRENT_BINARY_DIR}/${PROJECT_NAME}/${PROJECT_NAME}-config-version.cmake"
    VERSION ${PROJECT_VERSION}
    COMPATIBILITY SameMajorVersion)

target_include_directories(
    calculator-static
    PUBLIC
        $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include>
        $<INSTALL_INTERFACE:${CMAKE_INSTALL_INCLUDEDIR}/${PROJECT_NAME}-${PROJECT_VERSION}>
)

target_include_directories(
    writer-static
    PUBLIC
        $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include>
        $<INSTALL_INTERFACE:${CMAKE_INSTALL_INCLUDEDIR}/${PROJECT_NAME}-${PROJECT_VERSION}>
)

install(
    TARGETS calculator-static writer-static
    EXPORT ${PROJECT_NAME}-config
    ARCHIVE
        DESTINATION
            ${CMAKE_INSTALL_LIBDIR}/${PROJECT_NAME}-${PROJECT_VERSION}/${PROJECT_NAME}
)

install(
    EXPORT ${PROJECT_NAME}-config
    NAMESPACE ${PROJECT_NAME}::
    DESTINATION ${CMAKE_INSTALL_LIBDIR}/cmake/${PROJECT_NAME}-${PROJECT_VERSION}
)

install(
    DIRECTORY ${CMAKE_CURRENT_LIST_DIR}/include/${PROJECT_NAME}/
    DESTINATION
        ${CMAKE_INSTALL_INCLUDEDIR}/${PROJECT_NAME}-${PROJECT_VERSION}/${PROJECT_NAME}
)

install(
    FILES
        "${CMAKE_CURRENT_BINARY_DIR}/${PROJECT_NAME}/${PROJECT_NAME}-config-version.cmake"
    DESTINATION ${CMAKE_INSTALL_LIBDIR}/cmake/${PROJECT_NAME}-${PROJECT_VERSION}
)
