.8086
.model small
.stack 100h
.data

	cartel db "Ingrese un caracter del teclado: ",'$'
	salida db 10,13,"El binario del caracter ingresado es: ",'$'

.code
 main proc
	mov ax,@data
	mov ds,ax
	
	mov ah,9
	mov dx,offset cartel
	int 21h
	
ingreso:
	mov ah,1
	int 21h
	mov bl,al
	
imprimocartel:
	mov ah,9
	mov dx, offset salida
	int 21h
	
	mov cx,8 				;inicializo el loop
	
ciclo:
	shl bl,1
	jc uno					;si el carry es 1 imprime un "1", sino imprime un "0"
	mov dl,'0'
	jmp imprimo
	
uno:
	mov dl,'1'
	
imprimo:
	mov ah,6
	int 21h
	loop ciclo
	
	
	
	
	
	
	
	
	
	
	
	mov ax,4c00h
	int 21h
endp
end main