	section .data

	resultado db 0
	end db 10, 13


	section .text
	global _start


_start:
	mov ebx, 2
	mov ecx, 1
	mov eax, 4
	div ebx
	mul ecx

	add ax,48
	mov [resultado], ax

	mov eax,4
	mov ebx,1
	mov ecx, resultado
	mov edx, 1
	int 0x80

	mov eax, 1
	mov ebx, 0
	int 80h
	
	
