	section .data
	resultado db 0
	
	section .text
	global _start


_start:

	mov eax, 12
	mov ebx, 24

	add eax,ebx

	add eax, 48
	mov [resultado], eax

	mov eax, 4
	mov ebx, 1
	mov ecx, resultado
	mov edx, 1

	int 80h

	mov eax, 1
	mov ebx, 0
	int 80h
	