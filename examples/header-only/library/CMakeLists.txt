# set the minimum required version of cmake needed by this CMake project.
# this command is needed to set version and policy
# settings before invoking other commands
cmake_minimum_required(VERSION 3.8)

# set the name of the project, the version and which languages
# are needed to build this project
# this command must immediately follow the cmake_minimum_required command
project(calculator VERSION 0.0.1 LANGUAGES CXX)

# add an interface library target (it will not be built directly)
add_library(calculator INTERFACE)

# define GNU standard installation directories
# note: ${CMAKE_INSTALL_INCLUDEDIR}, ${CMAKE_INSTALL_LIBDIR} and
# ${CMAKE_CURRENT_LIST_DIR} etc. are defined in GNUInstallDirs
include(GNUInstallDirs)

# sets the search paths for the include files after installation
# this allows users to #include the library headers
target_include_directories(
    calculator INTERFACE
    $<INSTALL_INTERFACE:${CMAKE_INSTALL_INCLUDEDIR}>)

# specify the target to install (calculator library defined above)
# set the export name <name>-config (does not need to match target name)
install(
    TARGETS calculator
    EXPORT calculator-config)

# associate installed target files with the export, and then install the export
install(
    EXPORT calculator-config # name of .cmake file
    NAMESPACE calculator:: # set so clients must use calculator::calculator
                           # to distinguish imported targets from internal ones
    DESTINATION ${CMAKE_INSTALL_LIBDIR}/cmake/calculator) # where the .cmake file will be installed

# copy include files to the install include directory
install(
    DIRECTORY ${CMAKE_CURRENT_LIST_DIR}/include/
    DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}/calculator)