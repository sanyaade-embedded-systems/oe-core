DESCRIPTION = "Perl script that converts Texinfo to HTML"
HOMEPAGE    = "http://www.nongnu.org/texi2html/"
SECTION     = "console/utils"
LICENSE     = "GPLv2"
LIC_FILES_CHKSUM = "file://COPYING;md5=59530bdf33659b29e73d4adb9f9f6552"

PR = "r0"

SRC_URI     = "http://download.savannah.gnu.org/releases/texi2html/${P}.tar.bz2 \
               file://fix_gettext_version.patch"

SRC_URI[md5sum] = "f15ac876fcdc8be865b16535f480aa54"
SRC_URI[sha256sum] = "e8a98b0ee20c495a6ab894398a065ef580272dbd5a15b1b19e8bd1bc89d9f9fa"

inherit autotools gettext

do_configure_prepend() {
	# Make a directory for the old gettext setup
	mkdir ${S}/po
}

do_configure_append() {
	# Clean up the phony po directory
	rm -rf ${S}/po
}
