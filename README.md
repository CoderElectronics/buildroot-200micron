# Buildroot Package for 200micron Dev board
Opensource development package preconfigured and patched to run on the Allwinner F1c200s based 200micron Dev board by me.

## Driver support
Check this file to view current driver support progress for F1C100s/F1C200s: [PROGRESS-SUNIV.md](PROGRESS-SUNIV.md)
Check this file to view current driver support progress for V3/V3s/S3/S3L: [PROGRESS-V3.md](PROGRESS-V3.md)

## Install

### Install necessary packages
``` shell
sudo apt install rsync wget unzip build-essential git bc swig libncurses-dev libpython3-dev libssl-dev
sudo apt install python3-distutils
```

### Download BSP
**Notice: Root permission is not necessery for download or extract.**
```shell
git clone https://github.com/CoderElectronics/buildroot-200micron
```

## Make the first build
**Notice: Root permission is not necessery for build firmware.**

### Apply defconfig
**Caution: Apply defconfig will reset all buildroot configurations to default values.**

**Generally, you only need to apply it once.**
```shell
cd buildroot-200micron
make 200micron_r1_defconfig
```

### Regular build
Replace N with the number of CPU threads on the compiling computer.
```shell
make -jN
```

### If changed DTS or kenrel build
```shell
./rebuild-kernel.sh
```

### If changed Uboot, build
```shell
./rebuild-uboot.sh
```

## Flashing firmware to 200micron Rev 1
After building firmware, do the following with the 200micron plugged into your computer (both USB ports) and in FEL mode. (on a fresh board it is automatically in FEL mode, or hold MO test pad near flash IC to GND while plugging in)
```shell
sudo ./flashutils/linux/fel-uboot.sh
sudo ./flashutils/linux/dfu-nand-all.sh
```

## Helper Scripts
- rebuild-uboot.sh: Recompile U-Boot when you direct edit U-Boot sourcecode.
- rebuild-kernel.sh: Recompile Kernel when you direct edit Kernel sourcecode.
- emulate-chroot.sh: Emulate target rootfs by chroot.

## Helpful Buildroot commands
```shell
make menuconfig # buildroot packages
make linux-menuconfig # linux kernal config
```