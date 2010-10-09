# Common for Poky images
#
# Copyright (C) 2007 OpenedHand LTD

LIC_FILES_CHKSUM = "file://${POKYBASE}/LICENSE;md5=3f40d7994397109285ec7b81fdeb3b58 \
                    file://${POKYBASE}/meta/COPYING.MIT;md5=3da9cfbcb788c80a0384361b4de20420"

# IMAGE_FEATURES control content of images built with Poky.
# 
# By default we install task-poky-boot and task-base packages - this gives us
# working (console only) rootfs.
#
# Available IMAGE_FEATURES:
#
# - apps-console-core
# - x11-base          - X11 server + minimal desktop
# - x11-sato          - OpenedHand Sato environment
# - x11-netbook       - Metacity based environment for netbooks
# - apps-x11-core     - X Terminal, file manager, file editor
# - apps-x11-games
# - apps-x11-pimlico    - OpenedHand Pimlico apps
# - tools-sdk           - SDK
# - tools-debug         - debugging tools
# - tools-profile       - profiling tools
# - tools-testapps      - tools usable to make some device tests
# - nfs-server          - NFS server (exports / over NFS to everybody)
# - ssh-server-dropbear - SSH server (dropbear)
# - ssh-server-openssh  - SSH server (openssh)
# - dev                 - development packages
# - dbg                 - debug packages
#
PACKAGE_GROUP_apps-console-core = "task-poky-apps-console"
PACKAGE_GROUP_x11-base = "task-poky-x11-base"
PACKAGE_GROUP_x11-sato = "task-poky-x11-sato"
PACKAGE_GROUP_x11-netbook = "task-poky-x11-netbook"
PACKAGE_GROUP_apps-x11-core = "task-poky-apps-x11-core"
PACKAGE_GROUP_apps-x11-games = "task-poky-apps-x11-games"
PACKAGE_GROUP_apps-x11-pimlico = "task-poky-apps-x11-pimlico"
PACKAGE_GROUP_tools-debug = "task-poky-tools-debug"
PACKAGE_GROUP_tools-profile = "task-poky-tools-profile"
PACKAGE_GROUP_tools-testapps = "task-poky-tools-testapps"
PACKAGE_GROUP_tools-sdk = "task-poky-tools-sdk"
PACKAGE_GROUP_nfs-server = "task-poky-nfs-server"
PACKAGE_GROUP_package-management = "${ROOTFS_PKGMANAGE}"
PACKAGE_GROUP_qt4-pkgs = "task-poky-qt-demos"
PACKAGE_GROUP_ssh-server-dropbear = "task-poky-ssh-dropbear"
PACKAGE_GROUP_ssh-server-openssh = "task-poky-ssh-openssh"

POKY_BASE_INSTALL = '\
    task-poky-boot \
    task-base-extended \
    ${POKY_EXTRA_INSTALL} \
    '

POKY_EXTRA_INSTALL ?= ""

IMAGE_INSTALL ?= "${POKY_BASE_INSTALL}"

X11_IMAGE_FEATURES  = "x11-base apps-x11-core package-management"
ENHANCED_IMAGE_FEATURES = "${X11_IMAGE_FEATURES} apps-x11-games apps-x11-pimlico package-management"
SATO_IMAGE_FEATURES = "${ENHANCED_IMAGE_FEATURES} x11-sato ssh-server-dropbear"

inherit image

# Create /etc/timestamp during image construction to give a reasonably sane default time setting
ROOTFS_POSTPROCESS_COMMAND += "rootfs_update_timestamp ; "
