include(ExternalProject)

###############################################################################
# Catch2
#  - use commit fd9f5ac661f87335ecd70d39849c1d3a90f1c64d
#    v2.13.1
###############################################################################
# The parent script needs to define the "GLOBAL_OUTPUT_PATH" variable,
# which will be used as output directory for all *.lib, *.dll, *.a, *.so, *.pdb files.

set(EXTERNAL_LIB       catch2)
set(CATCH2_ROOT        ${GLOBAL_OUTPUT_PATH}/catch2)
set(CATCH2_INCLUDE_DIR ${CATCH2_ROOT}/include)

message(INFO "ExternalProject_Add() - ${EXTERNAL_LIB} - building ${CMAKE_BUILD_TYPE}")

ExternalProject_Add(
    CATCH2_external

    GIT_REPOSITORY "https://github.com/catchorg/Catch2"
    GIT_TAG  "v2.13.0"
    GIT_PROGRESS TRUE

    SOURCE_DIR "${CMAKE_SOURCE_DIR}/3rdparty/catch2"
    CMAKE_ARGS 
        -DCATCH_BUILD_TESTING=OFF
        -DCATCH_INSTALL_DOCS=OFF
        -DCMAKE_INSTALL_PREFIX=${CATCH2_ROOT}
        -DCMAKE_PREFIX_PATH=${CATCH2_ROOT}
        -DCMAKE_BUILD_TYPE=${CMAKE_BUILD_TYPE}

    TEST_COMMAND  ""
    UPDATE_COMMAND ""
    PATCH_COMMAND  ""

    INSTALL_DIR ${CATCH2_ROOT}
)

# Hack to make it work, otherwise INTERFACE_INCLUDE_DIRECTORIES will not be propagated
# https://stackoverflow.com/questions/45516209/cmake-how-to-use-interface-include-directories-with-externalproject
file(MAKE_DIRECTORY ${CATCH2_ROOT})
file(MAKE_DIRECTORY ${CATCH2_INCLUDE_DIR})

add_library(catch2 INTERFACE)
set_target_properties(catch2 PROPERTIES 
    INTERFACE_INCLUDE_DIRECTORIES ${CATCH2_INCLUDE_DIR}
)

add_dependencies(catch2 catch2_external)

