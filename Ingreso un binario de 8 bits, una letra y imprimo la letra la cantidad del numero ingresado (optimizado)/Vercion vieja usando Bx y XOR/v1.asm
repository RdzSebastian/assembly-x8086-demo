.8086
.model small
.stack 100h
.data
cartel db "ingrese un binario de ocho bits,$"
texto db 9 dup('$')
cartel2 db "ingrese una letra,$"
texto2 db 1 dup('$')
salto db 10,13,'$' 
.code
main proc
	mov ax,@data
	mov ds,ax
	
	mov cx,8
	mov ah,9
	mov dx,offset cartel
	int 21h
	mov ah,9
	mov dx,offset salto
	int 21h
	mov bx,0
lee:
	mov ah,1
	int 21h
	cmp al,'0'
	je sigo
	cmp al,'1'
	je sigo
	jmp lee
sigo:
	mov dl,al
	sub dl,'0'
	shl bx,1
	xor dh,dh
	add bx,dx
	loop lee
letra:
	mov ah,9
	mov dx,offset cartel2
	int 21h
	mov ah,9
	mov dx,offset salto
	int 21h

	mov ah,1
	int 21h
	mov ah,9
	mov dx,offset salto
	int 21h
	mov dl,al
print:
	mov ah,6
	int 21h
	sub bx,1
	cmp bx,0
	je fin
	jmp print
fin:
	mov ax,4c00h
	int 21h
endp
end main 