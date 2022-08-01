#!/bin/bash

git clone https://github.com/brainboxdotcc/DPP dpp-lib

cd dpp-lib

cmake -B ./build

cmake --build ./build -j8

cd build; sudo make install
