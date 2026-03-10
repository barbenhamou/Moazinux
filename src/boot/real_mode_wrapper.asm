global real_mode_wrapper
global low_level_func

%include "src/boot/macros.asm"

section .text
bits 64
real_mode_wrapper:
    mov rsi, REAL_MODE_ADDRESS(switch_long_to_protected)
    call rsi
bits 32
    mov esi, REAL_MODE_ADDRESS(switch_protected_to_real)
    call esi
bits 16
    pusha
    call di
    popa
    mov si, REAL_MODE_ADDRESS(switch_real_to_protected)
    call si
bits 32
    mov esi, REAL_MODE_ADDRESS(switch_protected_to_long)
    call esi
bits 64
    ret

low_level_func:
%include "src/boot/mode_switch.asm"
low_level_func_end:
