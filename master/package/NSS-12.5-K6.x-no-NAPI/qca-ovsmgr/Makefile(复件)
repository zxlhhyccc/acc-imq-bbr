include $(TOPDIR)/rules.mk

PKG_NAME:=qca-ovsmgr
PKG_RELEASE:=1

PKG_SOURCE_URL:=https://git.codelinaro.org/clo/qsdk/oss/lklm/qca-ovsmgr.git
PKG_SOURCE_PROTO:=git
PKG_SOURCE_DATE:=2023-10-29
PKG_SOURCE_VERSION:=6c1fafc4fbdc28474d2199fa2bef6e10c89d2118
PKG_MIRROR_HASH:=fcab1461d9b3a63f0c87623d499d4d6426e19e52defaf3da98fc33b45853bbd2

PPKG_FLAGS:=nonshared
PKG_BUILD_PARALLEL:=1

include $(INCLUDE_DIR)/kernel.mk
include $(INCLUDE_DIR)/package.mk

define KernelPackage/qca-ovsmgr
  SECTION:=kernel
  CATEGORY:=Kernel modules
  SUBMENU:=Network Devices
  TITLE:=Kernel driver for NSS OpenVSwitch manager
  DEPENDS:=+kmod-openvswitch @!LINUX_3_18 \
	  @TARGET_ipq_ipq807x||TARGET_ipq_ipq807x_64||TARGET_ipq807x||TARGET_ipq807x_64||TARGET_qualcommax||TARGET_ipq_ipq60xx||TARGET_ipq_ipq60xx_64||TARGET_ipq60xx||TARGET_ipq60xx_64||TARGET_ipq_ipq806x||TARGET_ipq_ipq50xx||TARGET_ipq_ipq50xx_64||TARGET_ipq50xx||TARGET_ipq95xx||TARGET_ipq95xx_32
  FILES:=$(PKG_BUILD_DIR)/qca-ovsmgr.ko
  AUTOLOAD:=$(call AutoLoad,50,qca-ovsmgr)
endef

define KernelPackage/qca-ovsmgr/Description
Kernel module for NSS OpenVSwitch manager
endef

ifeq ($(CONFIG_TARGET_SUBTARGET), "ipq807x")
	SOC=ipq807x_64
	subtarget:=$(CONFIG_TARGET_SUBTARGET)
else ifeq ($(CONFIG_TARGET_BOARD), "ipq60xx")
	SOC=ipq60xx_64
	subtarget:=$(SUBTARGET)
endif

define Build/InstallDev
	$(INSTALL_DIR) $(1)/usr/include/qca-ovsmgr
	$(CP) $(PKG_BUILD_DIR)/exports/ovsmgr.h $(1)/usr/include/qca-ovsmgr/
endef

EXTRA_CFLAGS += -I$(LINUX_DIR)/net/openvswitch -I$(PKG_BUILD_DIR)/exports

define Build/Compile
	$(MAKE) -C "$(LINUX_DIR)" $(strip $(MAKE_OPTS)) \
		CROSS_COMPILE="$(TARGET_CROSS)" \
		ARCH="$(LINUX_KARCH)" \
		M="$(PKG_BUILD_DIR)" \
		EXTRA_CFLAGS="$(EXTRA_CFLAGS) -Wno-error=unused-function " \
		SoC="$(SOC)" \
		$(KERNEL_MAKE_FLAGS) \
		$(PKG_JOBS) \
		modules
endef

$(eval $(call KernelPackage,qca-ovsmgr))
