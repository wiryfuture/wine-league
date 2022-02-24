#!/bin/bash
####################################
# DESC
####################################
# Prepare fedora container for building wine

####################################
# PARAMS
####################################


####################################
# et al
####################################
# Install build tools, non-arch dependent
dnf groupinstall -y "C Development Tools and Libraries" "Development Tools"
dnf install -y git ccache
# shellcheck disable=SC2016
echo 'export PATH="/usr/lib/ccache:$PATH"' | tee -a ~/.bashrc

# Enable RPMFusion repo
dnf install -y https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-"$(rpm -E %fedora)".noarch.rpm

#   # Fusion deps
dnf install -y gstreamer1-devel gstreamer1-plugins-base-tools gstreamer1-doc gstreamer1-plugins-base-devel gstreamer1-plugins-good gstreamer1-plugins-good-extras gstreamer1-plugins-ugly gstreamer1-plugins-bad-free gstreamer1-plugins-bad-free-devel gstreamer1-plugins-bad-free-extras
#   # Regular Fedora deps
dnf install -y alsa-plugins-pulseaudio.x86_64 glibc-devel.x86_64 glibc-devel libgcc.x86_64 libX11-devel.x86_64 freetype-devel.x86_64 libXcursor-devel.x86_64 libXi-devel.x86_64 libXext-devel.x86_64 libXxf86vm-devel.x86_64 libXrandr-devel.x86_64 libXinerama-devel.x86_64 libXfixes-devel.x86_64 mesa-libGLU-devel.x86_64 mesa-libOSMesa-devel.x86_64 libXrender-devel.x86_64 libpcap-devel.x86_64 ncurses-devel.x86_64 libzip-devel.x86_64 lcms2-devel.x86_64 zlib-devel.x86_64 libv4l-devel.x86_64 libgphoto2-devel.x86_64  cups-devel.x86_64 libxml2-devel.x86_64 openldap-devel.x86_64 libxslt-devel.x86_64 gnutls-devel.x86_64 libpng-devel.x86_64 flac-libs.x86_64 json-c.x86_64 libICE.x86_64 libSM.x86_64 libXtst.x86_64 libasyncns.x86_64 libedit.x86_64 liberation-narrow-fonts.noarch libieee1284.x86_64 libogg.x86_64 libsndfile.x86_64 libuuid.x86_64 libva.x86_64 libvorbis.x86_64 libwayland-client.x86_64 libwayland-server.x86_64 llvm-libs.x86_64 mesa-dri-drivers.x86_64 mesa-filesystem.x86_64 mesa-libEGL.x86_64 mesa-libgbm.x86_64 nss-mdns.x86_64 ocl-icd.x86_64 pulseaudio-libs.x86_64  sane-backends-libs.x86_64 tcp_wrappers-libs.x86_64 unixODBC.x86_64 samba-common-tools.x86_64 samba-libs.x86_64 samba-winbind.x86_64 samba-winbind-clients.x86_64 samba-winbind-modules.x86_64 mesa-libGL-devel.x86_64 fontconfig-devel.x86_64 libXcomposite-devel.x86_64 libtiff-devel.x86_64 openal-soft-devel.x86_64 mesa-libOpenCL-devel.x86_64 opencl-utils-devel.x86_64 alsa-lib-devel.x86_64 gsm-devel.x86_64 libjpeg-turbo-devel.x86_64 pulseaudio-libs-devel.x86_64 pulseaudio-libs-devel gtk3-devel.x86_64 libattr-devel.x86_64 libva-devel.x86_64 libexif-devel.x86_64 libexif.x86_64 glib2-devel.x86_64 mpg123-devel.x86_64 mpg123-devel.x86_64 libcom_err-devel.x86_64 libcom_err-devel.x86_64 libFAudio-devel.x86_64 libFAudio-devel.x86_64 ocl-icd-devel.x86_64 mingw64-gcc.x86_64 libusb-devel.x86_64 systemd-devel.x86_64 SDL2-devel.x86_64 vulkan-loader-devel.x86_64 mesa-vulkan-devel.x86_64 vulkan-validation-layers-devel.x86_64 libvkd3d-devel.x86_64 libvkd3d-utils-devel.x86_64 libvkd3d-shader-devel.x86_64 libgcrypt-devel.x86_64 krb5-devel.x86_64 jxrlib-devel.x86_64

# Get 32 bit deps because we always have to build 32bit
#   # Fusion deps
dnf install -y gstreamer1-devel.i686 gstreamer1-plugins-base-devel.i686 gstreamer1-plugins-good.i686 gstreamer1-plugins-good-extras.i686 gstreamer1-plugins-ugly.i686 gstreamer1-plugins-bad-free.i686 gstreamer1-plugins-bad-free-devel.i686 gstreamer1-plugins-bad-free-extras.i686
#   # Regular Fedora deps
dnf install -y alsa-plugins-pulseaudio.i686 glibc-devel.i686 glibc-devel libgcc.i686 libX11-devel.i686 freetype-devel.i686 libXcursor-devel.i686 libXi-devel.i686 libX11-devel libXext-devel.i686 libXxf86vm-devel.i686 libXrandr-devel.i686 libXinerama-devel.i686 libXfixes-devel.i686 mesa-libGLU-devel.i686 mesa-libOSMesa-devel.i686 libXrender-devel.i686 libpcap-devel.i686 ncurses-devel.i686 libzip-devel.i686 lcms2-devel.i686 zlib-devel.i686 libv4l-devel.i686 libgphoto2-devel.i686  cups-devel.i686 libxml2-devel.i686 openldap-devel.i686 libxslt-devel.i686 gnutls-devel.i686 libpng-devel.i686 flac-libs.i686 json-c.i686 libICE.i686 libSM.i686 libXtst.i686 libasyncns.i686 libedit.i686 liberation-narrow-fonts.noarch libieee1284.i686 libogg.i686 libsndfile.i686 libuuid.i686 libva.i686 libvorbis.i686 libwayland-client.i686 libwayland-server.i686 llvm-libs.i686 mesa-dri-drivers.i686 mesa-filesystem.i686 mesa-libEGL.i686 mesa-libgbm.i686 nss-mdns.i686 ocl-icd.i686 pulseaudio-libs.i686  sane-backends-libs.i686 tcp_wrappers-libs.i686 unixODBC.i686 mesa-libGL-devel.i686 fontconfig-devel.i686 libXcomposite-devel.i686 libtiff-devel.i686 openal-soft-devel.i686 mesa-libOpenCL-devel.i686 opencl-utils-devel.i686 alsa-lib-devel.i686 gsm-devel.i686 libjpeg-turbo-devel.i686 pulseaudio-libs-devel.i686 pulseaudio-libs-devel gtk3-devel.i686 libattr-devel.i686 libva-devel.i686 libexif-devel.i686 libexif.i686 glib2-devel.i686 mpg123-devel.i686 mpg123-devel.i686 libcom_err-devel.i686 libcom_err-devel.i686 libFAudio-devel.i686 libFAudio-devel.i686 ocl-icd-devel.i686 mingw32-gcc	libusb-devel.i686 systemd-devel.i686 SDL2-devel.i686 vulkan-loader-devel.i686 mesa-vulkan-devel.i686 vulkan-validation-layers-devel.i686 libvkd3d-devel.i686 libvkd3d-utils-devel.i686 libvkd3d-shader-devel.i686 libgcrypt-devel.i686 krb5-devel.i686 jxrlib-devel.i686

# Add rpmsphere
dnf install -y https://github.com/rpmsphere/noarch/raw/master/r/rpmsphere-release-34-2.noarch.rpm
# Packaging deps
dnf install -y checkinstall

ln -s /usr/bin/ccache /usr/local/bin/gcc
ln -s /usr/bin/ccache /usr/local/bin/g++
ln -s /usr/bin/ccache /usr/local/bin/cc
ln -s /usr/bin/ccache /usr/local/bin/c++

# Create directories for wine source
mkdir -p /builddir/wine /builddir/out64 /builddir/out32 /builddir/patches /builddir/wine-staging /exports/out32 /exports/out64
