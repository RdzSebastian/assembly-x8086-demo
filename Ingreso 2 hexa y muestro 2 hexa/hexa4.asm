.8086
.model small
.stack 100h
.data
	cartel db "Ingrese 2 cifras hexa: $"
	salida db 10,13,"Los dos hexas son : $"

.code
 main proc
	mov ax,@data
	mov ds,ax
	mov dx,0			;limpio dx
	
	mov ah,9
	mov dx,offset cartel
	int 21h
	mov dx,0			;limpio dx
	
ingre: 					;ingreso y valido primer hexa
	mov ah,1
	int 21h
	cmp al,48
	jl ingre
	cmp al,70
	jg ingre
	cmp al,57
	jle nume
	cmp al,65
	jge letra
	jmp ingre
	
nume:					;en caso de numero lo vuelvo binario
	sub al,'0'
sigo:	
	mov cl,al
	jmp segundo
letra:					;en caso de letra lo vuelvo binario
	sub al,'7'
	jmp sigo

segundo: 				;ingreso y valido el segundo hexa
	mov ah,1
	int 21h
	cmp al,48
	jl segundo
	cmp al,70
	jg segundo
	cmp al,57
	jle nume2
	cmp al,65
	jge letra2
	jmp segundo
	
nume2:					;en caso de numero lo vuelvo binario
	sub al,48
sigo2:
	add ch,al
	jmp convercion
letra2:					;en caso de letra lo vuelvo binario
	sub al,55
	jmp 
	
	
	

convercion:
	cmp cl,9
	jle nu1
	cmp cl,15
	jle letra
	
nu1: 
	add cl,48
	jmp convercion2
letra:
	add cl,55
	
convercion2:
	cmp ch,9
	jle nu2
	cmp ch,15
	jle letra2
	
nu2: 
	add ch,48
	jmp imprimo
letra2:
	add ch,55
		

	
	
imprimo: 
	mov ah,9			;imprimo el cartel de salida
	mov dx, offset salida
	int 21h
	
	mov ah,6			;imprimo el primer hexa 
	mov dl,cl
	int 21h
	
	mov ah,6			;imprimo el segundo
	mov dl,ch
	int 21h
	
fin:
	mov ax,4c00h
	int 21h
endp
end main
	