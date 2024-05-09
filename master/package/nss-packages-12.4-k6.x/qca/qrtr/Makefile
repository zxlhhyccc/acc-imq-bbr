include $(TOPDIR)/rules.mk

PKG_NAME:=qrtr
PKG_RELEASE:=1

PKG_SOURCE_URL:=https://git.codelinaro.org/clo/qsdk/qrtr.git
PKG_SOURCE_PROTO:=git
PKG_SOURCE_DATE:=2019-07-25
PKG_SOURCE_VERSION:=cd6bedd5d00f211e6c1e3803ff2f9f53c246435e
PKG_MIRROR_HASH:=99e9dc9a9c70d9fa664eaeecf6efcdcc23ccbe93267e3f964429be5b9270e58e

include $(INCLUDE_DIR)/package.mk

define Package/qrtr
  SECTION:=utils
  CATEGORY:=Utilities
  TITLE:=QRTR tools
  DEPENDS:=@(TARGET_qualcommax)
endef

define Package/qrtr/description
	Set of QRTR related configuration and debugging tools.
endef

define Package/qrtr/install
	$(INSTALL_DIR) $(1)/usr/sbin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/qrtr-cfg $(1)/usr/sbin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/qrtr-lookup $(1)/usr/sbin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/qrtr-ns $(1)/usr/sbin
endef

$(eval $(call BuildPackage,qrtr))
