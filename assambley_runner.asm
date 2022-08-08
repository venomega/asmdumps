;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Title:  Assambley Runner
;		mini game inspire in chrome`s dino game
;Author: Guillermo Plasencia <guilleps92@gmail.com>
;Date: 08/2022
;Assambler: fasm
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


format binary as 'img'
ORG 0x7C00

macro clean 
;clean the window
{
	mov ax, 0x0003
	int 0x10
	mov ax, 0xb800
	mov es, ax
}


macro bg
;draw the background field
{
	mov di, 160 * 10
	mov ah, 0x04 ;red
	mov al, '-'
	mov cx, 80
	@@:
		mov [es:di], ax
		add di, 2
	loop @b
}

macro enemy
;draw the enemy
{
	xor bx, bx
	mov bl, [0x0a00]
	mov ah, 0x02 ;green
	mov al, '*'
	mov di, bx
	add di, 160 * 9
	mov [es:di], ax
}

macro me
;draw the player
{
	mov di, [player_pos]
	mov ah, 0xf
	mov al, 'A'
	mov [es:di], ax
}

macro print str, pos, len
;print on screen strings
{
	mov si, str
	mov ah, 0x46
	mov di, pos
	mov cx, len
	@@:
		mov al, [si]
		mov [es:di], ax
		times 2 inc di
		inc si
	loop @b

}

init:
	mov word [0x0a00], 158 ; enemy pos

main:
	clean
	bg
	enemy
	me

	mov [dimension], @f
	mov ah, 0x1
	int 0x16
	jnz action.read_key  ;if key pressed	
	@@:

	mov [dimension], @f
	jmp action.player_loop
	@@:

	mov [dimension], @f
	jmp action.enemy
	@@:


	mov [dimension], @f
	jmp action.log
	@@:

hlt
jmp main



action:
	action.read_key:
		mov ah, 0x0
		int 0x16
		cmp al, 'p'
		je action.game_pause
	action.game_resume:
		cmp al, ' '
		je action.jump
		jmp [dimension]
	action.jump:
		cmp [player_jmp_state], 1
		je @f
		mov [player_count], 0
		mov [player_jmp_state], 1
		@@:
		jmp [dimension]
	action.player_loop:
		;player processor
		cmp [player_jmp_state], 1   ;if key was pressed
		jne @f
			inc [player_count]
			cmp [player_count], 4  ; if timer gets to 1s
			jb @f
				cmp [player_vector], 0 ; if player is rising
				jne vector_1
					cmp [player_height], 2 ;if heigh don`t reach max
					jnb reach_2
						inc [player_height]
						sub [player_pos], 160
						mov [player_count], 0
						jmp @f
					reach_2:
						mov [player_vector], 1
						mov [player_count], 0
						jmp @f
				vector_1:                    ;if player is falling
					dec [player_height]
					add [player_pos], 160
					mov [player_count], 0
					cmp [player_height], 0   ;if already fall
					jne @f
						mov [player_jmp_state], 0
						mov [player_vector], 0
						mov [player_height], 0
		@@:
		jmp [dimension]
	action.enemy:
		times 2 dec byte [0x0a00]
		action.enemy.colition:
			cmp byte [0x0a00], 14
			jne @f
				cmp [player_height], 0 ; if colition detected
				jne @f			
					mov [dimension], init
					jmp action.game_over
			@@:
		action.enemy.control:
			cmp byte [0x0a00], 0
			jne @f
				mov byte [0x0a00], 158 ;restore pos
				inc [score]
				cmp [score], 10
				je action.game_win
		@@:
		jmp [dimension]
	action.log:
		mov di, 0
		mov ah, 0x4
		mov al, byte [player_count]
		add al, '0'
		mov [es:di], ax
		mov di, 160
		mov ah, 0x4
		mov al, [player_height]
		add al, '0'
		mov [es:di], ax
		mov di, 160 * 2
		mov ah, 0x4
		mov al, [player_jmp_state]
		add al, '0'
		mov [es:di], ax
		mov di, 160 * 3
		mov ah, 0x4
		mov al, [player_vector]
		add al, '0'
		mov [es:di], ax
		mov di, 160 * 4
		mov ah, 0x4
		mov al, [score]
		add al, '0'
		mov [es:di], ax
		jmp [dimension]
	action.game_pause:
		print string3, 160 * 16 + 70, 11
		mov ah, 0x0
		int 0x16
		jmp action.game_resume
	action.game_over:
		print string, 160 * 16 + 72, 9
		mov ah, 0x0
		int 0x16
		jmp [dimension]
	action.game_win:
		print string2 , 160 * 16 + 74, 7
		mov ah, 0x0
		int 0x16
		mov [score], 0
		jmp init
	
player_pos dw 160 * 9  + 14
player_count dw 0
player_jmp_state db 0
player_height db 0
player_vector db 0
score db 0
string db "GAME OVER"
string2 db "YOU WIN"
string3 db "GAME PAUSED"
dimension dw 0

times 510 - ($-$$) db 0
dw 0xaa55

