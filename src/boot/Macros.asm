%ifndef MACROS_ASM
%define MACROS_ASM

%define PML4 0x60000
%define PDPT 0x61000
%define PDT 0x62000
%define PT 0x63000

%define PAGE_PRESENT (1 << 0)
%define PAGE_RW (1 << 1)

%endif