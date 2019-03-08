cmake_minimum_required(VERSION 3.8)

project(cmake-library-example VERSION 0.0.1 LANGUAGES CXX)

add_library(calculator-lib src/calculator.cpp)

include(GNUInstallDirs)

# sets where the include files will be after installation
# this allows users to #include the library headers
target_include_directories(
    calculator-lib PUBLIC
    $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include/>
    $<INSTALL_INTERFACE:${CMAKE_INSTALL_INCLUDEDIR}>)

# specify the target to install (calculator library defined above)
# set the export name <name>-config - does not need to match target name
install(
    TARGETS calculator-lib
    EXPORT calculator-lib-config
    LIBRARY DESTINATION lib
    ARCHIVE DESTINATION lib)

# associate installed target files with export and install export
install(
    EXPORT calculator-lib-config
    NAMESPACE calculator-lib::
    DESTINATION ${CMAKE_INSTALL_LIBDIR}/cmake/calculator-lib)

# copy files to install directory
install(
    DIRECTORY ${CMAKE_CURRENT_LIST_DIR}/include/
    DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}/calculator-lib)