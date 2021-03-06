require directfb.inc

RV = "1.4-6"
PR = "r1"

DEPENDS += "sysfsutils"

SRC_URI = " \
    http://directfb.org/downloads/Core/DirectFB-1.4/DirectFB-${PV}.tar.gz \
    file://directfb-1.2.x-fix-pkgconfig-cflags.patch \
    "

EXTRA_OECONF = "\
  --enable-freetype=yes \
  --enable-zlib \
  --with-gfxdrivers=none \
  --disable-sdl \
  --disable-vnc \
  --disable-x11 \
"

LEAD_SONAME = "libdirectfb-1.4.so.6"

SRC_URI[md5sum] = "9b2b90b81d7ded2a4a5caa22daeb81ef"
SRC_URI[sha256sum] = "a40e640b53da9b2b155d98bf8cb1d173b01418c04b176768307adebefa0b78a8"
