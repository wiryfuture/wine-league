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
cd /builddir/wine && patch -Np1 < /builddir/patches/proton/01-proton-use_clock_monotonic.patch
# large address aware patch | more memory can be used
cd /builddir/wine && patch -Np1 < /builddir/patches/proton/04-proton-LAA_staging.patch
# esync patch | lets you use esync
cd /builddir/wine && patch -Np1 < /builddir/patches/proton/03-proton-fsync_staging.patch
# proton patches that improve performance
cd /builddir/wine && patch -Np1 < /builddir/patches/proton/40-proton-futex2.patch
cd /builddir/wine && patch -Np1 < /builddir/patches/proton/49-proton_QPC.patch
cd /builddir/wine && patch -Np1 < /builddir/patches/lol/lfh-non-proton-pre-needed.patch # needed for league for some reason
cd /builddir/wine && patch -Np1 < /builddir/patches/proton/50-proton_LFH.patch
cd /builddir/wine && patch -Np1 < /builddir/patches/wine/hotfix-winelib.patch
cd /builddir/wine && patch -Np1 < /builddir/patches/wine/hotfix-iphlpapi-212361.patch
cd /builddir/wine && patch -Np1 < /builddir/patches/wine/hotfix-ntdll-socket-212770.patch
cd /builddir/wine && patch -Np1 < /builddir/patches/wine/hotfix-bf4_ping.patch

# Apply GE's league patche
cd /builddir/wine && patch -Np1 < /builddir/patches/lol/alternative_patch_by_using_a_fake_cs_segment.patch
cd /builddir/wine && patch -Np1 < /builddir/patches/lol/LoL-6.15-fix.patch

/builddir/wine/dlls/winevulkan/make_vulkan
/builddir/wine/tools/make_requests
cd /builddir/wine && autoreconf -f

# Add your patches here:
# Sample:
#   # cd /builddir/wine && patch -Np1 < /builddir/patches/PATCHFOLDER/YOURPATCHHERE.patch