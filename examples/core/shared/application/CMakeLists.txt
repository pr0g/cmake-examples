cmake_minimum_required(VERSION 3.15)

project(
    calculator-app
    VERSION 0.0.1
    LANGUAGES CXX)

find_package(calculator-shared REQUIRED CONFIG)

add_executable(${PROJECT_NAME})
target_sources(${PROJECT_NAME} PRIVATE main.cpp)

target_link_libraries(${PROJECT_NAME}
                      PUBLIC calculator-shared::calculator-shared)

if(WIN32)
    # copy the .dll file to the same folder as the executable
    add_custom_command(
        TARGET ${PROJECT_NAME}
        POST_BUILD
        COMMAND
            ${CMAKE_COMMAND} -E copy_directory
            $<TARGET_FILE_DIR:calculator-shared::calculator-shared>
            $<TARGET_FILE_DIR:${PROJECT_NAME}>
        VERBATIM)
endif()
