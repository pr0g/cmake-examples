# set the minimum required version of cmake needed by this CMake project.
# this command is needed to set version and policy
# settings before invoking other commands
cmake_minimum_required(VERSION 3.15)

# set the name of the project, the version and which languages
# are needed to build this project
# this command must immediately follow the cmake_minimum_required command
project(
    calculator
    VERSION 0.0.1
    LANGUAGES CXX)

# add an interface library target (it will not be built directly)
add_library(${PROJECT_NAME} INTERFACE)

# define GNU standard installation directories
# note: ${CMAKE_INSTALL_INCLUDEDIR}, ${CMAKE_INSTALL_LIBDIR} and
# ${CMAKE_CURRENT_LIST_DIR} etc. are defined in GNUInstallDirs
include(GNUInstallDirs)

# sets the search paths for the include files after installation
# this allows users to #include the library headers
target_include_directories(
    ${PROJECT_NAME}
    INTERFACE $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include>
              $<INSTALL_INTERFACE:${CMAKE_INSTALL_INCLUDEDIR}>)

# specify the target to install (calculator library defined above)
# set the export name <name>-config (does not need to match target name)
install(TARGETS ${PROJECT_NAME} EXPORT ${PROJECT_NAME}-config)

# associate installed target files with the export, and then install the export
install(
    EXPORT ${PROJECT_NAME}-config # name of .cmake file
    NAMESPACE ${PROJECT_NAME}:: # set so clients must use calculator::calculator
                                # to distinguish imported targets from internal
                                # ones
    # where the .cmake file will be installed
    DESTINATION ${CMAKE_INSTALL_LIBDIR}/cmake/${PROJECT_NAME})

# copy include files to the install include directory
install(DIRECTORY ${CMAKE_CURRENT_LIST_DIR}/include/${PROJECT_NAME}/
        DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}/${PROJECT_NAME})
