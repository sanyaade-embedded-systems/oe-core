SUMMARY = "File classification tool"
DESCRIPTION = "File attempts to classify files depending \
on their contents and prints a description if a match is found."
HOMEPAGE = "http://www.darwinsys.com/file/"
SECTION = "console/utils"

# two clause BSD
LICENSE = "BSD"
LIC_FILES_CHKSUM = "file://COPYING;beginline=2;md5=6a7382872edb68d33e1a9398b6e03188"

DEPENDS = "zlib file-native"
DEPENDS_virtclass-native = "zlib-native"
PR = "r0"

SRC_URI = "ftp://ftp.astron.com/pub/file/file-${PV}.tar.gz \
           file://fix_version_check.patch \
           file://dump \
           file://filesystems"

SRC_URI[md5sum] = "4cea34b087b060772511e066e2038196"
SRC_URI[sha256sum] = "73ae51889006b1ddb95db729237d411eb8d353884dfb149f0b4427d314aff68a"

inherit autotools

do_configure_prepend() {
	cp ${WORKDIR}/dump ${S}/magic/Magdir/
	cp ${WORKDIR}/filesystems ${S}/magic/Magdir/
}

FILES_${PN} += "${datadir}/misc/*.mgc"

do_install_append_virtclass-native() {
	create_cmdline_wrapper ${D}/${bindir}/file \
		--magic-file ${datadir}/misc/magic.mgc
}


BBCLASSEXTEND = "native"
