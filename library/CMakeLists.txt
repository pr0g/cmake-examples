cmake_minimum_required(VERSION 3.8)

project(cmake-library-example VERSION 0.0.1 LANGUAGES CXX)

add_library(calculator INTERFACE)

include(GNUInstallDirs)

# sets where the include files will be after installation
# this allows users to #include the library headers
target_include_directories(
    calculator INTERFACE
    $<INSTALL_INTERFACE:${CMAKE_INSTALL_INCLUDEDIR}>)

# specify the target to install (calculator library defined above)
# set the export name <name>-config - does not need to match target name
install(
    TARGETS calculator
    EXPORT calculator-config)

install(
    EXPORT calculator-config
    NAMESPACE calculator::
    DESTINATION ${CMAKE_INSTALL_LIBDIR}/cmake/calculator)

install(
    DIRECTORY ${CMAKE_CURRENT_LIST_DIR}/include/
    DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}/calculator)