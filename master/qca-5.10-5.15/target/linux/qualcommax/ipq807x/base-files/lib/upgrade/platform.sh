PART_NAME=firmware
REQUIRE_IMAGE_METADATA=1

RAMFS_COPY_BIN='fw_printenv fw_setenv head'
RAMFS_COPY_DATA='/etc/fw_env.config /var/lock/fw_printenv.lock'

xiaomi_initramfs_prepare() {
	# Wipe UBI if running initramfs
	[ "$(rootfs_type)" = "tmpfs" ] || return 0

	local rootfs_mtdnum="$( find_mtd_index rootfs )"
	if [ ! "$rootfs_mtdnum" ]; then
		echo "unable to find mtd partition rootfs"
		return 1
	fi

	local kern_mtdnum="$( find_mtd_index ubi_kernel )"
	if [ ! "$kern_mtdnum" ]; then
		echo "unable to find mtd partition ubi_kernel"
		return 1
	fi

	ubidetach -m "$rootfs_mtdnum"
	ubiformat /dev/mtd$rootfs_mtdnum -y

	ubidetach -m "$kern_mtdnum"
	ubiformat /dev/mtd$kern_mtdnum -y
}

platform_check_image() {
	return 0;
}

platform_do_upgrade() {
	case "$(board_name)" in
	buffalo,wxr-5950ax12)
		CI_KERN_UBIPART="rootfs"
		CI_ROOT_UBIPART="user_property"
		buffalo_upgrade_prepare
		nand_do_flash_file "$1" || nand_do_upgrade_failed
		nand_do_restore_config || nand_do_upgrade_failed
		buffalo_upgrade_optvol
		;;
	dynalink,dl-wrx36)
		nand_do_upgrade "$1"
		;;
	edgecore,eap102)
		active="$(fw_printenv -n active)"
		if [ "$active" -eq "1" ]; then
			CI_UBIPART="rootfs2"
		else
			CI_UBIPART="rootfs1"
		fi
		# force altbootcmd which handles partition change in u-boot
		fw_setenv bootcount 3
		fw_setenv upgrade_available 1
		nand_do_upgrade "$1"
		;;
	compex,wpq873|\
	edimax,cax1800|\
	netgear,wax218)
		nand_do_upgrade "$1"
		;;
	zyxel,nbg7815|\
	prpl,haze|\
	qnap,301w)
		kernelname="0:HLOS"
		rootfsname="rootfs"
		mmc_do_upgrade "$1"
		;;
	redmi,ax6|\
	xiaomi,ax3600|\
	xiaomi,ax9000)
		part_num="$(fw_printenv -n flag_boot_rootfs)"
		if [ "$part_num" -eq "1" ]; then
			CI_UBIPART="rootfs_1"
			target_num=1
			# Reset fail flag for the current partition
			# With both partition set to fail, the partition 2 (bit 1)
			# is loaded
			fw_setenv flag_try_sys2_failed 0
		else
			CI_UBIPART="rootfs"
			target_num=0
			# Reset fail flag for the current partition
			# or uboot will skip the loading of this partition
			fw_setenv flag_try_sys1_failed 0
		fi

		# Tell uboot to switch partition
		fw_setenv flag_boot_rootfs $target_num
		fw_setenv flag_last_success $target_num

		# Reset success flag
		fw_setenv flag_boot_success 0

		nand_do_upgrade "$1"
		;;
	zte,mf269)
		CI_UBIPART="rootfs"
		nand_do_upgrade "$1"
		;;
	tplink,xtr10890)
		nand_do_upgrade "$1"
		;;
	*)
		default_do_upgrade "$1"
		;;
	esac
}
