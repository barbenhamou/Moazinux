global ProtectedToLong

%include "src/boot/Macros.asm"

section .text
bits 32
ProtectedToLong:

    ; Pointing cr3 to PML4
    mov eax, PML4
    mov cr3, eax

    ; Enable PAE and Long Mode in EFER
    mov eax, cr4
    or eax, PAE_MODE_BIT
    mov cr4, eax

    ; Long mode bit
    mov ecx, EFER_MSR
    rdmsr
    or eax, LONG_MODE_BIT
    wrmsr

    ; Enable paging
    mov eax, cr0
    or eax, CR0_PAGING_ENABLED | CR0_WRITE_PROTECT
    mov cr0, eax
    ret