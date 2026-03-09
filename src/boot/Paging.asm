global InitalizePaging
global PML4
%include "src/boot/Macros.asm"

section .paging
    align 4096
    PML4:
        resq 512 ; 512 entries, each 8 bytes, total 4KB
    PDPT:
        resq 512 ; 512 entries, each 8 bytes, total 4KB
    PDT:
        resq 512 ; 512 entries, each 8 bytes, total 4KB

section .text
bits 32
InitalizePaging:

	; Point the first entry of the PML4 to the PDPT
	mov eax, PDPT
	or eax, PAGE_PRESENT | PAGE_RW
	mov dword [PML4 + 0], eax

	; Point the first entry of the PDPT to the PDT
	mov eax, PDT
	or eax, PAGE_PRESENT | PAGE_RW
	mov dword [PDPT + 0], eax

	; Map 512 * 2MB = 1GB with 2MB pages
	mov edi, 0  ; PDT index (0-511)
    MapPDT:
        ; Physical address for this 2MB page = edi * 0x200000
        mov eax, edi
        mov ebx, 0x200000  ; 2MB
        mul ebx            ; eax = edi * 0x200000
        or eax, PAGE_PRESENT | PAGE_RW | PAGE_PS  ; Enable 2MB page
        mov [PDT + edi * 8], eax

        inc edi
        cmp edi, 512
        jne MapPDT

    ret

    
