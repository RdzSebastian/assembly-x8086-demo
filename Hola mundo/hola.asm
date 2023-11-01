.8086
.model small
.stack 100h
.data
cartel db "Hola mundo!,$"

.code
 main proc
	mov ax,@data
	mov ds,ax
	
	mov ah,9
	mov dx,offset cartel
	int 21h
	
	mov ax,4c00h
	int 21h
endp
end main