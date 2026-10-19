.print_start_btn:
    lodsb
    test al, al
    jz .draw_window
    mov [edi], ax
    add edi, 2
    jmp .print_start_btn

.draw_window:
    mov edi, 0xb8000 + (160 * 4) + (20 * 2)
    mov esi, msg_win_title
    mov ah, 0x3f

.print_wintitle:
    lodsb
    test al, al
    jz .draw_win_body
    mov [edi], ax
    add edi, 2
    jmp .print_wintitle

.draw_win_body:
    mov edx, 5
.win_row_loop:
    cmp edx, 15
    jge .render_status
    
    mov ebx, 10
.win_col_loop:
    cmp ebx, 50
    jge .next_win_row

    mov eax, edx
    imul eax, 160
    mov ecx, ebx
    shl ecx, 1
    add eax, ecx
    add eax, 0xb8000

    mov word [eax], 0x7020

    inc ebx
    jmp .win_col_loop

.next_win_row:
    inc edx
    jmp .win_row_loop

.render_status:
    mov edi, 0xb8000 + (160 * 6) + (24 * 2)
    mov esi, msg_win_text
    mov ah, 0x70
.print_win_txt:
    lodsb
    test al, al
    jz .main_loop_txt
    mov [edi], ax
    add edi, 2
    jmp .print_win_txt

.main_loop_txt:
    mov dword [counter], 0

.refresh_loop:
    mov edi, 0xb8000 + (160 * 8) + (24 * 2)
    mov eax, [counter]
    inc eax
    mov [counter], eax
    call print_eax_decimal

    mov ecx, 0x1FFFFFF
.delay:
    dec ecx
    jnz .delay

    jmp .refresh_loop

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