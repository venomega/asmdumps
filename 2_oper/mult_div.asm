;;; NASM x86
	section .data		;data section

	resultado db 0
	end db 10, 13


	section .text		;text section
	global _start


_start:
	mov ebx, 2		;set 2 to ebx
	mov ecx, 1		;set 1 to ecx
	mov eax, 4		;set 4 to eax
	div ebx			;eax = eax / ebx
	mul ecx			;eax = ecx * eax

	add eax,48		;eax = eax + 48
	mov [resultado], eax	;resultado = eax
	
	;; print to stdout resulado
	mov eax,4
	mov ebx,1
	mov ecx, resultado
	mov edx, 1
	int 0x80
	;; exit code 0
	mov eax, 1
	mov ebx, 0
	int 80h
	
	
