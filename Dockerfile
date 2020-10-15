FROM debian:buster

COPY sources.list /etc/apt/sources.list

RUN apt-get update && export DEBIAN_FRONTEND=noninteractive \
    && apt-get -y install sudo vim \
    && groupadd --gid 1000 node && useradd -s /bin/bash --uid 1000 --gid 1000 -m node \
    && echo "node ALL=(root) NOPASSWD:ALL" > /etc/sudoers.d/node \
    && chmod 0440 /etc/sudoers.d/node

# Install additional OS packages.
RUN apt-get update && export DEBIAN_FRONTEND=noninteractive \
    && apt-get -y install --no-install-recommends '^libxcb.*-dev' \
        bison \
        build-essential \
        checkinstall \
        cmake \
        flex \
        git \
        gperf \
        libasound2-dev \
        libavcodec-dev \
        libavdevice-dev \
        libavfilter-dev \
        libavformat-dev \
        libavutil-dev \
        libcap-dev \
        libclang-6.0-dev \
        libcurl4-openssl-dev \
        libdbus-1-dev \
        libegl1-mesa-dev \
        libevent-dev \
        libfdk-aac-dev \
        libfontconfig1-dev \
        libfontconfig-dev \
        libfreetype6-dev \
        libgl1-mesa-dev \
        libglu1-mesa-dev \
        libgstreamer1.0-dev \
        libgstreamer-plugins-base1.0-dev \
        libicu-dev \
        libjack-jackd2-dev \
        libjansson-dev \
        libluajit-5.1-dev \
        libmbedtls-dev \
        libnss3-dev \
        libpci-dev \
        libpulse-dev \
        libqt5svg5-dev \
        libqt5x11extras5-dev \
        libspeexdsp-dev \
        libswresample-dev \
        libswscale-dev \
        libudev-dev \
        libv4l-dev \
        libvlc-dev \
        libx11-dev \
        libx11-xcb-dev \
        libx264-dev \
        libxcb1-dev \
        libxcb-randr0-dev \
        libxcb-shm0-dev \
        libxcb-xfixes0-dev \
        libxcb-xinerama0-dev \
        libxcomposite-dev \
        libxcursor-dev \
        libxdamage-dev \
        libxi-dev \
        libxinerama-dev \
        libxkbcommon-dev \
        libxkbcommon-x11-dev \
        libxrandr-dev \
        libxrender-dev \
        libxslt-dev ruby \
        libxss-dev \
        libxtst-dev \
        llvm-6.0 \
        mesa-utils \
        nodejs \
        perl \
        pkg-config \
        python \
        python3-dev \
        qtbase5-dev \
        swig \
    && apt-get -y autoremove

RUN apt-get update && export DEBIAN_FRONTEND=noninteractive \
    && apt-get -y install --no-install-recommends curl libssl-dev \
    && curl -sS -o cmake.tar.gz https://codeload.github.com/Kitware/CMake/tar.gz/v3.18.4 \
    && tar xf cmake.tar.gz \
    && cd CMake-3.18.4 \
    && ./bootstrap && make && sudo make install \
    && cd .. \
    && rm -rf cmake.tar.gz CMake-3.18.4 \
    && apt-get -y autoremove

RUN apt-get update && export DEBIAN_FRONTEND=noninteractive \
    && curl -sS -o nvm-install.sh https://raw.githubusercontent.com/nvm-sh/nvm/v0.36.0/install.sh \
    && chmod +x nvm-*.sh && sudo -unode /bin/bash `pwd`/nvm-install.sh \
    && rm nvm-*.sh \
    && apt-get -y autoremove
