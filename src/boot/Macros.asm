%ifndef MACROS_ASM
%define MACROS_ASM

%define PML4 0x60000
%define PDPT 0x61000
%define PDT 0x62000
%define PT 0x63000

%define PAGE_PRESENT (1 << 0)
%define PAGE_RW (1 << 1)

%define PAE_MODE_BIT (1 << 5)
%define LONG_MODE_BIT (1 << 8)
%define EFER_MSR 0xC0000080

%define CR0_PAGING_ENABLED (1 << 31)
%define CR0_WRITE_PROTECT (1 << 16)

%endif