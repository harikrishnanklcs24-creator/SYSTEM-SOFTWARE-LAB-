.model small 
.data 
m1 db 10,13,"Enter first $"
m2 db 10,13,"Enter first $"
m3 db 10,13, "result $"
.code
mov ax,@data 
mov ds,ax
lea dx,m1 
mov ah,09h 
int 21h
mov ah,01h 
int 21h 
sub al,30h
mov bl,al 
lea dx,m2 
mov ah,09h 
int 21h
mov ah,01h 
int 21h 
sub al,30h
add al,bl 
add al,30h
lea dx,m3 
mov ah,09h 
int 21h 
mov dl,al 
mov ah,02h 
int 21h 
mov ah,4ch 
int 21h
end 
