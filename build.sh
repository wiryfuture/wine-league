#!/bin/sh
####################################
# DESC
####################################
# Build wine source.

####################################
# PARAMS
####################################
# bool BUILD64BIT
#   # Whether wine64 dependencies will be installed. Defaults to true.
# shellcheck disable=SC2154
BUILD64BIT=${BUILD64BIT:="1"}
# int THREADS
#   # How many threads make will use to compile. Defaults to all available.
# shellcheck disable=SC2154
THREADS=${THREADS:=$(nproc)}

####################################
# et al
####################################

if [ "$BUILD64BIT" != 0 ] ; then
    # 64 bit build process (includes 32 bit. will take about twice the time because.)
    cd /builddir/out64 && CC="ccache gcc" ../wine/configure --enable-win64 && make -j"$THREADS"
    cd /builddir/out32 && PKG_CONFIG_PATH=/usr/lib/pkgconfig CC="ccache gcc -m32" ../wine/configure --with-wine64=../out64 && make -j"$THREADS"
    else
    cd /builddir/out32 && PKG_CONFIG_PATH=/usr/lib/pkgconfig CC="ccache gcc -m32" ../wine/configure && make -j"$THREADS"
fi