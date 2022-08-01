#!/bin/bash

latestDPPVersion=$(curl --silent "https://get-latest.herokuapp.com/brainboxdotcc/DPP")

git clone https://github.com/brainboxdotcc/DPP dpp-lib -b $latestDPPVersion

cd dpp-lib

cmake -B ./build

cmake --build ./build -j8

cd build; sudo make install
