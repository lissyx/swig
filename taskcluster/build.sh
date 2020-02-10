#!/bin/bash

set -xe

there=$(dirname $(dirname "$0"))
cross_compile=$1

pushd $there
    mkdir -p build-static/

    if [ ! -z "${cross_compile}" ]; then
        host="--host=${cross_compile}"
        export CFLAGS="-static-libgcc -static-libstdc++"
        export CXXFLAGS="-static-libgcc -static-libstdc++"
    fi;

    curl -sSL https://ftp.pcre.org/pub/pcre/pcre-8.43.tar.gz > pcre-8.43.tar.gz
    ./Tools/pcre-build.sh ${host}

    sh autogen.sh
    ./configure ${host} \
            --prefix=$there/build-static/ \
            --program-prefix=ds-

    make -j
    make install
popd
