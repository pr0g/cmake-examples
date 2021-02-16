cmake_minimum_required(VERSION 3.15)

# set the name of the project and also specify the version, we'll use
# this later by accessing it through the ${PROJECT_VERSION} variable
project(
    useless
    VERSION 1.0.0
    LANGUAGES CXX)

# add two libraries (targets) - this is done to demonstrate how to
# have multiple libraries per project (and then access them through
# the namespace defined later when installing)

add_library(calculator-static)
target_sources(calculator-static PRIVATE src/calculator.cpp)
set_target_properties(calculator-static PROPERTIES DEBUG_POSTFIX "d")

add_library(writer-static)
target_sources(writer-static PRIVATE src/writer.cpp)
set_target_properties(writer-static PROPERTIES DEBUG_POSTFIX "d")

# bring in useful functionality (GNU standard install directories
# and helper functions for creating config files)
include(GNUInstallDirs)
include(CMakePackageConfigHelpers)

# create the -config-version file (the version will default to the
# ${PROJECT_VERSION} but we're being explicit and SameMajorVersion
# seems like the safest/sanest compatibility option
write_basic_package_version_file(
    "${CMAKE_CURRENT_BINARY_DIR}/${PROJECT_NAME}/${PROJECT_NAME}-config-version.cmake"
    VERSION ${PROJECT_VERSION}
    COMPATIBILITY SameMajorVersion)

# sets the search paths for the include files after installation
# as well as during when building the library (as these may differ)
# this allows the library itself and users to #include the library headers
target_include_directories(
    calculator-static
    PUBLIC
        $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include>
        $<INSTALL_INTERFACE:${CMAKE_INSTALL_INCLUDEDIR}/${PROJECT_NAME}-${PROJECT_VERSION}>
)

# we need to do the same of both targets
target_include_directories(
    writer-static
    PUBLIC
        $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include>
        $<INSTALL_INTERFACE:${CMAKE_INSTALL_INCLUDEDIR}/${PROJECT_NAME}-${PROJECT_VERSION}>
)

# install both targets to the same project ("useless" in this case)
# note we use ${PROJECT_NAME}-${PROJECT_VERSION} as part of the path
# to distinguish different installed versions.
install(
    TARGETS calculator-static writer-static
    EXPORT ${PROJECT_NAME}-config
    ARCHIVE
        DESTINATION
            ${CMAKE_INSTALL_LIBDIR}/${PROJECT_NAME}-${PROJECT_VERSION}/${PROJECT_NAME}
)

# associate installed target files with the export, and then install the export
install(
    EXPORT ${PROJECT_NAME}-config # name of .cmake file
    NAMESPACE
        ${PROJECT_NAME}:: # set so clients must use useless::calculator or useless::writer
                          # to distinguish imported targets from internal ones
    # where the .cmake file will be installed
    DESTINATION ${CMAKE_INSTALL_LIBDIR}/cmake/${PROJECT_NAME}-${PROJECT_VERSION}
)

# copy include files to install include directory
install(
    DIRECTORY ${CMAKE_CURRENT_LIST_DIR}/include/${PROJECT_NAME}/
    DESTINATION
        ${CMAKE_INSTALL_INCLUDEDIR}/${PROJECT_NAME}-${PROJECT_VERSION}/${PROJECT_NAME}
)

# copy config-version files to install library directory
install(
    FILES
        "${CMAKE_CURRENT_BINARY_DIR}/${PROJECT_NAME}/${PROJECT_NAME}-config-version.cmake"
    DESTINATION ${CMAKE_INSTALL_LIBDIR}/cmake/${PROJECT_NAME}-${PROJECT_VERSION}
)
