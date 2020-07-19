cmake_minimum_required(VERSION 3.15)

project(
    calculator-app
    VERSION 0.0.1
    LANGUAGES CXX)

# find the package (library/libraries) we want while also specifying
# the version to ensure we get the specific version we need
# note: if you pass EXACT after the version number find_package will
# fail if the requested version does not exactly match the installed version
# for example you might really want version 1.2.14 an none other will do
find_package(useless 1.0.0 REQUIRED CONFIG)

add_executable(${PROJECT_NAME})
target_sources(${PROJECT_NAME} PRIVATE main.cpp)

# link our application against the libraries we're
# using contained in the "useless" package
target_link_libraries(${PROJECT_NAME} PUBLIC useless::calculator-static
                                             useless::writer-static)
