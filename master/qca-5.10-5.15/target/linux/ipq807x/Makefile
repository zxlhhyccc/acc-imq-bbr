include $(TOPDIR)/rules.mk

ARCH:=aarch64
BOARD:=ipq807x
BOARDNAME:=Qualcomm Atheros IPQ807x
FEATURES:=squashfs ramdisk fpu nand source-only
KERNELNAME:=Image dtbs
CPU_TYPE:=cortex-a53
SUBTARGETS:=generic

KERNEL_PATCHVER:=5.10
KERNEL_TESTING_PATCHVER:=5.15

include $(INCLUDE_DIR)/target.mk
DEFAULT_PACKAGES += \
	kmod-usb3 kmod-usb-dwc3 kmod-usb-dwc3-qcom \
	kmod-leds-gpio kmod-gpio-button-hotplug \
	ath11k-firmware-ipq8074 kmod-ath11k-ahb \
	autocore-arm htop wpad-openssl zram-swap \
	kmod-qca-nss-dp kmod-qca-nss-drv kmod-qca-nss-dp-64 \
	kmod-qca-nss-drv-pppoe kmod-qca-nss-ecm coremark \
	kmod-qca-nss-drv-bridge-mgr kmod-qca-drv-vlan-mgr nss-eip-firmware \
	nss-firmware-ipq8074 ath11k-board-ipq8074 qca-ssdk-shell kmod-qca-ssdk-nohnat kmod-qca-nss-crypto uboot-envtools

$(eval $(call BuildTarget))
