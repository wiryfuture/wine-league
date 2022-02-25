#!/bin/bash
####################################
# DESC
####################################
# Build wine source.

# remember to set ccache dir chmod to chmod g+s
export CCACHE_DIR=/ccache
export CCACHE_UMASK=002

####################################
# PARAMS
####################################
# int x86_64
#   # Do 64bit build true/false
# shellcheck disable=SC2154
x86_64=${x86_64:=0}
# int THREADS
#   # How many threads make will use to compile. Defaults to all available.
# shellcheck disable=SC2154
THREADS=${THREADS:=$(nproc)}

####################################
# et al
####################################
# 64 bit build
if [ "$x86_64" == 1 ]; then
# 64 bit build process (includes 32 bit. will take about twice the time because.)
(cd /exports/out64 || exit; CC="ccache gcc" ../wine/configure --enable-win64 && make clean && make -j"$THREADS")
#cat /builddir/out64/config.log
# 32 bit build
elif [ "$x86_64" == 0 ]; then
(cd /exports/out32-tools || exit; PKG_CONFIG_PATH=/usr/lib/pkgconfig CC="ccache gcc -m32" ../wine/configure && make clean && make -j"$THREADS")
#cat /builddir/out32/config.log
# biarch build
elif [ "$x86_64" == 2 ]; then
(cd /exports/out32 || exit; PKG_CONFIG_PATH=/usr/lib/pkgconfig CC="ccache gcc -m32" ../wine/configure --with-wine64=../out64 --with-wine-tools=../out32-tools && make -j"$THREADS" && make clean && make install)
#cat /builddir/out32/config.log
fi
