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

# issue with one of these
cd /builddir/wine && patch -Np1 < /builddir/patches/proton/01-proton-use_clock_monotonic.patch
cd /builddir/wine && patch -Np1 < /builddir/patches/proton/LAA-unix-staging.patch

# fsync esync patches
cd /builddir/wine && patch -Np1 < /builddir/patches/proton/esync-unix-mainline.patch

cd /builddir/wine && patch -Np1 < /builddir/patches/proton/40-proton-futex2.patch
cd /builddir/wine && patch -Np1 < /builddir/patches/proton/49-proton_QPC.patch
cd /builddir/wine && patch -Np1 < /builddir/patches/lol/lfh-non-proton-pre-needed.patch
cd /builddir/wine && patch -Np1 < /builddir/patches/proton/50-proton_LFH.patch
cd /builddir/wine && patch -Np1 < /builddir/patches/wine/hotfix-winelib.patch
cd /builddir/wine && patch -Np1 < /builddir/patches/wine/hotfix-iphlpapi-212361.patch
cd /builddir/wine && patch -Np1 < /builddir/patches/wine/hotfix-ntdll-socket-212770.patch
cd /builddir/wine && patch -Np1 < /builddir/patches/wine/hotfix-bf4_ping.patch

# Apply GE's league patches
# cd /builddir/wine && patch -Np1 < /builddir/patches/lol/
cd /builddir/wine && patch -Np1 < /builddir/patches/lol/alternative_patch_by_using_a_fake_cs_segment.patch
cd /builddir/wine && patch -Np1 < /builddir/patches/lol/0001-bodge-old-patch.patch

/builddir/wine/dlls/winevulkan/make_vulkan
/builddir/wine/tools/make_requests
cd /builddir/wine && autoreconf -f