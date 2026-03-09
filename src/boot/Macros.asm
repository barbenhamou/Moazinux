%ifndef MACROS_ASM
%define MACROS_ASM

%define PAGE_PRESENT (1 << 0)
%define PAGE_RW (1 << 1)

%define PAE_MODE_BIT (1 << 5)
%define LONG_MODE_BIT (1 << 8)
%define EFER_MSR 0xC0000080

%define CR0_PAGING_ENABLED (1 << 31)
%define CR0_WRITE_PROTECT (1 << 16)

; Page directory flags
%define PAGE_PS               (1 << 7)  ; Page Size (1 = 2MB page in PDT)

; GDT Access Byte Flags
%define GDT_ACCESS_P              (1 << 7)  ; Present
%define GDT_ACCESS_DPL0           (0 << 5)  ; Descriptor Privilege Level 0
%define GDT_ACCESS_DPL1           (1 << 5)  ; Descriptor Privilege Level 1
%define GDT_ACCESS_DPL2           (2 << 5)  ; Descriptor Privilege Level 2
%define GDT_ACCESS_DPL3           (3 << 5)  ; Descriptor Privilege Level 3
%define GDT_ACCESS_S              (1 << 4)  ; System (1 for code/data segments)
%define GDT_ACCESS_E              (1 << 3)  ; Executable
%define GDT_ACCESS_DC             (1 << 2)  ; Direction/Conforming
%define GDT_ACCESS_RW             (1 << 1)  ; Read/Write
%define GDT_ACCESS_A              (1 << 0)  ; Accessed

; GDT Flags
%define GDT_FLAG_G                (1 << 3)  ; Granularity
%define GDT_FLAG_DB               (1 << 2)  ; Default operation size (0=16-bit, 1=32-bit)
%define GDT_FLAG_L                (1 << 1)  ; Long mode (64-bit)

; Predefined Access Bytes
%define GDT_ACCESS_CODE64         (GDT_ACCESS_P | GDT_ACCESS_S | GDT_ACCESS_E | GDT_ACCESS_RW | GDT_ACCESS_A)
%define GDT_ACCESS_DATA64         (GDT_ACCESS_P | GDT_ACCESS_S | GDT_ACCESS_RW | GDT_ACCESS_A)
%define GDT_ACCESS_CODE32         (GDT_ACCESS_P | GDT_ACCESS_S | GDT_ACCESS_E | GDT_ACCESS_RW | GDT_ACCESS_A)
%define GDT_ACCESS_DATA32         (GDT_ACCESS_P | GDT_ACCESS_S | GDT_ACCESS_RW | GDT_ACCESS_A)
%define GDT_ACCESS_CODE16         (GDT_ACCESS_P | GDT_ACCESS_S | GDT_ACCESS_E | GDT_ACCESS_RW | GDT_ACCESS_A)
%define GDT_ACCESS_DATA16         (GDT_ACCESS_P | GDT_ACCESS_S | GDT_ACCESS_RW | GDT_ACCESS_A)

; Predefined Flags Bytes (flags << 4 | limit_high)
%define GDT_FLAGS_CODE64          (GDT_FLAG_L << 4 | 0x0f)
%define GDT_FLAGS_DATA64          ((0 << 4) | 0x0f)
%define GDT_FLAGS_CODE32          ((GDT_FLAG_G | GDT_FLAG_DB) << 4 | 0x0f)
%define GDT_FLAGS_DATA32          ((GDT_FLAG_G | GDT_FLAG_DB) << 4 | 0x0f)
%define GDT_FLAGS_CODE16          (GDT_FLAG_G << 4 | 0x0f)
%define GDT_FLAGS_DATA16          (GDT_FLAG_G << 4 | 0x0f)

; Note: All GDT descriptors are configured for kernel mode (DPL0 / ring 0).
; For user mode segments, DPL should be set to 3 (DPL3).

%macro UpdateSelectors 1
    mov ax, %1
    mov ss, ax
    mov ds, ax
    mov es, ax
    mov fs, ax
    mov gs, ax
%endmacro

%endif