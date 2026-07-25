include $(TOPDIR)/rules.mk

PKG_NAME:=qca-ovsmgr
PKG_SOURCE_URL:=https://git.codelinaro.org/clo/qsdk/oss/lklm/qca-ovsmgr.git
PKG_SOURCE_PROTO:=git
PKG_SOURCE_DATE:=2023-07-25
PKG_SOURCE_VERSION:=6c1fafc
PKG_MIRROR_HASH:=b72b4b1d3e3791ef1b33ee76f2589bc5209837863a3a6933996ac6dcb5c4f292
QSDK_VERSION:=12.4.5.r5
PKG_VERSION:=$(QSDK_VERSION)-$(PKG_SOURCE_DATE)-$(PKG_SOURCE_VERSION)

include $(INCLUDE_DIR)/kernel.mk
include $(INCLUDE_DIR)/package.mk

ifeq ($(CONFIG_TARGET_BOARD), "qualcommax")
  SoC:=$(CONFIG_TARGET_SUBTARGET)
else
  SoC:=$(CONFIG_TARGET_BOARD)
endif

define KernelPackage/qca-ovsmgr
  SECTION:=kernel
  CATEGORY:=Kernel modules
  SUBMENU:=Network Devices
  TITLE:=Kernel driver for NSS OpenVSwitch manager
  DEPENDS:=@TARGET_ipq807x||TARGET_ipq60xx||TARGET_qualcommax +kmod-openvswitch
  FILES:=$(PKG_BUILD_DIR)/qca-ovsmgr.ko
  AUTOLOAD:=$(call AutoLoad,50,qca-ovsmgr)
endef

define KernelPackage/qca-ovsmgr/Description
Kernel module for NSS OpenVSwitch manager
endef

define Build/InstallDev
	$(INSTALL_DIR) $(1)/usr/include/qca-ovsmgr
	$(CP) $(PKG_BUILD_DIR)/exports/ovsmgr.h $(1)/usr/include/qca-ovsmgr/
endef

EXTRA_CFLAGS += -I$(LINUX_DIR)/net/openvswitch -I$(PKG_BUILD_DIR)/exports

define Build/Compile
	+$(KERNEL_MAKE) $(strip $(MAKE_OPTS)) \
		M="$(PKG_BUILD_DIR)" \
		EXTRA_CFLAGS="$(EXTRA_CFLAGS)" \
		SoC="$(subtarget)" \
		modules
endef

$(eval $(call KernelPackage,qca-ovsmgr))
