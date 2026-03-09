ENTRY(start)

SECTIONS {
    .paging 0x60000 (NOLOAD) :
    {
        *(.paging)
    }

    .stack 0x270000 (NOLOAD) :
    {
        *(.stack)
    }
    . = 0x280000;

    .boot :
    {
        /* ensure that the multiboot header is at the beginning */
        *(.multiboot_header)
    }

    .text :
    {
        *(.text)
    }

    /* read‑only data (strings, constants, GDT, etc.) */
    .rodata :
    {
        *(.rodata)
    }
}
