include(ExternalProject)

###############################################################################
# rapidjson
#  - use commit ce81bc9edfe773667a7a4454ba81dac72ed4364c
#    from 07 August 2020
###############################################################################
# The parent script needs to define the "GLOBAL_OUTPUT_PATH" variable,
# which will be used as output directory for all *.lib, *.dll, *.a, *.so, *.pdb files.

set(RAPIDJSON_ROOT        ${GLOBAL_OUTPUT_PATH}/rapidjson)
set(RAPIDJSON_LIB_DIR     ${RAPIDJSON_ROOT}/lib)
set(RAPIDJSON_INCLUDE_DIR ${RAPIDJSON_ROOT}/include)

ExternalProject_Add(
    RAPIDJSON_external

    GIT_REPOSITORY "https://github.com/Tencent/rapidjson"
    GIT_TAG "ce81bc9edfe773667a7a4454ba81dac72ed4364c"
    GIT_PROGRESS TRUE

    SOURCE_DIR "${CMAKE_SOURCE_DIR}/3rdparty/rapidjson"
    CMAKE_ARGS 
        -DRAPIDJSON_BUILD_DOC=OFF
        -DRAPIDJSON_BUILD_EXAMPLES=OFF
        -DRAPIDJSON_BUILD_TESTS=OFF
        -DCMAKE_INSTALL_PREFIX=${RAPIDJSON_ROOT}
        -DCMAKE_PREFIX_PATH=${RAPIDJSON_ROOT}

    TEST_COMMAND  ""
    UPDATE_COMMAND ""
    PATCH_COMMAND  ""

    INSTALL_DIR ${RAPIDJSON_ROOT}
)

# Hack to make it work, otherwise INTERFACE_INCLUDE_DIRECTORIES will not be propagated
# https://stackoverflow.com/questions/45516209/cmake-how-to-use-interface-include-directories-with-externalproject
file(MAKE_DIRECTORY ${RAPIDJSON_ROOT})
file(MAKE_DIRECTORY ${RAPIDJSON_LIB_DIR})
file(MAKE_DIRECTORY ${RAPIDJSON_INCLUDE_DIR})

add_library(rapidjson INTERFACE)
set_target_properties(rapidjson PROPERTIES 
    INTERFACE_INCLUDE_DIRECTORIES ${RAPIDJSON_INCLUDE_DIR}
)

add_dependencies(rapidjson rapidjson_external)

