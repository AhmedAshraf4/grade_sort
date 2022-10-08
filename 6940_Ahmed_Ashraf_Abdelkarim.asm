INCLUDE EMU8086.INC
DATA SEGMENT    
STR  DB     "  ENTER GRADE: $"
GRADES:
DB   0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0    
IDS:
DB   0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0    

ends

STACK SEGMENT
DW    128 DUP(0)
ENDS


CODE SEGMENT 

;Enter an ID in the form of xx and enter the grade in the form of
; xxx where x is a digit 

START:  

;Input loop to take IDs and grades from the user by taking ascii
;value and converting it into hexa

MOV     CL,25
MOV     SI,[GRADES]

INPUTS: 
MOV     AX,@DATA
MOV     DS,AX


PRINT   "Enter student ID: "  

  
MOV     AH,01H
INT     21H
SUB     AL,30H
MOV     BH,AL

MOV     AH,01H
INT     21H
SUB     AL,30H
MOV     CH,AL

MOV     AL,BH
MOV     BL,10

MUL     BL
ADD     CH,AL

MOV     [SI+25],CH


LEA     DX,STR
MOV     AH,09H
INT     21H

MOV     AH,01H
INT     21H
SUB     AL,30H
MOV     BH,AL

MOV     AH,01H
INT     21H
SUB     AL,30H
MOV     CH,AL

MOV     AL,BH
MOV     BL,10

MUL     BL
ADD     CH,AL

MOV     AH,01H
INT     21H
SUB     AL,30H
MOV     DH,AL

MOV     AL,CH
MOV     BL,10

MUL     BL
ADD     AL,DH

 
MOV     [SI],AL  

MOV     AH,2
MOV     DL,0AH
INT     21H
MOV     DL,0DH
INT     21H

INC     SI 
DEC     CL
CMP     CL,0
JNE     INPUTS

;This program sorts data in a decending order using bubble sort
MOV     CL,24
OUTERLOOP:
MOV     CH,25
DEC     CH
MOV     SI,[GRADES]
INNERLOOP:
MOV     AL,[SI]  
MOV     AH,[SI+25]
INC     SI
CMP     AL,[SI]
JNC     NOSWAP
XCHG    AL,[SI]
XCHG    AH,[SI+25]
DEC     SI
XCHG    AL,[SI]
XCHG    AH,[SI+25]
INC     SI
NOSWAP: 
DEC     CH
JNZ     INNERLOOP
DEC     CL
JNZ     OUTERLOOP



; loop for printing IDs and grades in a table in a decsending order  

MOV     CX,25
MOV     AX,0
MOV     SI,[GRADES]

PRINT   "ID:   GRADE:"
  
L1: 
CALL    PTHIS
DB      10,13,0
MOV     AL,[SI+25]
CALL    PRINT_NUM 
PRINT   "     "
MOV     AL,[SI]
CALL    PRINT_NUM
INC     SI
LOOP    L1      
ret                     
DEFINE_SCAN_NUM
DEFINE_PRINT_STRING
DEFINE_PRINT_NUM
DEFINE_PRINT_NUM_UNS
DEFINE_PTHIS  
END  













