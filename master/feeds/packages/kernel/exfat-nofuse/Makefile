#
# Copyright (C) 2014 Bruno Randolf <br1@einfach.org>
# Copyright (C) 2019 Yousong Zhou <yszhou4tech@gmail.com>
# Copyright (C) 2020 [CTCGFW] Project OpenWrt
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk
include $(INCLUDE_DIR)/kernel.mk

PKG_NAME:=exfat-nofuse
PKG_RELEASE:=3

PKG_SOURCE_URL:=https://github.com/AdrianBan/exfat-nofuse.git
PKG_SOURCE_PROTO:=git
PKG_SOURCE_DATE:=2019-09-06
PKG_SOURCE_VERSION:=5536f067373c196f152061f5000fe0032dc07c48
PKG_MIRROR_HASH:=d0922e405f07e9c2f6971a089c90043c72991e926255815c12bf589c369af15b

PKG_MAINTAINER:=[CTCGFW] Project OpenWrt
PKG_LICENSE:=GPL-2.0
PKG_LICENSE_FILES:=LICENSE

include $(INCLUDE_DIR)/package.mk

define KernelPackage/fs-exfat0
	SUBMENU:=Filesystems
	TITLE:=ExFAT Kernel driver (deprecated)
	FILES:=$(PKG_BUILD_DIR)/exfat.ko
	AUTOLOAD:=$(call AutoLoad,30,exfat,1)
	DEPENDS:=+kmod-nls-base @(LINUX_4_14||LINUX_4_19)
endef

define KernelPackage/fs-exfat0/description
	Kernel module for ExFAT Filesytems
endef

define Build/Compile
	$(KERNEL_MAKE) \
		CONFIG_EXFAT_FS=m \
		M="$(PKG_BUILD_DIR)" \
		modules
endef

$(eval $(call KernelPackage,fs-exfat0))
