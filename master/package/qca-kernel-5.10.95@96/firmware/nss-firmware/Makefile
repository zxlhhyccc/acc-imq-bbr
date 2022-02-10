include $(TOPDIR)/rules.mk

PKG_NAME:=nss-firmware
PKG_VERSION:=383

PKG_MAINTAINER:=John Crispin <john@phrozen.org>

include $(INCLUDE_DIR)/package.mk

define Package/nss-firmware-default
  SECTION:=firmware
  CATEGORY:=Firmware
  URL:=$(PKG_SOURCE_URL)
  DEPENDS:=
endef

define Package/nss-firmware-ipq8074
$(Package/nss-firmware-default)
  TITLE:=NSS firmware for IPQ8074 devices
endef

define Build/Compile

endef

define Package/nss-firmware-ipq8074/install
	$(INSTALL_DIR) $(1)/lib/firmware/
	$(INSTALL_DATA) ./files/IPQ8074/* \
		$(1)/lib/firmware/
endef

$(eval $(call BuildPackage,nss-firmware-ipq8074))
