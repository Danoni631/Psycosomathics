[bits 16]
[ORG 0x7C00]

start:
    cli
    xor ax, ax
    mov ds, ax
    mov es, ax
    mov ss, ax
    mov sp, 0x7c00

    mov ax, 0x0003
    int 0x10

    lgdt [gdt_descriptor]

    mov eax, cr0
    or eax, 0x1
    mov cr0, eax

    jmp 0x08:kernel_main

%include "Psycosomathics/src/bootloader/gdt.asm"
%include "Psycosomathics/src/kernel/kernel.asm"

times 510 - ($ - $$) db 0x00
dw 0xAA55