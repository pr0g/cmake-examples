include(ExternalProject)

###############################################################################
# restbed 4.7
###############################################################################
# The parent script needs to define the "GLOBAL_OUTPUT_PATH" variable,
# which will be used as output directory for all *.lib, *.dll, *.a, *.so, *.pdb files.

set(EXTERNAL_LIB        restbed)
set(RESTBED_ROOT        ${GLOBAL_OUTPUT_PATH}/restbed)
set(RESTBED_LIB_DIR     ${RESTBED_ROOT}/library)
set(RESTBED_INCLUDE_DIR ${RESTBED_ROOT}/include)

message(INFO "ExternalProject_Add() - ${EXTERNAL_LIB} - building ${CMAKE_BUILD_TYPE}")

# Long discussion on how to properly handly cross platform builds
# with single-target / multiple-target compilers
# https://gitlab.kitware.com/cmake/cmake/-/issues/17645
ExternalProject_Add(
    restbed_external

    GIT_REPOSITORY "https://github.com/Corvusoft/restbed"
    GIT_TAG        "4.7"
    GIT_PROGRESS   TRUE

    SOURCE_DIR "${CMAKE_SOURCE_DIR}/3rdparty/restbed"
    CMAKE_ARGS 
        -DBUILDSHARED=OFF 
        -DBUILD_TESTS=OFF 
        -DBUILD_SSL=OFF 
        -DBUILD_SHARED_LIBS=OFF 
        -DCMAKE_INSTALL_PREFIX=${RESTBED_ROOT}
        -DCMAKE_PREFIX_PATH=${RESTBED_ROOT}
        -DCMAKE_BUILD_TYPE=${CMAKE_BUILD_TYPE}

    TEST_COMMAND   ""
    UPDATE_COMMAND ""
    PATCH_COMMAND  ""

    INSTALL_DIR     ${GLOBAL_OUTPUT_PATH}/restbed
    INSTALL_COMMAND ${CMAKE_COMMAND} --build . --config $<CONFIG> --target install
)

# Hack to make it work, otherwise INTERFACE_INCLUDE_DIRECTORIES will not be propagated
# https://stackoverflow.com/questions/45516209/cmake-how-to-use-interface-include-directories-with-externalproject
file(MAKE_DIRECTORY ${RESTBED_ROOT})
file(MAKE_DIRECTORY ${RESTBED_LIB_DIR})
file(MAKE_DIRECTORY ${RESTBED_INCLUDE_DIR})

add_library(restbed STATIC IMPORTED)
set_target_properties(restbed PROPERTIES 
    IMPORTED_LOCATION "${RESTBED_LIB_DIR}/${CMAKE_STATIC_LIBRARY_PREFIX}restbed${CMAKE_STATIC_LIBRARY_SUFFIX}"
    INTERFACE_INCLUDE_DIRECTORIES ${RESTBED_INCLUDE_DIR}
)

add_dependencies(restbed restbed_external)
