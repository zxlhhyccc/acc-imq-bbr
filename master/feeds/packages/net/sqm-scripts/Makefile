#
# Copyright (C) 2014 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=sqm-scripts
#PKG_SOURCE_VERSION:=ab763cba8b1516b3afa99760e0ca884f8b8d93b8
PKG_SOURCE_VERSION:=be432c79f1e87a7ac14303580ac87549da225b69
PKG_VERSION:=1.4.0
PKG_RELEASE:=7

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://github.com/zxlhhyccc/sqm-scripts.git
#PKG_MIRROR_HASH:=44f59dd4c74c5f1634498c18e370c5185110be1084597df37773cecf306e3a24
PKG_MIRROR_HASH:=a1a4061301dfa63685b59261fa1fb483ad7100678d6f5117a106477f4bcac78f

PKG_MAINTAINER:=Toke Høiland-Jørgensen <toke@toke.dk>
PKG_LICENSE:=GPL-2.0-only

include $(INCLUDE_DIR)/package.mk

define Package/sqm-scripts
  SECTION:=net
  CATEGORY:=Base system
  DEPENDS:=+tc +kmod-sched-core +kmod-ifb +iptables \
	+iptables-mod-ipopt +iptables-mod-conntrack-extra \
	+!LINUX_4_14:kmod-sched-cake +LINUX_4_14:kmod-sched-cake-oot
  TITLE:=SQM Scripts (QoS)
  PKGARCH:=all
endef

define Package/sqm-scripts/description
 A set of scripts that does simple SQM configuration.
endef

define Package/sqm-scripts/conffiles
/etc/config/sqm
/etc/sqm/sqm.conf
endef

define Package/sqm-scripts/install
	make -C $(PKG_BUILD_DIR) DESTDIR=$(1) PLATFORM=openwrt install
endef

$(eval $(call BuildPackage,sqm-scripts))
