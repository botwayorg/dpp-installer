#!/bin/bash

profilePath="$HOME/.profile"

if [ -x "$(command -v brew)" ]; then
    echo "Installing required packages using Homebrew"

    brew install openssl libsodium opus

    echo 'export PATH="/home/linuxbrew/.linuxbrew/opt/openssl@3/bin:$PATH"' >> $profilePath

    source $profilePath

    export LDFLAGS="-L/home/linuxbrew/.linuxbrew/opt/openssl@3/lib"
    export CPPFLAGS="-I/home/linuxbrew/.linuxbrew/opt/openssl@3/include"

    latestDPPVersion=$(curl --silent "https://get-latest.herokuapp.com/brainboxdotcc/DPP")

    git clone https://github.com/brainboxdotcc/DPP dpp-lib -b $latestDPPVersion

    cd dpp-lib

    cmake -B ./build
    cmake --build ./build -j8

    cd build; sudo make install
else
    echo "Homebrew not found. Would you like to install it? (Y/n)"
    read -n 1 accept

    if [[ $accept == "" || $accept == "Y" || $accept == "y" ]]; then
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

        echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >> $profilePath

        source $profilePath

        echo "Run this command again to install the required packages"
    else
        echo "you should accept to install"
        exit 0
    fi
fi
