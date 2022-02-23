#!/bin/bash
####################################
# DESC
####################################
# Build wine source.

####################################
# PARAMS
####################################
# int THREADS
#   # How many threads make will use to compile. Defaults to all available.
# shellcheck disable=SC2154
THREADS=${THREADS:=$(nproc)}
# STRING PKGTYPE
#   # What packages do we want? Defaults to R for RPM
#   # Can have "-D" for Debian, "-R" for RPM and "-S" for slackware (who uses that again?)
# shellcheck disable=SC2154
PKGTYPE=${PKGTYPE:="-R"}

####################################
# et al
####################################
# 64 bit build process (includes 32 bit. will take about twice the time because.)
cd /builddir/out64 && CC="ccache gcc" ../wine/configure --enable-win64 && make -j"$THREADS"
cat /builddir/out64/config.log
cd /builddir/out32 && PKG_CONFIG_PATH=/usr/lib/pkgconfig CC="ccache gcc -m32" ../wine/configure --with-wine64=../out64 && make -j"$THREADS"
cat /builddir/out32/config.log
# create packages
cd /builddir/out32 && checkinstall --install=no --pkgname="wine" --pkgarch="i686" --provides="wine" --pakdir=/exports/out32 $PKGTYPE
cd /builddir/out64 && checkinstall --install=no --pkgname="wine" --pkgarch="x86_64" --provides="wine" --pakdir=/exports/out64 $PKGTYPE
