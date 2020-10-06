#!/bin/bash
mkdir -p ${HOME}/temp/external-project-add/build
cmake -S . -B ${HOME}/temp/external-project-add/build -DCMAKE_BUILD_TYPE=Release