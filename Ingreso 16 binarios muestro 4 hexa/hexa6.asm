.8086
.model small
.stack 100h
.data
	cartel db 10,13,"Ingrese un nro binario de 16 bits: ",10,13,'$'
	salida db 10,13,"Los cuator numeros en hexa son: ",10,13,'$'
    bin db 16 dup('$'),'$'
.code
 main proc
	mov ax,@data
	mov ds,ax
	mov dx,0					;limpio dx
	
	mov ah,9
	mov dx,offset cartel
	int 21h
	mov dx,0					;limpio dx
	
	
leebin:  		   				;preparo para el ingreso de un binario
    mov cx,16   	
        
carga:							;carga binario
    mov ah,1
    int 21h
    cmp al,48
    je ok
    cmp al,49
    je ok
    jmp carga
    
ok: 
    sub al,'0'					;ingreso el caracter 0 = 48, asique le resto 48 para que sea 0
    shl dx,1
	mov ah,0
    add dx,ax 					;en dx se guardan los 16bits
    loop carga
	
    mov bx,dx
	
	mov ah,9
	mov dx, offset salida
	int 21h

	
convercion1:					;si es numero menor a 9 le suma 48 para que de un char numero
    mov al,bh
	shr al,1
	shr al,1
	shr al,1
	shr al,1
	cmp al,9
	jle num1
    jmp letra1
	
num1: 
	add al,48
	jmp imprime1
letra1:
	add al,55
	
imprime1:						;imprimo primer hexa	
    mov dl,al
    mov ah,6
    int 21h	
	
convercion2:					;repito convercion para el segundo hexa
    mov al,bh
    and al,0Fh					;mascara
	cmp al,9
	jle num2
    jmp letra2
	
num2: 
	add al,48
	jmp imprime2
letra2:
	add al,55
	
imprime2:						;imprimo segundo hexa					
    mov dl,al
    mov ah,6
    int 21h	

convercion3:						;repito convercion para el tercer hexa	
    mov al,bl
	shr al,1
	shr al,1
	shr al,1
	shr al,1
	cmp al,9
	jle num3
    jmp letra3
	
num3: 
	add al,48
	jmp imprime3
letra3:
	add al,55
	
imprime3:						;imprimo tercer hexa	
    mov dl,al
    mov ah,6
    int 21h	
	
convercion4:					;repito convercion para el cuarto hexa
    mov al,bl
    and al,0Fh					;mascara
	cmp al,9
	jle num4
    jmp letra4
	
num4: 
	add al,48
	jmp imprime4
letra4:
	add al,55
	
imprime4:						;imprimo cuarto hexa	
    mov dl,al
    mov ah,6
    int 21h	


fin:
	mov ax,4c00h
	int 21h
endp
end main