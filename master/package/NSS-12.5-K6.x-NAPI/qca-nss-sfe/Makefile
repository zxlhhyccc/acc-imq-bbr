#
# Copyright (c) 2013-2018, 2020 The Linux Foundation. All rights reserved.
# Permission to use, copy, modify, and/or distribute this software for
# any purpose with or without fee is hereby granted, provided that the
# above copyright notice and this permission notice appear in all copies.
# THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
# WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
# MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
# ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
# WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
# ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT
# OF OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=qca-nss-sfe
PKG_RELEASE:=1

PKG_SOURCE_URL:=https://git.codelinaro.org/clo/qsdk/oss/lklm/shortcut-fe.git
PKG_SOURCE_PROTO:=git
PKG_SOURCE_DATE:=2024-03-19
PKG_SOURCE_VERSION:=26ce422
PKG_MIRROR_HASH:=4a2709309585e43c1dfc07a0b2d698b6a27ac9466ff3f20f1e4cdbc7163e3890
QSDK_VERSION:=12.5.r2
PKG_VERSION:=$(QSDK_VERSION)-$(PKG_SOURCE_DATE)-$(PKG_SOURCE_VERSION)

include $(INCLUDE_DIR)/kernel.mk
include $(INCLUDE_DIR)/package.mk

define KernelPackage/qca-nss-sfe
  SECTION:=kernel
  CATEGORY:=Kernel modules
  SUBMENU:=Network Support
  DEPENDS:=@IPV6 +kmod-nf-conntrack +kmod-ppp +kmod-pppoe
  TITLE:=Kernel driver for SFE - QSDK 12.5.r2
  FILES:=$(PKG_BUILD_DIR)/qca-nss-sfe.ko
  KCONFIG:= \
	   CONFIG_NF_CONNTRACK_EVENTS=y \
	   CONFIG_NF_CONNTRACK_TIMEOUT=y \
	   CONFIG_QCA_NSS_SFE=y \
	   CONFIG_XFRM=y
  PROVIDES:=$(PKG_NAME)
  AUTOLOAD:=$(call AutoLoad,09,qca-nss-sfe)
endef

define KernelPackage/qca-nss-sfe/Description
Shortcut is an in-Linux-kernel IP packet forwarding engine.
endef

define KernelPackage/qca-nss-sfe/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) ./files/usr/bin/sfe_dump $(1)/usr/bin
endef

ifeq ($(CONFIG_IPV6),y)
SFE_MAKE_OPTS+=SFE_SUPPORT_IPV6=y
endif

SFE_MAKE_OPTS+= \
		SFE_GRE_TUN_ENABLE=y \
		SFE_PROCESS_LOCAL_OUT=y \
		SFE_BRIDGE_VLAN_FILTERING_ENABLE=y		

EXTRA_CFLAGS+= -I$(PKG_BUILD_DIR)/exports

define Build/Compile
	$(MAKE) -C "$(LINUX_DIR)" $(strip $(SFE_MAKE_OPTS)) \
		$(KERNEL_MAKE_FLAGS) \
		$(PKG_MAKE_FLAGS) \
		M="$(PKG_BUILD_DIR)" \
		EXTRA_CFLAGS="$(EXTRA_CFLAGS)" \
		modules
endef

# TODO: install dev
ifneq ($(CONFIG_PACKAGE_kmod-qca-nss-sfe),)
define Build/InstallDev
	$(INSTALL_DIR) $(1)/usr/include/qca-nss-sfe
	$(CP) -rf $(PKG_BUILD_DIR)/exports/sfe_api.h $(1)/usr/include/qca-nss-sfe
endef
endif

$(eval $(call KernelPackage,qca-nss-sfe))
