include $(TOPDIR)/rules.mk

PKG_NAME:=qca-nss-ecm
PKG_RELEASE:=$(AUTORELEASE)

PKG_SOURCE_URL:=https://git.codelinaro.org/clo/qsdk/oss/lklm/qca-nss-ecm.git
PKG_SOURCE_PROTO:=git
PKG_SOURCE_DATE:=2022-09-12
PKG_SOURCE_VERSION:=122b76a6179bf7e6649c80070c31cc355b045226
PKG_MIRROR_HASH:=9c542c04464a4ed9eedb97ccecbf211b0b038f7d1acb2c15a14c6a43e83cd131

PKG_BUILD_PARALLEL:=1

include $(INCLUDE_DIR)/kernel.mk
include $(INCLUDE_DIR)/package.mk

define KernelPackage/qca-nss-ecm
  SECTION:=kernel
  CATEGORY:=Kernel modules
  SUBMENU:=Network Support
  DEPENDS:=@(TARGET_ipq807x||TARGET_ipq60xx) \
  	+iptables-mod-extra \
	+iptables-mod-physdev \
  	+kmod-qca-nss-drv \
	+kmod-ipt-conntrack \
	+kmod-ipt-physdev \
	+kmod-ppp \
	+kmod-pppoe
  TITLE:=QCA NSS Enhanced Connection Manager (ECM)
  FILES:=$(PKG_BUILD_DIR)/*.ko
  KCONFIG:=CONFIG_BRIDGE_NETFILTER=y \
	CONFIG_NF_CONNTRACK_EVENTS=y \
	CONFIG_NF_CONNTRACK_CHAIN_EVENTS=y \
	CONFIG_NF_CONNTRACK_DSCPREMARK_EXT=y
endef

define KernelPackage/qca-nss-ecm/Description
This package contains the QCA NSS Enhanced Connection Manager
endef

define KernelPackage/qca-nss-ecm/install
	$(INSTALL_DIR) $(1)/etc/firewall.d $(1)/etc/init.d $(1)/usr/bin $(1)/lib/netifd/offload $(1)/etc/config $(1)/etc/uci-defaults $(1)/etc/sysctl.d
	$(INSTALL_DATA) ./files/qca-nss-ecm.firewall $(1)/etc/firewall.d/qca-nss-ecm
	$(INSTALL_BIN) ./files/qca-nss-ecm.init $(1)/etc/init.d/qca-nss-ecm
	$(INSTALL_BIN) ./files/ecm_dump.sh $(1)/usr/bin/
	$(INSTALL_BIN) ./files/on-demand-down $(1)/lib/netifd/offload/on-demand-down
	$(INSTALL_DATA) ./files/qca-nss-ecm.uci $(1)/etc/config/ecm
	$(INSTALL_DATA) ./files/qca-nss-ecm.defaults $(1)/etc/uci-defaults/99-qca-nss-ecm
	$(INSTALL_BIN) ./files/qca-nss-ecm.sysctl $(1)/etc/sysctl.d/qca-nss-ecm.conf
	echo 'net.netfilter.nf_conntrack_max=65535' >> $(1)/etc/sysctl.d/qca-nss-ecm.conf
endef

EXTRA_CFLAGS+=-I$(STAGING_DIR)/usr/include/qca-nss-drv

ifneq (, $(findstring $(CONFIG_TARGET_BOARD), "ipq807x" "ipq60xx"))
ECM_MAKE_OPTS:= ECM_IPV4_ENABLE=y \
		ECM_IPV6_ENABLE=y
ECM_MAKE_OPTS+= ECM_FRONT_END_NSS_ENABLE=y \
		ECM_FRONT_END_SFE_ENABLE=n \
		ECM_NON_PORTED_SUPPORT_ENABLE=y \
		ECM_MULTICAST_ENABLE=n \
		ECM_INTERFACE_BOND_ENABLE=n \
		ECM_INTERFACE_IPSEC_ENABLE=y \
		ECM_INTERFACE_PPTP_ENABLE=n \
		ECM_INTERFACE_PPPOE_ENABLE=y \
		ECM_INTERFACE_L2TPV2_ENABLE=n \
		ECM_INTERFACE_GRE_TAP_ENABLE=y \
		ECM_INTERFACE_GRE_TUN_ENABLE=y \
		ECM_INTERFACE_SIT_ENABLE=n \
		ECM_INTERFACE_TUN6RD_ENABLE=y \
		ECM_INTERFACE_TUNIPIP6_ENABLE=y \
		ECM_INTERFACE_RAWIP_ENABLE=n \
		ECM_INTERFACE_VLAN_ENABLE=y \
		ECM_INTERFACE_VXLAN_ENABLE=y \
		ECM_INTERFACE_WIFI_ENABLE=y \
		ECM_CLASSIFIER_HYFI_ENABLE=n \
		ECM_CLASSIFIER_MARK_ENABLE=n \
		ECM_CLASSIFIER_DSCP_ENABLE=n \
		ECM_CLASSIFIER_PCC_ENABLE=n \
		ECM_BAND_STEERING_ENABLE=n
endif

# Variant with additional features enabled for noload profile
define KernelPackage/qca-nss-ecm-noload
  $(call KernelPackage/qca-nss-ecm)
  TITLE+= (with noload features)
  PROVIDES:=kmod-qca-nss-ecm
  VARIANT:=noload
  DEPENDS+=+kmod-bonding
endef

define KernelPackage/qca-nss-ecm-noload/Description
  $(call KernelPackage/qca-nss-ecm/Description)
  When selected, this package installs the driver, but does not load it at init.
endef

define KernelPackage/qca-nss-ecm-noload/install
$(call KernelPackage/qca-nss-ecm/install, $(1))
	#
	# Remove the START line from the init script, so that the symlink
	# in the /etc/rc.d directory is not created.
	#
	sed -i '/START=/d' $(1)/etc/init.d/qca-nss-ecm
endef

ifeq ($(CONFIG_TARGET_BOARD), "ipq807x")
    SOC="ipq807x_64"
else ifeq ($(CONFIG_TARGET_BOARD), "ipq60xx")
    SOC="ipq60xx_64"
endif

define Build/InstallDev
	mkdir -p $(1)/usr/include/qca-nss-ecm
	$(CP) $(PKG_BUILD_DIR)/exports/* $(1)/usr/include/qca-nss-ecm
endef

define Build/Compile
	+$(MAKE) -C "$(LINUX_DIR)" $(strip $(ECM_MAKE_OPTS)) \
		CROSS_COMPILE="$(TARGET_CROSS)" \
		ARCH="$(LINUX_KARCH)" \
		M="$(PKG_BUILD_DIR)" \
		EXTRA_CFLAGS="$(EXTRA_CFLAGS) -Wno-error=unused-function " \
		SoC=$(SOC) \
		$(KERNEL_MAKE_FLAGS) \
		$(PKG_JOBS) \
		modules
endef

$(eval $(call KernelPackage,qca-nss-ecm))
$(eval $(call KernelPackage,qca-nss-ecm-noload))
