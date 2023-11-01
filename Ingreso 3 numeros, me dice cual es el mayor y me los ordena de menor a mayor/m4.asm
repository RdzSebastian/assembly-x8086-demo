.8086
.model small
.stack 100h
.data

	cartel db "Ingrese tres numeros: $"
	mayor db 10,13,"El mayor es: $"
	orden db 10,13,"El orden es: $"

.code
	main proc
	mov ax,@data
	mov ds,ax
	
	mov ah,9
	mov dx,offset cartel 
	int 21h
	
	mov ah,1					;ingreso el primer numero
	int 21h
	mov cl,al

	
	mov ah,1					;ingreso el segundo numero
	int 21h
	mov bl,al

	
	mov ah,1					;ingreso el tercer numero
	int 21h						
	mov bh,al

	
	cmp al,cl					;si el primer numero es mayor al tercero voy a 'b'
	jl b 
	
	cmp al,bl					;si el segundo numero es mayor al tercero voy a 'b'
	jl b
	
	
	mov ah,9					
	mov dx,offset mayor
	int 21h

	
	
	mov ah,6					;el tercer numero es el mayor (imprimo)
	mov dl,al					
	int 21h
	
	jmp ordena
	
b: 
	cmp bl,cl					;si el primer numero es mayor al segundo voy a 'c'
	jl c
	
	mov ah,9
	mov dx,offset mayor
	int 21h

	
	mov ah,6					;el segundo numero es el mayor (imprimo) 
	mov dl,bl
	int 21h
	
	jmp ordena

c:
	
	mov ah,9	
	mov dx,offset mayor
	int 21h

	
	mov ah,6					;el primer numero es el mayor (imprimo)
	mov dl,cl
	int 21h

ordena:
	;cl es el primero
	;bl es el segundo
	;bh es el tercero
	
	;dl es el menor
	;ch es el medio
	;dh es el mayor
	

	mov dl,cl					;el primer numero ingresado va a ser el mayor, el menor y el del medio
	mov ch,cl
	mov dh,cl
	
	
compara2:
	cmp bl,dh					;si el segundo numero es mayor o igual al mayor voy a 'bmax'
	jge bmax
	cmp bl,dl					;si el segundo numero es menor o igual al menor voy a 'bmin'
	jle bmin
	mov ch,bl
	jmp compara3
	

bmax: 
	mov ch,dh					;el del medio guarda el mayor anterior
	mov dh,bl					;el segundo numero es el mayor
	jmp compara3
	
bmin:
	mov ch,dl					;el del medio guarda el menor anterior
	mov dl,bl					;el segundo numero es el menor
	
compara3:
	cmp bh,dh					;si el tercer numero es mayor o igual al mayor voy a 'amax'
	jge amax
	cmp bh,dl					;si el tercer numero es menor o igual al menor voy a 'amin'
	jle amin
	mov ch,bh
	jmp imprime

amax: 
	mov ch,dh
	mov dh,bh					;el tercero es el mayor 
	jmp imprime
	
amin:
	mov ch,dl
	mov dl,bh					;el tercero es el menor 
	

	;dl es el menor
	;ch es el medio
	;dh es el mayor
	
imprime:	
	mov bl,dl					;libero dl y dh para imprimir 
	mov bh,dh
	
	mov ah,9					;cartel de orden
	mov dx, offset orden
	int 21h
	mov dx,0


	mov ah,6					;imprimo el menor
	mov dl,bl
	int 21h
	

	mov ah,6					;imprimo el del medio
	mov dl,ch
	int 21h


	mov ah,6					;imprimo el mayor
	mov dl,bh
	int 21h
	
fin:	
	mov ax,4c00h
	int 21h

endp
end main
	
	