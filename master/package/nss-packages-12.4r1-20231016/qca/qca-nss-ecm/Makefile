include $(TOPDIR)/rules.mk

PKG_NAME:=qca-nss-ecm
PKG_RELEASE=1

PKG_SOURCE_URL:=https://git.codelinaro.org/clo/qsdk/oss/lklm/qca-nss-ecm.git
PKG_SOURCE_PROTO:=git
PKG_SOURCE_DATE:=2023-04-26
PKG_SOURCE_VERSION:=f9b52bfceedca844c61e2e3df2078be8ee736853
PKG_MIRROR_HASH:=16d6d10b9544be68758736dee1c0e5c616fb1cf406646fbdf3e7a8db3844e7b3

PKG_BUILD_PARALLEL:=1
PKG_FLAGS:=nonshared

include $(INCLUDE_DIR)/kernel.mk
include $(INCLUDE_DIR)/package.mk

define KernelPackage/qca-nss-ecm
  SECTION:=kernel
  CATEGORY:=Kernel modules
  SUBMENU:=Network Support
  DEPENDS:=@(TARGET_qualcommax||TARGET_ipq60xx) \
  		   +@NSS_DRV_IPV6_ENABLE \
		   +@NSS_DRV_PPE_ENABLE \
		   +@NSS_DRV_TUN6RD_ENABLE \
		   +@NSS_DRV_PPPOE_ENABLE \
		   +@NSS_DRV_PPTP_ENABLE \
		   +@NSS_DRV_VIRT_IF_ENABLE \
		   +@NSS_DRV_WIFI_ENABLE \
		   +iptables-mod-extra \
		   +kmod-ipt-conntrack \
		   +kmod-qca-nss-drv \
		   +kmod-nf-conntrack \
		   +kmod-ppp +kmod-pppoe +kmod-pptp +kmod-bonding \
		   +PACKAGE_kmod-pppol2tp:kmod-pppol2tp \
		   +PACKAGE_kmod-qca-mcs:kmod-qca-mcs \
		   +PACKAGE_kmod-qca-nss-sfe:kmod-qca-nss-sfe \
		   +PACKAGE_kmod-nat46:kmod-nat46 \
		   +PACKAGE_kmod-vxlan:kmod-vxlan
  TITLE:=QCA NSS Enhanced Connection Manager (ECM)
  FILES:=$(PKG_BUILD_DIR)/*.ko \
  		$(PKG_BUILD_DIR)/examples/ecm_ae_select.ko
  KCONFIG:=CONFIG_BRIDGE_NETFILTER=y \
		   CONFIG_NF_CONNTRACK_EVENTS=y \
		   CONFIG_NF_CONNTRACK_CHAIN_EVENTS=y \
		   CONFIG_NF_CONNTRACK_DSCPREMARK_EXT=y
endef

define KernelPackage/qca-nss-ecm/Description
This package contains the QCA NSS Enhanced Connection Manager
endef

define KernelPackage/qca-nss-ecm/install
	$(INSTALL_DIR) $(1)/etc/firewall.d $(1)/etc/init.d $(1)/usr/bin $(1)/lib/netifd/offload $(1)/etc/config $(1)/etc/uci-defaults $(1)/etc/sysctl.d $(1)/etc/hotplug.d/net
	$(INSTALL_DATA) ./files/qca-nss-ecm.firewall $(1)/etc/firewall.d/qca-nss-ecm
	$(INSTALL_BIN) ./files/qca-nss-ecm.init $(1)/etc/init.d/qca-nss-ecm
	$(INSTALL_BIN) ./files/ecm_dump.sh $(1)/usr/bin/
	$(INSTALL_BIN) ./files/disable_offloads.sh $(1)/usr/bin/
	$(INSTALL_BIN) ./files/on-demand-down $(1)/lib/netifd/offload/on-demand-down
	$(INSTALL_DATA) ./files/qca-nss-ecm.uci $(1)/etc/config/ecm
	$(INSTALL_DATA) ./files/qca-nss-ecm.defaults $(1)/etc/uci-defaults/99-qca-nss-ecm
	$(INSTALL_BIN) ./files/qca-nss-ecm.sysctl $(1)/etc/sysctl.d/qca-nss-ecm.conf
	$(INSTALL_BIN) ./files/disable_offloads.hotplug $(1)/etc/hotplug.d/net/99-disable_offloads
endef

EXTRA_CFLAGS+= \
		 -I$(STAGING_DIR)/usr/include/qca-nss-drv \
		 -I$(STAGING_DIR)/usr/include/qca-mcs \
		 -I$(STAGING_DIR)/usr/include/nat46 \
		 -I$(STAGING_DIR)/usr/include/qca-nss-sfe

ifneq (, $(findstring $(CONFIG_TARGET_BOARD), "qualcommax" "ipq60xx"))
ECM_MAKE_OPTS+=ECM_FRONT_END_NSS_ENABLE=y \
			   ECM_NON_PORTED_SUPPORT_ENABLE=y \
			   ECM_INTERFACE_BOND_ENABLE=y \
			   ECM_INTERFACE_VLAN_ENABLE=y \
			   ECM_CLASSIFIER_MARK_ENABLE=y \
			   ECM_CLASSIFIER_DSCP_ENABLE=y \
			   ECM_CLASSIFIER_PCC_ENABLE=n \
			   ECM_BAND_STEERING_ENABLE=n
endif

# Disable ECM IPv6 support when global IPv6 support is disabled.
ifneq ($(CONFIG_IPV6),)
ECM_MAKE_OPTS+=ECM_IPV6_ENABLE=y
endif

ifneq ($(CONFIG_PACKAGE_kmod-qca-nss-drv-ovpn-link),)
ECM_MAKE_OPTS+=ECM_INTERFACE_OVPN_ENABLE=y
endif

ifneq ($(CONFIG_PACKAGE_kmod-qca-nss-drv-vxlanmgr),)
ECM_MAKE_OPTS+=ECM_INTERFACE_VXLAN_ENABLE=y
endif

ifneq ($(CONFIG_PACKAGE_kmod-qca-ovsmgr),)
ECM_MAKE_OPTS+=ECM_INTERFACE_OVS_BRIDGE_ENABLE=y \
			   ECM_CLASSIFIER_OVS_ENABLE=y
EXTRA_CFLAGS+= -I$(STAGING_DIR)/usr/include/qca-ovsmgr
endif

ifneq ($(CONFIG_PACKAGE_kmod-macvlan),)
ECM_MAKE_OPTS+=ECM_INTERFACE_MACVLAN_ENABLE=y
endif

ifneq ($(CONFIG_PACKAGE_kmod-qca-mcs),)
ECM_MAKE_OPTS+=ECM_MULTICAST_ENABLE=y
endif

ifneq ($(CONFIG_PACKAGE_kmod-qca-nss-sfe),)
ECM_MAKE_OPTS+=ECM_FRONT_END_SFE_ENABLE=y
endif

ifneq ($(CONFIG_PACKAGE_kmod-nat46),)
ECM_MAKE_OPTS+=ECM_INTERFACE_MAP_T_ENABLE=y
endif

ifneq ($(CONFIG_PACKAGE_kmod-ipsec),)
ECM_MAKE_OPTS+=ECM_INTERFACE_IPSEC_ENABLE=y
endif

ifneq ($(CONFIG_PACKAGE_kmod-pppoe),)
ECM_MAKE_OPTS+=ECM_INTERFACE_PPPOE_ENABLE=y \
			   ECM_INTERFACE_PPTP_ENABLE=y \
			   ECM_INTERFACE_PPP_ENABLE=y
endif

ifneq ($(CONFIG_PACKAGE_kmod-pppol2tp),)
ECM_MAKE_OPTS+=ECM_INTERFACE_L2TPV2_ENABLE=y
endif

ifneq ($(CONFIG_PACKAGE_kmod-gre)$(CONFIG_PACKAGE_kmod-gre6),)
ECM_MAKE_OPTS+=ECM_INTERFACE_GRE_TAP_ENABLE=y \
			   ECM_INTERFACE_GRE_TUN_ENABLE=y
endif

ifneq ($(CONFIG_PACKAGE_kmod-sit),)
ECM_MAKE_OPTS+=ECM_INTERFACE_SIT_ENABLE=y
endif

ifneq ($(CONFIG_PACKAGE_kmod-ip6-tunnel),)
ECM_MAKE_OPTS+=ECM_INTERFACE_TUNIPIP6_ENABLE=y
endif

ifneq ($(CONFIG_PACKAGE_kmod-qca-nss-drv-mscs),)
ECM_MAKE_OPTS+=ECM_CLASSIFIER_MSCS_ENABLE=y
endif

define Build/InstallDev
	mkdir -p $(1)/usr/include/qca-nss-ecm
	$(CP) $(PKG_BUILD_DIR)/exports/* $(1)/usr/include/qca-nss-ecm
endef

ifeq ($(CONFIG_TARGET_BOARD), "qualcommax")
    SOC:=$(CONFIG_TARGET_SUBTARGET)
else ifeq ($(CONFIG_TARGET_BOARD), "ipq60xx")
    SOC="ipq60xx_64"
endif

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
