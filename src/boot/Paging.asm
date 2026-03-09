global InitalizePaging

%define PML4 0x60000
%define PDPT 0x61000
%define PDT 0x62000
%define PT 0x63000

%define PAGE_PRESENT (1 << 0)
%define PAGE_RW (1 << 1)

section .text
bits 32
InitalizePaging:

	; Point the first entry of the PML4 to the first entry in the PDPT
	mov eax, PDPT
	or eax, PAGE_PRESENT | PAGE_RW
	mov dword [PML4 + 0], eax

	; Point the first entry of the PDPT to the first entry in the PDT
	mov eax, PDT
	or eax, PAGE_PRESENT | PAGE_RW
	mov dword [PDPT + 0], eax

	; Map 1 GB: Set up PDT entries to point to PT tables, and fill each PT with 4KB pages
	mov edi, 0  ; PDT index (0-511)
    MapPDT:
        ; Point PDT[edi] to the corresponding PT table
        mov eax, PT
        add eax, edi
        shl eax, 12  ; Multiply by 0x1000 (PT table size)
        or eax, PAGE_PRESENT | PAGE_RW
        mov [PDT + edi * 8], eax

        ; Now fill the PT table for this PDT entry
        mov esi, 0  ; PT index (0-511)
        MapPT:
            ; Calculate physical address: (edi * 512 + esi) * 0x1000
            mov eax, edi
            mov ebx, 512
            mul ebx      ; eax = edi * 512
            add eax, esi ; eax = edi*512 + esi
            mov ebx, 0x1000
            mul ebx      ; eax = (edi*512 + esi) * 0x1000
            or eax, PAGE_PRESENT | PAGE_RW
            ; Store in PT[edi][esi]
            mov ebx, PT
            add ebx, edi
            shl ebx, 12  ; PT base for this edi
            mov [ebx + esi * 8], eax

            inc esi
            cmp esi, 512
            jne MapPT

        inc edi
        cmp edi, 512
        jne MapPDT

    ret

    
