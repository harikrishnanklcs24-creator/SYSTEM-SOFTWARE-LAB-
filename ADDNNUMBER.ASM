.model small
printn macro m 
lea dx,m
mov ah,09h 
int 21h
endm 


prints macro q 
mov al,q 
mov cl,0ah
mov ah,00h 
div cl
mov bl,ah 
add al,30h 
mov dl,al 
mov ah,02h 
int 21h 
add bl,30h
mov dl,bl 
mov ah,02h 
int 21h
endm 


printr macro 
mov ah,01h
int 21h
sub al,30h 
endm

.data
m1 db 10,13,"Limit $"
m2 db 10,13,"enter number $"
m3 db 10,13,"sum $"
arr db 100 dup(?)
val db 0
.code
mov ax,@data 
mov ds,ax
printn m1
printr
mov bl,al
mov si,0
printn m2
loo:	printr
    	mov arr[si],al
	inc si 
	inc val
	cmp bl,val
	jne loo 
	mov si,00h 
	mov val,00h 
	mov cl,00h 
add_loo:	mov al,arr[si]
		add cl,al
		inc si
		inc val
		cmp bl,val
		jne add_loo
printn m3
prints cl
mov ah,4ch
int 21h
end

