.MODEL SMALL
.STACK 100H

; the newline macro
PRINT_NEWLINE MACRO
    PUSH DX
    PUSH AX
    LEA DX, NEWLINE
    MOV AH, 9
    INT 21H
    POP AX
    POP DX
ENDM


.DATA
    ; Welcome and score messages
    STAR_LINE DB     '******************************************',0DH,0AH,'$'
    EMPTY_LINE DB    '*                                        *',0DH,0AH,'$'
    WELCOME_TEXT DB  '*         Welcome to Quiz Game!          *',0DH,0AH
                 DB  '* Presented by Arafat, Arpita and Sadman *',0DH,0AH,'$'
                 ;DB  '* Arafat, Arpita and Sadman *',0DH,0AH,'$'
    CONGRATS_TEXT DB '*         Congratulations on             *',0DH,0AH
                  DB '*         completing the quiz!           *',0DH,0AH,'$'
    
 ASCII_ART DB  '  ___ __   ___  ______  ',0DH,0AH
         DB ' |__ \\ \\ / / |/ / __ \\ ',0DH,0AH
         DB '    ) |\\ V /| '' / |  | |',0DH,0AH
         DB '   / /  > < |  <| |  | |',0DH,0AH
         DB '  / /_ / . \\| . \\ |__| |',0DH,0AH
         DB ' |____/_/ \\_\\_|\\_\\____/ ',0DH,0AH,'$'
        

    
    NEWLINE DB 0DH,0AH,'$'
    SCORE_MSG DB 'Your final score is: $'
    CORRECT_MSG DB '* Correct! *$'
    WRONG_MSG DB '* Wrong! *$'

    ; Questions
    QUESTIONS DW OFFSET Q1, OFFSET Q2, OFFSET Q3, OFFSET Q4, OFFSET Q5, OFFSET Q6, OFFSET Q7, OFFSET Q8, OFFSET Q9, OFFSET Q10
    ANSWERS DB 'a','c','a','b','a','c','b','b','b','a'

    Q1 DB 'Question 1: What is the national flower of Bangladesh?',0DH,0AH
       DB 'a) Water Lily',0DH,0AH
       DB 'b) Lotus',0DH,0AH
       DB 'c) Rose',0DH,0AH
       DB 'd) Sunflower',0DH,0AH
       DB 'Your answer (a/b/c/d): $'
       
    Q2 DB 'Question 2: What is the capital of Bangladesh?',0DH,0AH
       DB 'a) Chittagong',0DH,0AH
       DB 'b) Sylhet',0DH,0AH
       DB 'c) Dhaka',0DH,0AH
       DB 'd) Rajshahi',0DH,0AH
       DB 'Your answer (a/b/c/d): $'
       
    Q3 DB 'Question 3: What is the highest peak in Bangladesh?',0DH,0AH
       DB 'a) Saka Haphong',0DH,0AH
       DB 'b) Keokradong',0DH,0AH
       DB 'c) Tazing Dong',0DH,0AH
       DB 'd) Chimbuk Hill',0DH,0AH
       DB 'Your answer (a/b/c/d): $'
          
    Q4 DB 'Question 4: What is the largest river in Bangladesh?',0DH,0AH
       DB 'a) Jamuna',0DH,0AH
       DB 'b) Padma',0DH,0AH
       DB 'c) Meghna',0DH,0AH
       DB 'd) Brahmaputra',0DH,0AH
       DB 'Your answer (a/b/c/d): $'  
       
    Q5 DB 'Question 5: Which is the national bird of Bangladesh?',0DH,0AH
       DB 'a) Magpie Robin',0DH,0AH
       DB 'b) Peacock',0DH,0AH
       DB 'c) Sparrow',0DH,0AH
       DB 'd) Kingfisher',0DH,0AH
       DB 'Your answer (a/b/c/d): $'
       
    Q6 DB 'Question 6: What is the official language of Bangladesh?',0DH,0AH
       DB 'a) Urdu',0DH,0AH
       DB 'b) Hindi',0DH,0AH
       DB 'c) Bengali',0DH,0AH
       DB 'd) English',0DH,0AH
       DB 'Your answer (a/b/c/d): $'
       
    Q7 DB 'Question 7: Where is the Sundarbans located?',0DH,0AH
       DB 'a) Chittagong',0DH,0AH
       DB 'b) Khulna',0DH,0AH
       DB 'c) Sylhet',0DH,0AH
       DB 'd) Rajshahi',0DH,0AH
       DB 'Your answer (a/b/c/d): $'
       
    Q8 DB 'Question 8: What is the currency of Bangladesh?',0DH,0AH
       DB 'a) Rupee',0DH,0AH
       DB 'b) Taka',0DH,0AH
       DB 'c) Dollar',0DH,0AH
       DB 'd) Dinar',0DH,0AH
       DB 'Your answer (a/b/c/d): $'
       
    Q9 DB 'Question 9: Which is the national sport of Bangladesh?',0DH,0AH
       DB 'a) Football',0DH,0AH
       DB 'b) Kabaddi',0DH,0AH
       DB 'c) Cricket',0DH,0AH
       DB 'd) Hockey',0DH,0AH
       DB 'Your answer (a/b/c/d): $'
       
    Q10 DB 'Question 10: Where is the Shaheed Minar located?',0DH,0AH
        DB 'a) Dhaka',0DH,0AH
        DB 'b) Sylhet',0DH,0AH
        DB 'c) Rajshahi',0DH,0AH
        DB 'd) Chittagong',0DH,0AH
        DB 'Your answer (a/b/c/d): $'

    SCORE DB 0

.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX
    
    
    CALL DISPLAY_BOX
    LEA DX, ASCII_ART
    CALL DISPLAY_CENTER
    CALL DISPLAY_BOX
    PRINT_NEWLINE
    
    
    ; Display welcome message box
    CALL DISPLAY_BOX
    LEA DX, WELCOME_TEXT
    
    CALL DISPLAY_CENTER
    CALL DISPLAY_BOX
    
    PRINT_NEWLINE
    
    ; Initialize score
    MOV SCORE, 0
    
    ; Loop through questions
    MOV CX, 10          ; Number of questions
    LEA SI, QUESTIONS   ; Point to the question offsets
    LEA DI, ANSWERS     ; Point to the answers array

QUESTION_LOOP: 
    PRINT_NEWLINE
    
    ; Display question
    MOV BX, [SI]        ; Load question address
    LEA DX, [BX]
    MOV AH, 9
    INT 21H
    
    ; Get user input
    MOV AH, 1
    INT 21H

    ; Convert to lowercase if uppercase
    CMP AL, 'A'
    JL SKIP_CONVERSION
    CMP AL, 'Z'
    JG SKIP_CONVERSION
    ADD AL, 32   
    
SKIP_CONVERSION:

    ; Compare with correct answer
    MOV BL, [DI]
    CMP AL, BL 
    
    PRINT_NEWLINE
    
    JNE WRONG
    INC SCORE
    LEA DX, CORRECT_MSG
    
    JMP DISPLAY_RESULT

WRONG:
    LEA DX, WRONG_MSG 
    

DISPLAY_RESULT:
    MOV AH, 9
    INT 21H
    
    PRINT_NEWLINE
    
    ; Move to next question
    ADD SI, 2           ; Increment to next question offset
    INC DI              ; Increment to next answer
    LOOP QUESTION_LOOP

    PRINT_NEWLINE
    
    ; Display final score
    LEA DX, SCORE_MSG
    MOV AH, 9
    INT 21H
    
    PRINT_NEWLINE
    
    MOV AX, 0      ; Clear AX  
    MOV AL, SCORE   ; Move score to AL
    
    ; Convert to decimal
    MOV BL, 10
    DIV BL          ; Divide by 10 - AL contains quotient, AH contains remainder
    
    ; Display first digit (tens)
    PUSH AX         ; Save AX (we need the remainder in AH)
    MOV DL, AL      ; Move quotient to DL
    ADD DL, 30H     ; Convert to ASCII
    MOV AH, 2       ; Display character function
    INT 21H
    
    ; Display second digit (ones)
    POP AX          ; Restore AX to get remainder
    MOV DL, AH      ; Move remainder to DL
    ADD DL, 30H     ; Convert to ASCII
    MOV AH, 2       ; Display character function
    INT 21H
    
    PRINT_NEWLINE
    
    ; Display congratulations box
    CALL DISPLAY_BOX
    LEA DX, CONGRATS_TEXT
    CALL DISPLAY_CENTER
    CALL DISPLAY_BOX
    
    MOV AH, 4CH
    INT 21H
    
MAIN ENDP

; Subroutine to display a centered box
DISPLAY_BOX PROC
    MOV CX, 2            ; Number of lines in the box
BOX_LOOP:
    LEA DX, STAR_LINE
    MOV AH, 9
    INT 21H
    LOOP BOX_LOOP
    RET
DISPLAY_BOX ENDP

; Subroutine to display centered text
DISPLAY_CENTER PROC
    MOV AH, 9
    INT 21H
    RET
DISPLAY_CENTER ENDP

END MAIN