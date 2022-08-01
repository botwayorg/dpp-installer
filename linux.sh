#!/bin/bash

echo "Installing required packages..."

declare -A osInfo;

osInfo[/etc/redhat-release]=yum
osInfo[/etc/arch-release]=pacman
osInfo[/etc/gentoo-release]=emerge
osInfo[/etc/debian_version]=apt-get
osInfo[/etc/alpine-release]=apk

for f in ${!osInfo[@]}
do
    if [[ -f $f ]];then
        if [ "${osInfo[$f]}" == "yum" ]; then
            sudo yum update && sudo yum install -y opus libsodium
        elif [ "${osInfo[$f]}" == "pacman" ]; then
            sudo pacman -Syu && sudo pacman -S opus libsodium
        elif [ "${osInfo[$f]}" == "emerge" ]; then
            sudo emerge --update --deep --with-bdeps=y @world && sudo emerge -pv opus libsodium
        elif [ "${osInfo[$f]}" == "apt-get" ]; then
            sudo apt-get upgrade -y && sudo apt-get install -y libsodium-dev libopus-dev
        elif [ "${osInfo[$f]}" == "apk" ]; then
            sudo apk update && sudo apk add libsodium opus
        fi
    fi
done

git clone https://github.com/brainboxdotcc/DPP dpp-lib

cd dpp-lib

cmake -B ./build

cmake --build ./build -j8

cd build; sudo make install
