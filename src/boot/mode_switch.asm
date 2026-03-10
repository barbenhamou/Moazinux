
%ifndef MODE_SWITCH_ASM
%define MODE_SWITCH_ASM

extern stack_top
extern PML4
extern low_level_func
global switch_protected_to_long
global switch_long_to_protected
global switch_protected_to_real
global switch_real_to_protected
global real_mode_testing

%include "src/boot/macros.asm"

section .rodata
%include "src/boot/gdt.asm"

section .text
bits 32
ivt:
    dw 0x03ff ; Limit  0 - 15
    dq 0 ; Base 16 - 89

bits 32
switch_protected_to_long:
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

    jmp GDT.code64:long_mode_entry

bits 64
long_mode_entry:
    and rsi, 0xffffffff
    push rsi
    ret

bits 64
switch_long_to_protected:
    pop rsi

    push GDT.code32
    push compatibility
    retfq

bits 32
compatibility:
    ; Disable paging
    mov eax, cr0
    and eax, ~(CR0_PAGING_ENABLED | CR0_WRITE_PROTECT)
    mov cr0, eax

    ; Clear Long mode bit in EFER
    mov ecx, EFER_MSR
    rdmsr
    and eax, ~LONG_MODE_BIT
    wrmsr

    ; Disable PAE
    mov eax, cr4
    and eax, ~PAE_MODE_BIT
    mov cr4, eax

    push esi
    ret

bits 32
switch_protected_to_real:
    pop esi
    cli
    jmp dword GDT.code16:REAL_MODE_ADDRESS(real_mode_entry)

bits 16
real_mode_entry:
    UpdateSelectors GDT.data16
    mov bx, REAL_MODE_ADDRESS(ivt)
    lidt [bx]

    ; Disable protected
    mov eax, cr0
    and eax, ~CR0_PROTECTED_ENABLED
    mov cr0, eax

    jmp word 0:REAL_MODE_ADDRESS(real_mode)

real_mode:
    UpdateSelectors 0
    push si
    ret

bits 16
switch_real_to_protected:
    pop si
    cli

    ; Enable protected.
    mov eax, cr0
    or eax, CR0_PROTECTED_ENABLED
    mov cr0, eax

    jmp dword GDT.code32:REAL_MODE_ADDRESS(protected_mode)

bits 32
    protected_mode:

    UpdateSelectors GDT.data32

    ; Returning the addr to stack.
    and esi, 0xffff
    push esi
    ret

bits 16
real_mode_testing:
    pusha
    pushf
    ; Software INT works with IF=0, but BIOS handlers may expect IRQs.
    sti

    mov si, REAL_MODE_ADDRESS(real_mode_test_msg)

.print_loop:
    lodsb
    test al, al
    jz .done
    mov ah, 0x0E
    mov bh, 0x00
    mov bl, 0x0F
    int 0x10
    jmp .print_loop

.done:
    popf
    popa
    ret

real_mode_test_msg db "16-bit BIOS test via INT 10h", 0

%endif
