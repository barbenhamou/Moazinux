extern stack_top
extern PML4
global ProtectedToLong

%include "src/boot/Macros.asm"

section .rodata
%include "src/boot/Gdt.asm"

section .text
bits 32
ProtectedToLong:
    ; caller pushed a 32-bit return address on the stack.  when we
    ; far-jump into 64-bit mode the stack pointer is unchanged, but the
    ; size of return addresses changes to 64 bits.  pop/push tricks let
    ; us save the 32-bit value and restore it after switching modes.
    pop esi

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

    lgdt [GDT.pointer]

    UpdateSelectors GDT.data64

    jmp GDT.code64:LongModeEntry

    bits 64
    LongModeEntry:
        mov rsp, stack_top
        push rsi
        ret