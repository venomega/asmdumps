;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Title:  nordic_runes
;		translate mesages to nordic runes and delete it every 10s
;Author: Guillermo Plasencia <guilleps92@gmail.com>
;Date: 07/07/2022
;Assambler: fasm
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

format binary as 'img' 
org 0x7C00

jmp main

clean: ; iniciar modo de video
	mov ax, 0x0003
	int 0x10
	mov ax, 0xb800
	mov es, ax
ret

main:
	call clean ;iniciar modo video
	mov dl, 0  ;usar dl como contador
	mov di, 40 ;pocicion inicial en donde se empieza a escribir
	mov ch, 0x04 ; color rojo
	a:
		hlt ;esta interrupcion hace que el codigo espere 55ms cada vez que se usa
		cmp dl, 18 * 10 ; 55ms x 18 aproximadamente es 1s y 1s x 10 son 10s
		jbe @f ; si no ha transcurrido 10s, salta a @@:
		call clean ;si transcurrio, limpia la pantalla
		mov dl, 0 ;inicializa el contador
		mov di, 40;inicializa la posicion del texto
		@@:
		mov ah, 0x1 ;comprobar si hay precionada alguna tecla
		int 0x16
		jnz @f ; si lo esta, salta a la proxima etiquet a anonima
		inc dl ; sino lo esta, incrementa el cronometro
	jmp a ; se reinicia el ciclo

@@:
		;una vez precionada una tecla
		mov ah, 0x0   ;se obtiene la tecla y se guarda en al
		int 0x16
		mov ah, 0x4   ;se pone un color en ah (rojo)
		mov [es:di], ax ; se pone el caracter rojo en la pantalla
		add di, 2 ; aumenta la posicion del puntero, para el proximo caracter
		;;;;;;; A partir de aqui se escriben las runas
		; en al se guarda la tecla que fue precionada
			sub al, 'a' ; se le resta a esa tecla el valor de 'a'
			mov ah, 0 ; se pone ah en 0
			mov si, ax ; se usa el registro si, para que haga de desplazamiento
			mov al, [runes+si] ; se desplaza por el alfabeto runico, en dependencia de la tecla pulsada
			mov ah, 0xa ; se mueve en ah un color, verde
			mov [es:di + 160 * 4 - 2], ax ; se escribe la runa en otra posicion

	jmp a ; se salta al ciclo principal

runes db "†‡–—¶þøõðëæßÞØ××ÐÆIJKTUVWXZ"
		
times 510 - ($-$$) db 0
dw 0xaa55
