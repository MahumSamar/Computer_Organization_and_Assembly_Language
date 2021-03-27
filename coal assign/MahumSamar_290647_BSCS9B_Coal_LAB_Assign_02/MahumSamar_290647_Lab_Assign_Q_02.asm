;-------------------------------------------------------------------------------------------------------------------------------------
TITLE program for simple calcultor for 8-bit numbers
;-------------------------------------------------------------------------------------------------------------------------------------
INCLUDE irvine32.inc
;-------------------------------------------------------------------------------------------------------------------------------------
.DATA
;-------------------------------------------------------------------------------------------------------------------------------------
	;using table driven selection
	                CalculatorTable BYTE '1'                           	;lookup value
	                DWORD           ProcAND                            	;address of procedure
	ProcedureSize   =               ($ - CalculatorTable)              	;size of one procedure and its lookup value
	                BYTE            '2'
	                DWORD           ProcOR
        
	                BYTE            '3'
	                DWORD           ProcNOT

	                BYTE            '4'
	                DWORD           ProcXOR

	                BYTE            '5'
	                DWORD           ProcADD

	                BYTE            '6'
	                DWORD           ProcSUB

	                BYTE            '7'
	                DWORD           ProcMUL

	                BYTE            '8'
	                DWORD           ProcDIV

	NumberOfEntries =               ($ - CalculatorTable)/ProcedureSize
	                promptText      BYTE "Type any option from 1-9: ",0
	;notifying option
	                str1            BYTE "1. x AND y",0
	                str2            BYTE "2. x OR y",0
	                str3            BYTE "3. NOT x",0
	                str4            BYTE "4. x XOR y",0
	                str5            BYTE "5. x ADD y",0
	                str6            BYTE "6. x SUB y",0
	                str7            BYTE "7. x MUL y",0
	                str8            BYTE "8. x DIV y",0
	                str9            BYTE "9. Exit Program",0
	                choice          BYTE "Your choice ",0
	                input1          BYTE "Enter 1st number: ",0
	                input2          BYTE "Enter 2nd number: ",0
					resultIs 		BYTE "Result in hexadecimal is:	",0
	;variables for storing numbers
	                val1            BYTE ?
	                val2            BYte ?
;-------------------------------------------------------------------------------------------------------------------------------------
.CODE
;-------------------------------------------------------------------------------------------------------------------------------------
main PROC
	;calls procedure to take input from user
	               call InputNumbers

	               exit
main ENDP
;-------------------------------------------------------------------------------------------------------------------------------------
	; method to take input from user
;-------------------------------------------------------------------------------------------------------------------------------------
InputNumbers PROC
	userInput:     
	               call Crlf
	               call DisplayOptions
	               mov  edx, OFFSET promptText
	               call WriteString
	               call Crlf
	               mov  eax,0
	               call ReadChar
	               call WriteChar
	               call Crlf
	;    compares to check if the user wants to exit
	               cmp  al,'9'
	               jge  quit
	               mov  ebx, OFFSET CalculatorTable
	               mov  ecx, NumberOfEntries

				  
	; loop for finding the procedure which user wants to execute
	findProcedure: 

	               cmp  al,[ebx]
	               jne  nextEntry
	               call Crlf
	               mov  edx, OFFSET choice
	               call WriteString
	               call Crlf
	               call NEAR PTR [ebx + 1]
	               call Crlf
	               jmp  userInput
	               call crlf
	nextEntry:     
	; if value is not found in curret location pointer incremented to next lookup value
	               add  ebx, ProcedureSize
	               loop findProcedure
	quit:          
	; when user wants to exit
	               mov  edx, OFFSET str9
	               call WriteString
	               call Crlf
	               call Crlf
	               ret
InputNumbers ENDP
;-------------------------------------------------------------------------------------------------------------------------------------
	;procedure takes input of 2 numbers from user
	;perfroms AND operation
	;returns result in eax
	;val1 used to print result
;-------------------------------------------------------------------------------------------------------------------------------------
ProcAND PROC
	               mov  edx, OFFSET str1
	               call WriteString
	               call Crlf
	               call Crlf
	               mov  edx, OFFSET input1
	               call WriteString
	               call ReadHex
	               mov  val1,al
	               mov  edx, OFFSET input2
	               call WriteString
	               call ReadHex
	               mov  val2,al

	               mov  edx, OFFSET resultIs
	               call WriteString
				   mov  eax, 0
	               mov  al, val1
	               AND  al,val2
	               call Crlf
	               call WriteHex

	               ret
ProcAnd ENDP
;-------------------------------------------------------------------------------------------------------------------------------------
	;procedure takes input of 2 numbers from user
	;perfroms OR operation
	;returns result in eax
	;val1 used to print result
;-------------------------------------------------------------------------------------------------------------------------------------
ProcOR PROC
	               mov  edx, OFFSET str2
	               call WriteString
	               call Crlf
	               call Crlf

	               mov  edx, OFFSET input1
	               call WriteString
	               call ReadHex
	               mov  val1,al
	               mov  edx, OFFSET input2
	               call WriteString
	               call ReadHex
	               mov  val2,al

				   mov  edx, OFFSET resultIs
	               call WriteString
	               mov  eax, 0
	               mov  al, val1
	               OR   al,val2
	               call Crlf
	               call WriteHex
	               ret

ProcOR ENDP
;-------------------------------------------------------------------------------------------------------------------------------------
	;procedure takes input of number from user
	;perfroms NOT operation
	;returns result in eax
	;val1 used to print result
;-------------------------------------------------------------------------------------------------------------------------------------
ProcNOT PROC
	               mov  edx, OFFSET str3
	               call WriteString
	               call Crlf
	               call Crlf
	               mov  edx, OFFSET input1
	               call WriteString
	               call ReadHex
	               mov  val1,al
	               
	               mov  edx, OFFSET resultIs
	               call WriteString
	               mov  eax, 0
	               mov  al, val1
	               NOT  al
	               call Crlf
	               call WriteHex
	               ret
ProcNOT ENDP
;-------------------------------------------------------------------------------------------------------------------------------------
	;procedure takes input of 2 numbers from user
	;perfroms XOR operation
	;returns result in eax
	;val1 used to print result
;-------------------------------------------------------------------------------------------------------------------------------------
ProcXOR PROC
	               mov  edx, OFFSET str4
	               call WriteString
	               call Crlf
	               call Crlf
	               mov  edx, OFFSET input1
	               call WriteString
	               call ReadHex
	               mov  val1,al
	               mov  edx, OFFSET input2
	               call WriteString
	               call ReadHex
	               mov  val2,al
				   mov  edx, OFFSET resultIs
	               call WriteString
	               mov  eax, 0
	               mov  al, val1
	               XOR  al,val2
	               call Crlf
	               call WriteHex
	               ret
ProcXOR ENDP
;-------------------------------------------------------------------------------------------------------------------------------------
	;procedure takes input of 2 numbers from user
	;perfroms ADD operation
	;returns result in eax
	;val1 used to print result
;-------------------------------------------------------------------------------------------------------------------------------------
ProcADD PROC
	               mov  edx, OFFSET str5
	               call WriteString
	               call Crlf
	               call Crlf
	               mov  edx, OFFSET input1
	               call WriteString
	               call ReadHex
	               mov  val1,al
	               mov  edx, OFFSET input2
	               call WriteString
	               call ReadHex
	               mov  val2,al
				   mov  edx, OFFSET resultIs
	               call WriteString
	               mov  eax, 0
	               mov  al, val1
	               ADD  al,val2
	               call Crlf
	               call WriteHex
	               ret
ProcADD ENDP
;-------------------------------------------------------------------------------------------------------------------------------------
	;procedure takes input of 2 numbers from user
	;perfroms SUB operation
	;returns result in eax
	;val1 used to print result
;-------------------------------------------------------------------------------------------------------------------------------------
ProcSUB PROC
	               mov  edx, OFFSET str6
	               call WriteString
	               call Crlf
	               call Crlf
	               mov  edx, OFFSET input1
	               call WriteString
	               call ReadHex
	               mov  val1,al
	               mov  edx, OFFSET input2
	               call WriteString
	               call ReadHex
	               mov  val2,al
				   mov  edx, OFFSET resultIs
	               call WriteString
	               mov  eax, 0
	               mov  al, val1
	               SUB  al,val2
	               call Crlf
	               call WriteHex
	               ret
ProcSUB ENDP
;-------------------------------------------------------------------------------------------------------------------------------------
	;procedure takes input of 2 numbers from user
	;perfroms MUL operation
	;returns result in eax
	;val1 used to print result
;-------------------------------------------------------------------------------------------------------------------------------------
ProcMUL PROC
	               mov  edx, OFFSET str7
	               call WriteString
	               call Crlf
	               call Crlf
	               mov  edx, OFFSET input1
	               call WriteString
	               call ReadHex
	               mov  val1,al
	               mov  edx, OFFSET input2
	               call WriteString
	               call ReadHex
	               mov  val2,al
				   mov  edx, OFFSET resultIs
	               call WriteString
	               mov  eax, 0
	               mov  al, val1
	               MUL  val2
	               call Crlf
	               call WriteHex
	               ret
ProcMUL ENDP
;-------------------------------------------------------------------------------------------------------------------------------------
	;procedure takes input of 2 numbers from user
	;perfroms DIV operation
	;returns result in eax
	;val1 used to print result
;-------------------------------------------------------------------------------------------------------------------------------------
ProcDIV PROC
	               mov  edx, OFFSET str8
	               call WriteString
	               call Crlf
	               call Crlf
	               mov  edx, OFFSET input1
	               call WriteString
	               call ReadHex
	               mov  val1,al
	               mov  edx, OFFSET input2
	               call WriteString
	               call ReadHex
	               mov  val2,al
				   mov  edx, OFFSET resultIs
	               call WriteString
	               mov  eax, 0
	               mov  al, val1
	               DIV  val2
	               call Crlf
	               
	               call WriteHex
	               ret
ProcDIV ENDP
;-------------------------------------------------------------------------------------------------------------------------------------
	; method for displaying the options on screen
;-------------------------------------------------------------------------------------------------------------------------------------
DisplayOptions PROC
	               mov  edx, OFFSET str1
	               call WriteString
	               call Crlf
	               mov  edx, OFFSET str2
	               call WriteString
	               call Crlf
	               mov  edx, OFFSET str3
	               call WriteString
	               call Crlf
	               mov  edx, OFFSET str4
	               call WriteString
	               call Crlf
	               mov  edx, OFFSET str5
	               call WriteString
	               call Crlf
	               mov  edx, OFFSET str6
	               call WriteString
	               call Crlf
	               mov  edx, OFFSET str7
	               call WriteString
	               call Crlf
	               mov  edx, OFFSET str8
	               call WriteString
	               call Crlf
	               mov  edx, OFFSET str9
	               call WriteString
	               call Crlf
	               ret
DisplayOptions ENDP
;-------------------------------------------------------------------------------------------------------------------------------------
END main
;-------------------------------------------------------------------------------------------------------------------------------------