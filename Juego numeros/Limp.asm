;limpia pantalla
.8086
.model small
.stack 100h
.data	

.code
PUBLIC limp
limp proc
	push ax
	push dx
	push bx
	push cx
	
	MOV AX,0600H ; Peticion para limpiar pantalla
	MOV BH,07H ; Color de letra ==7 "Blanco"
	; Fondo ==0 "Negro"
	MOV CX,0000H ; Se posiciona el cursor en Ren=0 Col=0
	MOV DX,184FH ; Cursor al final de la pantalla Ren=24(18)
	; Col=79(4F)
	INT 10H ; INTERRUPCION AL BIOS
;------------------------------------------------------------------------------
	MOV AH,02H ; Peticion para colocar el cursor
	MOV BH,00 ; Nunmero de pagina a imprimir
	MOV DH,00; Cursor en el renglon 00
	MOV DL,00 ; Cursor en la columna 00
	INT 10H ; Interrupcion al bios

finret:
	pop cx
	pop bx
	pop dx
	pop ax
	ret 
	endp
end 

	
	
