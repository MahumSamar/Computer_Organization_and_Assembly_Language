;-------------------------------------------------------------------------------------------------------------------------------------
TITLE program to calculate Greatest Common Divisor
;-------------------------------------------------------------------------------------------------------------------------------------
INCLUDE irvine32.inc
;-------------------------------------------------------------------------------------------------------------------------------------
.DATA
;-------------------------------------------------------------------------------------------------------------------------------------
	     promptText BYTE "Type any option from 1-2: ",0                          	;prompts for selecting the input
	;input prompt
	     input1     BYTE "Enter 1st number: ",0
	     input2     BYTE "Enter 2nd number: ",0
	;variables for storing using input numbers
	     num1       WORD ?
	     num2       WORD ?
	;variable for storing the remainder
	     remainder  WORD ?
	     strOut     BYTE "The Greatest Common Divisor of ",0
	     printAnd   BYTE " and ",0
	     str1       BYTE "1. Enter numbers for finding Greatest Common Divisor",0
	     str2       BYTE "2. Exit Program",0
	     choice     BYTE "Your choice ",0

;-------------------------------------------------------------------------------------------------------------------------------------
.CODE
;-------------------------------------------------------------------------------------------------------------------------------------
main PROC

	;calls the function for inputing the numbers by user
	               call   InputNumbers

	               exit
main ENDP
;-------------------------------------------------------------------------------------------------------------------------------------
	; method for inputing the numbers until user wants to calculate gcd of the numbers
;-------------------------------------------------------------------------------------------------------------------------------------
InputNumbers PROC
	userInput:     
	;displays options
	               call   DisplayOptions
	               mov    edx, OFFSET promptText
	               call   WriteString
	               call   Crlf
	               mov    eax,0
	               call   ReadChar
	               call   WriteChar
	               call   Crlf
	               call   Crlf
	;compares if user wants to exit
	               cmp    al,'2'
	               jge    quit
	;printing choice
	               mov    edx, OFFSET choice
	               call   WriteString
	               call   Crlf

	               mov    edx, OFFSET str1
	               call   WriteString
	               call   Crlf
	               call   Crlf
	;takes input
	               mov    eax, 0
	               mov    edx, OFFSET input1
	               call   WriteString
	               call   ReadInt
	               mov    num1,ax
	               mov    edx, OFFSET input2
	               call   WriteString
	               mov    eax, 0
	               call   ReadInt
	               mov    num2,ax
	               call   Crlf
	;notifying which values gcd found
	               mov    edx, OFFSET strOut
	               call   WriteString
	               mov    eax,0
	               mov    ax,num1
	               call   WriteDec
	               mov    edx, OFFSET printAnd
	               call   WriteString
	               mov    eax, 0
	               mov    ax,num2
	               call   WriteDec
	               call   Crlf
	               call   Crlf

	;calls procedure to calculte the gcd of the inout numbers
	               call   CalculateGCD

	;print the gcd

	               mov    ax, num1
	               call   WriteDec
	               call   Crlf
	               call   Crlf

	               jmp    userInput

	quit:          
	; ends procedure when user want to exit program
	               mov    edx, OFFSET str2
	               call   WriteString
	               call   Crlf
	               call   Crlf
	               ret
InputNumbers ENDP
;-------------------------------------------------------------------------------------------------------------------------------------

	; procedure to calculate the gcd
	; inputs are num1 and num2
	; gcd is returned in num1
	;uses do while loop
	;restores all the registers it uses using PUSHAD and POPAD
;-------------------------------------------------------------------------------------------------------------------------------------
CalculateGCD PROC
	               PUSHAD
	               mov    eax,0
	               mov    ax, num1
	;loop
	beginDoWhile:  
	               mov    edx,0
	               div    num2
	               mov    remainder, dx
	               mov    eax, 0
	               mov    ax, num2
	               mov    ebx,0
	               mov    bx, remainder
	               mov    num2, bx
	               cmp    num2,0
	               jg     beginDoWhile

	               mov    num1, ax
	               POPAD
	               ret
CalculateGCD ENDP
;-------------------------------------------------------------------------------------------------------------------------------------
	; method for displaying the options on screen
;-------------------------------------------------------------------------------------------------------------------------------------
DisplayOptions PROC

	               mov    edx, OFFSET str1
	               call   WriteString
	               call   crlf
	               mov    edx, OFFSET str2
	               call   WriteString
	               call   Crlf
	               call   Crlf
	               ret
DisplayOptions ENDP
;-------------------------------------------------------------------------------------------------------------------------------------
END main
;-------------------------------------------------------------------------------------------------------------------------------------