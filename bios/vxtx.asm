; Copyright (c) 2019-2022 Andreas T Jonsson
; 
; This software is provided 'as-is', without any express or implied
; warranty. In no event will the authors be held liable for any damages
; arising from the use of this software.
; 
; Permission is granted to anyone to use this software for any purpose,
; including commercial applications, and to alter it and redistribute it
; freely, subject to the following restrictions:
; 
; 1. The origin of this software must not be misrepresented; you must not
;    claim that you wrote the original software. If you use this software
;    in a product, an acknowledgment in the product documentation would be
;    appreciated but is not required.
; 2. Altered source versions must be plainly marked as such, and must not be
;    misrepresented as being the original software.
; 3. This notice may not be removed or altered from any source distribution.

cpu 8086
org 0

db 0x55             ; The BIOS...
db 0xAA             ; Signature!
db 0x4              ; We're a 2k ROM(4*512 bytes)
jmp short init

init:
    pushf
    cli         ; We don't want to be interrupted now!

    call install_handlers

    popf
    retf

int_13_handler:
    out 0xB1, al

    push ax
    
    pushf
    pop ax

    push bp
    mov bp, sp
    mov [bp+8], ax
    pop bp

    pop ax

    iret

install_handlers:
    push ds
    push ax

    mov ax,0
    mov ds,ax   ; Point DS to the IVT

    ; Set up our own vectors!
    mov word [INT_13_OFFSET], int_13_handler
    mov [INT_13_OFFSET+2], cs

    pop ax
    pop ds
    ret

;;;;;;;;;;;;;;;;;; Data ;;;;;;;;;;;;;;;;;;

INT_13_OFFSET  equ 0x4C
db 'VXTX - VirtualXT BIOS Extensions', 0xA
db 'This work is licensed under the zlib license.', 0

times 0x7FF-($-$$) db 0
checksum db 0
