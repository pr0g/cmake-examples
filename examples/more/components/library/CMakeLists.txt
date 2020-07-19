cmake_minimum_required(VERSION 3.15)
project(phrases LANGUAGES CXX)

include(GNUInstallDirs)

################################################################################
# greetings component section

# hello library/target
add_library(hello)
target_sources(hello PRIVATE hello/hello.cpp)
target_include_directories(
    hello PUBLIC $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/hello/include/>
                 $<INSTALL_INTERFACE:${CMAKE_INSTALL_INCLUDEDIR}>)

install(
    TARGETS hello
    EXPORT greetings-config
    ARCHIVE DESTINATION ${CMAKE_INSTALL_LIBDIR})

install(DIRECTORY ${CMAKE_CURRENT_LIST_DIR}/hello/include/
        DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}/${PROJECT_NAME}/greetings/hello)

# hey library/target
add_library(hey)
target_sources(hey PRIVATE hey/hey.cpp)
target_include_directories(
    hey PUBLIC $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/hey/include/>
               $<INSTALL_INTERFACE:${CMAKE_INSTALL_INCLUDEDIR}>)

install(
    TARGETS hey
    EXPORT greetings-config
    ARCHIVE DESTINATION ${CMAKE_INSTALL_LIBDIR})

install(DIRECTORY ${CMAKE_CURRENT_LIST_DIR}/hey/include/
        DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}/${PROJECT_NAME}/greetings/hey)

################################################################################
# export greetings-config file for all associated targets
install(
    EXPORT greetings-config
    NAMESPACE ${PROJECT_NAME}::
    DESTINATION ${CMAKE_INSTALL_LIBDIR}/cmake/${PROJECT_NAME})

################################################################################
# farewells component section

# goodbye library/target
add_library(goodbye)
target_sources(goodbye PRIVATE goodbye/goodbye.cpp)
target_include_directories(
    goodbye
    PUBLIC $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/goodbye/include/>
           $<INSTALL_INTERFACE:${CMAKE_INSTALL_INCLUDEDIR}>)

install(
    TARGETS goodbye
    EXPORT farewells-config
    ARCHIVE DESTINATION ${CMAKE_INSTALL_LIBDIR})

install(
    DIRECTORY ${CMAKE_CURRENT_LIST_DIR}/goodbye/include/
    DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}/${PROJECT_NAME}/farewells/goodbye)

################################################################################
# export farewells-config file for all associated targets
install(
    EXPORT farewells-config
    NAMESPACE ${PROJECT_NAME}::
    DESTINATION ${CMAKE_INSTALL_LIBDIR}/cmake/${PROJECT_NAME})

################################################################################
# project section

configure_file(${PROJECT_NAME}-config.cmake.in ${PROJECT_NAME}-config.cmake
               @ONLY)

install(FILES "${CMAKE_BINARY_DIR}/${PROJECT_NAME}-config.cmake"
        DESTINATION ${CMAKE_INSTALL_LIBDIR}/cmake/${PROJECT_NAME})

################################################################################
