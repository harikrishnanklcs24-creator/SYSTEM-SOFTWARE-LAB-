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



1.  Set memory model to SMALL and reserve stack.
2.  Define macros:
      - printn: print a string (uses DX/INT 21h AH=09h)
      - prints: print a 2-digit number in AL (0..99)
      - printr: read a single character (INT 21h AH=01h) and convert ASCII → numeric by subtracting '0'
3.  In DATA segment define messages and storage:
      - m1: "Limit"
      - m2: "enter number"
      - m3: "sum"
      - arr: buffer to store numbers
      - val: counter used while storing/adding
4.  Start CODE and define program entry (main proc).
5.  Initialize DS using @DATA.
6.  Print prompt for limit (printn m1).
7.  Read one character (printr) → numeric limit now in AL.
8.  Move limit from AL to BL (BL will hold number of inputs to read).
9.  Initialize SI = 0 (index into arr).
10. Print prompt for numbers (printn m2).
11. Enter input loop (label loo):
      a. Read one character (printr) → numeric digit in AL.
      b. Store numeric value AL into arr[SI].
      c. Increment SI.
      d. Increment val (number read so far).
      e. Compare val with BL (limit). If not equal, repeat loop.
12. After inputs done: reset SI = 0, val = 0, CL = 0 (CL will hold sum).
13. Enter addition loop (label add_loo):
      a. Load AL ← arr[SI] (numeric value).
      b. Add AL to CL (accumulate sum in CL).
      c. Increment SI.
      d. Increment val.
      e. Compare val with BL (limit). If not equal, repeat loop.
14. Print "sum" message (printn m3).
15. Move sum from CL → AL and call prints to display the sum.
16. Exit program (INT 21h AH=4Ch).
17. End program.

