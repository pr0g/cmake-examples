# set the minimum required version of cmake to use
# needed to set version and policy settings before invoking other commands
cmake_minimum_required(VERSION 3.8)

# set the name of the project
# must immediately follow cmake_minimum_required command
project(cmake-application-example VERSION 0.0.1 LANGUAGES CXX)

# find_package will find everything that is required to use
# the calculator library (include paths, libs if required etc..)
find_package(calculator REQUIRED)

# add an executable target with one source file
add_executable(calculator-app main.cpp)

# link the executable target against the imported target
# must prefix the target with the namespace set during install
target_link_libraries(calculator-app PUBLIC calculator::calculator)