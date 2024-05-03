[org 0x00]
[bits 16]

section code

.main:
    mov eax, 0xb800
    mov es,  eax

    mov byte[es:0x00], 'H';
    mov byte[es:0x01], 0x30;

    jmp $

    times 510 - ($-$$) db 0x00;

    db 0x55
    db 0xaa