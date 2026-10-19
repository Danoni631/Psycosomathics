msg_start_btn   db ' [ gui test ] ', 0
msg_win_title   db ' Build v00008 ', 0
msg_win_text    db ' sample :D ', 0
counter         dd 0
MouseX    dw 160
MouseY    dw 100
mousebmp  db 0x80, 0xC0, 0xE0, 0xF0, 0xF8, 0xFC, 0xFE, 0xF8, 0xDC, 0x8E, 0x06