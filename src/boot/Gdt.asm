%ifndef GDT_ASM
%define GDT_ASM

%include "src/boot/Macros.asm"

GDT:
    .null:
        dq 0
    .code64: equ $ - GDT
        dw 0xffff ; Limit 0 - 15, defines the maximum addressable unit.
        dw 0 ; Base 16 - 31, defines the beginning of the segment.
        db 0 ; Base 32 - 39.
        db GDT_ACCESS_CODE64 ; Access byte 40 - 47, premissions and stuff, 1|00|1|1|0|1|1. 
        db GDT_FLAGS_CODE64 ; Limit 48 - 51, Flags 52 - 55, long mode flag is on, (0|0|1|0) | (1111).
        db 0 ; Base ; 56 - 63.
    .data64: equ $ - GDT
        dw 0xffff ; Limit 0 - 15, defines the maximum addressable unit.
        dw 0 ; Base 16 - 31, defines the beginning of the segment.
        db 0 ; Base 32 - 39.
        db GDT_ACCESS_DATA64 ;Access byte 40 - 47, premissions and stuff, 1|00|1|0|0|1|1. 
        db GDT_FLAGS_DATA64 ; Limit 48 - 51, Flags 52 - 55, long mode flag is on, (0|0|0|0) | (1111).
        db 0 ; Base 56 - 63.
    .code32: equ $ - GDT
        dw 0xffff ; Limit 0 - 15, defines the maximum addressable unit.
        dw 0 ; Base 16 - 31, defines the beginning of the segment.
        db 0 ; Base 32 - 39.
        db GDT_ACCESS_CODE32 ; Access byte 40 - 47, premissions and stuff, 1|00|1|1|0|1|1. 
        db GDT_FLAGS_CODE32 ; Limit 48 - 51, Flags 52 - 55, DB flag is on, (0|1|0|0) | (0000).
        db 0 ; Base ; 56 - 63.
    .data32: equ $ - GDT
        dw 0xffff ; Limit 0 - 15, defines the maximum addressable unit.
        dw 0 ; Base 16 - 31, defines the beginning of the segment.
        db 0 ; Base 32 - 39.
        db GDT_ACCESS_DATA32 ; Access byte 40 - 47, premissions and stuff, 1|00|1|0|0|1|1. 
        db GDT_FLAGS_DATA32 ; Limit 48 - 51, Flags 52 - 55, DB flag is on, (0|1|0|0) | (0000).
        db 0 ; Base ; 56 - 63.
    .code16: equ $ - GDT
        dw 0xffff ; Limit 0 - 15, defines the maximum addressable unit.
        dw 0 ; Base 16 - 31, defines the beginning of the segment.
        db 0 ; Base 32 - 39.
        db GDT_ACCESS_CODE16 ; Access byte 40 - 47, premissions and stuff, 1|00|1|1|0|1|1. 
        db GDT_FLAGS_CODE16 ; Limit 48 - 51, Flags 52 - 55, no flag is on, (0|0|0|0) | (1111).
        db 0 ; Base ; 56 - 63.
    .data16: equ $ - GDT
        dw 0xffff ; Limit 0 - 15, defines the maximum addressable unit.
        dw 0 ; Base 16 - 31, defines the beginning of the segment.
        db 0 ; Base 32 - 39.
        db GDT_ACCESS_DATA16 ; Access byte 40 - 47, premissions and stuff, 1|00|1|0|0|1|1. 
        db GDT_FLAGS_DATA16 ; Limit 48 - 51, Flags 52 - 55, no flag is on, (0|0|0|0) | (1111).
        db 0 ; Base ; 56 - 63.
    .pointer: 
        dw .pointer - GDT - 1 ; Size of GDT - 1.
        dq GDT ; Offset.

%endif