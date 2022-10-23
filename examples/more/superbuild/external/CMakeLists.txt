cmake_minimum_required(VERSION 3.15)
# handle new policy for url download method
# see https://cmake.org/cmake/help/latest/policy/CMP0135.html for details
cmake_policy(SET CMP0135 NEW)

# only bother creating a separate project if we're not
# building as part of a superbuild
if(NOT SUPERBUILD)
    project(external)
endif()

include(ExternalProject)

# handle different build configurations for external dependencies for both
# single and multi-config generators.
# this is to ensure different build configurations go to separate internal
# folders so switching between Debug/Release doesn't cause frequent rebuilds
get_property(isMultiConfig GLOBAL PROPERTY GENERATOR_IS_MULTI_CONFIG)
if(NOT isMultiConfig)
    if(NOT CMAKE_BUILD_TYPE)
        set(CMAKE_BUILD_TYPE
            Debug
            CACHE STRING "" FORCE)
    endif()
    set(build_type_dir ${CMAKE_BUILD_TYPE})
    set(build_type_arg -DCMAKE_BUILD_TYPE=$<CONFIG>)
else()
    set(build_config_arg --config=$<CONFIG>)
endif()

# when using superbuild, choose a default build folder for the external
# project(s), otherwise default to the one provided by the user if building
# from this folder
if(SUPERBUILD)
    set(PREFIX_DIR ${CMAKE_CURRENT_SOURCE_DIR}/external/build)
else()
    set(PREFIX_DIR ${CMAKE_CURRENT_BINARY_DIR})
endif()

# download, configure, build and install the dependency
# note: The install location is set to the build folder
ExternalProject_Add(
    SDL2
    URL https://github.com/libsdl-org/SDL/releases/download/release-2.24.1/SDL2-2.24.1.tar.gz
    URL_HASH MD5=10bad2a286f155565edc611f41345de1
    PREFIX ${PREFIX_DIR}
    BINARY_DIR ${PREFIX_DIR}/src/SDL2-build/${build_type_dir}
    CMAKE_ARGS ${build_type_arg} -DCMAKE_INSTALL_PREFIX=<INSTALL_DIR>
    BUILD_COMMAND cmake --build <BINARY_DIR> ${build_config_arg}
    INSTALL_COMMAND cmake --build <BINARY_DIR> --target install
                    ${build_config_arg})
