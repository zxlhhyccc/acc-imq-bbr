include $(TOPDIR)/rules.mk

PKG_NAME:=qca-mcs
PKG_RELEASE:=1

PKG_SOURCE_PROTO:=git
PKG_SOURCE_DATE:=2022-03-28
PKG_SOURCE_URL:=https://git.codelinaro.org/clo/qsdk/oss/lklm/qca-mcs.git
PKG_SOURCE_VERSION:=dd8a43859e3984e8552125b07b1cbd0d76e9e4c4
PKG_MIRROR_HASH:=941a3a720cd9d10df1f2057d920ea23a76c506fcbe41252cdda97233eba9164b

include $(INCLUDE_DIR)/kernel.mk
include $(INCLUDE_DIR)/package.mk

define KernelPackage/qca-mcs
  SECTION:=kernel
  CATEGORY:=Kernel modules
  SUBMENU:=Network Support
  TITLE:=QCA Multicast Snooping Support
  DEPENDS:=@(TARGET_ipq806x||TARGET_ipq807x)
  KCONFIG:= \
	CONFIG_NETFILTER=y \
	CONFIG_BRIDGE_NETFILTER=y
  FILES:=$(PKG_BUILD_DIR)/qca-mcs.ko
  AUTOLOAD:=$(call AutoLoad,52,qca-mcs)
endef

define KernelPackage/qca-mcs/description
  This package installs the IGMP/MLD Snooping Module
endef

QCA_MC_SNOOPING_HEADERS= \
            $(PKG_BUILD_DIR)/mc_api.h \
            $(PKG_BUILD_DIR)/mc_ecm.h \

define Build/InstallDev
	$(INSTALL_DIR) $(1)/usr/include/qca-mcs
	$(foreach header_file,$(QCA_MC_SNOOPING_HEADERS), $(CP) $(header_file) $(1)/usr/include/qca-mcs;)
	$(foreach header_file,$(QCA_MC_SNOOPING_HEADERS), $(CP) $(header_file) $(1)/usr/include/;)
endef

QCA_MC_SNOOPING_MAKE_OPTS:= \
        $(KERNEL_MAKE_FLAGS) \
        CONFIG_SUPPORT_MLD=y \
        MDIR=$(PKG_BUILD_DIR) \
        KBUILDPATH=$(LINUX_DIR) \
        KERNELPATH=$(LINUX_SRC_DIR) \
        KERNELRELEASE=$(LINUX_RELEASE)

define Build/Compile
	$(MAKE) -C $(LINUX_DIR) M=$(PKG_BUILD_DIR) $(strip $(QCA_MC_SNOOPING_MAKE_OPTS))
endef

$(eval $(call KernelPackage,qca-mcs))
