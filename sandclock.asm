;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Title:  Sandclock
;		sandclock that last 1m
;Author: Guillermo Plasencia <guilleps92@gmail.com>
;Date: 03/2022
;Assambler: fasm
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

format binary as 'img' 
org 0x7C00

jmp main

macro clean 
{
	mov ax, 0x0013
	int 0x10
	mov ax, 0xa000
	mov es, ax
}

macro sleep cantidad_de_tiempo_a_esperar
{
	mov cx, cantidad_de_tiempo_a_esperar
	@@:
		hlt
	loop @b
}

macro draw_line pos, color, length, offset
{
	mov di, pos
	mov dl, color
	mov cx, length
	@@:
		mov [es:di], dl
		add di, offset
	loop @b
}
macro draw_line_delay pos, color, length, offset
{
	mov di, pos
	mov dl, color
	mov cx, length
	@@:
		mov [es:di], dl
		add di, offset
		hlt
		hlt
		hlt
		hlt
		hlt
		hlt
	loop @b
}
macro draw_line2 pos, color, length, offset
{
	mov si, pos
	mov dl, color
	mov cx, length
	@@:
		mov [es:si], dl
		add si, offset
	loop @b
}

macro draw_clock pos
{
	draw_line pos, 00000111b, 100, 1
	draw_line di, 00000111b, 100, 319
	draw_line di, 00000111b, 100, 1
	draw_line di, 00000111b, 100, -321
}



main:
	clean
	draw_clock [clock_position]
	mov di, [clock_position]
	add di, 321 + 1
	push di
	mov [token], 97
	draw_line di, 00001110b, [token], 1
	aa:
		pop di
		add di, 321
		push di
		sub [token], 2
		draw_line di, 00001110b, [token], 1
		;sleep 1
		cmp [token], 2
		jb esperar_por_tecla
	jmp aa

	esperar_por_tecla:
	@@:
		mov ah, 0x0
		int 0x16
		cmp al, "c"
	jne @b

	;animation
	mov di, [clock_position]
	add di, 320 * 47 + 50
	draw_line_delay di, 00001110b,  18, 320 * 3

	sleep 18 * 3 

	; the thing
	mov si, 0
	mov di, [clock_position]
	add di, 321 + 1 
	mov si, di
	add si, 320 * 98
	push di
	push si
	mov [token], 97
	draw_line di, 00000000b, [token], 1
	draw_line si, 00001110b, [token], 1
	bb:
			mov ah, 0x1
			int 0x16
			cmp al, 27
			je fin 
		pop si
		pop di
		add di, 321
		add si, -319
		push di
		push si
		sub [token], 2
		draw_line di, 00000000b, [token], 1
		draw_line si, 00001110b, [token], 1
		sleep 20
		cmp [token], 2
		jb esperar_por_tecla2
	jmp bb

	clean

	esperar_por_tecla2:
	@@:
		mov ah, 0x0
		int 0x16
		cmp al, "r"
	jne @b
	jmp main

fin:
	clean

token dw 100
clock_position dw 320 * 60 + 110
times 510 - ($-$$) db 0
    dw 0xaa55

