all: bootloader

bootloader:
	nasm boot/boot.asm -o boot/boot.img

clear:
	rm -f boot/boot.img

run:
	qemu-system-x86_64 ./boot/boot.img