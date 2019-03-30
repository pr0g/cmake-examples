# accepts a single argument, the path to the library in active development
# this will configure, generate, build and install the library.
# notes:
# 1. requirement - you must make sure that a build/ folder
#   already exists in the library directory for this to work
# 2. `execute_process` runs at configure time (during `cmake ..`)
#   so you must run `cmake ..` from the application folder to
#   have these operations execute
function(install_it)
    execute_process(
        COMMAND cmake ..
        WORKING_DIRECTORY ${ARGV0}/build)
    execute_process(
        COMMAND cmake --build . --target install
        WORKING_DIRECTORY ${ARGV0}/build)
endfunction()