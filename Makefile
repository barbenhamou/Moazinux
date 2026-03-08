default: run

.PHONY: default build run clean

# tools

NASM := nasm
LD := ld
QEMU := qemu-system-x86_64
GRUB := grub-mkrescue

# directories

SRC := src/boot
BUILD := build
ISO := $(BUILD)/isofiles

# files

KERNEL := $(BUILD)/kernel.bin
OBJS := $(BUILD)/MultibootHeader.o $(BUILD)/boot.o

# build objects

$(BUILD)/MultibootHeader.o: $(SRC)/MultibootHeader.asm
	mkdir -p $(BUILD)
	$(NASM) -f elf64 $< -o $@

$(BUILD)/boot.o: $(SRC)/boot.asm
	mkdir -p $(BUILD)
	$(NASM) -f elf64 $< -o $@

# link kernel

$(KERNEL): $(OBJS) linker.ld
	$(LD) -n -T linker.ld -o $@ $(OBJS)

# build iso

$(BUILD)/os.iso: $(KERNEL)
	mkdir -p $(ISO)/boot/grub
	cp isofiles/boot/grub/grub.cfg $(ISO)/boot/grub/
	cp $(KERNEL) $(ISO)/boot/
	$(GRUB) -o $@ $(ISO)

build: $(BUILD)/os.iso

run: build
	$(QEMU) -cdrom $(BUILD)/os.iso

clean:
	rm -rf $(BUILD)
