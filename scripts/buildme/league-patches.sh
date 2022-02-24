#!/bin/bash
####################################
# DESC
####################################
# Apply non-staging patches to wine source.

####################################
# et al
####################################
# Apply GloriousEggroll's wine and proton patches
# How to apply:
#   # cd /builddir/wine && patch -Np1 < /builddir/patches/FOLDER/name.patch
# monotonic clock patch | performance
(cd /builddir/wine || exit; patch -Np1 < /builddir/patches/proton/01-proton-use_clock_monotonic.patch)
# large address aware patch | more memory can be used
(cd /builddir/wine || exit; patch -Np1 < /builddir/patches/proton/04-proton-LAA_staging.patch)
# esync patch | lets you use esync
(cd /builddir/wine || exit; patch -Np1 < /builddir/patches/proton/03-proton-fsync_staging.patch)
# proton patches that improve performance
(cd /builddir/wine || exit; patch -Np1 < /builddir/patches/proton/49-proton_QPC.patch)
(cd /builddir/wine || exit; patch -Np1 < /builddir/patches/proton/49-proton_QPC-update-replace.patch)
(cd /builddir/wine || exit; patch -Np1 < /builddir/patches/lol/lfh-non-proton-pre-needed.patch) # needed for league for some reason
(cd /builddir/wine || exit; patch -Np1 < /builddir/patches/proton/50-proton_LFH.patch)
# winsock on unix
(cd /builddir/wine || exit; patch -Np1 < /builddir/patches/lol/include-allow_using_windows_sockets_on_unix.patch)

# Apply GE's league patches
(cd /builddir/wine || exit; patch -Np1 < /builddir/patches/lol/alternative_patch_by_using_a_fake_cs_segment.patch)
# Change proc syscall for anticheat to work
(cd /builddir/wine || exit; patch -Np1 < /builddir/patches/lol/LoL-6.17+-syscall-fix.patch)
(cd /builddir/wine || exit; patch -Np1 < /builddir/patches/lol/LoL-broken-client-update-fix.patch)
# patches for garena windows or smth
(cd /builddir/wine || exit; patch -Np1 < /builddir/patches/lol/LoL-garena-childwindow.patch)
# sio_back_query
(cd /builddir/wine || exit; patch -Np1 < /builddir/patches/lol/LoL-launcher-client-connectivity-fix-0001-ws2_32-Return-a-valid-value-for-WSAIoctl-SIO_IDEAL_S.patch)


/builddir/wine/dlls/winevulkan/make_vulkan
/builddir/wine/tools/make_requests
(cd /builddir/wine || exit; autoreconf -f)

# Add your patches here:
# Sample:
#   # cd /builddir/wine && patch -Np1 < /builddir/patches/PATCHFOLDER/YOURPATCHHERE.patch
