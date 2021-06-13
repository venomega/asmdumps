	section .data
	
	msg db "Hola Mundo!",0xa,0xd, '$'
	msg_len equ $-msg-1
	
	section .text
	
	global _start

_start:
	mov eax, 4
	mov ebx, 1
	mov ecx, msg
	mov edx, msg_len
	
	int 0x80
	
	mov eax, 1
	int 0x80


	
