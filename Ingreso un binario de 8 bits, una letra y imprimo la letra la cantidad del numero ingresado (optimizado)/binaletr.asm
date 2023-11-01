.8086
.model small
.stack 100h
.data

	cartel db "ingrese un binario de ocho bits: $"
	cartel2 db 10,13,"ingrese una letra: $"
	salto db 10,13,'$'
	texto db 9 dup('$')

.code
main proc
	mov ax,@data
	mov ds,ax

	mov ah,9				;muestro cartel 1
	mov dx,offset cartel
	int 21h
	
	mov cx,8				;inicializo el loop en 8
	mov bx,0				;inicializo bx en 0
	
binario:
	mov ah,1				;ingreso binario de 8 bits
	int 21h
	
	cmp al,'0'				;validacion de 0 o 1
	je guardo
	cmp al,'1'
	je guardo
	jmp binario
	
guardo:
	mov dl,al				;guardo en dl 
	sub dl,'0'				
	shl bl,1
	add bl,dl				;pongo el contenido de dl (porque dh es 0000 0000) en bx
	loop binario
	
letra:
	mov ah,9				;imprimo cartel 2
	mov dx,offset cartel2
	int 21h
	

	mov ah,1				;ingreso letra
	int 21h
	
	mov ah,9
	mov dx,offset salto
	int 21h

	mov dl,al				;guardo la letra en dl
	
print:
	mov ah,6				;imprimo el contendio de dl
	int 21h
	
	sub bl,1				;resto 1 a bx (el numero que ingrese en binario)
	cmp bl,0				;cuando llega 0 imprimo
	je fin
	jmp print
	
fin:
	mov ax,4c00h
	int 21h
endp
end main 