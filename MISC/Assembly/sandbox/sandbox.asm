; filename: sandbox.asm
; author: gsharp@2020
; date:  2020-11-08
; This is a template for assembly code
; Enjoy it
; =====================================
; MAKE
; nasm -f elf -g -F stabs sandbox.asm
; ld -m elf_i386 -o sandbox sandbox.o
; ====================================
;
; ====================================

SECTION .data ; For Data
; Input data here

; ====================================

; ====================================

SECTION .text ; For Text

global _start

_start:
    nop
	;Input code here
	nop
	call exit
exit:
	mov eax, 1
	mov ebx, 0
	int 80H
; ====================================
; ====================================
SECTION .bss
; ====================================
