cmake_minimum_required(VERSION 3.15)

project(external-project-add LANGUAGES CXX)

# get external libraries
SET(GLOBAL_OUTPUT_PATH ${CMAKE_BINARY_DIR}/3rdparty/bin/${CMAKE_BUILD_TYPE})
include(${PROJECT_SOURCE_DIR}/cmake/Restbed_External.cmake)
include(${PROJECT_SOURCE_DIR}/cmake/Rapidjson_External.cmake)
include(${PROJECT_SOURCE_DIR}/cmake/Catch2_External.cmake)

add_executable(${PROJECT_NAME})
target_sources(${PROJECT_NAME} PRIVATE main.cpp)

if(WIN32)
    target_link_libraries(${PROJECT_NAME} PRIVATE
        restbed
        catch2
        rapidjson
    )
else()
    set(THREADS_PREFER_PTHREAD_FLAG ON)
    find_package(Threads REQUIRED)
    target_link_libraries(${PROJECT_NAME} PRIVATE
        restbed
        catch2
        rapidjson
        ${CMAKE_THREAD_LIBS_INIT}
    )
endif()