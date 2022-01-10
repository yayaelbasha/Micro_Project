;MoveCursor 18,25
;PrintMessage string
;call GetEnter

;OP CODE LIST:

;01-CLC
;04-STC

;07-INC
;10-DEC
;13-MUL
;16-DIV
;19-PUSH
;23-POP

;26-MOV
;29-ADD
;32-SUB
;35-ADC
;38-SBB
;41-AND
;44-OR
;46-XOR

;OPERANDS NUM VS RANGE OF OPCODES

;1,4-> NO
;7-23-> 1 OP
;26-46-> 2 OPS 

;REG CODES:
;01-AL
;03-AH 

;05-BL
;07-BH

;09-CL
;11-CH 

;13-DL
;15-DH

;17-AX
;19-BX
;21-CX
;23-DX

;25-SI
;27-DI
;29-SP
;31-BP
 
 GetKey MACRO INPUT_KEY,ASCII
    PUSH AX
    MOV AH,0
    INT 16H
    MOV INPUT_KEY,AH
    MOV ASCII,AL
    POP AX
ENDM



Graphicsmode Macro

    mov ah,0
    mov al,13h
    int 10h

endm Graphicsmode 

STR2DEC MACRO NUM,STR
    LOCAL STR2DEC1
    PUSHA
    MOV SI,OFFSET STR
    MOV CX,3H
    MOV BL,64H
    STR2DEC1:
    MOV AL,[SI]
    SUB AL,30H
    MUL BL
    ADD NUM,AX
    INC SI
    MOV AX,0
    MOV AL,BL
    MOV BL,0AH
    DIV BL
    MOV BL,AL
    LOOP STR2DEC1
    POPA    
ENDM 


DEC2STR MACRO NUM,STR
    LOCAL DEC2STR1
    PUSHA
    
    MOV CX,3H
    MOV SI,OFFSET STR
    ADD SI,2
    MOV BL,10
    MOV DX,NUM
    
    DEC2STR1: 
    MOV AX,DX
    DIV BL
    MOV DL,AL
    MOV DH,0
    ADD AH,30H
    MOV [SI],AH
    DEC SI
    LOOP DEC2STR1
    
    POPA
    
ENDM

ReadMessage MACRO msg,x,y
pusha
    MoveCursor x,y
    mov ah,0Ah
    lea dx,msg
    int 21h
popa
endm ReadMessage

RSTCMDLINE MACRO VAR
LOCAL CHECKAGAIN12
    PUSHA
    MOV SI,OFFSET VAR
    MOV CX,15
    CHECKAGAIN12:
    MOV [SI],'$'
    INC SI
    DEC CX
    CMP CX,0
    jNE CHECKAGAIN12
    POPA   
ENDM


 REGSET1 MACRO REGCODE,OPOFF,OPDW   
    LOCAL REG1,REG2,REG3,REG4,REG5,REG6,REG7,REG8,REG9,REG10,REG11,REG12,REG13,REG14,REG15,ENDOFF,US2,US21,US22,US23,US24,US25,US26,US27,US28,US29,US30,US31,US32,US33,US34,US35,ENDUS,ENDUS1,ENDUS2,ENDUS3,ENDUS4,ENDUS5,ENDUS6,ENDUS7,ENDUS8,ENDUS9,ENDUS10,ENDUS11,ENDUS12,ENDUS13,ENDUS14,ENDUS15
  
    
          CMP REGCODE,1
          JNE REG1
          
          CMP USER,1
          
          JNZ US2
          
          MOV OPOFF,OFFSET AL2 
          
          JMP ENDUS
          
    US2:  MOV OPOFF,OFFSET AL1
       
    ENDUS: MOV OPDW,0
          
          JMP ENDOFF
          
    REG1: CMP REGCODE,3
          JNE REG2
          
          CMP USER,1
          
          JNZ US21
          
          MOV OPOFF,OFFSET AH2 
          
          JMP ENDUS1
          
    US21:  MOV OPOFF,OFFSET AH1
       
    ENDUS1: MOV OPDW,0
            
          JMP ENDOFF
                     
    REG2: CMP REGCODE,5 
          JNE REG3
          
          CMP USER,1
          
          JNZ US22
          
          MOV OPOFF,OFFSET BL2 
          
          JMP ENDUS2
          
    US22:  MOV OPOFF,OFFSET BL1
       
    ENDUS2: MOV OPDW,0
          
          JMP ENDOFF
    
    REG3: CMP REGCODE,7
          JNE REG4 
          
         CMP USER,1
          
          JNZ US23
          
          MOV OPOFF,OFFSET BH2 
          
          JMP ENDUS3
          
    US23:  MOV OPOFF,OFFSET BH1
       
    ENDUS3: MOV OPDW,0
          
          JMP ENDOFF
    
    REG4: CMP REGCODE,9
          JNE REG5
          
         CMP USER,1
          
          JNZ US24
          
          MOV OPOFF,OFFSET CL2 
          
          JMP ENDUS4
          
    US24:  MOV OPOFF,OFFSET CL1
       
    ENDUS4: MOV OPDW,0
          
          JMP ENDOFF
    
    REG5: CMP REGCODE,11
          JNE REG6
          
         CMP USER,1
          
          JNZ US25
          
          MOV OPOFF,OFFSET CH2 
          
          JMP ENDUS5
          
    US25:  MOV OPOFF,OFFSET CH1
       
    ENDUS5: MOV OPDW,0
          
          JMP ENDOFF              
                        
    REG6: CMP REGCODE,13 
          JNE REG7
          
        CMP USER,1
          
          JNZ US26
          
          MOV OPOFF,OFFSET DL2 
          
          JMP ENDUS6
          
    US26:  MOV OPOFF,OFFSET DL1
       
    ENDUS6: MOV OPDW,0
          
          JMP ENDOFF
    
    REG7: CMP REGCODE,15
          JNE REG8
          
          CMP USER,1
          
          JNZ US27
          
          MOV OPOFF,OFFSET DH2 
          
          JMP ENDUS7
          
    US27:  MOV OPOFF,OFFSET DH1
       
    ENDUS7: MOV OPDW,0
          
          JMP ENDOFF
    
    REG8: CMP REGCODE,17 
          JNE REG9
          
          CMP USER,1
          
          JNZ US28
          
          MOV OPOFF,OFFSET AX2 
          
          JMP ENDUS8
          
    US28:  MOV OPOFF,OFFSET AX1
       
    ENDUS8: MOV OPDW,1
          
          JMP ENDOFF
    
    REG9: CMP REGCODE,19 
          JNE REG10 
          
          CMP USER,1
          
          JNZ US29
          
          MOV OPOFF,OFFSET BX2 
          
          JMP ENDUS9
          
    US29:  MOV OPOFF,OFFSET BX1
       
    ENDUS9: MOV OPDW,1
          
          JMP ENDOFF
    
    REG10: CMP REGCODE,21
           JNE REG11
           
          CMP USER,1
          
          JNZ US30
          
          MOV OPOFF,OFFSET CX2 
          
          JMP ENDUS10
          
    US30:  MOV OPOFF,OFFSET CX1
       
    ENDUS10: MOV OPDW,1
           
           JMP ENDOFF
                           
    REG11: CMP REGCODE,23 
           JNE REG12
           
           CMP USER,1
          
          JNZ US31
          
          MOV OPOFF,OFFSET DX2 
          
          JMP ENDUS11
          
    US31:  MOV OPOFF,OFFSET DX1
       
    ENDUS11: MOV OPDW,1
           
           JMP ENDOFF
    
    REG12: CMP REGCODE,25 
           JNE REG13
           
          CMP USER,1
          
          JNZ US32
          
          MOV OPOFF,OFFSET SI2 
          
          JMP ENDUS12
          
    US32:  MOV OPOFF,OFFSET SI1
       
    ENDUS12: MOV OPDW,1
           
           JMP ENDOFF
    
    REG13: CMP REGCODE,27
           JNE REG14
           
          CMP USER,1
          
          JNZ US33
          
          MOV OPOFF,OFFSET DI2 
          
          JMP ENDUS13
          
    US33:  MOV OPOFF,OFFSET DI1
       
    ENDUS13: MOV OPDW,1
           JMP ENDOFF
    
    REG14: CMP REGCODE,29
           JNE REG15
           
          CMP USER,1
          
          JNZ US34
          
          MOV OPOFF,OFFSET SP2 
          
          JMP ENDUS14
          
    US34:  MOV OPOFF,OFFSET SP1
       
    ENDUS14: MOV OPDW,1
           
           JMP ENDOFF
    
    REG15: CMP REGCODE,31 
    
          CMP USER,1
          
          JNZ US35
          
          MOV OPOFF,OFFSET BP2 
          
          JMP ENDUS15
          
    US35:  MOV OPOFF,OFFSET BP1
       
    ENDUS15: MOV OPDW,1
           
    ENDOFF:
    
ENDM

 REGSETOFF1 MACRO REGCODE,ERCODE,OPOFF,USR 
          LOCAL REGOFF1,REGOFF2,REGOFF3,REGOFF4,REGOFF5,REGOFF6,REGOFF7,REGOFF8,REGOFF9,REGOFF10,REGOFF11,REGOFF12,REGOFF13,REGOFF14,REGOFF15,ENDOPOFF,USR1MEM,ENDADDRESS,OFOF1,OFOF2,OFOF3,OFOF4,ENDOFOF1,ENDOFOF2,ENDOFOF3,ENDOFOF4
         
          PUSHA
          
           CMP USR,1
           
           JNZ USR1MEM
          
          MOV SI,OFFSET MEM2
          
          MOV OPOFF,SI
          
          JMP ENDADDRESS
          
 USR1MEM: MOV SI,OFFSET MEM1
 
          MOV OPOFF,SI
      
  ENDADDRESS:    
    
          CMP REGCODE,1
          JNE REGOFF1
          
          MOV ERCODE,1
          
          JMP ENDOPOFF
          
    REGOFF1: CMP REGCODE,3D
          JNE REGOFF2
          
          MOV ERCODE,1
            
          JMP ENDOPOFF
                     
    REGOFF2: CMP REGCODE,5D 
          JNE REGOFF3
          
          MOV ERCODE,1
          
          JMP ENDOPOFF
    
    REGOFF3: CMP REGCODE,7D
          JNE REGOFF4 
          
          MOV ERCODE,1
          
          JMP ENDOPOFF
    
    REGOFF4: CMP REGCODE,9D
          JNE REGOFF5
          
          MOV ERCODE,1
          
          JMP ENDOPOFF
    
    REGOFF5: CMP REGCODE,11D
          JNE REGOFF6
          
          MOV ERCODE,1
          
          JMP ENDOPOFF              
                        
    REGOFF6: CMP REGCODE,13D 
          JNE REGOFF7
          
          MOV ERCODE,1
          
          JMP ENDOPOFF
    
    REGOFF7: CMP REGCODE,15D
          JNE REGOFF8
          
          MOV ERCODE,1
          
          JMP ENDOPOFF
    
    REGOFF8: CMP REGCODE,17D 
          JNE REGOFF9
          
          MOV ERCODE,1
          
          JMP ENDOPOFF
    
    REGOFF9: CMP REGCODE,19D 
          JNE REGOFF10 
          
           CMP USR,1
           JNZ  OFOF1
          MOV SI,OFFSET BX2
          MOV AX,[SI]
          JMP ENDOFOF1
          
    OFOF1: MOV SI,OFFSET BX1
          MOV AX,[SI]      
     ENDOFOF1:      
          ADD OPOFF, AX
          
          JMP ENDOPOFF
    
    REGOFF10: CMP REGCODE,21D
           JNE REGOFF11
           
           MOV ERCODE,1
           
           JMP ENDOPOFF
                           
    REGOFF11: CMP REGCODE,23D 
           JNE REGOFF12
           
           MOV ERCODE,1
           
           JMP ENDOPOFF
    
    REGOFF12: CMP REGCODE,25D 
           JNE REGOFF13
         CMP USR,1
           JNZ  OFOF2
          
          MOV AX,SI2
          JMP ENDOFOF2
          
    OFOF2: MOV AX,SI1      
     ENDOFOF2:
          
          ADD OPOFF, AX
           
           JMP ENDOPOFF
    
    REGOFF13: CMP REGCODE,27D
           JNE REGOFF14
          CMP USR,1
           JNZ  OFOF3
          
          MOV AX,DI2
          JMP ENDOFOF1
          
    OFOF3: MOV AX,DI1      
     ENDOFOF3:
          
          ADD OPOFF, AX
           
           JMP ENDOPOFF
    
    REGOFF14: CMP REGCODE,29D
           JNE REGOFF15
           
          MOV ERCODE,1
           
           JMP ENDOPOFF
    
    REGOFF15: CMP REGCODE,31D 
    
         CMP USR,1
           JNZ  OFOF4
          
          MOV AX,BP2
          JMP ENDOFOF4
          
    OFOF4: MOV AX,BP1      
     ENDOFOF4: 
            ADD OPOFF, AX
           
    ENDOPOFF: POPA
    
ENDM

DIRSETOFF MACRO  OPRND
    PUSHA
   CMP USER,1
   JNZ DIR2
    
    MOV OPOFF1,OFFSET MEM2
    
    JMP ENDDIR
     
  DIR2: MOV OPOFF1,OFFSET MEM1
  ENDDIR:
    
    MOV BH,0
    MOV BL,OPRND
    
    SUB BX,30H ;ASSUME ONLY ONE DIGIT IN DIRECT ADDRESSING
    
    MOV AX,BX
    
    ADD OPOFF1,AX 
    
    POPA
ENDM    

DIRSETOFF2 MACRO  OPRND
    PUSHA
    
    CMP USER,1
   JNZ DIR21
    
    MOV OPOFF2,OFFSET MEM2
    
    JMP ENDDIR2
     
  DIR21: MOV OPOFF2,OFFSET MEM1
  ENDDIR2: 
    
    MOV BH,0
    MOV BL,OPRND
    
    SUB BX,30H ;ASSUME ONLY ONE DIGIT IN DIRECT ADDRESSING
    
    MOV AX,BX
    
    ADD OPOFF2,AX 
    
    POPA
ENDM

SETOPDWFORREG MACRO REGCODE,OPDW
    LOCAL EIGHTBITS,ENDOFSETMACRO
    CMP REGCODE,17d
    
    JL EIGHTBITS
    
    MOV OPDW,1
    
    JMP ENDOFSETMACRO
    
    EIGHTBITS:
    MOV OPDW,0
    
    ENDOFSETMACRO:
    
    
ENDM

 PUTINVAL MACRO VAL
    PUSHA
    MOV AH,VAL
    
    CMP AH,41H
    JB  SUBNUM
    
    SUB AH,37H 
    JMP CONT11
       
 SUBNUM:   SUB AH,30H 
 CONT11: MOV [BX],AH  
    POPA
 ENDM 
 
EXCHANGE MACRO
pusha
    MOV SI,OFFSET OPERAND2VAL
    MOV AH,[SI]
    MOV DI,OFFSET OPERAND2VAL+1
    MOV AL,[DI]
    MOV [SI],AL
    MOV [DI],AH 
    ;MoveCursor 23,23
    ;DisplayString OPERAND2VAL
popa    
ENDM EXCHANGE

MULT MACRO  
pusha
    ;MoveCursor 0,0
    ;DisplayString OPERAND2VAL 
    MOV CX,0
    MOV SI,OFFSET OPERAND2VAL
    MOV AL,[SI] 
    INC SI
    MOV BH,[SI]
    MOV BL,10H
    MUL BL ;AX=AL*BL =1*10 =10
    ADD AL,BH

    DEC SI
    MOV [SI],AL 

    ;; 3 4 5 6
    MOV SI,OFFSET OPERAND2VAL
    ADD SI,2
    MOV AL,[SI] 
    INC SI
    MOV BH,[SI]
    MOV BL,10H
    MUL BL ;AX=AL*BL =1*10 =10
    ADD AL,BH
    mov si, offset OPERAND2VAL+1
    MOV [SI],AL   

    ;MoveCursor 10,12
    ;DisplayString OPERAND2VAL
popa                        
ENDM MULT

VALUEIS2 MACRO
    PUSHA
    MOV SI,OFFSET OPERAND2VAL
    MOV DI,OFFSET OPERAND2VAL+2
    MOV AH,[SI]
    MOV [DI],AH
    MOV [SI],0
    
    MOV SI,OFFSET OPERAND2VAL+1
    MOV DI,OFFSET OPERAND2VAL+3
    MOV AH,[SI]
    MOV [DI],AH
    MOV [SI],0
    POPA
    
ENDM

VALUEIS1OR3 MACRO
    PUSHA
    
    MOV DI,OFFSET OPERAND2VAL+2
    MOV AX,[DI]
    PUSH AX
    
    MOV DI,OFFSET OPERAND2VAL+1
    MOV AX,[DI]
    PUSH AX
    
    MOV DI,OFFSET OPERAND2VAL
    MOV AX,[DI]
    PUSH AX
    
    MOV BX,0
    MOV [OPERAND2VAL],0
    
    MOV SI,OFFSET OPERAND2VAL+1
    POP AX  
    MOV [SI],AX
    INC SI
    POP AX
    MOV [SI],AX
    INC SI
    POP AX
    MOV [SI],AX

    POPA
    
    ENDM
DisplayString MACRO STR
PUSHA
MOV AH,09
MOV DX,OFFSET STR
INT 21H
POPA
ENDM

MoveCursor MACRO x,y
    PUSHA
    MOV  AH,2
    MOV  DL,x
    MOV  DH,y
    int  10H
    POPA
ENDM

PrintMessage MACRO MyMessage 
    pusha
    mov AH,9h
    mov bl,5
    lea DX,MyMessage
    int 21h
    popa
ENDM PrintMessage

GetCursorPosition MACRO x,y
    PUSHA
    MOV  AH,3H
    MOV  BH,0H
    INT  10H
    MOV  x,DL
    MOV  y,DH
    POPA
ENDM

DrawLineH MACRO y,x1,x2
    local DRAW2
    PUSHA
    mov   cx,x1     ;Column
    mov   dx,y      ;Row
    mov   al,5      ;Pixel color 5
    mov   ah,0ch    ;Draw Pixel Command
    DRAW2:     int   10h
    inc   cx
    cmp   cx,x2
    jnz   DRAW2
    POPA
ENDM

DrawLineV MACRO x,y1,y2
    local DRAW1
    PUSHA
    mov   cx,x      ;Column
    mov   dx,y1     ;Row
    mov   al,5      ;Pixel color 5
    mov   ah,0ch    ;Draw Pixel Command
    DRAW1:    int   10h
    inc   dx
    cmp   dx,y2
    jnz   DRAW1
    POPA
ENDM

DisplayStringVM MACRO STR,x,y,col 
    local dispSTR,checkSTR,stopSTR
    PUSHA
    mov si,offset STR
    MoveCursor x,y
    checkSTR:
    mov bl,[si]
    cmp bl,'$'
    jnz dispSTR
    jz stopSTR
    dispSTR:
    mov ah,0Eh
    mov al,bl
    mov bl,col
    mov bh,0 
    int 10h
    inc si
    jmp checkSTR
    stopSTR: 
    POPA
ENDM                ;Displays string in graphics mode and takes a string, coordinates, and color as parameters  


DisplayNumVM MACRO Num,x,y
    PUSHA
    MoveCursor x,y
    mov  ah,0Eh
    mov  al,Num
    mov  bl,0Eh
    mov  bh,0
    int  10h
    POPA
ENDM                ;Displays number in graphics mode if number is ascii   


DisplayNumVMb MACRO Num
    local again3,add30h1,add37h,continue3,disp3
    PUSHA
    mov  cx,2      ;number of times to display number
    mov  ah,0h      ;for divison we only need the no. in al
    mov  al,Num
    mov  bl,10h    ;divisor 
    again3:
    div  bl
    cmp  ah,9h      ;checks if number is letter or digit
    jg   add37h    ;if letter add 37h to convert it to ascii
    jl   add30h1    ;if digit add 30h to convert it to ascii
    add30h1:    
    add  ah,30h
    PUSH AX
    jmp  continue3
    add37h:    
    add  ah,37h
    PUSH AX
    continue3:     
    mov ah,0
    loop again3
    mov cx,2         
    disp3:          ;loop twice to print number on screen
    POP AX 
    mov dh,ah
    mov dl,al      
    mov  ah,0Eh
    mov  al,dh
    mov  bl,0Ah
    mov  bh,0
    int  10h
    loop disp3
    POPA
ENDM                ;Displays byte in graphics mode if number is hex            



DisplayNumVMw MACRO Num1,Num2,x,y ;NUM1: 34 NUM2: 12
    local again1,add30hw,add37hw,continue1,disp1
    PUSHA
    MoveCursor x,y     
    mov  dx,0
    mov  al,Num1 
    mov  ah,Num2 
    mov  bh,0 
    mov  bl,10h ;10h
    mov  cx,4 
    again1:
    mov  dl,0
    div  bx ;
    cmp  dl,9h
    jg   add37hw
    jl   add30hw
    add30hw:    
    add  dl,30h
    PUSH DX
    jmp  continue1
    add37hw:    
    add  dl,37h
    PUSH DX
    continue1:
    loop again1
    mov cx,4
    disp1:         ;loop 4 times to print number on screen
    POP  DX       
    mov  ah,0Eh
    mov  al,dl
    mov  bl,0Bh
    mov  bh,0h
    int  10h
    loop disp1         
    POPA
ENDM                ;Displays word in graphics mode if number is hex(used for common use registers ex:AX|BX|CX|DX)


DisplayNumVMSR MACRO Num,x,y
    local again2,add30hSR,add37hSR,continue2,disp2
    PUSHA
    MoveCursor x,y     
    mov  dx,0h
    mov  ax,Num
    mov  bh,0h
    mov  bl,10h
    mov  cx,4 
    again2:
    mov  dl,0h
    div  bx
    cmp  dl,9h
    jg   add37hSR
    jl   add30hSR
    add30hSR:    
    add  dl,30h
    PUSH DX
    jmp  continue2
    add37hSR:    
    add  dl,37h
    PUSH DX
    continue2:
    loop again2
    mov cx,4
    disp2:               ;loop 4 times to print number on screen
    POP  DX       
    mov  ah,0Eh
    mov  al,dl
    mov  bl,0Eh
    mov  bh,0h
    int  10h
    loop disp2      
    POPA
ENDM                    ;Displays word in graphics mode if number is hex(used for common use registers ex:SI|DI|SP|BP)



DrawMemory MACRO 
    PUSHA
    DrawLineV         130,10,120         ;Draw memory for player1
    DrawLineV         290,10,120         ;Draw memory for player2
    DrawLineV         319,0,150    
    POPA
ENDM                    ;Draws vertical lines of the memory 

DisplayMemory MACRO Num,x,y
    local print,again,add30h2,add37h,continue,disp
    PUSHA
    mov cx,10
    mov si,offset Num
    ;mov ax,5h
    ;mov [si]+3,ax
    print: 
    MoveCursor x,y
    PUSH CX         
    mov  cx,2      ;number of times to display number
    mov  ah,0      ;for divison we only need the no. in al
    mov  al,[si]
    mov  bl,10h    ;divisor     
    again:
    div  bl
    cmp  ah,9      ;checks if number is letter or digit
    jg   add37h    ;if letter add 37h to convert it to ascii
    jl   add30h2    ;if digit add 30h to convert it to ascii
    add30h2:    
    add  ah,30h
    PUSH AX
    jmp  continue
    add37h:    
    add  ah,37h
    PUSH AX
    continue:     
    mov ah,0
    loop again
    mov cx,2         
    disp:               ;loop twice to print number on screen
    POP  AX 
    mov  dh,ah
    mov  dl,al      
    mov  ah,0Eh
    mov  al,dh
    mov  bl,0Fh
    mov  bh,0
    int  10h
    loop disp
    inc si
    POP CX
    GetCursorPosition x,y
    inc y
    sub x,2    
    loop print
    POPA
ENDM               ;Writes the numbers in the memory in hex



DrawRegisters MACRO
    DrawLineV         20,30,120          ;Draw registers for player 1     
    DrawLineV         60,30,120    
    DrawLineV         100,30,120     
    DrawLineH         30,20,100
    DrawLineH         52,20,100
    DrawLineH         74,20,100
    DrawLineH         96,20,100
    DrawLineH         120,20,100
    
    DrawLineV         190,30,120         ;Draw registers for player 2        
    DrawLineV         230,30,120
    DrawLineV         270,30,120     
    DrawLineH         30,190,270
    DrawLineH         52,190,270
    DrawLineH         74,190,270
    DrawLineH         96,190,270
    DrawLineH         120,190,270          
ENDM                                    

DisplayRegisters MACRO
    DisplayStringVM   Vax,0,5,7
    DisplayStringVM   Vbx,0,8,7
    DisplayStringVM   Vcx,0,10,7
    DisplayStringVM   Vdx,0,13,7          ;Writes AX/BX/CX/DX for player 1
    
    DisplayStringVM   Vsi,13,5,7
    DisplayStringVM   Vdi,13,8,7
    DisplayStringVM   Vsp,13,10,7
    DisplayStringVM   Vbp,13,13,7         ;Writes SI/DI/SP/DP for player 1
    
    
    DisplayStringVM   Vax,21,5,7
    DisplayStringVM   Vbx,21,8,7
    DisplayStringVM   Vcx,21,10,7
    DisplayStringVM   Vdx,21,13,7         ;Writes AX/BX/CX/DX for player 2   
    
    DisplayStringVM   Vsi,34,5,7
    DisplayStringVM   Vdi,34,8,7
    DisplayStringVM   Vsp,34,10,7
    DisplayStringVM   Vbp,34,13,7         ;Writes SI/DI/SP/DP for player 2
    
    
    DisplayNumVMw      AL1,AH1,3,5
    DisplayNumVMw      BL1,BH1,3,8
    DisplayNumVMw      CL1,CH1,3,10
    DisplayNumVMw      DL1,DH1,3,13     ;Numbers printed of registers for player 1
    
    DisplayNumVMSR     SI1,8,5
    DisplayNumVMSR     DI1,8,8
    DisplayNumVMSR     SP1,8,10
    DisplayNumVMSR     BP1,8,13         ;Numbers printed of segment registers for player 1
    
    DisplayNumVMw      AL2,AH2,24,5
    DisplayNumVMw      BL2,BH2,24,8
    DisplayNumVMw      CL2,CH2,24,10 
    DisplayNumVMw      DL2,DH2,24,13
                                    ;Numbers printed of registers for player 2
    DisplayNumVMSR     SI2,29,5
    DisplayNumVMSR     DI2,29,8                                    
    DisplayNumVMSR     SP2,29,10                                    
    DisplayNumVMSR     BP2,29,13        ;Numbers printed of segment registers for player 2
ENDM DisplayRegisters
 
DisplayPlayerInfo MACRO
    ;Omar:1|M|0
    DisplayStringVM   Accp1Name,0,0,0Ah    ;disp name 1 
    DisplayStringVM   Accp1Points,11,0,0Eh      ;disp player1 points
    DrawLineV         115,0,10 
    DisplayStringVM   AccForChar2,15,0,5   ;disp forbidden char for player1
    DrawLineV         130,0,10  
    DisplayStringVM   AccPowerupNo1,17,0,0EH   ;disp no. of powerups
    
    ;Yehia:2|0|1
    DisplayStringVM   Accp2Name,21,0,0Ah  ;disp name 2 
    DisplayStringVM   Accp2Points,31,0,0Eh      ;disp player2 points
    DrawLineV         275,0,10
    DisplayStringVM   AccForChar1,35,0,5   ;disp forbidden char for player2
    DrawLineV         290,0,10  
    DisplayStringVM   AccPowerupNo2,37,0,0EH   ;disp no. of powerups   
ENDM    

DisplayPlayerInfo2 MACRO
    ;Omar:1|M|0
    DisplayStringVM   Accp1Name,0,0,0Ah    ;disp name 1 
    DisplayStringVM   Accp1Points,11,0,0Eh      ;disp player1 points
    DrawLineV         115,0,10 
    DrawLineV         130,0,10  
    DisplayStringVM   AccPowerupNo1,17,0,0EH   ;disp no. of powerups
    
    ;Yehia:2|0|1
    DisplayStringVM   Accp2Name,21,0,0Ah  ;disp name 2 
    DisplayStringVM   Accp2Points,31,0,0Eh      ;disp player2 points
    DrawLineV         275,0,10
    DrawLineV         290,0,10  
    DisplayStringVM   AccPowerupNo2,37,0,0EH   ;disp no. of powerups   
ENDM   

DisplayErrorMsg MACRO 
    local er1,er2,er3,er4,er5,er6,er7,er8,er9,endDisp
    DisplayStringVM   ErrorMsg,0,19,4h     ;disp Error
    cmp ERCODE,1
    jl endDisp
    jg er2
    er1:
    DisplayStringVM ErrorMsg1,7,19,4h
    jmp endDisp
    
    er2:
    cmp ERCODE,2
    jg er3
    DisplayStringVM ErrorMsg2,7,19,4h
    jmp endDisp
    
    er3:
    cmp ERCODE,3
    jg er4
    DisplayStringVM ErrorMsg3,7,19,4h
    jmp endDisp
    
    er4:
    cmp ERCODE,4
    jg er5
    DisplayStringVM ErrorMsg4,7,19,4h
    jmp endDisp
    
    er5:
    cmp ERCODE,5
    jg er6
    DisplayStringVM ErrorMsg5,7,19,4h
    jmp endDisp

    er6:
    cmp ERCODE,6
    jg er7
    DisplayStringVM ErrorMsg6,7,19,4h
    jmp endDisp
    
    er7:
    cmp ERCODE,7
    jg er8
    DisplayStringVM ErrorMsg7,7,19,4h
    jmp endDisp

    er8:
    cmp ERCODE,8
    JG ER9
    DisplayStringVM ErrorMsg8,7,19,4h
    jmp endDisp
    
    er9:
    cmp ERCODE,9
    DisplayStringVM ErrorMsg9,7,19,4h
    jmp endDisp
    endDisp:
ENDM

DispCharVM MACRO var,col
    PUSHA
    mov  ah,0Eh
    mov  al,var
    mov  bl,col
    mov  bh,0
    int  10h 
    POPA
ENDM

ReadCommandVM MACRO cmd,x,y 
    local for,endread
    PUSHA    
    MoveCursor x,y
    MOV AH,0AH  
    MOV DX,OFFSET cmd
    INT 21H
    mov si,offset cmd
    for:
    cmp [si],0Dh
    jz endread
    inc si
    jmp for
    endread:
    mov [si],'$'
    POPA    
ENDM

ClearCmd MACRO lines,x1,y1,x2,y2
   PUSHA
   MOV AH,06H
   MOV AL,lines
   MOV BH,0
   MOV CL,x1
   MOV CH,y1
   MOV DL,x2
   MOV DH,y2
   INT 10H
   POPA
ENDM

ClearScreen MACRO
   PUSHA
   MOV AH,06H
   MOV AL,0h
   MOV BH,07
   MOV CL,0h
   MOV CH,0h
   MOV DL,0FFH
   MOV DH,0FFH
   INT 10H
   POPA
ENDM

AddDollarSign MACRO var
LOCAL checkVar,stopCHECK
    PUSHA
mov si,offset var
    checkVar:
    cmp [si],0Dh
    jz stopCHECK
    inc si
    jmp checkVar
    stopCHECK:
    mov [si],'$'
    inc si
    mov [si],'$'
    inc si
    mov [si],'$'
    POPA
ENDM

CALCSCORE1 MACRO OP,VAL
LOCAL CHECKSUB1,ENDCALC1
PUSHA
STR2DEC SCORE1,Accp1Points
MOV BH,OP
CMP BH,0 ;0: ADD
JNE CHECKSUB1
MOV AX,VAL
ADD SCORE1,AX
JMP ENDCALC1
CHECKSUB1: ;1 OR ANYTHING SUB
MOV AX,VAL
SUB SCORE1,AX
ENDCALC1:
DEC2STR SCORE1,Accp1Points
MOV SCORE1,0000
POPA
ENDM 

CALCSCORE2 MACRO OP,VAL
LOCAL CHECKSUB2,ENDCALC2
PUSHA
STR2DEC SCORE2,Accp2Points
MOV BH,OP
CMP BH,0 ;0: ADD
JNE CHECKSUB2
MOV AX,VAL
ADD SCORE2,AX
JMP ENDCALC2
CHECKSUB2: ;1 OR ANYTHING SUB
MOV AX,VAL
SUB SCORE2,AX
ENDCALC2:
DEC2STR SCORE2,Accp2Points
MOV SCORE2,0000
POPA
ENDM 

score MACRO x,y,l,c
PUSHA
MOV AH,2
MOV DL,x
MOV DH,y
int 10H
mov ah,9 ;Display
mov al,l ;Letter D
mov cx,1h ;5 times
mov bl,c ;Green (A) on white(F) background
int 10h
POPA
ENDM


delete_char MACRO x,y
PUSHA
MOV AH,2
MOV DL,x
MOV DH,y
int 10H
mov ah,9 ;Display
mov al,00 ;Letter D
mov cx,1h ;5 times
mov bl,0h ;Green (A) on white(F) background
int 10h
POPA
ENDM

disp_bullet macro x,y
PUSHA
mov  al,13h      ;graphics mode
      int     10H
      MOV AH,2
MOV DL,x
MOV DH,y
int 10H

mov ah,9 ;Display
mov al,7 ;Letter D
mov cx,1h ;5 times
mov bl,0Fh ;Green (A) on white(F) background
int 10h
POPA
endm

disp_gun macro x,y
PUSHA
mov al,13h      ;graphics mode
int 10H
MOV AH,2
MOV DL,x
MOV DH,y
int 10H

mov ah,9 ;Display
mov al,196 ;Letter D
mov cx,1h ;5 times
mov bl,0Fh ;Green (A) on white(F) background
int 10h
POPA
endm
disp_fly macro x,y,col
PUSHA
mov  al,13h      ;graphics mode
      int     10H
      MOV AH,2
MOV DL,x
MOV DH,y
int 10H
mov ah,9 ;Display
mov al,02 ;Letter D
mov cx,1h ;5 times
mov bl,col ;Green (A) on white(F) background
int 10h
POPA
endm
Clear_sq macro  
PUSHA
mov  ah,00H
mov  al,13h      ;graphics mode
int     10H 
mov ah,0ch  ;drawing
mov al,0h ;colour
int 10h
POPA
ENDM


.MODEL small
.STACK 64
.386
.DATA

;-----------USERS PROCESSORS------------

;USER 1 PROCESSOR

AX1 LABEL WORD
AL1 DB 00H
AH1 DB 00H

BX1 LABEL WORD
BL1 DB 00H
BH1 DB 00H

CX1 LABEL WORD
CL1 DB 00H
CH1 DB 00H

DX1 LABEL WORD
DL1 DB 00H
DH1 DB 00H

SI1 DW 0000H
DI1 DW 0000H

SP1 DW 0000H
BP1 DW 0000H

FR1 DW 0000H

IMMB1 DB ?
IMMW1 DB ?

MEM1 DB 10 DUP(00H)

;STACK1 DW 10 DUP(0000)

;USER 2 PROCESSOR

AX2 LABEL WORD
AL2 DB 00
AH2 DB 00

BX2 LABEL WORD
BL2 DB 00
BH2 DB 00

CX2 LABEL WORD
CL2 DB 00
CH2 DB 00

DX2 LABEL WORD
DL2 DB 00H
DH2 DB 00H

SI2 DW 0000H
DI2 DW 0000H

SP2 DW 0000H
BP2 DW 0000H

FR2 DW 0000H 

IMMB2 DB ?
IMMW2 DB ?

MEM2 DB 10 DUP(00H)

;STACK2 DW 10 DUP(0000)

;-------OPERAND 2 IF VALUE--------
OPERAND2VAL DB ?,? ;WILL BE PUT IN HEXADECIMAL
TMPOP2 DB 0,0,'$'
STARTOP2 DW ? , '$'
;-------------OPERATION STRINGS---------------

;INSTRUCTIONS STRING
INSTRING DB 'CLCSTCINCDECMULDIVPUSHPOPMOVADDSUBADCSBBANDORXOR'

;REGISTERS STRING
REGSTRING DB 'ALAHBLBHCLCHDLDHAXBXCXDXSIDISPBP'

;COMMAND LINE
CMDLINE1 db 20,?,20 DUP('$') ,'$','$'
;CMDLINE DB 'MOV AX,12','$'

;COMMAND AND OPERANDS STRINGS
CMD DB 5 DUP('$')
CMDNUM DB ? ;NUM OF CHARS IN CMD
OPRND1 DB 3 DUP('$')
F1 DB ? ;FLAG FOR ADRESS MODE 
OPRND2 DB 5 DUP('$')
F2 DB ?
MEMOP1 DB ? ;FLAG 0: ADDRESSING MODE 1 OR 2, 1: BRACKET ADDRESSING MODE
MEMOP2 DB ? ;FLAG 0: ADDRESSING MODE 1 OR 2, 1: BRACKET ADDRESSING MODE 
ELTKN DB ? ;NUMBER OF ELEMENTS TAKEN 
ADDMODE DB ?

; OPERANDS OFFSETS
OPOFF1 DW ?
OPOFF2 DW ?

FOUND DB ? ; FLAG 1: THE CMD IS FOUND, 0: THE COMMAND IS NOT FOUND
FOUND2 DB ? ; FLAG 1: THE REG IS FOUND, 0: THE REG IS NOT FOUND
FOUND3 DB ? ; FLAG 1: THE REG OF OPERAND2 IS FOUND, 0: THE REG OF OPERAND2 IS NOT FOUND

FCFOUND DB 0

OPCODE DB ? ; IS REPRESENTED BY THE FIRST CHAR MATCHED IN THE SUBSTRING PROCEDURE
REGCODE DB ?; IS REPRESENTED BY THE FIRST CHAR MATCHED IN THE REGSTRING PROCEDURE
REGCODE2 DB ? 
ERCODE DB 00 ; PUT THE CODE OF THE ERROR IN IT

OP1DW DB ?   ; EQUALS 1 WHEN OP1 IS WORD AND 0 WHEN OP1 IS BYTE 
OP2DW DB ?   ; EQUALS 1 WHEN OP2 IS WORD AND 0 WHEN OP2 IS BYTE

STRERROR DB "THERE IS AN ERROR $" 
SIZEMISMATCHSTR DB "SIZE MISMATCH ERROR $"

FCERROR DB "INCORRECT FORBIDDEN CHARACTER $"
USER DB ?
ROUND DB 0

INPUT_KEY DB ?
ASCII DB '$$'

PLAYERWON DB ?

DONE DB 0

WIN_NUM DW 105EH
;-------------GUI VARIABLES---------------
    temp db ?
    ;CMDLINE1 db 15,?
    ;CMDLINE db 15 dup('$')
    ;CMDLINE2 db 15,? 
    ;ACCCMDLINE2 db 15 dup('$')
    nameMsg db 'Please enter your name:','$'
    p1Name    db 10,?
    Accp1Name  db 10 DUP('$')
    p2Name    db 10,?
    Accp2Name  db 10 DUP('$')
    
    ForCharMsg db 'Please enter forbidden character:','$'
    ForChar1    db 3,?
    AccForChar1  db 3 DUP('$')
    ForChar2    db 3,?
    AccForChar2  db 3 DUP('$')
    
    pointsMsg db 'Please enter intial points:','$'
    p1Points db 5,?
    Accp1Points  db 5 DUP('$')
    p2Points db 5,?
    Accp2Points  db 5 DUP('$')
    
    LVLMsg db 'Please enter level:','$'
    level db 3,?
    Acclevel  db 3 DUP('$')
    
    SCORE1 DW 0000
    SCORE2 DW 0000
    
    ErrorMsg db 'Error:','$'
    ErrorMsg1 db 'Size Mismatch','$'
    ErrorMsg2 db 'Incorrect Addressing Mode','$'
    ErrorMsg3 db 'Memory to Memory Operation','$'
    ErrorMsg4 db 'Invalid register name','$'
    ErrorMsg5 db 'Popping 8-Bits','$'
    ErrorMsg6 db 'Pushing 8-Bits','$'
    ErrorMsg7 db "OP1 can't be Immediate Value",'$'
    ErrorMsg8 db 'Invalid Command Name','$'
    ErrorMsg9 db 'Forbidden Character Used','$'
    Vax      db 'AX','$'
    Vbx      db 'BX','$'
    Vcx      db 'CX','$'
    Vdx      db 'DX','$'
    Vsi      db 'SI','$'
    Vdi      db 'DI','$'
    Vsp      db 'SP','$'
    Vbp      db 'BP','$'

    PowerupNo1     db 3,?
    AccPowerupNo1  db 3 DUP('$')
    PowerupNo2     db 3,?
    AccPowerupNo2  db 3 DUP('$')
    x        db ?
    y        db ?
    MemX1    db 17
    MemX2    db 37
    MemY     db 2
    CmdX1    db 0
    CmdX2    db 21
    CmdY     db 17

    CONGRATSSTR DB "CONGRATUALTIONS",'$'
    PUPFORCHAR DB 3 DUP('$')

    WhichProc     db 3,? ;0 means as usual, 1 reverse
    AccProc  db 3 DUP('$')
;-------------GAME VARIABLES---------------
gunx DB 10
guny DB 23
flyx db 10
flyy db 2
gun2x DB 24
gun2y DB 23
fly2x db 24
fly2y db 2
user2_bound1 equ 21
user2_bound2 EQU  35
gun_right equ 1
gun_left equ -1
obj_new_position db 1
user1_bound1 equ 0
user1_bound2 EQU  15
y_bound1 equ 22
y_bound2 equ 24
bulletx db 0
bullety db 0
bullet2x db 0
bullet2y db 0
sc1g db 30H
sc1b db 30H
sc2g db 30H
sc2b db 30H
t db 0
col DB 9
col_changer db -1
tjump db 0
tjump2 db 0

.CODE
;-----------PROCEDURES-----------



SPLITCMD PROC 
pusha
    MOV ERCODE,0
    MOV MEMOP1,0
    MOV MEMOP2,0    
    MOV OPERAND2VAL,0  ;TO AVOID GARBAGE FROM PREVIOUS ROUNDS ESPECIALLY SINCE THE USER MIGHT ENTER 1 BYTE
    MOV DI,OFFSET OPERAND2VAL
    INC DI
    MOV [DI],0
    

    MOV BL,0
    MOV MEMOP1,BL ;SETTING BRACKET ADDRESSING MODE TO ZERO

    MOV SI,OFFSET CMDLINE1+2
    MOV DI,OFFSET CMD
    
    MOV DX,0 ;SIZE OF CMD
    
    SC1: MOV AH,[SI] ;MOV THE CHAR IN CMDLINE TO AX
         CMP AH,20H
         JZ EXSC1 ;EXIT WHEN THE CHAR IS EQUAL TO SPACEBAR ASCII
         CMP AH,'$'
         JZ EXSC1 
         MOV [DI],AH ;MOVE THE CHAR TO THE CMD
         INC DX
         INC SI 
         INC DI
         JMP SC1


    EXSC1: INC SI ; TO GET THE FIRST CHAR AFTER THE SPACE
    ;MoveCursor 15,5
    ;DisplayString CMD
    MOV CMDNUM,DL

    CALL SUBINSTRING ;CHECK HERE THE COMMAND SUBSTRING
    CMP [FOUND],0
    JE ERROR7
      ;MoveCursor 15,6
    ;DisplayString FOUND
    
    CMP OPCODE,7D ;CHECK IF TAKES NO OPERANDS 
    
    JB EXFSC 

    MOV DI,OFFSET OPRND1
    
    MOV CL,0 ;COUNTER TO SEE IF MEMORY ADDRESS OPERAND IS NUM OR REG 
    SC2:MOV AH,[SI]   
        
        CMP MEMOP1,1
        JZ PROCEED
        
        CMP AH,30H    ;CHECK IF IT IS A NUMBER
        JB PROCEED    
        CMP AH,39H
        JA PROCEED    ;JUMP TO PROCEED IF IT IS NOT A NUMBER
        
        MOV ERCODE,7  ;IF IT IS A NUMBER THEN ERROR
        JMP ERROR6
        
    
PROCEED: CMP AH,'['  ;CHECK 1ST BRACKET
        JNZ TAKE     ;NOT A BRACKET 
                
        INC MEMOP1   ;IF THERE IS A BRACKET THEN THIS IS A MEMORY OPERAND
        MOV OP1DW,1 ;THIS MEANS OPPERAND 1 ACCEPTS WORD
        JMP BRCKTST

    TAKE: CMP AH,']'  ;CHECK 2ND BRCKET BEFORE TAKING IT
          JZ BRCKTND
          CMP AH,','
          JZ EXSC2
           CMP AH,'$'
          JZ EXSC2
         MOV [DI],AH
         INC CL ;INC COUNT OF ELEMENTS TAKEN
          
         INC DI

    BRCKTST:INC SI
          
          JMP SC2
    BRCKTND: INC SI   ;SI WILL POINT AT THE ','
    EXSC2:   INC SI   ; WILL POINT AT FIRST CHAR OF OPRND2 
             MOV ELTKN,CL ;NUMBER OF ELEMENTS TAKEN
             ;PUSH SI  ; RESERVE THE PLACE, POINTER TO THE FIRST CHAR OF OPRND2
             MOV STARTOP2, SI
    MOV AL,MEMOP1 ;1 IF IT IS A MEMORY OPERAND
    MUL CL ;AL=0 IF IT IS NOT A MEMORY OPERAND AND IT IS A REGISTER, AL=1 IF IT IS A MEMORY LOCATION, AL=2 IF IT IS A REGISTER MEMORY OPERAND 
    
    MOV ADDMODE,AL 
    
    CMP ADDMODE,1  ;AVOID CHECK REGSTRING IF IT IS DIRECT ADDRESING MODE
    JE SKIPREG
              
    ;CHECK HERE REG SUBSTRING
    CALL SUBREGSTRING1
    ;MoveCursor 10,7
    ;DisplayString OPRND1
    CMP [FOUND2],0 ;IF FOUND2=0 THIS MEANS THE REGISTER IS INVALID THEREFORE ERROR: INVALID REGISTER NAME 
    JNE SKIPERR
    ;POP SI
    JMP ERROR  ;JUMP TO THE END OF THE PROCEDURE 
    SKIPERR:
    
    
 SKIPREG: CMP ADDMODE,0 ; CHECK IF IT IS REGISTER DIRECT
     
     JNE SCOP1
   
     REGSET1 REGCODE,OPOFF1,OP1DW
     SETOPDWFORREG REGCODE,OP1DW
     
     JMP ENDOP1 ; OP1 DONE
    
     SCOP1:
     
     CMP ADDMODE,2  ; CHECK IF IT IS REGISTER INDIRECT 
     
     JNE SCOP11      
   
     REGSETOFF1 REGCODE,ERCODE,OPOFF1,USER
     
     CMP ERCODE,1   ; INCORRECT ADDRESSING MODE ERROR 
       
     JNE ENDOP1 ; OP1 DONE  
       
     ;POP SI ;SINCE WE SKIPPED ITS POP
     
     JMP ERROR3 
     
     SCOP11:
     
     CMP ADDMODE,1
     
     JNE ENDOP1
     
     DIRSETOFF [OPRND1]
           
    
    
    
  ENDOP1: CMP OPCODE,26D  ;CHECK IF TAKES 1 OPERAND 
    
          JB EXFSC1OP
          
          MOV ADDMODE,0 
          MOV ELTKN,0
          
          ;POP SI ;HERE IS THE POP, SI POINTS TO THE FIRST CHARACTER OF OPERAND 2 IN THE COMMAND LINE
          
          MOV BL,0
          MOV MEMOP2,BL ;SETTING BRACKET ADDRESSING MODE TO ZERO
             
 
       MOV DI,OFFSET OPRND2 
      MOV BX,OFFSET OPERAND2VAL
     ;MoveCursor 1,10
     ;DisplayString OPRND2
      ;MOV DI,OFFSET CMDLINE1+1
  ;    MoveCursor 2,23
   ;   DisplayString CMDLINE1
    ;  MOV BL,[DI] ;BL HAS ACTUAL SIZE OF COMMAND LINE
     ; MOV BH,0
      ;
   ;   MOV DI,OFFSET CMDLINE1+2
    ;  ADD DI,BX
     ; MOV SI,STARTOP2
  ;    SUB DI,SI
 ;     MOV CH,[DI]
      ;MoveCursor 2,23
      ;DisplayString CH
   ;   MOV SIZEOP2,CH
    ;  MoveCursor 2,25
     ; DisplayString SIZEOP2

      MOV CL,0 ;COUNTER TO SEE IF MEMORY ADDRESS OPERAND IS NUM OR REG
    MOV CH,0 ;COUNTS THE NUMBER OF DIGITS OF OPERAND 2 IF IT IS A VALUE
    MOV DH,0 ;USED TO KNOW WHETHER USER ENTERED LETTERS FOR REGISTERS OR LETTERS AS NUMBERS 

     MOV SI,[STARTOP2]
      ;MoveCursor 5,1
    ;DisplayString [SI]
    SC3:MOV AH,[SI] ;MOVES FIRST CHARACTER OF OPERAND 2 IN AH
         
         CMP MEMOP2,1
         JZ PROCEED2  

         CMP CL,2 ;AVOID IMMEDIATE CHECK
         JE TAKE2

         CMP AH,30H
         JL CHECK1 ;CHECK IF SPECIAL CHARACTER BEFORE ZERO
         
         CMP AH,3AH ;CHECK IF IT IS BETWEEN 0-9 IF YES CONTINUE
         JL CONTINUEHEREEE
         
         CMP AH,41H
         JL CHECK1 ;A SPECIAL CHARACTER BEFORE CAPITAL LETTERS

         ;CMP AH,53H ;IF "S" COULD BE A REGISTER
         ;JE CONTINUEHEREEE

         CMP AH,5DH ;SPECIAL CHARACTER AFTER ']'
         JG CHECK1

         CMP DH,0 ;IF DH=0 THIS MEANS REGISTER
         JNE STRT ;IF DH IS NOT EQUAL ZERO THIS MEANS THAT WE ARE SURE THE USER IS ENTERRING A VALUE AND HENCE WE WILL GO TO STRT SO THAT ANY "ZERO" VALUE ENTERRED IS ACCEPTED BECAUSE ELSE SI WILL BE INC AND ANY ZERO WILL NOT BE REGISTERED
         CMP CH,0 ;YES EQUAL ZERO THAN THIS IS THE FIRST DIGIT
         JA CHECKALLHEX ;IF THIS IS NOT THE FIRST DIGIT THEN SKIP THE REGISTER CHECK AS E.G. "A" WOULD BE UNDERSTOOD AS THE START OF A REGISTER NAME

         CONTINUEHEREEE:
         ;CMP MEMOP2,1
         ;JZ PROCEED2  
         
         ;CMP CL,2 ;AVOID IMMEDIATE CHECK
         ;JE TAKE2

         ;CMP CH,2
         ;JE CHECK1
         
         ;CMP DH,0 ;IF DH=0 THIS MEANS REGISTER
         ;JNE STRT ;IF DH IS NOT EQUAL ZERO THIS MEANS THAT WE ARE SURE THE USER IS ENTERRING A VALUE AND HENCE WE WILL GO TO STRT SO THAT ANY "ZERO" VALUE ENTERRED IS ACCEPTED BECAUSE ELSE SI WILL BE INC AND ANY ZERO WILL NOT BE REGISTERED
         ;CMP CH,0 ;YES EQUAL ZERO THAN THIS IS THE FIRST DIGIT
         ;JA CHECKALLHEX ;IF THIS IS NOT THE FIRST DIGIT THEN SKIP THE REGISTER CHECK AS E.G. "A" WOULD BE UNDERSTOOD AS THE START OF A REGISTER NAME
      
         CMP AH,30H    ;CHECK IF IT IS A NUMBER
         JB PROCEED2   ;JUMP IF IT IS NOT A NUMBER
         CMP AH,39H
         JA PROCEED2   ;JUMP IF IT IS NOT A NUMBER    
         
         
         CHECKALLHEX:
         ;CHECK HERE IF USER WILL ENTER LETTERS FOR REGISTER OR FOR VALUE 
         CMP CH,0
         JNE STRT  
         CMP AH,30H ;0 ASCII, IF FIRST DIGIT IS ZERO USER WILL ENTER IMMEDIATE HEX
         JNE STRT
         INC SI ;SKIP THE ZERO TO PUT THE HEX VALUE
         MOV AH,[SI]
         INC DH  ;INC DH SO THAT WE KNOW USER WILL ENTER IMMEDIATE
         
   STRT: 
         PUTINVAL AH 
         ;mov CURRENtAH,ah
         ;MoveCursor 20,CH
         ;DisplayString CURRENtAH
         
         INC BX  
         INC CH 
         ;mov CURRENtAH,ch
         ;MoveCursor 22,CH
         ;DisplayString CURRENtAH
         INC SI
      JMP SC3

         CHECK1:
         ;MoveCursor 1,1
    ;DisplayString CHECK11
         CMP CH,1  ;IF 1 DIGIT
         JA CHECK2
         MOV OP2DW,0
         VALUEIS1OR3
         EXCHANGE
         JMP ENDVAL
         
         CHECK2:
     ;    MoveCursor 1,2
    ;DisplayString CHECK11
         CMP CH,2
         JA CHECK3
         MOV OP2DW,0
         MULT
         JMP ENDVAL

         CHECK3: 
     ;    MoveCursor 1,3
    ;DisplayString CHECK11
         CMP CH,3
         JA CHECK4
         MOV OP2DW,1
         VALUEIS1OR3
         MULT
         EXCHANGE
         JMP ENDVAL

         CHECK4:
     ;    MoveCursor 1,4
    ;DisplayString CHECK11
         CMP CH,4
         JNE CHECKABOVE4
         MOV OP2DW,1
     ;    MoveCursor 1,6
      ;   DisplayString OPERAND2VAL
         MULT
         EXCHANGE
       ;  MoveCursor 1,8
        ; DisplayString OPERAND2VAL
         JMP ENDVAL
      ;MoveCursor 25,1
      ;DisplayString OPERAND2VAL

         CHECKABOVE4:
         CMP CH,4
         JA ERROR2B ;DEFINITE SIZE MISMATCH
           
         ENDVAL:
         ;CHECK SIZE MISMATCH (EX: MOV BL,1234)
         PUSH DX
         MOV DH,OP2DW 
         CMP ADDMODE,0  ;CHECK IF ADDRESSING MODE IS IMMEDIATE (REGISTER HANDLED LATER)
         JNZ ENDVAL2   
         CMP OP1DW,DH
         JB ERROR2 
         
         POP DX
         
         ENDVAL2:
         MOV OPOFF2,OFFSET OPERAND2VAL 
         ; MoveCursor 10,9
          ;  DisplayString OPERAND2VAL
         JMP EXFSC
        
    
PROCEED2: CMP AH,'['  ;CHECK 1ST BRACKET
        JNZ TAKE2 
        
        MOV OP2DW,1
        
        CMP MEMOP1,0   ;CHECK IF THE FIRST OPERAND WAS MEMORY OR NOT
        JZ MEMCONT
        
        MOV ERCODE,3 ;ERROR IF THE FIRST OPERAND WAS MEMORY
        
        JMP ERROR5
                
 MEMCONT: INC MEMOP2
        JMP BRCKTST2

    TAKE2: CMP AH,']'  ; CHECK 2ND BRCKET BEFORE TAKING IT
          JZ BRCKTND2
          ;CMP AH,'$'
          CMP AH,30H
          JL EXSC3 ;CHECK IF SPECIAL CHARACTER BEFORE ZERO
          
          CMP AH,3AH ;CHECK IF IT IS BETWEEN 0-9 IF YES CONTINUE
          JL CONTINUEHEREEE2
 
          CMP AH,41H
          JL EXSC3 ;A SPECIAL CHARACTER BEFORE CAPITAL LETTERS
          
          CMP AH,58H ;SPECIAL CHARACTER AFTER ']'
         JG EXSC3

         CONTINUEHEREEE2:
         MOV [DI],AH
         INC CL ;INC COUNT OF ELEMENTS TAKEN
          
         INC DI

    BRCKTST2:INC SI
          
          JMP SC3
    BRCKTND2: INC SI   ;SI WILL POINT AT THE '$'
    EXSC3:   
         MOV ELTKN,CL ;CL=2 IF REGISTER (MEMORY), CL=1 IF MEMORY LOCATION
         MOV AL,MEMOP2
         MUL CL  
         MOV ADDMODE,AL    ;AL=0 IF IT IS NOT A MEMORY OPERAND AND IT IS A REGISTER, AL=1 IF IT IS A MEMORY LOCATION, AL=2 IF IT IS A REGISTER MEMORY OPERAND 
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  
    CMP ADDMODE,1  ;AVOID CHECK REGSTRING IF IT IS DIRECT ADDRESING MODE
    JE SKIPREG2
              
    ;CHECK HERE REG SUBSTRING 2
    CALL SUBREGSTRING2
    CMP [FOUND3],0 ;IF FOUND3=0 THIS MEANS THE REGISTER IS INVALID THEREFORE ERROR: INVALID REGISTER NAME 
    JE ERROR  ;JUMP TO THE END OF THE PROCEDURE  
    
    
 SKIPREG2:    
     CMP ADDMODE,0 ; CHECK IF IT IS REGISTER DIRECT
     
     JNE SCOP12
   
     REGSET1 REGCODE2,OPOFF2,OP2DW
     
     ;CHECK SIZE MISMATCH ERROR (EX: AL,BX OR BX,AL)
     SETOPDWFORREG REGCODE2,OP2DW
     PUSH DX 
     MOV DH,OP2DW
     CMP DH,OP1DW
     JNZ ERROR2  
     POP DX
     
     JMP EXFSC ; OP2 DONE
    
     SCOP12:
     
     CMP ADDMODE,2  ; CHECK IF IT IS REGISTER INDIRECT 
     
     JNE SCOP13      
   
     REGSETOFF1 REGCODE2,ERCODE,OPOFF2,USER 
     
     
     CMP ERCODE,1   ; INCORRECT ADDRESSING MODE ERROR, DW WILL OVERWRITE AT THE END WITH 2 FOR DISPLAY MESSAGE
     
     JE ERROR3
     
     JMP EXFSC ; OP2 DONE 
     
     SCOP13:
     
     CMP ADDMODE,1
     
     JNE EXFSC
     
     DIRSETOFF2 [OPRND2] 
     
  JMP EXFSC
  
  ERROR:
  MOV ERCODE,4 ;INVALID REGISTER NAME 
  ;DisplayString STRERROR 
  JMP EXFSC
  
  ERROR2:
  ;DisplayString SIZEMISMATCHSTR
  MOV ERCODE,1 ;SIZE MISMATCH 
  POP DX
  JMP EXFSC 
  
  ERROR2B:  ;MORE THAN 2 BYTES ENTERRED
  ;DisplayString SIZEMISMATCHSTR
  MOV ERCODE,1 ;SIZE MISMATCH 
  JMP EXFSC 
  
  ERROR3:
  MOV ERCODE,2 ;INCORRECT ADDRESSING MODE
  JMP EXFSC 
  
  ERROR4:
  MOV ERCODE,5 ;INCORRECT IMMEDIATE VALUE
  JMP EXFSC 
  
  ERROR5:
  MOV ERCODE,3
  JMP EXFSC ;MEMORY TO MEMORY OPERATION
  
  ERROR6:   ;OPERAND 1 CANNOT BE IMMEDIATE VALUE, MOV ERCODE,7 WAS ALREADY IMPLEMENTED  
  JMP EXFSC
  
  ERROR7:
  MOV ERCODE,8 
  JMP EXFSC ;INVALID COMMAND NAME          
            
  EXFSC1OP: ;POP SI
  EXFSC: 
  popa
RET
SPLITCMD ENDP  

SUBINSTRING PROC 
    
    PUSHA
    
     MOV SI,OFFSET INSTRING 
       
    MOV DI,OFFSET CMDNUM ;Points to the actual size 
    MOV BL,[DI] ;BX now has the actual size of the sub-string 
    MOV BH,0 ;tried MOV BX,[DI] but BH contained garbage so asemtaha
    
    MOV DI,OFFSET CMD  ;Points at first letter of sub-string
    
    MOV DX,49d   ;Length of the string + 1
    SUB DX,BX    ;To avoid comparing with garbage at the end 
    INC DX 
    INC BX     
    
    COMPARE_WITH_ALL_STR:
    
    MOV CX,BX   
    REPE CMPSB  ;This string operation auto-increments SI and DI as well as keeps decrementing CX when the 2 bytes are equal 
    CMP CX,0
    JZ STRFOUND 
    DEC DX
    CMP DX,0 ;If DX=0 this means we have made all possible comparisons        
    JZ NOTFOUND
    PUSH CX
    MOV CX,50d
    SUB CX,BX
    SUB CX,DX  
    MOV SI,OFFSET INSTRING      ;Reset SI to the beginning of the string
    MOV DI,OFFSET CMD  ;Reset DI to the beginning of the substring
    ADD SI,CX    ;To skip the letter we have already compared with in STR
    POP CX
    JMP COMPARE_WITH_ALL_STR
    
    
    STRFOUND:  
    DEC DX 
    MOV [FOUND],1
    SUB SI,BX  ;SI points at the first element of the substring in the string
    
    CMP DX,46d
    JZ FIRST ;First element is handled differently
    MOV CX,50d 
    SUB CX,DX
    SUB CX,BX ;CX is the number of the first element (of the sub-string) in the string 
    MOV OPCODE,CL
    JMP END5
     
    FIRST:
    MOV CX,1d
    MOV OPCODE,CL
    JMP END5

    NOTFOUND:
    MOV [FOUND],0
    
    END5:
    ;MoveCursor 18,23
    
    POPA
    
    RET
SUBINSTRING ENDP  

;FOR FIRST OPERAND TO CHECK IF IT IS A REGISTER
SUBREGSTRING1 PROC 
    
    PUSHA
    
    MOV SI,OFFSET REGSTRING 
       
    MOV BL,2d ;BX now has the actual size of the sub-string 
    MOV BH,0
    
    MOV DI,OFFSET OPRND1  ;Points at first letter of sub-string
    
    MOV DX,33d   ;Length of the string + 1
    SUB DX,BX    ;To avoid comparing with garbage at the end 
    INC DX 
    INC BX     
    
    COMPARE_WITH_ALL_STR2:
    
    MOV CX,BX   
    REPE CMPSB  ;This string operation auto-increments SI and DI as well as keeps decrementing CX when the 2 bytes are equal 
    CMP CX,0
    JZ STRFOUND2 
    DEC DX
    CMP DX,0 ;If DX=0 this means we have made all possible comparisons        
    JZ NOTFOUND2
    PUSH CX
    MOV CX,34d
    SUB CX,BX
    SUB CX,DX  
    MOV SI,OFFSET REGSTRING      ;Reset SI to the beginning of the string
    MOV DI,OFFSET OPRND1  ;Reset DI to the beginning of the substring
    ADD SI,CX    ;To skip the letter we have already compared with in STR
    POP CX
    JMP COMPARE_WITH_ALL_STR2
    
    
    STRFOUND2:  
    DEC DX 
    MOV [FOUND2],1
    SUB SI,BX  ;SI points at the first element of the substring in the string
    
    CMP DX,31d
    JZ FIRST2 ;First element is handled differently
    MOV CX,34d 
    SUB CX,DX
    SUB CX,BX ;CX is the number of the first element (of the sub-string) in the string 
    MOV REGCODE,CL
    JMP END2
     
    FIRST2:
    MOV CX,1d
    MOV REGCODE,CL
    JMP END2

    NOTFOUND2:
    MOV [FOUND2],0
    
    END2:
    
    POPA
    
    RET
SUBREGSTRING1 ENDP     

;;FOR THE SECOND OPERAND TO CHECK IF IT IS A REGISTER

SUBREGSTRING2 PROC 
    
    PUSHA
    
    MOV SI,OFFSET REGSTRING 
       
    MOV BL,2d ;BX now has the actual size of the sub-string 
    MOV BH,0
    
    MOV DI,OFFSET OPRND2  ;Points at first letter of sub-string
    
    MOV DX,33d   ;Length of the string + 1
    SUB DX,BX    ;To avoid comparing with garbage at the end 
    INC DX 
    INC BX     
    
    COMPARE_WITH_ALL_STR3:
    
    MOV CX,BX   
    REPE CMPSB  ;This string operation auto-increments SI and DI as well as keeps decrementing CX when the 2 bytes are equal 
    CMP CX,0
    JZ STRFOUND3 
    DEC DX
    CMP DX,0 ;If DX=0 this means we have made all possible comparisons        
    JZ NOTFOUND3
    PUSH CX
    MOV CX,34d
    SUB CX,BX
    SUB CX,DX  
    MOV SI,OFFSET REGSTRING      ;Reset SI to the beginning of the string
    MOV DI,OFFSET OPRND2  ;Reset DI to the beginning of the substring
    ADD SI,CX    ;To skip the letter we have already compared with in STR
    POP CX
    JMP COMPARE_WITH_ALL_STR3
    
    
    STRFOUND3:  
    DEC DX 
    MOV [FOUND3],1
    SUB SI,BX  ;SI points at the first element of the substring in the string
    
    CMP DX,31d
    JZ FIRST3 ;First element is handled differently
    MOV CX,34d 
    SUB CX,DX
    SUB CX,BX ;CX is the number of the first element (of the sub-string) in the string 
    MOV REGCODE2,CL
    JMP END3
     
    FIRST3:
    MOV CX,1d
    MOV REGCODE2,CL
    JMP END3

    NOTFOUND3:
    MOV [FOUND3],0
    
    END3:
    
    POPA
    
    RET
SUBREGSTRING2 ENDP


DOTHECOMMAND PROC
    
    CMP OPCODE,1 ;CLC
    JNE CHECKSTC
    CALL CLCOP
    JMP ENDCOMMAND
    CHECKSTC:
    
    CMP OPCODE,4 ;STC  
    JNE CHECKINC
    CALL STCOP
    JMP ENDCOMMAND
    CHECKINC:
    
    CMP OPCODE,7 ;INC
    JNE CHECKDEC
    CALL INCOP  
    JMP ENDCOMMAND
    CHECKDEC:
    
    CMP OPCODE,10 ;DEC 
    JNE CHECKMUL
    CALL DECOP 
    JMP ENDCOMMAND
    CHECKMUL:
    
    CMP OPCODE,13 ;MUL
    JNE CHECKDIV
    CALL MULOP 
    JMP ENDCOMMAND
    CHECKDIV:
    
    CMP OPCODE,16 ;DIV
    JNE CHECKPUSH
    CALL DIVOP   
    JMP ENDCOMMAND
    CHECKPUSH:
    
    CMP OPCODE,19 ;PUSH 
    JNE CHECKPOP
    CALL PUSHOP
    JMP ENDCOMMAND
    CHECKPOP:
    
    CMP OPCODE,23 ;POP
    JNE CHECKMOV
    CALL POPOP 
    JMP ENDCOMMAND
    CHECKMOV:
    
    CMP OPCODE,26 ;MOV
    JNE CHECKADD
    CALL MOVOP  
    JMP ENDCOMMAND
    CHECKADD:
    
    CMP OPCODE,29 ;ADD 
    JNE CHECKSUB
    CALL ADDOP  
    JMP ENDCOMMAND
    CHECKSUB:
    
    CMP OPCODE,32 ;SUB
    JNE CHECKADC
    CALL SUBOP  
    JMP ENDCOMMAND
    CHECKADC:
    
    CMP OPCODE,35 ;ADC
    JNE CHECKSBB
    CALL ADCOP 
    JMP ENDCOMMAND
    CHECKSBB:
    
    CMP OPCODE,38 ;SBB
    JNE CHECKAND
    CALL SBBOP      
    JMP ENDCOMMAND
    CHECKAND:
    
    CMP OPCODE,41 ;AND
    JNE CHECKXOR
    CALL ANDOP
    JMP ENDCOMMAND
    CHECKOR:
    
    CMP OPCODE,44 ;OR
    JNE CHECKXOR
    CALL OROP  
    JMP ENDCOMMAND
    CHECKXOR:
    
    CMP OPCODE,46 ;XOR
    CALL XOROP
 ENDCOMMAND:
    RET 
    DOTHECOMMAND ENDP 

CLCOP PROC
    PUSHA
     
    CMP USER,1
    JNE CLC1
    
    MOV AX,FR2
    
    AND AX,1111111111111110B 
    
    MOV FR2,AX
    
    JMP ENDCLC
    
CLC1: MOV AX,FR1
      
      AND AX,1111111111111110B
      
      MOV FR1,AX
      
ENDCLC:
     POPA

RET
CLCOP ENDP 

STCOP PROC 
    PUSHA
    
    CMP USER,1
    JNE STC1
    
    MOV AX,FR2
    
    OR AX,0000000000000001B
    
    MOV FR2,AX
    
    JMP ENDSTC
    
STC1: MOV AX,FR1

      OR AX,0000000000000001B
      
      MOV FR1,AX
      
ENDSTC: POPA
RET

STCOP ENDP

 INCOP PROC
    PUSHA
    
    MOV SI, OPOFF1
    CMP OP1DW,1
    JNE INC2
    MOV AX,[SI]
    INC AX
    MOV [SI],AX
    JMP ENDINC 
 INC2:
    MOV AL,[SI]
    INC AL
    MOV [SI],AL
    
    ENDINC:  
    CALL UPDTFR
    POPA
    RET
    INCOP ENDP

DECOP PROC
    PUSHA
    
    MOV SI, OPOFF1
    CMP OP1DW,1
    JNE DEC2
    MOV AX,[SI]
    DEC AX
    MOV [SI],AX
    JMP ENDDEC 
 DEC2:
    MOV AL,[SI]
    DEC AL
    MOV [SI],AL
    
    ENDDEC:  
    CALL UPDTFR
    
    POPA
    
    RET
    DECOP ENDP

MULOP PROC 
    
    PUSHA
    CMP USER,1
    JNE MUL1
    
    CMP OP1DW,1
    JNE MUL2
    
    MOV SI,OPOFF1    
    MOV BX,[SI]     
    MOV AX,AX2
    MUL BX
    MOV AX2,AX
    MOV DX2,DX
    JMP ENDMUL
    
MUL2: MOV SI,OPOFF1
      MOV BL,[SI]
      MOV AL,AL2
      
      MUL BL
      
      MOV AX2,AX
      JMP ENDMUL
   
MUL1: CMP OP1DW,1
      JNE MUL3
    
    MOV SI,OPOFF1    
    MOV BX,[SI]     
    MOV AX,AX1
    MUL BX
    MOV AX1,AX
    MOV DX1,DX
    JMP ENDMUL
    
MUL3: MOV SI,OPOFF1
      MOV BL,[SI]
      MOV AL,AL1
      
      MUL BL
      
      MOV AX1,AX
      JMP ENDMUL 
      
ENDMUL: CALL UPDTFR

        POPA 
RET

MULOP ENDP

DIVOP PROC 
    
    PUSHA
    CMP USER,1
    JNE DIV1
    
    CMP OP1DW,1
    JNE DIV2
    MOV SI,OPOFF1
    MOV BX,[SI]
    MOV AX,AX2
    MOV DX,DX2
    DIV BX
    MOV AX2,AX
    MOV DX2,DX
    JMP ENDDIV
    
DIV2: MOV SI,OPOFF1
      MOV BL,[SI]
      MOV AX,AX2
      DIV BL
      MOV AH2,AH
      MOV AL2,AL
      
DIV1: CMP OP1DW,1
      JNE DIV3
      MOV SI,OPOFF1
      MOV BX,[SI]
      MOV AX,AX1
      MOV DX,DX1
      DIV BX
      MOV AX1,AX
      MOV DX1,DX
      JMP ENDDIV
    
DIV3: MOV SI,OPOFF1
      MOV BL,[SI]
      MOV AX,AX1
      DIV BL
      MOV AH1,AH
      MOV AL1,AL
      
      
ENDDIV: CALL UPDTFR
        POPA
RET
DIVOP ENDP

PUSHOP PROC
    PUSHA
    CMP MEMOP1,0
    JNE PUSH1
    
    CMP OP1DW,0
    JNE PUSH1
    
    MOV ERCODE,6
    JMP ENDPUSH
    
PUSH1: CMP USER,1
       JNE PUSH2
       
       MOV SI,SP2
       MOV DI,OPOFF1
       MOV AX,[DI]
       MOV [SI],AH
       DEC SI    ; STACK POINTER DECREMENTS WITH EACH BYTE PUSHED
       MOV [SI],AL
       DEC SI    ; STACK POINTER DECREMENTS WITH EACH BYTE PUSHED
       MOV SP2,SI
       JMP ENDPUSH
       
PUSH2: MOV SI,SP1
       MOV DI,OPOFF1
       MOV AX,[DI]
       MOV [SI],AH
       DEC SI    ; STACK POINTER DECREMENTS WITH EACH BYTE PUSHED
       MOV [SI],AL
       DEC SI    ; STACK POINTER DECREMENTS WITH EACH BYTE PUSHED
       MOV SP1,SI
       JMP ENDPUSH

ENDPUSH: POPA
RET
PUSHOP ENDP

POPOP PROC
    PUSHA
    CMP MEMOP1,0
    JNE POP1
    
    CMP OP1DW,0
    JNE POP1
    
    MOV ERCODE,5
    JMP ENDPUSH
    
POP1: CMP USER,1
      JNE POP2
       
      MOV SI,SP2
      MOV DI,OPOFF1
      INC SI    ; STACK POINTER INCREMENTS WITH EACH BYTE POPED
      MOV AL,[SI]
      INC SI    ; STACK POINTER INCREMENTS WITH EACH BYTE POPED
      MOV AH,[SI]
      
      MOV [DI],AX
      
      MOV SP2,SI
      JMP ENDPOP
       
POP2: MOV SI,SP1
      MOV DI,OPOFF1
      INC SI    ; STACK POINTER INCREMENTS WITH EACH BYTE POPED
      MOV AL,[SI]
      INC SI    ; STACK POINTER INCREMENTS WITH EACH BYTE POPED
      MOV AH,[SI]
      
      MOV [DI],AX
      
      MOV SP1,SI
      JMP ENDPOP
 

ENDPOP: POPA
RET
POPOP ENDP

MOVOP PROC 
    PUSHA
    
    MOV SI,OPOFF1
    MOV DI,OPOFF2

    CMP MEMOP1,1
    JNE MOV1
    
    CMP OP2DW,1
    JNE MOV2
    MOV AX,[DI]
    MOV [SI],AX
    JMP ENDMOV
    
    MOV2:
    MOV AL,[DI]
    MOV [SI],AL
    JMP ENDMOV
    
    MOV1:
    CMP OP1DW,1
    JNE MOV3
    MOV AX,[DI]
    MOV [SI],AX
;DisplayStringVM AL2,20,5,10
;CALL GetEnter
    JMP ENDMOV
    
    MOV3:
    MOV AL,[DI]
    MOV [SI],AL
    
    
    ENDMOV:
    POPA
   ;Graphicsmode
   ;DisplayNumVMw AL2,AH2,18,23
   ;CALL GetEnter
   
    RET

    MOVOP ENDP

 ADDOP PROC
    
    PUSHA
    
    MOV SI,OPOFF1
    MOV DI,OPOFF2
    
    CMP MEMOP1,1
    JNE ADD1
    CMP OP2DW,1
    JNE ADD2
   
    MOV AX,[DI] 
    
    ADD [SI],AX
    JMP ENDADD
    
    ADD2:
    MOV AL,[DI] 
    ADD [SI],AL
    JMP ENDADD
    
    ADD1:
    CMP OP1DW,1
    JNE ADD3
    MOV AX,[DI]
    ADD [SI],AX
    JMP ENDADD
    
    ADD3: 
    MOV AL,[DI]
    ADD [SI],AL
    JMP ENDADD 
        
    ENDADD:
    CALL UPDTFR
    POPA
    
    RET 
    ADDOP ENDP

SUBOP PROC
    PUSHA
    MOV SI,OFFSET OPOFF1
    MOV DI,OFFSET OPOFF2
    
    CMP MEMOP1,1
    JNE SUB1
    CMP OP2DW,1
    JNE SUB2
   
    MOV AX,[DI] 
    
    SUB [SI],AX
    JMP ENDSUB
    
    SUB2:
    MOV AL,[DI] 
    SUB [SI],AL
    JMP ENDSUB
    
    SUB1:
    CMP OP1DW,1
    JNE SUB3
    MOV AX,[DI]
    SUB [SI],AX
    JMP ENDSUB
    
    SUB3: 
    MOV AL,[DI]
    SUB [SI],AL
    JMP ENDSUB 
    
    ENDSUB:
    CALL UPDTFR
    POPA
    RET 
    SUBOP ENDP

ADCOP PROC
    PUSHA
    MOV SI,OPOFF1
    MOV DI,OPOFF2
    
    CMP MEMOP1,1
    JNE ADC1
    
    CMP OP2DW,1
    JNE ADC2
    
    CMP USER,1
    JNE ADC3
    
    MOV AX,FR2
    SHR AX,1
    MOV AX,[DI]
    MOV BX,[SI]
    ADC AX,BX
    MOV [SI],AX
    JMP ENDADC
    
ADC3: MOV AX,FR1
      SHR AX,1
      MOV AX,[DI]
      MOV BX,[SI]
      ADC AX,BX
      MOV [SI],AX
      JMP ENDADC    
        
ADC2: CMP USER,1
      JNE ADC4
      MOV AX,FR2
      SHR AX,1
      MOV AL,[DI]
      MOV AH,[SI]
      ADC AL,AH
      MOV [SI],AL
      JMP ENDADC

ADC4: MOV AX,FR1
      SHR AX,1
      MOV AL,[DI]
      MOV AH,[SI]
      ADC AL,AH
      MOV [SI],AL
      JMP ENDADC
      
ADC1: CMP OP1DW,1
      JNE ADC5
    
      CMP USER,1
      JNE ADC6
    
      MOV AX,FR2
      SHR AX,1
      MOV AX,[DI]
      MOV BX,[SI]
      ADC AX,BX
      MOV [SI],AX
      JMP ENDADC
    
ADC6: MOV AX,FR1
      SHR AX,1
      MOV AX,[DI]
      MOV BX,[SI]
      ADC AX,BX
      MOV [SI],AX
      JMP ENDADC    
        
ADC5: CMP USER,1
      JNE ADC7
      MOV AX,FR2
      SHR AX,1
      MOV AL,[DI]
      MOV AH,[SI]
      ADC AL,AH
      MOV [SI],AL
      JMP ENDADC

ADC7: MOV AX,FR1
      SHR AX,1
      MOV AL,[DI]
      MOV AH,[SI]
      ADC AL,AH
      MOV [SI],AL
      
      
ENDADC: CALL UPDTFR
POPA
RET
ADCOP ENDP

SBBOP PROC
    PUSHA
    MOV SI,OPOFF1
    MOV DI,OPOFF2
    
    CMP MEMOP1,1
    JNE SBB1
    
    CMP OP2DW,1
    JNE SBB2
    
    CMP USER,1
    JNE SBB3
    
    MOV AX,FR2
    SHR AX,1
    MOV AX,[DI]
    MOV BX,[SI]
    SBB BX,AX
    MOV [SI],BX
    JMP ENDSBB
    
SBB3: MOV AX,FR1
      SHR AX,1
      MOV AX,[DI]
      MOV BX,[SI]
      SBB BX,AX
      MOV [SI],BX
      JMP ENDSBB    
        
SBB2: CMP USER,1
      JNE SBB4
      MOV AX,FR2
      SHR AX,1
      MOV AL,[DI]
      MOV AH,[SI]
      SBB AH,AL
      MOV [SI],AH
      JMP ENDSBB

SBB4: MOV AX,FR1
      SHR AX,1
      MOV AL,[DI]
      MOV AH,[SI]
      SBB AH,AL
      MOV [SI],AH
      JMP ENDSBB
      
SBB1: CMP OP1DW,1
      JNE SBB5
    
      CMP USER,1
      JNE SBB6
    
      MOV AX,FR2
      SHR AX,1
      MOV AX,[DI]
      MOV BX,[SI]
      SBB BX,AX
      MOV [SI],BX
      JMP ENDSBB
    
SBB6: MOV AX,FR1
      SHR AX,1
      MOV AX,[DI]
      MOV BX,[SI]
      SBB BX,AX
      MOV [SI],BX
      JMP ENDSBB    
        
SBB5: CMP USER,1
      JNE SBB7
      MOV AX,FR2
      SHR AX,1
      MOV AL,[DI]
      MOV AH,[SI]
      SBB AH,AL
      MOV [SI],AH
      JMP ENDSBB

SBB7: MOV AX,FR1
      SHR AX,1
      MOV AL,[DI]
      MOV AH,[SI]
      SBB AH,AL
      MOV [SI],AH
      
      
ENDSBB: CALL UPDTFR
POPA
RET

SBBOP ENDP

ANDOP PROC 
    
    PUSHA
    
    MOV SI, OPOFF1
    MOV DI, OPOFF2
    
    CMP OP1DW,1
    JNE AND1
    
    MOV AX,[SI]
    MOV BX,[DI]
    
    AND AX,BX
    MOV [SI],AX
    JMP ENDAND
    
    AND1:
    MOV AL,[SI]
    MOV AH,[DI]
    
    AND AL,AH
    
    MOV [SI],AL
    
    ENDAND:
    
    CALL UPDTFR
    POPA
    RET
    ANDOP ENDP

OROP PROC
    
    PUSHA
    
    MOV SI, OPOFF1
    MOV DI, OPOFF2
    
    CMP OP1DW,1
    JNE OR1
    
    MOV AX,[SI]
    MOV BX,[DI]
    
    OR AX,BX
    MOV [SI],AX
    JMP ENDOR
    
    OR1:
    MOV AL,[SI]
    MOV AH,[DI]
    
    OR AL,AH
    
    MOV [SI],AL
    
    ENDOR:
    
    CALL UPDTFR 
    
    POPA
    RET
    OROP ENDP 

XOROP PROC
    
    PUSHA
    
    MOV SI, OPOFF1
    MOV DI, OPOFF2
    
    CMP OP1DW,1
    JNE XOR1
    
    MOV AX,[SI]
    MOV BX,[DI]
    
    OR AX,BX
    MOV [SI],AX
    JMP ENDXOR
    
    XOR1:
    MOV AL,[SI]
    MOV AH,[DI]
    
    XOR AL,AH
    
    MOV [SI],AL
    
    ENDXOR:
    
    CALL UPDTFR
    
    POPA
    RET
    XOROP ENDP

UPDTFR PROC 
    PUSHA
    PUSHF
    POP AX 
    
    CMP USER,1
    JNE UPDT1

    MOV FR2,AX
    JMP ENDUPDT
    
UPDT1: MOV FR1,AX

ENDUPDT: POPA

RET

UPDTFR ENDP

CHECKFORBIDDEN PROC
    PUSHA
    MOV SI,OFFSET CMDLINE1+2
    ;MOV AL,[SI]
    MOV FCFOUND,0
    
    CMP USER,1
    JNE CHCKFC1
    
CHCKFC2: 
         MOV AL,[SI]
         CMP AccForChar2,AL
         JE CHCKPOS
         
         CMP AL,'$'
         JE CHCKDONE
         
         INC SI
         
         JMP CHCKFC2     
  
  
  
CHCKFC1: 
         MOV AL,[SI]
         CMP AccForChar1,AL
         JE CHCKPOS
         
         CMP AL,'$'
         JE CHCKDONE
         
         INC SI
         
         JMP CHCKFC1
         
         
CHCKPOS: 
MOV FCFOUND,1
MOV ERCODE,9
CHCKDONE:
POPA
RET

CHECKFORBIDDEN ENDP



GUI1 PROC
    
    Graphicsmode
    DrawLineV 160,0,150         ;split screen line
    DrawLineH 150,0,320         ;error warning line
    DrawLineH 120,0,320         ;command line player 1 
    DrawLineH 10,0,320          ;info segment line
    DrawLineH 170,0,320         ;chat segment line
    DrawMemory                  ;Draws Memory for both players
    DrawRegisters               ;Draws registers for both players
    DisplayRegisters            ;Writes name of registers for both players
    mov MemY,2
    DisplayMemory     MEM1,MemX1,MemY
    mov MemY,2
    DisplayMemory     MEM2,MemX2,MemY
    
    DisplayPlayerInfo     
RET
GUI1 ENDP

UPDATEGUI1 PROC

    DisplayNumVMw      AL1,AH1,3,5
    DisplayNumVMw      BL1,BH1,3,8
    DisplayNumVMw      CL1,CH1,3,10
    DisplayNumVMw      DL1,DH1,3,13     ;Numbers printed of registers for player 1
    
    DisplayNumVMSR     SI1,8,5
    DisplayNumVMSR     DI1,8,8
    DisplayNumVMSR     SP1,8,10
    DisplayNumVMSR     BP1,8,13         ;Numbers printed of segment registers for player 1
    
    DisplayNumVMw      AL2,AH2,24,5
    DisplayNumVMw      BL2,BH2,24,8
    DisplayNumVMw      CL2,CH2,24,10 
    DisplayNumVMw      DL2,DH2,24,13
                                    ;Numbers printed of registers for player 2
    DisplayNumVMSR     SI2,29,5
    DisplayNumVMSR     DI2,29,8                                    
    DisplayNumVMSR     SP2,29,10                                    
    DisplayNumVMSR     BP2,29,13        ;Numbers printed of segment registers for player 2
    mov MemY,2
    DisplayMemory     MEM1,MemX1,MemY
    mov MemY,2
    DisplayMemory     MEM2,MemX2,MemY
    
    DisplayPlayerInfo
RET
UPDATEGUI1 ENDP

GUI2 PROC
    
    Graphicsmode
    DrawLineV 160,0,150         ;split screen line
    DrawLineH 150,0,320         ;error warning line
    DrawLineH 120,0,320         ;command line player 1 
    DrawLineH 10,0,320          ;info segment line
    DrawLineH 170,0,320         ;chat segment line
    DrawMemory                  ;Draws Memory for both players
    DrawRegisters               ;Draws registers for both players
    DisplayRegisters            ;Writes name of registers for both players
    mov MemY,2
    DisplayMemory     MEM1,MemX1,MemY
    mov MemY,2
    DisplayMemory     MEM2,MemX2,MemY
    
    DisplayPlayerInfo2   
RET
GUI2 ENDP

UPDATEGUI2 PROC

    DisplayNumVMw      AL1,AH1,3,5
    DisplayNumVMw      BL1,BH1,3,8
    DisplayNumVMw      CL1,CH1,3,10
    DisplayNumVMw      DL1,DH1,3,13     ;Numbers printed of registers for player 1
    
    DisplayNumVMSR     SI1,8,5
    DisplayNumVMSR     DI1,8,8
    DisplayNumVMSR     SP1,8,10
    DisplayNumVMSR     BP1,8,13         ;Numbers printed of segment registers for player 1
    
    DisplayNumVMw      AL2,AH2,24,5
    DisplayNumVMw      BL2,BH2,24,8
    DisplayNumVMw      CL2,CH2,24,10 
    DisplayNumVMw      DL2,DH2,24,13
                                    ;Numbers printed of registers for player 2
    DisplayNumVMSR     SI2,29,5
    DisplayNumVMSR     DI2,29,8                                    
    DisplayNumVMSR     SP2,29,10                                    
    DisplayNumVMSR     BP2,29,13        ;Numbers printed of segment registers for player 2
    mov MemY,2
    DisplayMemory     MEM1,MemX1,MemY
    mov MemY,2
    DisplayMemory     MEM2,MemX2,MemY
    
    DisplayPlayerInfo2
RET
UPDATEGUI2 ENDP

ENTINFO PROC
    ClearScreen
    MoveCursor 1,1
    mov ah, 9
    mov dx, offset nameMsg ;DISPLAYS NAME INPUT MESSAGE
    int 21h

    mov ah,0AH
    mov dx,offset p1Name   ;TAKES NAME INPUT IN VAR
    int 21h
    
    AddDollarSign Accp1Name;PUTS DOLLAR SIGN AT THE END OF THE STR
    ClearScreen
    
    MoveCursor 1,1
    mov ah, 9
    mov dx, offset nameMsg  ;DISPLAYS NAME INPUT MESSAGE
    int 21h
    
    mov ah,0AH
    mov dx,offset p2Name    ;TAKES NAME INPUT IN VAR
    int 21h
    AddDollarSign Accp2Name ;PUTS DOLLAR SIGN AT THE END OF THE STR
    ClearScreen

    MoveCursor 1,1
    mov ah, 9
    mov dx, offset pointsMsg ;DISPLAYS POINTS INPUT MESSAGE
    int 21h

    mov ah,0AH
    mov dx,offset p1Points   ;TAKES POINTS INPUT IN VAR
    int 21h
    
    AddDollarSign Accp1Points;PUTS DOLLAR SIGN AT THE END OF THE STR

    ClearScreen
    
    MoveCursor 1,1
    mov ah, 9
    mov dx, offset pointsMsg ;DISPLAYS POINTS INPUT MESSAGE
    int 21h

    mov ah,0AH
    mov dx,offset p2Points   ;TAKES POINTS INPUT IN VAR
    int 21h
    
    AddDollarSign Accp2Points;PUTS DOLLAR SIGN AT THE END OF THE NAME
    
    STR2DEC SCORE1,Accp1Points;CHECKS FOR THE LOWER NO. OF POINTS
    STR2DEC SCORE2,Accp2Points;AND INITIALIZES BOTH PLAYERS WITH THIS NO.
    MOV DX,SCORE1
    CMP DX,SCORE2
    JL CHNG2
    JG CHNG1
    
    CHNG2:
    MOV AX,SCORE1
    MOV SCORE2,AX
    DEC2STR SCORE2,Accp2Points
    JMP CHNGEND
    
    CHNG1:
    MOV AX,SCORE2
    MOV SCORE1,AX
    DEC2STR SCORE1,Accp1Points
    CHNGEND:
    MOV SCORE1,0000
    MOV SCORE2,0000
    ClearScreen
    
    MoveCursor 1,1
    mov ah, 9
    mov dx, offset LVLMsg ;DISPLAYS LEVEL INPUT MESSAGE
    int 21h

    mov ah,0AH
    mov dx,offset level   ;TAKES POINTS INPUT IN VAR
    int 21h
    
    AddDollarSign Acclevel;PUTS DOLLAR SIGN AT THE END OF THE STR
    ClearScreen
    
    MoveCursor 1,1
    mov ah, 9
    mov dx, offset ForCharMsg;DISPLAYS FORBIDDEN CHARACTER INPUT MESSAGE
    int 21h
    JMP TAKEFC1
;--------------------------------------------
    TAKEFC1AGAIN:
    MoveCursor 1,1
    ClearScreen
    DisplayString FCERROR
    MoveCursor 1,2
    DisplayString ForCharMsg
    TAKEFC1:
    mov ah,0AH
    mov dx,offset ForChar1;TAKES FORBIDDEN CHARACTER INPUT IN VAR
    int 21h
    AddDollarSign AccForChar1;PUTS DOLLAR SIGN AT THE END OF THE STR
    ;CHECK IF NOT ALPHANEUMERIC:
    CMP [AccForChar1],30H ;CHECK IF SPECIAL CHARACTER BEFORE ZERO
    JL TAKEFC1AGAIN
    CMP [AccForChar1],3AH ;CHECK IF IT IS BETWEEN 0-9 IF YES CONTINUE
    JL GOUSER2FC
    CMP [AccForChar1],41H
    JL TAKEFC1AGAIN
    CMP [AccForChar1],5AH
    JG TAKEFC1AGAIN

    GOUSER2FC:
    ClearScreen
    ;-------------------------------------
    MoveCursor 1,1
    mov ah, 9
    mov dx, offset ForCharMsg;DISPLAYS FORBIDDEN CHARACTER INPUT MESSAGE
    int 21h
    JMP TAKEFC2
    
    TAKEFC2AGAIN:
    MoveCursor 1,1
    ClearScreen
    DisplayString FCERROR
    MoveCursor 1,2
    DisplayString ForCharMsg
    TAKEFC2:
    mov ah,0AH
    mov dx,offset ForChar2;TAKES FORBIDDEN CHARACTER INPUT IN VAR
    int 21h
    AddDollarSign AccForChar2;PUTS DOLLAR SIGN AT THE END OF THE STR
    ;CHECK IF NOT ALPHANEUMERIC:
    CMP [AccForChar2],30H ;CHECK IF SPECIAL CHARACTER BEFORE ZERO
    JL TAKEFC2AGAIN
    CMP [AccForChar2],3AH ;CHECK IF IT IS BETWEEN 0-9 IF YES CONTINUE
    JL GOUSERENDFC
    CMP [AccForChar2],41H
    JL TAKEFC2AGAIN
    CMP [AccForChar2],5AH
    JG TAKEFC2AGAIN

    GOUSERENDFC:
    MoveCursor 1,2
    GetKey INPUT_KEY,ASCII
    CMP INPUT_KEY,3EH
    JNE GOUSERENDFC
    ClearScreen
    
RET    
ENTINFO ENDP

gun_game proc 
 call gun1
 call gun2
mov ah,col
neg col_changer
mov al,col_changer
mov col_changer,al
add ah,al
mov col,ah
 
ret
gun_game endp

LEVEL1 PROC
NWROUND:
MOV AH,0
MOV AL,ROUND
MOV BL,5
DIV BL
CMP AH,0
JE CALL_GUNGAME
JNE D_CALL_GUNGAME
CALL_GUNGAME:
CALL gun_game
CALL GUI1
D_CALL_GUNGAME:
 MOV AL,ROUND ;EVEN user 1, ODD user 2
 MOV AH,0 
 MOV BL,2
 DIV BL ;To know odd or even
 MOV USER,AH ;moves remainder, ODD user 1, EVEN user 2
 INC USER

ROUNDAGAIN:
STR2DEC SCORE1,Accp1Points
CMP SCORE1,0
JE USR2WON

STR2DEC SCORE2,Accp2Points
CMP SCORE2,0
JE USR1WON

MOV AX,WIN_NUM


CMP AX1,AX
JE USR2WON
CMP BX1,AX
JE USR2WON
CMP CX1,AX
JE USR2WON
CMP DX1,AX 
JE USR2WON
CMP SI1,AX 
JE USR2WON
CMP DI1,AX 
JE USR2WON
CMP SP1,AX 
JE USR2WON
CMP BP1,AX 
JE USR2WON


CMP AX2,AX
JE USR1WON
CMP BX2,AX 
JE USR1WON
CMP CX2,AX
JE USR1WON
CMP DX2,AX 
JE USR1WON
CMP SI2,AX 
JE USR1WON
CMP DI2,AX 
JE USR1WON
CMP SP2,AX 
JE USR1WON
CMP BP2,AX 
JE USR1WON


MOV [SCORE1],0000
MOV [SCORE2],0000
CALL UPDATEGUI1
CMP USER,1
JNE CMDUSER2

;RSTCMDLINE PowerupNo1+2
ReadCommandVM PowerupNo1,CmdX1,CmdY
ClearCmd 0,CmdX1,CmdY,19,CmdY
CALL UPDATEGUI1
CMP [AccPowerupNo1],30H ;COMPARE WITH ZERO
JE NOPOWERUP

CMP [AccPowerupNo1],31H ;COMPARE WITH 1
JNE COMP4

MOV AL,AccForChar2
mov PUPFORCHAR,al
 
ReadCommandVM FORCHAR2,CmdX1,CmdY
CALCSCORE1  1,8
CALL UPDATEGUI1


MOV [SCORE1],0000

COMP4:
CMP [AccPowerupNo1],34H ;COMPARE WITH 4
JNE NOPOWERUP
MOV AX1,0000H
MOV BX1,0000H
MOV CX1,0000H
MOV DX1,0000H
MOV SI1,0000H
MOV BP1,0000H
MOV DI1,0000H

MOV AX2,0000H
MOV BX2,0000H
MOV CX2,0000H
MOV DX2,0000H
MOV SI2,0000H
MOV BP2,0000H
MOV DI2,0000H

CALCSCORE1  1,30
MOV [SCORE1],0000
;CECK POWER UPS HERE:

CALL UPDATEGUI1
NOPOWERUP:
RSTCMDLINE CMDLINE1+2
RSTCMDLINE CMD
ReadCommandVM CMDLINE1,CmdX1,CmdY
ClearCmd 0,CmdX1,CmdY,19,CmdY
JMP LL
CMDUSER2: 
ReadCommandVM PowerupNo2,CmdX2,CmdY
ClearCmd 0,CmdX2,CmdY,38,CmdY
CALL UPDATEGUI1
CMP [AccPowerupNo2],30H ;COMPARE WITH ZERO
JE NOPOWERUP1

CMP [AccPowerupNo2],31H ;COMPARE WITH 1
JNE COMP44
MOV AL,AccForChar1
mov PUPFORCHAR,AL
 
ReadCommandVM FORCHAR1,CmdX2,CmdY
CALCSCORE2  1,8
CALL UPDATEGUI1
MOV [SCORE2],0000

COMP44:
CMP [AccPowerupNo2],34H ;COMPARE WITH 4
JNE NOPOWERUP1
MOV AX1,0000H
MOV BX1,0000H
MOV CX1,0000H
MOV DX1,0000H
MOV SI1,0000H
MOV BP1,0000H
MOV DI1,0000H

MOV AX2,0000H
MOV BX2,0000H
MOV CX2,0000H
MOV DX2,0000H
MOV SI2,0000H
MOV BP2,0000H
MOV DI2,0000H

CALCSCORE2  1,30
MOV [SCORE2],0000
;CECK POWER UPS HERE:

CALL UPDATEGUI1
NOPOWERUP1:

RSTCMDLINE CMDLINE1+2
RSTCMDLINE CMD
ReadCommandVM CMDLINE1,CmdX2,CmdY
ClearCmd 0,CmdX2,CmdY,38,CmdY
LL:
CALL CHECKFORBIDDEN ;CHECKKK THE FC
CMP FCFOUND,1
JE ERRORMESSAGE

;CALL SPLITCMD

;CMP ERCODE,0
;JNE ERRORMESSAGE ;there is an error

;JMP CONTINUECODE



;CONTINUECODE:

ClearCmd 0,0,19,39,19
ClearCmd 0,0,20,39,20

CMP USER,1
JNE UPFOR2

CMP [AccPowerupNo1],30H ;NO POWERUP
JNE CHECKPUP1

CALL SPLITCMD
CMP ERCODE,0
JNE ERRORMESSAGE ;there is an error

CALL DOTHECOMMAND
CMP ERCODE,0

JNE ERRORMESSAGE ;there is an error
CALL UPDATEGUI1

JMP ENDTHEPUP
CHECKPUP1:
CMP [AccPowerupNo1],31H ;CHANGE FORBIDDEN CHAR
JNE CHECKPUP2
CALL SPLITCMD
CMP ERCODE,0

JNE ERRORMESSAGE ;there is an error

CALL DOTHECOMMAND

CMP ERCODE,0

JNE ERRORMESSAGE ;there is an error

MOV AL,PUPFORCHAR
MOV AccForChar2,AL

CALL UPDATEGUI1

JMP ENDTHEPUP

CHECKPUP2:
CMP [AccPowerupNo1],32H ;EXECUTE ON OWN PROCESSOR
JNE CHECKPUP3
MOV USER,2
CALL SPLITCMD

CMP ERCODE,0
JNE ERRORMESSAGE ;there is an error

CALL DOTHECOMMAND
CMP ERCODE,0

JNE ERRORMESSAGE ;there is an error
CALCSCORE1  1,5

CALL UPDATEGUI1

MOV USER,1


JMP ENDTHEPUP
CHECKPUP3:

CMP [AccPowerupNo1],33H ;ON BOTH PROCESSORS
JNE CHECKPUP4

MOV USER,2
CALL SPLITCMD
CMP ERCODE,0

JNE ERRORMESSAGE ;there is an error

CALL DOTHECOMMAND
CMP ERCODE,0

JNE ERRORMESSAGE ;there is an error
CALL UPDATEGUI1

MOV USER,1
CALL SPLITCMD
CMP ERCODE,0

JNE ERRORMESSAGE ;there is an error

CALL DOTHECOMMAND
CMP ERCODE,0

JNE ERRORMESSAGE ;there is an error
CALCSCORE1  1,3
CALL UPDATEGUI1

JMP ENDTHEPUP
CHECKPUP4:
CMP [AccPowerupNo1],34H
JNE ENDTHEPUP

JNE CHECKPUP1

CALL SPLITCMD
CMP ERCODE,0

JNE ERRORMESSAGE ;there is an error
CALL DOTHECOMMAND
CMP ERCODE,0

JNE ERRORMESSAGE ;there is an error
CALL UPDATEGUI1

JMP ENDTHEPUP


UPFOR2:
CMP [AccPowerupNo2],30H ;NO PUP
JNE CHECKPUP11

CALL SPLITCMD
CMP ERCODE,0

JNE ERRORMESSAGE ;there is an error
CALL DOTHECOMMAND
CMP ERCODE,0

JNE ERRORMESSAGE ;there is an error
CALL UPDATEGUI1

JMP ENDTHEPUP
CHECKPUP11:
CMP [AccPowerupNo2],31H ; CHANGE FORBIDDEN CHAR
JNE CHECKPUP22

CALL SPLITCMD
CMP ERCODE,0

JNE ERRORMESSAGE ;there is an error
CALL DOTHECOMMAND
CMP ERCODE,0

JNE ERRORMESSAGE ;there is an error
MOV AL,PUPFORCHAR
MOV AccForChar1,AL

CALL UPDATEGUI1

JMP ENDTHEPUP

CHECKPUP22:
CMP [AccPowerupNo2],32H ;ON OWN PROCESSOR

JNE CHECKPUP33
MOV USER,1

CALL SPLITCMD

CMP ERCODE,0
JNE ERRORMESSAGE ;there is an error

CALL DOTHECOMMAND
CMP ERCODE,0

JNE ERRORMESSAGE ;there is an error
CALCSCORE2  1,5
CALL UPDATEGUI1

MOV USER,2

JMP ENDTHEPUP
CHECKPUP33:
CMP [AccPowerupNo2],33H ; ON BOTH
JNE CHECKPUP44

MOV USER,1
CALL SPLITCMD

CMP ERCODE,0
JNE ERRORMESSAGE ;there is an error

CALL DOTHECOMMAND
CMP ERCODE,0

JNE ERRORMESSAGE ;there is an error
CALL UPDATEGUI1

MOV USER,2
CALL SPLITCMD

CMP ERCODE,0
JNE ERRORMESSAGE ;there is an error

CALL DOTHECOMMAND
CMP ERCODE,0

JNE ERRORMESSAGE ;there is an error
CALCSCORE2  1,3
CALL UPDATEGUI1

JMP ENDTHEPUP

CHECKPUP44:
CMP [AccPowerupNo2],34H ;CLEAR ALL REGS
JNE ENDTHEPUP
JNE CHECKPUP1

CALL SPLITCMD
CMP ERCODE,0
JNE ERRORMESSAGE ;there is an error

CALL DOTHECOMMAND
CMP ERCODE,0

JNE ERRORMESSAGE ;there is an error

CALL UPDATEGUI1

JMP ENDTHEPUP

ENDTHEPUP:

JMP CONTINUEHEREEEEEEE

ERRORMESSAGE:
ClearCmd 0,0,19,39,19
ClearCmd 0,0,20,39,20
CMP USER,1
JNE HEISUSER2
STR2DEC SCORE1,Accp1Points
DEC SCORE1
DEC2STR SCORE1,Accp1Points
DisplayErrorMsg      ;Displays Error message and the reason of error
JMP ROUNDAGAIN
HEISUSER2:
STR2DEC SCORE2,Accp2Points
DEC SCORE2
DEC2STR SCORE2,Accp2Points
DisplayErrorMsg      ;Displays Error message and the reason of error
JMP ROUNDAGAIN

CONTINUEHEREEEEEEE:
;-----------
STR2DEC SCORE1,Accp1Points
CMP SCORE1,0
JE USR2WON

STR2DEC SCORE2,Accp2Points
CMP SCORE2,0
JE USR1WON

MOV AX,WIN_NUM


CMP AX1,AX
JE USR2WON
CMP BX1,AX
JE USR2WON
CMP CX1,AX
JE USR2WON
CMP DX1,AX 
JE USR2WON
CMP SI1,AX 
JE USR2WON
CMP DI1,AX 
JE USR2WON
CMP SP1,AX 
JE USR2WON
CMP BP1,AX 
JE USR2WON


CMP AX2,AX
JE USR1WON
CMP BX2,AX 
JE USR1WON
CMP CX2,AX
JE USR1WON
CMP DX2,AX 
JE USR1WON
CMP SI2,AX 
JE USR1WON
CMP DI2,AX 
JE USR1WON
CMP SP2,AX 
JE USR1WON
CMP BP2,AX 
JE USR1WON


MOV SCORE1,0000H
MOV SCORE2,0000H
INC ROUND
JMP NWROUND

USR1WON: MOV PLAYERWON,1
         JMP CONGRATS

USR2WON: MOV PLAYERWON,2

CONGRATS:
CALL UPDATEGUI1
;-----------------------
DisplayStringVM CONGRATSSTR,11,20,0EH
    RET
    LEVEL1 ENDP

LEVEL2 PROC
; MOV USER,1
; CMP USER,1
; JNE ANY_CMDUSER2
; ReadCommandVM WhichProc,CmdX1,CmdY
; ClearCmd 0,CmdX1,CmdY,19,CmdY
; RSTCMDLINE CMDLINE1+2
; RSTCMDLINE CMD
; ReadCommandVM CMDLINE1,CmdX1,CmdY
; ClearCmd 0,CmdX1,CmdY,19,CmdY
; JMP LL2

; ANY_CMDUSER2:
; ReadCommandVM WhichProc,CmdX2,CmdY
; ClearCmd 0,CmdX2,CmdY,38,CmdY
; RSTCMDLINE CMDLINE1+2
; RSTCMDLINE CMD
; ReadCommandVM CMDLINE1,CmdX2,CmdY
; ClearCmd 0,CmdX2,CmdY,38,CmdY
; MOV DONE,1
; JMP LL2

NWROUND2:
MOV AH,0
MOV AL,ROUND
MOV BL,5
DIV BL
CMP AH,0
JE CALL_GUNGAME2
JNE D_CALL_GUNGAME2
CALL_GUNGAME2:
CALL gun_game
CALL GUI2
D_CALL_GUNGAME2:
 MOV AL,ROUND ;EVEN user 1, ODD user 2
 MOV AH,0 
 MOV BL,2
 DIV BL ;To know odd or even
 MOV USER,AH ;moves remainder, ODD user 1, EVEN user 2
 INC USER

ROUNDAGAIN2:
STR2DEC SCORE1,Accp1Points
CMP SCORE1,0
JE USR2WON2

STR2DEC SCORE2,Accp2Points
CMP SCORE2,0
JE USR1WON2

MOV AX,WIN_NUM


CMP AX1,AX
JE USR2WON2
CMP BX1,AX
JE USR2WON2
CMP CX1,AX
JE USR2WON2
CMP DX1,AX 
JE USR2WON2
CMP SI1,AX 
JE USR2WON2
CMP DI1,AX 
JE USR2WON2
CMP SP1,AX 
JE USR2WON2
CMP BP1,AX 
JE USR2WON2


CMP AX2,AX
JE USR1WON2
CMP BX2,AX 
JE USR1WON2
CMP CX2,AX
JE USR1WON2
CMP DX2,AX 
JE USR1WON2
CMP SI2,AX 
JE USR1WON2
CMP DI2,AX 
JE USR1WON2
CMP SP2,AX 
JE USR1WON2
CMP BP2,AX 
JE USR1WON2


MOV [SCORE1],0000
MOV [SCORE2],0000
CALL UPDATEGUI2
CMP USER,1
JNE CMDUSER22

;RSTCMDLINE PowerupNo1+2
ReadCommandVM PowerupNo1,CmdX1,CmdY
ClearCmd 0,CmdX1,CmdY,19,CmdY
CALL UPDATEGUI2
ReadCommandVM WhichProc,CmdX1,CmdY
ClearCmd 0,CmdX1,CmdY,19,CmdY


ASUSUALCONT:
CMP [AccPowerupNo1],30H ;COMPARE WITH ZERO
JE NOPOWERUP12

CMP [AccPowerupNo1],31H ;COMPARE WITH 1
JNE COMP42
MOV AL,AccForChar2
mov PUPFORCHAR,al
 
ReadCommandVM FORCHAR2,CmdX1,CmdY
CALCSCORE1  1,8
CALL UPDATEGUI2

COMP42:
CMP [AccPowerupNo1],34H ;COMPARE WITH 4
JNE NOPOWERUP12
MOV AX1,0000H
MOV BX1,0000H
MOV CX1,0000H
MOV DX1,0000H
MOV SI1,0000H
MOV BP1,0000H
MOV DI1,0000H

MOV AX2,0000H
MOV BX2,0000H
MOV CX2,0000H
MOV DX2,0000H
MOV SI2,0000H
MOV BP2,0000H
MOV DI2,0000H

CALCSCORE1  1,30
MOV [SCORE1],0000
;CECK POWER UPS HERE:

CALL UPDATEGUI2
NOPOWERUP12:
RSTCMDLINE CMDLINE1+2
RSTCMDLINE CMD
ReadCommandVM CMDLINE1,CmdX1,CmdY
ClearCmd 0,CmdX1,CmdY,19,CmdY
JMP LL2
CMDUSER22: 
ReadCommandVM PowerupNo2,CmdX2,CmdY
ClearCmd 0,CmdX2,CmdY,38,CmdY
CALL UPDATEGUI2
ReadCommandVM WhichProc,CmdX2,CmdY
ClearCmd 0,CmdX2,CmdY,38,CmdY

CMP [AccPowerupNo2],30H ;COMPARE WITH ZERO
JE NOPOWERUP22

CMP [AccPowerupNo2],31H ;COMPARE WITH 1
JNE COMP442
MOV AL,AccForChar1
mov PUPFORCHAR,AL
 
ReadCommandVM FORCHAR1,CmdX2,CmdY
CALCSCORE2  1,8
CALL UPDATEGUI2
MOV [SCORE2],0000

COMP442:
CMP [AccPowerupNo2],34H ;COMPARE WITH 4
JNE NOPOWERUP22
MOV AX1,0000H
MOV BX1,0000H
MOV CX1,0000H
MOV DX1,0000H
MOV SI1,0000H
MOV BP1,0000H
MOV DI1,0000H

MOV AX2,0000H
MOV BX2,0000H
MOV CX2,0000H
MOV DX2,0000H
MOV SI2,0000H
MOV BP2,0000H
MOV DI2,0000H

CALCSCORE2  1,30
MOV [SCORE2],0000
;CECK POWER UPS HERE:

CALL UPDATEGUI2
NOPOWERUP22:

RSTCMDLINE CMDLINE1+2
RSTCMDLINE CMD
ReadCommandVM CMDLINE1,CmdX2,CmdY
ClearCmd 0,CmdX2,CmdY,38,CmdY
LL2:
CALL CHECKFORBIDDEN
CMP FCFOUND,1
JE ERRORMESSAGE2

;CONTINUECODE:

ClearCmd 0,0,19,39,19
ClearCmd 0,0,20,39,20

CMP USER,1
JNE WPROC1
CMP AccProc,31H
JNE WPROC2
CMP AccProc,31H
JE  WPROC3

WPROC1:
CMP AccProc,31H
JNE WPROC4
CMP AccProc,31H
JE  WPROC5


CMP USER,1
JNE UPFOR22

CMP [AccPowerupNo1],30H ;NO POWERUP
JNE CHECKPUP12
WPROC2:
CALL SPLITCMD
CMP ERCODE,0
JNE ERRORMESSAGE2 ;there is an error

CALL DOTHECOMMAND
CMP ERCODE,0

JNE ERRORMESSAGE ;there is an error
CALL UPDATEGUI2

JMP ENDTHEPUP2
CHECKPUP12:
CMP [AccPowerupNo1],31H ;CHANGE FORBIDDEN CHAR
JNE CHECKPUP23
CALL SPLITCMD
CMP ERCODE,0

JNE ERRORMESSAGE2 ;there is an error

CALL DOTHECOMMAND
CMP ERCODE,0

JNE ERRORMESSAGE ;there is an error
CALCSCORE1  1,8

CALL UPDATEGUI2

JMP ENDTHEPUP2

CHECKPUP23:
CMP [AccPowerupNo1],32H ;EXECUTE ON OWN PROCESSOR
JNE CHECKPUP32
WPROC3: 
MOV USER,2
CALL SPLITCMD

CMP ERCODE,0
JNE ERRORMESSAGE2 ;there is an error

CALL DOTHECOMMAND
CMP ERCODE,0

JNE ERRORMESSAGE ;there is an error

CMP AccProc,31H
JE LEGAL1
CALCSCORE1  1,5
LEGAL1:
CALL UPDATEGUI2

MOV USER,1


JMP ENDTHEPUP2
CHECKPUP32:

CMP [AccPowerupNo1],33H ;ON BOTH PROCESSORS
JNE CHECKPUP42

MOV USER,2
CALL SPLITCMD
CMP ERCODE,0

JNE ERRORMESSAGE2 ;there is an error

CALL DOTHECOMMAND 
CMP ERCODE,0

JNE ERRORMESSAGE ;there is an error
CALL UPDATEGUI2

MOV USER,1
CALL SPLITCMD
CMP ERCODE,0

JNE ERRORMESSAGE2 ;there is an error

CALL DOTHECOMMAND
CMP ERCODE,0

JNE ERRORMESSAGE ;there is an error
CALCSCORE1  1,3
CALL UPDATEGUI2

JMP ENDTHEPUP2
CHECKPUP42:
CMP [AccPowerupNo1],34H
JNE ENDTHEPUP2

JNE CHECKPUP12

CALL SPLITCMD
CMP ERCODE,0

JNE ERRORMESSAGE2 ;there is an error
CALL DOTHECOMMAND
CMP ERCODE,0

JNE ERRORMESSAGE ;there is an error
CALL UPDATEGUI2

JMP ENDTHEPUP2


UPFOR22: ;HERE
CMP [AccPowerupNo2],30H ;NO PUP
JNE CHECKPUP112
WPROC4:
CALL SPLITCMD
CMP ERCODE,0

JNE ERRORMESSAGE2 ;there is an error
CALL DOTHECOMMAND
CMP ERCODE,0

JNE ERRORMESSAGE ;there is an error
CALL UPDATEGUI2

JMP ENDTHEPUP2
CHECKPUP112:
CMP [AccPowerupNo2],31H ; CHANGE FORBIDDEN CHAR
JNE CHECKPUP222

CALL SPLITCMD
CMP ERCODE,0

JNE ERRORMESSAGE2 ;there is an error
CALL DOTHECOMMAND
CMP ERCODE,0

JNE ERRORMESSAGE ;there is an error
CALCSCORE2  1,8
CALL UPDATEGUI2

JMP ENDTHEPUP2

CHECKPUP222:
CMP [AccPowerupNo2],32H ;ON OWN PROCESSOR

JNE CHECKPUP332
WPROC5:
MOV USER,1

CALL SPLITCMD

CMP ERCODE,0
JNE ERRORMESSAGE2 ;there is an error

CALL DOTHECOMMAND
CMP ERCODE,0

JNE ERRORMESSAGE ;there is an error
CMP AccProc,31H
JE LEGAL2
CALCSCORE1  1,5
LEGAL2:
CALL UPDATEGUI2

MOV USER,2

JMP ENDTHEPUP2
CHECKPUP332:
CMP [AccPowerupNo2],33H ; ON BOTH
JNE CHECKPUP442

MOV USER,1
CALL SPLITCMD

CMP ERCODE,0
JNE ERRORMESSAGE2 ;there is an error

CALL DOTHECOMMAND
CMP ERCODE,0

JNE ERRORMESSAGE ;there is an error
CALL UPDATEGUI2

MOV USER,2
CALL SPLITCMD

CMP ERCODE,0
JNE ERRORMESSAGE2 ;there is an error

CALL DOTHECOMMAND
CMP ERCODE,0

JNE ERRORMESSAGE ;there is an error
CALCSCORE2  1,3
CALL UPDATEGUI2

JMP ENDTHEPUP2

CHECKPUP442:
CMP [AccPowerupNo2],34H ;CLEAR ALL REGS
JNE ENDTHEPUP2
JNE CHECKPUP12

CALL SPLITCMD
CMP ERCODE,0
JNE ERRORMESSAGE2 ;there is an error

CALL DOTHECOMMAND
CMP ERCODE,0

JNE ERRORMESSAGE ;there is an error

CALL UPDATEGUI2

JMP ENDTHEPUP2

ENDTHEPUP2:

JMP CONTINUEHEREEEEEEE2

ERRORMESSAGE2:
ClearCmd 0,0,19,39,19
ClearCmd 0,0,20,39,20
CMP USER,1
JNE HEISUSER22
STR2DEC SCORE1,Accp1Points
DEC SCORE1
DEC2STR SCORE1,Accp1Points
DisplayErrorMsg      ;Displays Error message and the reason of error
JMP ROUNDAGAIN2
HEISUSER22:
STR2DEC SCORE2,Accp2Points
DEC SCORE2
DEC2STR SCORE2,Accp2Points
DisplayErrorMsg      ;Displays Error message and the reason of error
JMP ROUNDAGAIN2

CONTINUEHEREEEEEEE2:
;-----------
STR2DEC SCORE1,Accp1Points
CMP SCORE1,0
JE USR2WON2

STR2DEC SCORE2,Accp2Points
CMP SCORE2,0
JE USR1WON2

MOV AX,WIN_NUM


CMP AX1,AX
JE USR2WON2
CMP BX1,AX
JE USR2WON2
CMP CX1,AX
JE USR2WON2
CMP DX1,AX 
JE USR2WON2
CMP SI1,AX 
JE USR2WON2
CMP DI1,AX 
JE USR2WON2
CMP SP1,AX 
JE USR2WON2
CMP BP1,AX 
JE USR2WON2


CMP AX2,AX
JE USR1WON2
CMP BX2,AX 
JE USR1WON2
CMP CX2,AX
JE USR1WON2
CMP DX2,AX 
JE USR1WON2
CMP SI2,AX 
JE USR1WON2
CMP DI2,AX 
JE USR1WON2
CMP SP2,AX 
JE USR1WON2
CMP BP2,AX 
JE USR1WON2


MOV SCORE1,0000H
MOV SCORE2,0000H
INC ROUND
CMP DONE,0;NOT DONE = 0
;JE ANY_CMDUSER2
JMP NWROUND2

USR1WON2: MOV PLAYERWON,1
         JMP CONGRATS2

USR2WON2: MOV PLAYERWON,2

CONGRATS2:
CALL UPDATEGUI2
;-----------------------
DisplayStringVM CONGRATSSTR,11,20,0EH
    RET
    LEVEL2 ENDP

gun1 proc 
    cmp level,1
    jne call_gui_gun1
    call GUI1
    jmp XT
    call_gui_gun1:
    call GUI2  
    XT:
    MOV AH,2Ch ;get the system time
    INT 21h    ;CH = hour CL = minute DH = second DL = 1/100 seconds
    mov tjump,cl
    start_gun:
    MOV AH,2Ch ;get the system time
    INT 21h    ;CH = hour CL = minute DH = second DL = 1/100 seconds
    cmp DL,t
    je start_gun
    mov t,DL
    cmp cl,tjump
    jne endproc

    score 18,13,sc1b,9
    score 17,13,sc1g,10
    score  37,13,sc2b,9
    score 38,13,sc2g,10
            
    cmp flyx,user1_bound2
    je reverse_dir
    cmp flyx,user1_bound1
    je reverse_dir
    delete_char flyx,flyy

    mov AH,obj_new_position
    add flyx,AH
    disp_fly flyx,flyy,col

    jmp next

    reverse_dir:
    neg obj_new_position
    delete_char flyx,flyy
    mov AH,obj_new_position
    add flyx,AH
    disp_fly flyx,flyy,col


    next:
    disp_gun gunx,guny

    mov ah,01h
    int 16h    
    jnz check_key  
    jmp start_gun
    check_key: mov ah,0h
    int 16h
    cmp ah,77
    je move_right
    cmp ah,75
    je move_left
    cmp ah,72
    je move_up
    cmp ah,80
    je move_down
    cmp ah,57
    je shoot
    jmp start_gun

    move_left:

    mov AH,gun_left

    cmp gunx,user1_bound1
    je move_right
    delete_char gunx,guny

    add gunx,AH
    jmp start_gun

    move_down:
    mov ah,gun_right
    delete_char gunx,guny
    cmp guny,y_bound2
    je move_up
    add guny,ah
    jmp start_gun

    move_right:
    cmp gunx,user1_bound2
    je move_left
    mov AH,gun_right
    delete_char gunx,guny
    add gunx,AH
    jmp start_gun

    move_up:
    mov ah,gun_left
    cmp guny,y_bound1
    je move_down
    delete_char gunx,guny
    add guny,ah
    jmp start_gun

    shoot:
    mov ah,gunx
    mov bulletx,ah
    mov al,guny
    add al,1
    mov bullety,al

    bullet_mov:
    MOV     CX, 00H
    MOV     DX, 0F040H
    MOV     AH, 86H
    INT     15H
    cmp flyx,user1_bound2
    je reverse_dir12
    cmp flyx,user1_bound1
    je reverse_dir12
    delete_char flyx,flyy

    mov AH,obj_new_position
    add flyx,AH
    disp_fly flyx,flyy,col

    jmp m1

    reverse_dir12:
    neg obj_new_position
    delete_char flyx,flyy
    mov AH,obj_new_position
    add flyx,AH
    disp_fly flyx,flyy,col
   m1: delete_char bulletx,bullety
    disp_gun gunx,guny
    dec bullety
    disp_bullet bulletx,bullety
    cmp bullety,0
    JG check_hit
    cmp level,1
    jne call_gui_gun
    call GUI1
     
    jmp start_gun
    call_gui_gun:
    call gui2
    jmp start_gun


    check_hit:
    mov AH,flyy
    cmp bullety,ah
    jne bullet_mov
    mov al,flyx
    cmp bulletx,al
    jne bullet_mov
    mov ah,2
    mov dl,7
    int 21h
    delete_char flyx,flyy
    cmp col,9
    je blue
    inc sc1g
    score 17,13,sc1g,10
    CALCSCORE1 0,1
    ret

    blue:
    inc sc1b
    score 18,13,sc1b,9
    CALCSCORE1 0,2
    endproc: ret
    gun1 endp



    gun2 proc 
    mov  al,13h      ;graphics mode
    int     10H
    MOV AH,2Ch ;get the system time
    INT 21h    ;CH = hour CL = minute DH = second DL = 1/100 seconds
    mov tjump2,cl

    cmp level,1
    jne call_gui_gun22
    call GUI1
    jmp XT2
    call_gui_gun22:
    call GUI2  
    XT2:
    start_gun2:
    MOV AH,2Ch ;get the system time
    INT 21h    ;CH = hour CL = minute DH = second DL = 1/100 seconds
    cmp DL,t
    je start_gun2
    mov t,dl
    cmp cl,tjump2
    jne endproc2
    score 18,13,sc1b,9
    score 17,13,sc1g,10
    score  37,13,sc2b,9
    score 38,13,sc2g,10

    cmp fly2x,user2_bound2
    je reverse_dir2
    cmp fly2x,user2_bound1
    je reverse_dir2
    delete_char fly2x,fly2y

    mov AH,obj_new_position
    add fly2x,AH
    disp_fly fly2x,fly2y,col

    jmp next2

    reverse_dir2:
    neg obj_new_position
    delete_char fly2x,fly2y
    mov AH,obj_new_position
    add fly2x,AH
    disp_fly fly2x,fly2y,col


    next2:
    disp_gun gun2x,gun2y

    mov ah,01h
    int 16h   
    jnz check_key2
    jmp start_gun2
    check_key2: mov ah,0h
    int 16h
    cmp ah,77
    je move_right2
    cmp ah,75
    je move_left2
    cmp ah,72
    je move_up2
    cmp ah,80
    je move_down2
    cmp ah,57
    je shoot2
    jmp start_gun2

    move_left2:

    mov AH,gun_left

    cmp gun2x,user2_bound1
    je move_right2
    delete_char gun2x,gun2y

    add gun2x,AH
    jmp start_gun2

    move_down2:
    mov ah,gun_right
    delete_char gun2x,gun2y
    cmp gun2y,y_bound2
    je move_up2
    add gun2y,ah
    jmp start_gun2

    move_right2:
    cmp gun2x,user2_bound2
    je move_left2
    mov AH,gun_right
    delete_char gun2x,gun2y
    add gun2x,AH
    jmp start_gun2

    move_up2:
    mov ah,gun_left
    cmp gun2y,y_bound1
    je move_down2
    delete_char gun2x,gun2y
    add gun2y,ah
    jmp start_gun2

    shoot2:
    mov ah,gun2x
    mov bullet2x,ah
    mov al,gun2y
    add al,1
    mov bullet2y,al
    bullet_mov2:
    MOV     CX, 00H
    MOV     DX, 0F040H
    MOV     AH, 86H
    INT     15H
    cmp fly2x,user2_bound2
    je reverse_dir22
    cmp fly2x,user2_bound1
    je reverse_dir22
    delete_char fly2x,fly2y

    mov AH,obj_new_position
    add fly2x,AH
    disp_fly fly2x,fly2y,col

    jmp bnm1234

    reverse_dir22:
    neg obj_new_position
    delete_char fly2x,fly2y
    mov AH,obj_new_position
    add fly2x,AH
    disp_fly fly2x,fly2y,col
   bnm1234:
    delete_char bullet2x,bullet2y
    disp_gun gun2x,gun2y
    dec bullet2y
    disp_bullet bullet2x,bullet2y
    cmp bullet2y,0
    JG check_hit2
    cmp level,1
    jne call_gui_gun2
    call gui1
    jmp start_gun2
    call_gui_gun2:
    call gui2
    jmp start_gun2

    check_hit2:
    mov AH,fly2y
    cmp bullet2y,ah
    jne bullet_mov2
    mov al,fly2x
    cmp bullet2x,al
    jne bullet_mov2
    mov ah,2
    mov dl,7
    int 21h
    delete_char fly2x,fly2y
    cmp col,9
    je blue1
    inc sc2g
    score 17,13,sc2g,10
    CALCSCORE2 0,1
    ret
    blue1:
    inc sc2b
    score 18,13,sc2b,9
    CALCSCORE2 0,2
    endproc2: ret
    gun2 endp    


; MAIN PROGRAM

MAIN PROC FAR

MOV AX,@DATA
MOV DS,AX
MOV ES,AX

PUSHF
POP AX
MOV FR2,AX
MOV FR1,AX

MOV SI,OFFSET MEM1
ADD SI,9
MOV SP1,SI
MOV DI,OFFSET MEM2
ADD DI,9
MOV SP2,DI

PUSHF
MOV AH,0

CALL ENTINFO
CMP [Acclevel],31H ;1
JE LEVEL1START
CMP [Acclevel],32H ;2
JE LEVEL2START

LEVEL1START:
CALL GUI1
CALL LEVEL1
JMP ENDTHEPROGRAM
LEVEL2START:
CALL GUI2
CALL LEVEL2
ENDTHEPROGRAM:
MoveCursor 0,22
mov AH,4Ch
int 21h
MAIN ENDP 

END MAIN ;END OF PROGRAM


;AADMODE 1 INDIRECT ADDRESSING MODE 
;2 register indirect
;0 immediate or register
