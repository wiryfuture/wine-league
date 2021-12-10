#!/bin/sh
####################################
# DESC
####################################
# Apply non-staging patches to wine source.

####################################
# et al
####################################
# Apply GloriousEggroll's wine and proton patches
# cd /builddir/wine && patch -Np1 < /builddir/patches/proton/
cd /builddir/wine && patch -Np1 < /builddir/patches/wine/imm32-com-initialization_no_net_active_window.patch
cd /builddir/wine && patch -Np1 < /builddir/patches/proton/01-proton-use_clock_monotonic.patch
cd /builddir/wine && patch -Np1 < /builddir/patches/proton/04-proton-LAA_staging.patch
cd /builddir/wine && patch -Np1 < /builddir/patches/proton/03-proton-fsync_staging.patch
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
cd /builddir/wine && patch -Np1 < /builddir/patches/lol/LoL-6.15-fix.patch

# Apply my patches (testing)
# cd /builddir/wine && patch -Np1 < /builddir/patches/
cd /builddir/wine && patch -Np1 < /builddir/patches/isb.patch
cd /builddir/wine && patch -Np1 < /builddir/patches/0005-try-decrease-number-of-unecessary-resets.patch
cd /builddir/wine && patch -Np1 < /builddir/patches/0003-this-is-wrong-but-what-if-we-just-ignore-this-lol.patch
cd /builddir/wine && patch -Np1 < /builddir/patches/0001-remove-ret-values-from-getaddrinfoexw-so-handle-happ.patch
cd /builddir/wine && patch -Np1 < /builddir/patches/0001-Hope-I-haven-t-broken-the-dns-api.patch
cd /builddir/wine && patch -Np1 < /builddir/patches/0002-fix-patch.patch