# use the find_path() function to locate the header file
find_path(calculator-static_INCLUDE_DIR calculator-static
          PATHS ${calculator-static_PATH}/include)

# use the find_library() function to locate the library binary
find_library(
    calculator-static_LIBRARY
    NAMES calculator-static
    PATHS ${calculator-static_PATH}/lib)

# handle the result of the search
include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(
    calculator-static DEFAULT_MSG calculator-static_LIBRARY
    calculator-static_INCLUDE_DIR)

# if the library has been found, define the imported target
if(calculator-static_FOUND AND NOT TARGET calculator-static::calculator-static)
    add_library(calculator-static::calculator-static UNKNOWN IMPORTED)
    set_target_properties(
        calculator-static::calculator-static
        PROPERTIES IMPORTED_LOCATION "${calculator-static_LIBRARY}"
                   INTERFACE_INCLUDE_DIRECTORIES
                   "${calculator-static_INCLUDE_DIR}")
endif()
