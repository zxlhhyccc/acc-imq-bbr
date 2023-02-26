PART_NAME=firmware
REQUIRE_IMAGE_METADATA=1

RAMFS_COPY_BIN='fw_printenv fw_setenv head'
RAMFS_COPY_DATA='/etc/fw_env.config /var/lock/fw_printenv.lock'

platform_check_image() {
	return 0;
}

platform_do_upgrade() {
	case "$(board_name)" in
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
	edimax,cax1800)
		nand_do_upgrade "$1"
		;;
	qnap,301w)
		kernelname="0:HLOS"
		rootfsname="rootfs"
		mmc_do_upgrade "$1"
		;;
	zyxel,nbg7815)
		local config_mtdnum="$(find_mtd_index 0:bootconfig)"
		[ -z "$config_mtdnum" ] && reboot
		part_num="$(hexdump -e '1/1 "%01x|"' -n 1 -s 168 -C /dev/mtd$config_mtdnum | cut -f 1 -d "|" | head -n1)"
		if [ "$part_num" -eq "0" ]; then
			kernelname="0:HLOS"
			rootfsname="rootfs"
			mmc_do_upgrade "$1"
		else
			kernelname="0:HLOS_1"
			rootfsname="rootfs_1"
			mmc_do_upgrade "$1"
		fi
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
