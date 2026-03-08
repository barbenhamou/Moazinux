default: run

.PHONY: default build run clean

CC      := gcc
AS      := nasm
LD      := ld
QEMU    := qemu-system-x86_64
GRUB    := grub-mkrescue

CFLAGS  := -ffreestanding -m64 -c
ASFLAGS := -f elf64
LDFLAGS := -n -T linker.ld

BUILD      := build
C_BUILD    := $(BUILD)/c
ASM_BUILD  := $(BUILD)/asm
ISO_BUILD  := $(BUILD)/isofiles

C_SOURCES   := $(wildcard src/*/*.c)
ASM_SOURCES := $(wildcard src/*/*.asm)

C_OBJECTS   := $(patsubst src/%.c,$(C_BUILD)/%.o,$(C_SOURCES))
ASM_OBJECTS := $(patsubst src/%.asm,$(ASM_BUILD)/%.o,$(ASM_SOURCES))
OBJECTS     := $(C_OBJECTS) $(ASM_OBJECTS)

KERNEL := $(BUILD)/kernel.bin
ISO    := $(BUILD)/os.iso

build: $(ISO)

run: $(ISO)
	$(QEMU) -cdrom $(ISO)

$(ISO): $(KERNEL) isofiles/boot/grub/grub.cfg
	mkdir -p $(ISO_BUILD)/boot/grub
	cp isofiles/boot/grub/grub.cfg $(ISO_BUILD)/boot/grub/
	cp $(KERNEL) $(ISO_BUILD)/boot/
	$(GRUB) -o $@ $(ISO_BUILD)

$(KERNEL): $(OBJECTS) linker.ld
	$(LD) $(LDFLAGS) -o $@ $(OBJECTS)

$(C_BUILD)/%.o: src/%.c
	mkdir -p $(dir $@)
	$(CC) $(CFLAGS) -o $@ $<

$(ASM_BUILD)/%.o: src/%.asm
	mkdir -p $(dir $@)
	$(AS) $(ASFLAGS) -o $@ $<

clean:
	rm -rf $(BUILD)