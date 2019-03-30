function(install_it)
    execute_process(
        COMMAND cmake ..
        WORKING_DIRECTORY ${ARGV0}/build)
    execute_process(
        COMMAND cmake --build . --target install
        WORKING_DIRECTORY ${ARGV0}/build)
endfunction()