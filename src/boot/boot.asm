extern paging_init
extern switch_protected_to_long
extern kmain
global start
global stack_top

section .stack
    align 0x1000
    stack_bottom:
        resb 0x4000   ; 16KB stack
    stack_top:


section .text
bits 32
start:
    mov esp, stack_top
    call paging_init
    call switch_protected_to_long
    
    bits 64
        mov rax, 0x2f592f412f4b2f4f
        mov qword [0xb8000], rax
        call kmain
        hlt 