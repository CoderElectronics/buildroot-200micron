build-uboot:
	./rebuild-uboot.sh
	make -j12

build-linux:
	./rebuild-linux.sh
	make -j12

build:
	make -j12

flash:
	sudo ./flashutils/linux/fel-uboot.sh
	sudo ./flashutils/linux/dfu-nand-all.sh

flashfast:
	sudo ./flashutils/linux/fel-uboot.sh
	sudo ./flashutils/linux/dfu-nand-fast.sh

updateconf:
	make savedefconfig BR2_DEFCONFIG=board/200micron/r1/200micron_r1_defconfig
