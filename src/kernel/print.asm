
print_eax_decimal:
    pusha
    mov ebx, 10
    mov ecx, 0
.div_loop:
    xor edx, edx
    div ebx
    push dx
    inc ecx
    test eax, eax
    jnz .div_loop

.pop_loop:
    pop ax
    add al, '0'
    mov ah, 0x74
    mov [edi], ax
    add edi, 2
    dec ecx
    jnz .pop_loop

    popa
    ret