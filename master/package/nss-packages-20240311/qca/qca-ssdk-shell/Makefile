include $(TOPDIR)/rules.mk

PKG_NAME:=qca-ssdk-shell
PKG_RELEASE:=1

PKG_SOURCE_URL:=https://git.codelinaro.org/clo/qsdk/oss/ssdk-shell.git
PKG_SOURCE_PROTO:=git
PKG_SOURCE_DATE:=2023-11-14
PKG_SOURCE_VERSION:=5a3e1d6d72338d605e700cc083bf0f93e83d57cc
PKG_MIRROR_HASH:=45422a819a1569636e72cb841b2bb5b7e71c6831a89613587f6a75fc59401393

include $(INCLUDE_DIR)/kernel.mk
include $(INCLUDE_DIR)/package.mk

define Package/qca-ssdk-shell
  SECTION:=QCA
  CATEGORY:=Utilities
  TITLE:=Shell application for QCA SSDK
endef


define Package/qca-ssdk-shell/Description
  This package contains a qca-ssdk shell application for QCA chipset
endef

ifndef CONFIG_TOOLCHAIN_BIN_PATH
CONFIG_TOOLCHAIN_BIN_PATH=$(TOOLCHAIN_DIR)/bin
endif

QCASSDK_CONFIG_OPTS+= TOOL_PATH=$(CONFIG_TOOLCHAIN_BIN_PATH) \
                SYS_PATH=$(LINUX_DIR) \
                TOOLPREFIX=$(TARGET_CROSS) \
                KVER=$(LINUX_VERSION) \
                CFLAGS="$(TARGET_CFLAGS)" \
                LDFLAGS="$(TARGET_LDFLAGS)" \
                ARCH=$(LINUX_KARCH)

define Build/Compile
	$(MAKE) -C $(PKG_BUILD_DIR) $(PKG_JOBS) $(strip $(QCASSDK_CONFIG_OPTS))
endef

define Package/qca-ssdk-shell/install
	$(INSTALL_DIR) $(1)/usr/sbin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/build/bin/ssdk_sh $(1)/usr/sbin/
endef


$(eval $(call BuildPackage,qca-ssdk-shell))
