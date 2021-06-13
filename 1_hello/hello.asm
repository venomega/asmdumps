	;; NASM x86
	
	section .data		;begin of data section
	
	msg db "Hola Mundo!",0xa,0xd, '$' ;declare a msg variable with 1byte data width
	msg_len equ $-msg-1		  ;declare a mas_len as a variable containing len of someone else
	
	section .text		;begin of text section
	
	global _start		;this tell the compiler where to start

_start:				;this is a segment code label


	;; this put an interrupt to print to stdout a msg with a len of msg_len
	mov eax, 4
	mov ebx, 1
	mov ecx, msg
	mov edx, msg_len
	int 0x80

	;; this tell that the exit code is 0
	mov eax, 1
	mov ebx, 0
	int 0x80


	
