cmake_minimum_required(VERSION 3.15)

project(external-project-add-example LANGUAGES CXX)

# normal find_package command (no explicit reference to
# ExternalProject_Add at all)
find_package(bec REQUIRED)

add_executable(${PROJECT_NAME})
target_sources(${PROJECT_NAME} PRIVATE main.cpp)
target_link_libraries(${PROJECT_NAME} PRIVATE bec::bec)
