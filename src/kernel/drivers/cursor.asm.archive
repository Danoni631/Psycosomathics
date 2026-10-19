DrawCursor:
    pusha
    mov dx, [MouseY]
    mov si, mousebmp
    mov di, 11
    mov bl, al       
.loopY:
    lodsb            
    mov bh, al       
    mov cx, [MouseX]
    mov bp, 8        
.loopX:
    test bh, 0x80
    jz .skip
    mov ah, 0x0C     
    mov al, bl       
    push bx
    xor bx, bx       
    int 0x10
    pop bx
.skip:
    inc cx
    shl bh, 1
    dec bp
    jnz .loopX
    inc dx
    dec di
    jnz .loopY
    popa
    ret