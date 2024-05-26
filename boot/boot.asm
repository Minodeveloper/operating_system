.print_main:
    mov dl, byte [eax + ebx]
    
    cmp dl, 0
    je .print_end
    
    mov byte [es:ecx], dl

    inc ebx
    inc ecx
    inc ecx
    
    jmp .print_main

.print_end:
    ret

.switch:
    cli ; Turh off the interrupts
    lgdt [gdt_descriptor] ; Load the GDT Table

    mov eax, cr0
    or eax, 0x1
    mov cr0, eax ; Make the switch

    jmp protected_start

welcome: db 'Welcome to SaphireOS.', 0

[bits 32]
protected_start:
    mov ax, data_seg
    mov ds, ax
    mov ss, ax
    mov es, ax
    mov fs, ax
    mov gs, ax

    ; Update the stack pointer
    mov ebp, 0x90000
    mov esp, ebp

    jmp $

gdt_begin:
gdt_null_descriptor:
    dd 0x00
    dd 0x00
gdt_code_seg:
    dw 0xffff
    dw 0x00
    db 0x00
    db 10011010b
    db 11001111b
    db 0x00
gdt_data_seg:
    dw 0xffff
    dw 0x00
    db 0x00
    db 10010010b
    db 11001111b
    db 0x00
gdt_end:
gdt_descriptor:
    dw gdt_end - gdt_begin - 1
    dd gdt_begin

code_seg equ gdt_code_seg - gdt_begin
data_seg equ gdt_data_seg - gdt_begin

times 510 - ($ - $$) db 0x00 ; Pads the file with 0s, making the file the right size

db 0x55
db 0xaa