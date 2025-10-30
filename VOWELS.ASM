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
endm

.data
m1 db 10,13,"Enter the string$"
m2  db 10,13,"vowels$"
arr db 100 dup(?)
c1 db 0 
.code 
mov ax,@data
mov ds,ax
printn  m1 
mov si,0
lop:	printr
	mov arr[si],al
a2:	cmp al,'a'
	je c3
e2:	cmp al,'e'
	je c3
i2:	cmp al,'o'
	je c3
o2:	cmp al,'o'
	je c3
u2:	cmp al,'u'
	je c3
	jne con_lo
c3:	inc c1 
	jmp con_lo
	inc si 
con_lo:cmp al,0dh
	jne lop 
	prints c1
	mov ah,4ch 
	int 21h 
end





1.  Start the program
2.  Define the memory model as SMALL
3.  Define macros for printing strings (printn), printing numbers (prints), and reading a character (printr)
4.  In the DATA segment, define messages and variables:
      m1 → message asking user to enter a string
      m2 → message to display "vowels"
      arr → space to store input string
      c1 → counter for vowels, initialized to 0
5.  Begin CODE segment
6.  Initialize the data segment using DS = @DATA
7.  Display the message asking for a string (printn m1)
8.  Initialize index register SI = 0
9.  Start a loop (label: lop) to read each character:
      - Read a character from keyboard (printr)
      - Store it in arr[SI]
10. Check if the character is 'a'; if yes, jump to vowel-count part
11. Check if the character is 'e'; if yes, jump to vowel-count part
12. Check if the character is 'i'; if yes, jump to vowel-count part
13. Check if the character is 'o'; if yes, jump to vowel-count part
14. Check if the character is 'u'; if yes, jump to vowel-count part
15. If character is not vowel, jump to continue loop (con_lo)
16. When vowel found, increment vowel counter c1 and jump to continue loop
17. In continue loop (con_lo):
       - Compare input character with carriage return (0Dh)
       - If not Enter key, continue reading next character
18. When Enter is pressed, exit loop
19. Display message “vowels”
20. Display the count (prints c1)
21. Terminate program with AH=4Ch, INT 21h
22. End of program






