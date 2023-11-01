.8086
.model small
.stack 100h
.data
    texto db 51 dup('$')
    bin db 4 dup('0'),'$'
	inverso db 51 dup('$')
    car1 db 'Ingrese un texto de hasta 50 caracteres: $',10,13,'$'
    car2 db 10,13,'Ingrese un nro binario de 4 bits: $',10,13,'$'
    car3 db 10,13,'Ingrese una letra: $',10,13,'$'
.code 
main proc
    mov ax,@data
    mov ds,ax
    mov bx,0
    mov ah,9
    mov dx, offset car1
    int 21h
    
ingr:
    mov ah,1
    int 21h
    cmp al,13
    je sigo
    cmp bx,50
    je sigo
    mov texto[bx],al
    inc bx
    jmp ingr
sigo:
    mov si,bx 								;largo de la cadena en si
    mov dx,0
	mov di,0
    
Parte1:
	dec bx
    mov ah,6
    mov dl,texto[bx]
    int 21h
	mov inverso[di],dl  				 	;guardados texto invertido
	inc di
    cmp bx,0
    je sigo2
    jmp Parte1
    
sigo2: 
    mov ah,9
    mov dx, offset car3
    int 21h
    mov ah,1
    int 21h
	


    
parte2:									 	;le cambio la letra ingresada por un guion
	dec di
    cmp inverso[di],al
    je cambio1
	
compara:
    cmp di,0
    je imprime2
    jmp parte2

cambio1:
    mov inverso[di],'-'
    jmp compara
	
imprime2:
	mov ah,9 								;imprimo segunda parte
	mov dx,offset inverso
	int 21h
   
   

leebin:     								;preparo para el ingreso de un binario
    mov ah,9    
    mov dx, offset car2
    int 21h
    mov bx,0   
    
    carga:									;carga binario
    mov ah,1
    int 21h
    cmp al,48
    je ok
    cmp al,49
    je ok
    jmp carga
    
ok: 
    mov bin[bx],al
    add bx,1
    cmp bx,4
    je carg									;salto para trasformar el ascii en bin
    jmp carga
     
carg:
    mov bx,0
    mov cx,4
    mov dx,0
    
bini:
    mov al,bin[bx]
    sub al,'0'
    shl dl,1
    add dl,al 								;dl guarda el nro que representa el ingresado
    inc bx
    loop bini
    mov cx,si
    mov di,0
    
cambio2:
    mov al, inverso[di]
    add al,dl
    mov inverso[di],al
    inc di
    loop cambio2
    mov dx,0
    
muestra:
    mov ah,9    
    mov dx, offset inverso
    int 21h
    je fin

   
fin:
    mov ax,4c00h
    int 21h
endp
end main