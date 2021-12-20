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
# something to do with memory management idk
cd /builddir/wine && patch -Np1 < /builddir/patches/lol/lfh-non-proton-pre-needed.patch
# I have no idea what this does
cd /builddir/wine && patch -Np1 < /builddir/patches/wine/hotfix-iphlpapi-212361.patch

# League specific patches
# cd /builddir/wine && patch -Np1 < /builddir/patches/lol/
cd /builddir/wine && patch -Np1 < /builddir/patches/lol/alternative_patch_by_using_a_fake_cs_segment.patch
cd /builddir/wine && patch -Np1 < /builddir/patches/lol/0001-bodge-old-patch.patch
# build vulkan cache and some wine tools or something
/builddir/wine/dlls/winevulkan/make_vulkan
/builddir/wine/tools/make_requests
cd /builddir/wine && autoreconf -f

# Apply my patches:
cd /builddir/wine && patch -Np1 < /builddir/patches/cef/0001-pollfd-user-.revents-0.patch
