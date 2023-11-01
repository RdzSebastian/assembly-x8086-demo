.8086
.model small
.stack 100h
.data
	generado db 5 dup ("$")
	ingreso db 5 dup ("$")

	cartelIntro db "---Juego de los numeros---",10,13,'$'

	cartelJuego db 10,13,"Ingrese 4 numeros",10,13,'$'
	
	cartelRepetida db 10,13,"Ingreso no permitido",10,13,'$'
	
	cartelRespuesta db 10,13,"Tiene ",'$'
	cartelAciertos db "B y ",'$'
	
	CartelGano db 10,13,10,13,"Gano el juego! Felicitaciones.",'$'
	cartelIntentos db 10,13,"Realizo ",'$'
	cartelIntento db " Intento",'$'
	cartelIntentos1 db " Intentos",'$'
	

	cartelPreguntaFin db 10,13,10,13,"Desea jugar de nuevo <Entr>=Si?";,10,13,"Presione Enter para volver a jugar",10,13,10,13,"Toque cualquier otra tecla para finalizar.",10,13,'$'
	gracias db 10,13,"Gracias por utilizar nuestro programa! $"
	
.code
EXTRN limp:proc
EXTRN numm:proc



start:
 main proc
	mov ax,@data
	mov ds,ax
	
	call limp
	
menuprincipal:
	mov ah,9
	mov dx,offset cartelintro
	int 21h
	
	mov bx,offset generado
	push bx
	call numm
	mov di,0				;contador de intentos

;--------------------------------------------------------------------------------------------|
;Probador (si quiere jugar el programa debe comentar esto ya que le va a mostrar la solucion |
	mov bx,0																				;|
impr:																						;|
	mov ah,6																				;|
	mov dx,offset generado[bx]																;|
	int 21h																					;|
	inc bx																					;|
	cmp bx,4																				;|
	jl impr																					;|
;--------------------------------------------------------------------------------------------|
	

juego:
	mov ah,9
	mov dx,offset cartelJuego
	int 21h
	mov bx,0
	
ingre: 						;ingreso y valido el decimal
	mov ah,8				;ingreso sin eco 
	int 21h
	cmp al,27				;si presiona ESC termina el programa
	je finmed
	cmp al,48
	jl ingre
	cmp al,57
	jg ingre

ok:
	mov ingreso[bx],al		;devuelvo el decimal en cl
	inc bx

	mov ah,6
	mov dl,al				;en caso de ser valido el numero ingresado lo muestro
	int 21h
	cmp bx,4
	jl ingre
	
	
	mov bx,0				;inicializa devuelta bx en 0 para empezar a comparar
	mov si,1
	
	
;------------------------------------------------------------------------------------------------------|
;Comienza la comparacion entre los numeros ingresados para comprobar que no ingreso dos numeros iguales|
;------------------------------------------------------------------------------------------------------|
	
compara:					
	cmp bx,si				;si bx es igual a si incremento en 1 si
	je incsi
	mov al,ingreso[bx]
	mov ah,ingreso[si]
	cmp al,ah
	je repetida
incsi:
	inc si
	cmp si,4				;cuando si llega a 4 incremento bx 
	je incbx
	jmp compara
	
incbx:
	inc bx
	mov si,0
	cmp bx,4				;cuando bx llega a 4 salto a parte 1 para empezar a comparar lo ingresado con los numeros que genero el programa
	je parte1
	jmp compara


repetida:
	mov ah,9				;si ingresa dos numeros iguales cartel de error y vuelve a pedir ingreso, cuanta como intento
	mov dx,offset cartelRepetida
	int 21h
	inc di
	mov bx,0
	jmp ingre
	
;------------------------------|
;punto medio de principio y fin|
;------------------------------|
	
startmed1:
	jmp start
finmed:
	jmp fin

	
;------------------------------------------------------------------------------------|
;Comienza la comparacion entre los numeros generados por el programa y los ingresados|
;------------------------------------------------------------------------------------|
	
parte1:
	mov bx,0				;Incializo para recorrer los numeros generados
	mov si,0				;Incializo para recorrer los numeros ingresados
	mov ch,0				;ch guarda los buenos
	mov cl,0				;cl guarda los regulares
	
parte2:						;compara
	mov al,generado[bx]
	mov ah,ingreso[si]
	cmp al,ah
	je acierto
incsi2:
	inc si
	cmp si,4				;cuando si llega a 4 incremento bx 
	je incbx2
	jmp parte2
	
incbx2:
	inc bx
	mov si,0
	cmp bx,4				
	je parte3
	jmp parte2


acierto:
	cmp bx,si
	je bueno
	inc cl					;cl guarda los regulares

	jmp incsi2
	
bueno:
	inc ch					;ch guarda los buenos
	jmp incsi2
	
	
;-----------------------|
;Imprimo los resulatados|
;-----------------------|
	
parte3:
	inc di					;intentos
	cmp ch,4
	je gano					;si ch es 4 gano
	
	add ch,48
	add cl,48
	
	mov ah,9
	mov dx,offset cartelRespuesta
	int 21h
	
	mov ah,6
	mov dl,ch					;cuantos aciertos logro
	int 21h
	
	mov ah,9
	mov dx,offset cartelAciertos
	int 21h
	
	mov ah,6
	mov dl,cl					;cuantos regulares logro
	int 21h
	
	mov ah,6
	mov dl,'R'
	int 21h

	jmp juego
	
startmed2:
	jmp startmed1
	
;-------------|
;gano el juego|
;-------------|
	
gano:

	mov bx,di
	mov cl,bl
	and bl,0Fh
	shr cl,1
	shr cl,1
	shr cl,1
	shr cl,1
	cmp bl,9
	jg resta
sigo:
	add bl,48
	add cl,48

	mov ah,9
	mov dx,offset cartelGano
	int 21h
	
	mov ah,9
	mov dx,offset cartelIntentos
	int 21h
	
	mov ah,6
	mov dl,cl					;cuantos intentos realizo
	int 21h
	
	mov ah,6
	mov dl,bl					;cuantos intentos realizo
	int 21h
	
	cmp bl,49
	je unIntento
	
	mov ah,9
	mov dx,offset cartelIntentos1
	int 21h
	
	jmp preguntafin

unIntento:
	mov ah,9
	mov dx,offset cartelIntento
	int 21h
	
	jmp preguntafin
	
resta:
	sub bl,10
	add cl,1
	jmp sigo
	

;--------------------------------------------|
;cartel pregunta si vuelve a empezar el juego|
;--------------------------------------------|
	
preguntafin:
	mov ah,9
	mov dx,offset cartelPreguntaFin
	int 21h
	
	
	mov ah,8
	int 21h
	
	call limp
	
	cmp al,13
	je startmed2

	
fin:
	call limp
	
	mov ah,9
	mov dx,offset gracias
	int 21h

	mov ax,4c00h
	int 21h
endp
end main











	