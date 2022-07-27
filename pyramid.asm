;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Title:  pyramids
;		simple brick arrangement
;Author: Guillermo Plasencia <guilleps92@gmail.com>
;Date: 03/2022
;Assambler: fasm
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


format binary as 'img' 
org 0x7C00

jmp zmhfsrg
zdnfoah : 
		mov ax, 0x0013
		int 0x10
		mov ax, 0xa000
		mov es, ax
ret

zygfyud: 
	push cx  
		jmp ziufyuya 
	zkugskgkn: 
			mov ah, 0
			int 0x16
			cmp al, "r"
			jne zkugskgkn
			jmp [zrggbrttr]
	ziufyuya: 
			mov di, [zur68r_zdjgbe] 
			mov dl, [zur68r_zuegnbfr] 
			mov cx, [zur68r_zrqeuqeg] 
			zgkmbvjgf:
					mov ah, 1  
					int 0x16 
					cmp al, (0x60 + 0x04)
					mov [zrggbrttr], zbjaedg
					je zkugskgkn  
					cmp al, (0x20 - 0x05) 
					je ze815 
					zbjaedg:
					mov [es:di], dl 
					add di, [zur68r_zaiygionb] 
					hlt 
			loop zgkmbvjgf
	pop cx 
ret

zvhfkghf:  
		mov di, [zdjgbe]  
		mov [zur68r_zdjgbe], di 
		mov [zur68r_zuegnbfr], 00000110b
		mov [zur68r_zrqeuqeg], 30
		mov [zur68r_zaiygionb], 1
		call zygfyud 
		mov [zur68r_zdjgbe], di  
		mov [zur68r_zrqeuqeg], 15
		mov [zur68r_zaiygionb], 320
		call zygfyud
		mov [zur68r_zdjgbe], di
		mov [zur68r_zrqeuqeg], 30
		mov [zur68r_zaiygionb], -1
		call zygfyud
		mov [zur68r_zdjgbe], di
		mov [zur68r_zrqeuqeg], 15
		mov [zur68r_zaiygionb], -320
		call zygfyud
ret


zmhfsrg: 
		call zdnfoah 
		mov [0x111A], dword zdjgbe
		mov cx, 4 
		zugnro:
				call zvhfkghf  
				add [zdjgbe], 35
		loop zugnro

		mov di, [0x111A]
		mov [zdjgbe], di 

		mov cx, 3
		add [zdjgbe], 320 * 30 + 93 
		@@:
			call zvhfkghf  
			add [zdjgbe], 35
		loop @b

		mov di, [0x111A]
		mov [zdjgbe], di   

		mov cx, 2
		add [zdjgbe], 320 * 10 + 110 
		zugnroc:
			call zvhfkghf  
			add [zdjgbe], 35
		loop zugnroc

		mov di, [0x111A]
		mov [zdjgbe], di      

		mov cx, 1
		add [zdjgbe], -320 * 10 + 128   
		zugnroad:
			call zvhfkghf  
			add [zdjgbe], 35
		loop zugnroad

@@:       
	mov ah, 0  
	int 0x16
	cmp al, 27
jne @b

ze815:  
	call zdnfoah
	jmp $


;VARS
zdjgbe dw  320 * 150 + 96
zrggbrttr dw 0
;---------------------
;zygfyud_args
zur68r_zdjgbe dw 0
zur68r_zuegnbfr db 0
zur68r_zrqeuqeg dw 0
zur68r_zaiygionb dw 0
;---------------------
times 510 - ($-$$) db 0
    dw 0xaa55


