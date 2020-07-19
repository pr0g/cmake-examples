# set the minimum required version of cmake to use
# needed to set version and policy settings before invoking other commands
cmake_minimum_required(VERSION 3.15)

# set the name of the project
# must immediately follow cmake_minimum_required command
project(
    calculator-app
    VERSION 0.0.1
    LANGUAGES CXX)

# find_package will find everything that is required to use
# the calculator library (include paths, libs if required etc..)
find_package(calculator REQUIRED CONFIG)

# add an executable target
add_executable(${PROJECT_NAME})

# add the source files to build
target_sources(${PROJECT_NAME} PRIVATE main.cpp)

# link the executable target against the imported target
# must prefix the target with the namespace set during install
target_link_libraries(${PROJECT_NAME} PUBLIC calculator::calculator)
