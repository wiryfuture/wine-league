#!/bin/bash
####################################
# DESC
####################################
# Apply non-staging patches to wine source.

####################################
# et al
####################################
# Apply GloriousEggroll's wine and proton patches
#cd /builddir/wine && patch -Np1 < /builddir/patches/proton/
# monotonic clock
cd /builddir/wine && patch -Np1 < /builddir/patches/proton/01-proton-use_clock_monotonic.patch
# large address aware patch
cd /builddir/wine && patch -Np1 < /builddir/patches/proton/LAA-unix-staging.patch
# something to do with syscalls
cd /builddir/wine && patch -Np1 < /builddir/patches/proton/lfh-non-proton-pre-needed.patch
cd /builddir/wine && patch -Np1 < /builddir/patches/proton/0002-proton_LFH.mypatch

# League specific patches
# cd /builddir/wine && patch -Np1 < /builddir/patches/lol/
cd /builddir/wine && patch -Np1 < /builddir/patches/lol/alternative_patch_by_using_a_fake_cs_segment.patch
cd /builddir/wine && patch -Np1 < /builddir/patches/lol/LoL-6.19-fix.patch
cd /builddir/wine && patch -Np1 < /builddir/patches/lol/lol-update-fix.patch

# build vulkan cache and some wine tools or something
/builddir/wine/dlls/winevulkan/make_vulkan
/builddir/wine/tools/make_requests
cd /builddir/wine && autoreconf -f

# Apply my patches:
#cd /builddir/wine && patch -Np1 < /builddir/patches/cef/0001-pollfd-user-.revents-0.patch
