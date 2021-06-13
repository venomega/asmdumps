;;; NASM x86
	section .data		;data section
	resultado db 0		;create a resultado var
	
	section .text		;text section
	global _start		;tells compiler where to start 


_start:				;the start label

	mov eax, 12		;set eax to 12
	mov ebx, 24		;set ebx to 24

	add eax,ebx		;add eax to ebx and store the result on eax

	add eax, 48		;add 48 to eax and store the result on eax
	mov [resultado], eax 	;put eax on resultado var

	;; print to stdout resultado
	mov eax, 4
	mov ebx, 1
	mov ecx, resultado
	mov edx, 1
	int 80h
	
	;; exit code 0
	mov eax, 1
	mov ebx, 0
	int 80h
	
