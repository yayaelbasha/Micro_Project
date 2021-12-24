MoveCursor MACRO x,y
PUSH AX
PUSH DX
MOV AH,2
MOV DL,x
MOV DH,y
int 10H
POP DX
POP AX
ENDM

GetCursorPosition MACRO x,y
PUSH AX
PUSH BX
PUSH CX
PUSH DX
MOV AH,3H
MOV BH,0H
INT 10H
MOV x,DL
MOV y,DH
POP DX
POP CX
POP BX
POP AX
ENDM

DisplayString MACRO STR
PUSH AX
PUSH DX
MOV AH,09
MOV DX,OFFSET STR
INT 21H
POP DX
POP AX
ENDM

ReadInput MACRO NAME
   PUSH AX
   PUSH DX
   MOV AH,0AH  
   MOV DX,OFFSET NAME
   INT 21H
   POP DX
   POP AX
ENDM

GetKey MACRO INPUT_KEY,ASCII
    PUSH AX
    MOV AH,0
    INT 16H
    MOV INPUT_KEY,AH
    MOV ASCII,AL
    POP AX
ENDM

ClearScreen MACRO
    PUSH AX
    MOV AX,3
    INT 10H
    POP AX
ENDM

DisplayHashedLine MACRO
   PUSH AX
    PUSH BX
    PUSH CX
    MOV AH,9
    MOV BH, 0
    MOV AL,2DH
    MOV CX,80
    MOV BL,00AH
    INT 10H
    POP CX
    POP BX
    POP AX
ENDM

DisplayName1 MACRO
   PUSH BX
   PUSH CX
   DisplayString TMP1
   DisplayString ACCNAME
   GetCursorPosition col,row 
   MOV BX,OFFSET NAME1+1 
   MOV CL,[BX]
   ADD col,CL
   INC col
   MoveCursor col,row
   DisplayString N1Chatting
   POP CX
   POP BX
ENDM

DisplayName2 MACRO
   PUSH BX
   PUSH CX
   DisplayString TMP2
   DisplayString ACCNAME2
   GetCursorPosition col,row
   MOV BX,OFFSET NAME1+1 
   MOV CL,[BX]
   ADD col,CL
   INC col
   MoveCursor col,row
   DisplayString N1Chatting
   POP CX
   POP BX
ENDM
ScrollUp MACRO lines,x1,y1,x2,y2
   PUSH AX
   PUSH BX
   PUSH CX
   PUSH DX
   MOV AH,06H
   MOV AL,lines
   MOV BH,07
   MOV CL,x1
   MOV CH,y1
   MOV DL,x2
   MOV DH,y2
   INT 10H
   POP DX
   POP CX
   POP BX
   POP AX
ENDM

ReadChar MACRO CHAR
   
   PUSH AX 
   MOV AH,07
   INT 21H
   MOV CHAR,AL
   POP AX
ENDM

ReadChar2 MACRO CHAR
   
   PUSH AX
   PUSH BX 
   MOV AH,08
   MOV BH,0
   INT 10H
   MOV CHAR,AL
   POP BX
   POP AX
   ENDM

.MODEL SMALL
.STACK 64
.DATA

;Outputs
STR1 DB "Please enter your name: $"
str11 db "User2: $"
STR2 DB "Initial points: $"
STR3 DB "Press Enter key to continue $" 
STR5 DB "To start chatting press F1 $" 
STR6 DB "To start game press F2 $" 
STR7 DB "To end program press ESC $" 
STR10 DB "input initial points (only numbers) $"
N1Chatting DB " : $"
col DB ?
row DB ?
STR4 DB "To end Chatting Press F3", '$'
;Inputs from user
TMP1 DB '$$' ;first letter of Name 1
NAME1 DB 15,? ;Maximum size and actual size
ACCNAME DB 15 DUP('$') ;Actual bytes reserved for the name (to be used when printing)
InitialPts DB 5,?
ACCInitialPts DB 5 DUP('$')
CHAR DB '$$'
INPUT_KEY DB ?
ASCII DB '$$'
;user2
TMP2 DB '$$' ;first letter of Name 2
NAME2 DB 15,? ;Maximum size and actual size
ACCNAME2 DB 15 DUP('$') ;Actual bytes reserved for the name (to be used when printing)
InitialPts2 DB 5,?
ACCInitialPts2 DB 5 DUP('$')
CHAR2 DB '$$'
;Chatting
USER1TEXT DB 76,?
ACCUSER1TEXT DB 76 DUP('$')
USER2TEXT DB 76,?
ACCUSER2TEXT DB 76 DUP('$')

.CODE
WELCOMESCREEN PROC   
   
   DisplayString STR1 
   ;Start in new line  
   MoveCursor 0,1

   ;Read First Character
ENTER:
   
   ReadChar CHAR
   ;Check if it is a special character
   MOV AL,CHAR
   CMP AL,41H ;Compare with the first capital letter
   JL ENTER
   CMP AL,5AH ;Compare with the last capital letter
   JG SMALL_LETTER_CHECK ;If it is not in the range of capital letters check if it is a small letter
   CMP AL,7AH ;Compare with ASCII of special characters after Capital letters
   JG ENTER
   JMP ACCEPTED
   
   SMALL_LETTER_CHECK:
   CMP AL,61H ;Compare with the first small letter
   JL ENTER ;if less then it is a special character between the last capital letter and the first small letter
   
   ACCEPTED:
   MOV TMP1,AL ;Put the accepted first letter in TMP1 to be able to display it
   DisplayString TMP1
   ReadInput NAME1
 
   ;After the user enters the input, a "\t" is automatically added by the assembler in the memory which would cause overwriting if we were to display NAME1
   MOV SI,OFFSET NAME1+1 
   MOV CX,[SI] ;Put the actual size of the input in CX
   ADD SI,CX ;To let SI point at the "\t"
   MOV SI,'$' ;Replace the "\t" with '$' for when printing/displaying

   MoveCursor 0,3
   DisplayString STR2

   MoveCursor 0,4
   ReadInput InitialPts
 mov bl,5
 ew:  mov di,offset InitialPts+1
   mov cl,[di]
   mov ch,00H
  mov si,OFFSET ACCInitialPts
  enter4: mov al,[si]
   
   CMP al,30H ;Compare with the first NUMBER
   jb ENTER2
   CMP al,39H ;Compare with the last NUMBER
   ja ENTER2
   inc si
   dec CL
   jcxz k
   jmp enter4
   enter2:
   inc bl
   MoveCursor 0,bl
      DisplayString STR10
      ReadInput InitialPts
      jmp ew
       loop enter2
   ;Same idea (to avoid overwriting when printing)
   
   ;Same idea (to avoid overwriting when printing)
   k:MOV SI,OFFSET InitialPts+1
   MOV CX,[SI]
   ADD SI,CX
   MOV SI,'$'
   inc bl
   MoveCursor 0,bl

   DisplayString STR3
   checkenter:
   MOV AH,0
   int 16h
   CMP AH,28
   jne checkenter
  ClearScreen   
    DisplayString str11
    DisplayString STR1 
   ;Start in new line  
   MoveCursor 0,1

   ;Read First Character
enter20:
   
   ReadChar CHAR2
   ;Check if it is a special character
   MOV AL,CHAR2
   CMP AL,41H ;Compare with the first capital letter
   JL enter20
   CMP AL,5AH ;Compare with the last capital letter
   JG SMALL_LETTER_CHECK2 ;If it is not in the range of capital letters check if it is a small letter
   CMP AL,7AH ;Compare with ASCII of special characters after Capital letters
   JG enter20
   JMP ACCEPTED2
   
   SMALL_LETTER_CHECK2:
   CMP AL,61H ;Compare with the first small letter
   JL enter20 ;if less then it is a special character between the last capital letter and the first small letter
   
   ACCEPTED2:
   MOV TMP2,AL ;Put the accepted first letter in TMP2 to be able to display it
   DisplayString TMP2
   ReadInput NAME2
 
   ;After the user enters the input, a "\t" is automatically added by the assembler in the memory which would cause overwriting if we were to display NAME2
   MOV SI,OFFSET NAME2+1 
   MOV CX,[SI] ;Put the actual size of the input in CX
   ADD SI,CX ;To let SI point at the "\t"
   MOV SI,'$' ;Replace the "\t" with '$' for when printing/displaying

   MoveCursor 0,3
   DisplayString STR2

   MoveCursor 0,4
   ReadInput InitialPts2
 mov bl,5
 ew2:  mov di,offset InitialPts2+1
   mov cl,[di]
   mov ch,00H
  mov si,OFFSET ACCInitialPts2
  enter42: mov al,[si]
   
   CMP al,30H ;Compare with the first NUMBER
   jb ENTER22
   CMP al,39H ;Compare with the last NUMBER
   ja ENTER22
   inc si
   dec CL
   jcxz k2
   jmp enter42
   enter22:
   inc bl
   MoveCursor 0,bl
      DisplayString STR10
      ReadInput InitialPts2
      jmp ew2
       loop ENTER22
   ;Same idea (to avoid overwriting when printing)
   
   ;Same idea (to avoid overwriting when printing)
   k2:MOV SI,OFFSET InitialPts2+1
   MOV CX,[SI]
   ADD SI,CX
   MOV SI,'$'
   inc bl
   MoveCursor 0,bl

   DisplayString STR3
   checkenter2:
   MOV AH,0
   int 16h
   CMP AH,28
   jne checkenter2
  ClearScreen  
  jmp SCREEN2
   RET
   WELCOMESCREEN ENDP

   SCREEN2 PROC
    MoveCursor 20,11
    DisplayString STR5
    MoveCursor 20,13
    DisplayString STR6
    MoveCursor 20,15
    DisplayString STR7
    mov cx,1
    check2: 
     MOV AH,0
    INT 16H    
     CMP AH,59
    je endscreen2 
    CMP AH,60
    je endscreen2 
    CMP AH,1
    je endscreen2
    inc cx
    loop check2
    ;DISPLAY THE OPTIONS AND USE SET CURSOR
    ;AND NOTIFICATION BAR
    endscreen2:RET
    SCREEN2 ENDP

    ChattingMode PROC
    DisplayName1
    
    MoveCursor 0,11
    DisplayHashedLine ;in the middled os the screen

    MoveCursor 0,12
    DisplayName2
   
    MoveCursor 0,23
    DisplayHashedLine ;Before last row in the screen
   
    MoveCursor 1,24
    DisplayString STR4

   ;chatting text
   MOV CL,0 ;Line before starting line of text for user 1 (since we will increment it later)
   MOV CH,12 ;Line before starting line of text for user 2 (since we will increment it later)
   
   USER1: 
   MOV BX,76 ;Number of characters that we can enter per line
   CMP CL,10 ;The last row at which the user can write without needing to scroll
   JNL SCROLL1
   INC CL
   MoveCursor 4,CL
   Input1:
   GetKey INPUT_KEY,ASCII
   CMP INPUT_KEY,28 ;Comparing the input key scan code with the scan code of enter
   JE USER2 ;if user 1 pressed enter go to user 2
   CMP INPUT_KEY,1 ;Comparing the input scan code with the scan code of esc
   JE ENDCHAT ;Go to the end of this procedure
   DisplayString ASCII
   DEC BX ;Decrements the number of characters that can be entered per line by one
   CMP BX,0
   JNZ Input1
   
   ENDCHAT: ;Added since VSCODE does not allow long jumps
   JMP ENDCHAT2

   USER2: ;same method as user 1
   MOV BX,76
   CMP CH,22
   JNL SCROLL2
   INC CH
   MoveCursor 4,CH
   Input2:
   GetKey INPUT_KEY,ASCII
   CMP INPUT_KEY,28
   JE GOUSER1
   CMP INPUT_KEY,1
   JE ENDCHAT2
   DisplayString ASCII
   DEC BX
   CMP BX,0
   JNZ Input2
   
   SCROLL1:
   ScrollUp 1,0,1,79,10 ;deletes the first line of text sent by user 1 and shifts all texts sent by user 1 up by 1 
   DEC CL ;Decrements CL since there is now an empty line user 1 can write in
   JMP USER1

   GOUSER1:
   JMP USER1

   SCROLL2: 
   ScrollUp 1,0,13,79,22
   DEC CH
   JMP USER2

   ENDCHAT2:
   ;call main menu



    RET
    ChattingMode ENDP

;; NOTIFICATION PROCEDURE

   MAIN PROC FAR
   MOV AX,@DATA
   MOV DS,AX
   
   ClearScreen
   CALL WELCOMESCREEN
   ;CHECK SCAN CODE using loop till user presses enter
   ;ClearScreen
   ;CALL WELCOMESCREEN ;for user 2
   ;CHECK SCAN CODE using loop till user presses enter
   ;ClearScreen
   ;CALL SCREEN2
      ;CHECK SCAN CODES F1, F2, F3 AND ESC
   
   ClearScreen
 ecv:  CALL ChattingMode 
   MAIN ENDP
END MAIN