# note: external/CMakeLists.txt is included ahead of this in the root
# CMakeLists.txt file which makes SDL2, ${build_type_arg} and
# ${build_config_arg} visible

# create an external project of our local project
ExternalProject_Add(
    ${PROJECT_NAME}_superbuild
    # set the dependencies required by our project to ensure they're built
    DEPENDS SDL2
    # set the source location to be that of our local project
    SOURCE_DIR ${PROJECT_SOURCE_DIR}
    BINARY_DIR ${CMAKE_CURRENT_BINARY_DIR}
    INSTALL_DIR ${CMAKE_CURRENT_BINARY_DIR}
    CMAKE_ARGS -DCMAKE_PREFIX_PATH=${CMAKE_CURRENT_SOURCE_DIR}/external/build
               # disable SUPERBUILD (as we're effectively calling the top level
               # CMakeLists.txt file recursively)
               -DSUPERBUILD=OFF
               ${build_type_arg}
    # ${build_type_arg} and ${build_config_arg} come from the external project
    # CMakeLists.txt file and correspond to the build configuration for single
    # and multi-config generators
    BUILD_COMMAND cmake --build <BINARY_DIR> ${build_config_arg}
    # (optional) disable install command for application
    INSTALL_COMMAND "")
