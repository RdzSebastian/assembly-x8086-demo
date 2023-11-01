.8086
.model small
.stack 100h
.data

.code
PUBLIC numm
numm proc	
	
	push bp
	mov bp,sp
	
	mov bx,[bp+4]
	mov si,0


start:
	mov ah,2Ch					;Get time
	int 21h
	
	;ch=hora(0-23)
	;cl=minutos(0-59)
	;dh=segundos(0-59)
	;dl=centesimos (0-99)
	
	and dx,00F0h
	shr dl,1
	shr dl,1
	shr dl,1
	shr dl,1
	
	cmp dl,9
	jg start	
	add dl,48
	
	cmp [bx],dl
	je start
	cmp [bx+1],dl
	je start
	cmp [bx+2],dl
	je start
	cmp [bx+3],dl
	je start
	
	
	mov [bx+si],dl		;en caso de ser diferente a los otros numeros lo ingreso
	inc si
	
inicia:
	cmp si,4
	je finret
	mov cx,100
	
loopcx:
	nop
	loop loopcx
	jmp start

	
finret: 
	pop bp
	ret 
endp
end 
