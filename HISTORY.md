# History

## 8th April 2024

- Update `examples/more/components` after discussion on CMake Discourse

## 23rd October 2022

- Add new example to `examples/more` folder covering _superbuilds_ (see [superbuild](/examples/more/superbuild)).
- Update `.sh/.bat` configure scripts to remove redundant `-S .` command line argument.
- See [PR #10](https://github.com/pr0g/cmake-examples/pull/10) for both changes.

## 30th April 2022

- Added new CMake intro article link (cd1cbeb739057b017085d8f7bd25bac6b2059942)

## 16th February 2021

- Update examples to improved project structure

## 14th February 2021

- Add new info to README.md about project structure

## 30th January 2021

- Add a new example ([nested-dependencies](examples/more/nested-dependencies)) to discuss some requirements of `<proj>-config.cmake` files
- Add reference to [cmake-helpers](https://github.com/pr0g/cmake-helpers) repo

## 28th October 2020

- Add a new example project to examples/more to demonstrate `ExternalProject_Add`
- Shuffle `FetchContext` description to new README file in the relevant directory
- Update README.md with a reference to the new `ExternalProject_Add` example
- Add a couple helper `.bat/.sh` scripts for `ExternalProject_Add` and `FetchContent` examples

## 19th July 2020

- Rename branch
- Add `.bat` scripts for static-versioned library in examples/more
- Add `.cmake-format.yml` file and auto-format all `CMakeLists.txt` files
- Add simple script to run `cmake-format` across all `CMakeLists.txt` files
- Add `.sh` scripts for static-versioned library in examples/more

## 8th June 2020

- Add `.sh` files for all examples/core projects

## 7th June 2020

- Add `.bat` files for all examples/core projects
- Add a new example project to examples/more to demonstrate `FetchContent`
- Updated README.md with some information about `FetchContent` and additional links

## 26th April 2020

- Included `DEBUG_POSTFIX` section in README.md
- Added `DEBUG_POSTFIX` to examples/core/static project

## 10th April 2020

- Updated README.md for more/components example section

## 9th April 2020

- Updated CMakeLists.txt files to require CMake 3.15

## 7th April 2020

- Added example of using CMake Components in More section
- Added `%cd%` as well as `$(pwd)` to example install instructions

## 29th March 2020

- Updated guidance on CMake `--verbose` flag
- Updated info about `CMAKE_EXPORT_COMPILE_COMMANDS`
- Updated CMakeLists.txt files to require CMake 3.13
- Updated CMakeLists.txt files to use `target_sources`
- Added more CMake YouTube videos to the root README
- Updated Visual Studio examples to use 2019 instead of 2017
- A few other minor tweaks in the README files

## 24th October 2019

- Small updates to `shared` and `shared-export` libraries to include RUNTIME and ARCHIVE locations (CMake picks sensible defaults in later versions but this provides more customization points for users)
- Add link to new CMake video by Craig Scott from CppCon 2019
- Added new line at end of files

## 6th September 2019

- Added more info about installing to custom locations in Install section
- Added miscellaneous section to main README.md with some useful CMake techniques

## 16th June 2019

- Added a new example in `more` section titled `header-only-defines` with an example of using `target_compile_definitions` in the application and `target_compile_features` in the library

## 7th April 2019

- Added a few more links to the main README.md file

## 30th March 2019

- Added experimental `static-auto-install` example
- Reorganised folders to split up core examples from slightly more advanced cases
- Do a pass over READMEs to ensure they are up to date

## 28th March 2019

- Added README for `static-versioned` example and updated comments in `CMakeLists.txt` files for that project

## 24th March 2019

- Added a new example folder `static-versioned` to show an example of setting up a `CMakeLists.txt` file to handle installing multiple versions of the same library

## 15th March 2019

- Added an explanation for the flag `gtest_force_shared_crt` passed to CMake when building Google Test on Windows

## 12th March 2019

- Fixed `.gitattributes` file (finally) to correctly display languages in repo
- Merged [PR](https://github.com/pr0g/cmake-examples/pull/3) by [0xflotus](https://github.com/0xflotus) to fix a spelling mistake

## 11th March 2019

- Added LICENSE

## 10th March 2019

- Publish!
- Rename `dynamic` to `shared` for more standard naming
- Add `shared-export` example using CMake `GenerateExportHeader` instead of custom export file
