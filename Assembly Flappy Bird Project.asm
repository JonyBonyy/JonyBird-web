; multi-segment executable file template.

data segment
    ; add your data here!
    
    ;bird
    height dw 100 
    x dw 25
    tempX dw ?
    tempY dw ?
    jumpCnt dw 40
    color db 11
    color2 db 14
    color3 db 6
    colorCnt dw ?
    fillCnt dw ? 
    fillCnt2 dw ?
    
    ;strings
    best_score db 'best:$'
    your_score_is db 'Your score is:$'
    Quit_Or_Play_Again db "Would you like to play again? y/n$"
    flappy_bird db 'FLAPPY BIRD$'
    welcome db 'Welcome To Flappy Bird!$'
    welcome2 db 'This Game Was Created By Jonathan$' 
    game_menu db 'GAME MENU:$'
    points_amount db 'points:$'
    
    basic_input_menu db 'Basic Input Menu:', 0dh, 0ah, 0ah
    db 'Jump = SPACE', 0dh, 0ah
    db 'Play Again = Y', 0dh, 0ah
    db 'End Game = N$'
    
    color_menu db 'Color menu:', 0dh, 0ah, 0ah 
    db 'Yellow = P', 0dh, 0ah
    db 'Pink = O', 0dh, 0ah
    db 'White = I', 0dh, 0ah 
    db 'Red = U', 0dh, 0ah
    db 'Brown = T', 0dh, 0ah
    db 'Purple = R', 0dh, 0ah, 0ah
    db 'Wing Brown = L', 0dh, 0ah
    db 'Wing White = K', 0dh, 0ah
    db 'Wing Pink = J', 0dh, 0ah 
    db 'Wing Red = H', 0dh, 0ah
    db 'Wing Yellow = G', 0dh, 0ah
    db 'Wing Purple = F$'
    
    
    ;bird points
    pointX1 dw ?
    pointY1 dw ?
    pointX2 dw ?
    pointY2 dw ?
    pointX3 dw ?
    pointY3 dw ?
    pointX4 dw ?
    pointY4 dw ?
    pointX5 dw ?
    pointY5 dw ?
    pointX6 dw ?
    pointY6 dw ?
    
    ;bar1
    barY dw 200
    barX dw 317
    tempBarY dw ?
    tempBarX dw ?
    lowerBar db ?
    upperBar db 200
    barDistance dw ?
    upperCnt dw ?
    barsFlag dw ?
    fillLowerCnt1 dw ? ;17 - 36
    fillLowerCnt2 dw ?
    fillUpperCnt1 dw ?
    fillUpperCnt2 dw ?
    gap equ 80
    
    ;bar2
    barY2 dw 200
    barX2 dw 317
    tempBarY2 dw ?
    tempBarX2 dw ?
    lowerBar2 db ?
    upperBar2 db 200
    barDistance2 dw ?
    upperCnt2 dw ?
    barsFlag2 dw ?
    fillLowerCnt1Bar2 dw ? ;17 - 36
    fillLowerCnt2Bar2 dw ?
    fillUpperCnt1Bar2 dw ?
    fillUpperCnt2Bar2 dw ?
    bar2Cnt dw 190
    
    ;bar1 openings
    tempBarDistance dw ?
    barOpeningX dw ?
    barOpeningY dw ?
    barOpeningCnt dw ?
    barOpeningX2 dw ?
    barOpeningY2 dw ?
    barOpeningCnt2 dw ?
    
    ;bar2 openings
    tempBarDistance2 dw ?
    barOpeningXBar2 dw ?
    barOpeningYBar2 dw ?
    barOpeningCntBar2 dw ?
    barOpeningX2Bar2 dw ?
    barOpeningY2Bar2 dw ?
    barOpeningCnt2Bar2 dw ?
    
    ;outers
    startFlag db ?
    soundCnt db ?
    score dw ?
    scoreCnt db ?
    best dw ?
    collisionFlag db ?
    points dw ?

ends

stack segment
    dw   128  dup(0)
ends

code segment
start:
; set segment registers:
    mov ax, data
    mov ds, ax
    mov es, ax
    
       
BACK_TO_CODE:

    
               
    ;------set grapic mode-------
    mov al, 13h
	mov ah, 0
	int 10h
	
	
	;jmp BIRDFALL
	
	
	
	call CLEAR_SCREEN
	
    
    
;---------------------------bird fall-----------------------
    
         
         
         
    jmp BIRDFALL

BIRDJUMP:
    cmp colorCNT, 1
    je SKIP123
             
    dec height 
    
    cmp height, 0
    je TO_HIGH
SKIP123:
    
    dec jumpCnt
	jz BIRDFALL ;hereeeeeeeeeeeeeeeeeeee
	 
	
BIRDFALL:

    call PRINT_SCORE
    
    cmp colorCnt, 0
    je PRINT_BLACK
    
    ;----------wait 0.045 second-------
    mov cx, 00
    mov dx, 90
    mov ah, 86h
    int 15h
    
    ;mov cx, 00
    ;mov dx, 90
    ;mov ah, 86h
    ;int 15h
    
    ;mov cx, 00
    ;mov dx, 90
    ;mov ah, 86h
    ;int 15h
    
    ;mov cx, 00
    ;mov dx, 90
    ;mov ah, 86h
    ;int 15h
    
    cmp soundCnt, 0
    je SKIP_WAIT_TIME
    
    inc soundCnt
    
    cmp soundCnt, 3
    jbe SKIP_WAIT_TIME
    
    
    call STOP_SOUND
     
    

SKIP_WAIT_TIME:    
    mov color, 11;0 ;opisite
    jmp PRINT_BLUE
    
PRINT_BLACK:
    mov color, 0;15 ;oppisite
    
    cmp jumpCnt, 40
    jne PRINT_BLUE
     
    inc height
    
PRINT_BLUE:
    
    cmp jumpCnt, 0
    jne STILL_IN_JUMP_LOOP
    
    mov jumpCnt, 40
    
STILL_IN_JUMP_LOOP:
    
	mov cx, x
	mov pointX1, cx
	
	mov cx, height
    mov pointY1, cx
      
	mov fillCnt, 27
	mov bx, 29
PRINT_BIRD_UP_PART: ;part 1
	mov al, color
	mov cx, x
	mov dx, height
	mov ah, 0ch
	int 10h
	
FILL_BIRD_PART1:
    
    inc height

	mov al, color2;14
	mov cx, x
	mov dx, height
	mov ah, 0ch
	int 10h
	
	dec bx
	jz INC_X_TO_FILL_BIRD
	
	loop FILL_BIRD_PART1
	
INC_X_TO_FILL_BIRD:
    
    mov bx, 29
    sub height, bx
	inc x
	
	mov al, color
	mov cx, x
	mov dx, height
	mov ah, 0ch
	int 10h
	
	dec fillCnt
	jz PRINT_BIRD_PART2 
         
	loop FILL_BIRD_PART1
	                        ;ends
PRINT_BIRD_PART2:  ;part 2
    
    mov cx, x
	mov pointX2, cx
	
	mov cx, height
    mov pointY2, cx

    mov fillCnt, 3
    mov fillCnt2, 29
    mov bx, 29
PRINT_BIRD_PART2_AGAIN:
	
	inc height
	
	mov al, color2;14
	mov cx, x
	mov dx, height
	mov ah, 0ch
	int 10h

	dec bx
	jz FILL_BIRD_PART2
	
	loop PRINT_BIRD_PART2_AGAIN
	 
	 
FILL_BIRD_PART2:
    mov cx, fillCnt2
    sub height, cx
    sub fillCnt2, 2
    mov bx, fillCnt2
    
    inc x
    inc height
    
    mov al, color
	mov cx, x
	mov dx, height
	mov ah, 0ch
	int 10h
	
	dec fillCnt
	jz PRINT_BIRD_PART3 
	
	loop PRINT_BIRD_PART2_AGAIN
    
	               ;ends
PRINT_BIRD_PART3: ;part 3
    mov bx, 6
    
    PRINT_BIRD_PART3_AGAIN:
	mov al, color
	mov cx, x
	mov dx, height
	mov ah, 0ch
	int 10h
	
	inc height
	
	dec bx
	jz PRINT_BIRD_PART4 
	loop PRINT_BIRD_PART3_AGAIN
	                   ;ends
PRINT_BIRD_PART4: ;part 4
    
    mov fillCnt, 6
    mov fillCnt2, 6
    mov bx, 6
PRINT_BIRD_PART4_AGAIN:	        
	mov al, 43
	mov cx, x
	mov dx, height
	mov ah, 0ch
	int 10h

	inc height
	
	dec bx
	jz FILL_BIRD_PART3 
	loop PRINT_BIRD_PART4_AGAIN
	
	
FILL_BIRD_PART3:

    mov cx, fillCnt2
    sub height, cx
    dec fillCnt2
    mov bx, fillCnt2
    
    
    mov al, color
	mov cx, x
	mov dx, height
	mov ah, 0ch
	int 10h
	
	inc x
    inc height
	
	dec fillCnt
	jz PRINT_BIRD_LINE 
	
	loop PRINT_BIRD_PART4_AGAIN	
	
	 
PRINT_BIRD_LINE:
    
    mov cx, x
	mov pointX3, cx
	
	mov cx, height
    mov pointY3, cx
    
    dec x
    mov fillCnt, 5
    mov fillCnt2, 1
    mov bx, 10
PRINT_BIRD_LINE_AGAIN:
    mov si, fillCnt2
    
    cmp fillCnt, 5
    je SKIP_INC_X11
    
    inc x   
SKIP_INC_X11:
   
    mov al, 0
	mov cx, x
	mov dx, height
	mov ah, 0ch
	int 10h 
	 
	dec bx
	jz PRINT_BIRD_PART5
	 
	cmp bx, 5
	jae FILL_BIRD_PART4
	 
	
    loop PRINT_BIRD_LINE_AGAIN
    
FILL_BIRD_PART4:

    mov al, 43
	mov cx, x
	mov dx, height
	mov ah, 0ch
	int 10h
    
    inc height
    
    dec fillCnt2
	jz INC_X2
	
    jmp FILL_BIRD_PART4
    
INC_X2:
    mov fillCnt2, si
    inc fillCnt2
    sub height, si
    
    dec x
    dec x
    
    dec fillCnt
	jz PRINT_BIRD_LINE_AGAIN
    
    jmp PRINT_BIRD_LINE_AGAIN
                                ;ends
PRINT_BIRD_PART5: ;part 5
    
    inc x
    
    mov al, 0
	mov cx, x
	mov dx, height
	mov ah, 0ch
	int 10h
	
	dec x
    
    inc x
    inc x
    mov bx, 6
    
PRINT_BIRD_PART5_AGAIN:
    dec x
    inc height
	
    mov al, color
	mov cx, x
	mov dx, height
	mov ah, 0ch
	int 10h
	
	dec bx
	jz FINISH_FILL_BIRD_PART4
	LOOP PRINT_BIRD_PART5_AGAIN  
	
FINISH_FILL_BIRD_PART4:


	mov fillCnt, 5
	mov bx, 5
FINISH_FILL_BIRD_PART4_AGAIN:
    
    dec height
    
    mov al, 43
	mov cx, x
	mov dx, height
	mov ah, 0ch
	int 10h
	
	dec fillCnt
	jz PRINT_BIRD_PART6
	
	jmp FINISH_FILL_BIRD_PART4_AGAIN 
           ;ends
PRINT_BIRD_PART6: ;part 6
	
	add height, bx
	
    mov bx, 6
	
PRINT_BIRD_PART6_AGAIN:
	mov al, color
	mov cx, x
	mov dx, height
	mov ah, 0ch
	int 10h
	
	inc height
	
	dec bx
	jz PRINT_BIRD_PART7 
	loop PRINT_BIRD_PART6_AGAIN
                  ;ends
PRINT_BIRD_PART7: ;part 7
 
    mov bx, 3
PRINT_BIRD_PART7_AGAIN:
	dec x
	inc height
	
	mov al, color
	mov cx, x
	mov dx, height
	mov ah, 0ch
	int 10h
	
	dec bx
	jz PRINT_BIRD_PART8
	loop PRINT_BIRD_PART7_AGAIN
	         
	              
	
PRINT_BIRD_PART8:
    
    mov cx, x
	mov pointX4, cx
	
	mov cx, height
    mov pointY4, cx

	mov bx, 27
PRINT_BIRD_PART8_AGAIN:
	dec x
	
	mov al, color
	mov cx, x
	mov dx, height
	mov ah, 0ch
	int 10h
	dec bx
	jz PRINT_BIRD_PART9
	loop PRINT_BIRD_PART8_AGAIN
	
PRINT_BIRD_PART9:

    mov cx, x
	mov pointX5, cx
	
	mov cx, height
    mov pointY5, cx
    
    mov fillCnt, 3
    mov fillCnt2, 29
    mov bx, 29
PRINT_BIRD_PART9_AGAIN:
	
	dec height
	
	mov al, color2;14
	mov cx, x
	mov dx, height
	mov ah, 0ch
	int 10h
	dec bx
	jz FILL_BIRD_PART5
	loop PRINT_BIRD_PART9_AGAIN
	
FILL_BIRD_PART5:
    mov cx, fillCnt2
    add height, cx
    sub fillCnt2, 2
    mov bx, fillCnt2
    
    dec x
    dec height
    
    mov al, color
	mov cx, x
	mov dx, height
	mov ah, 0ch
	int 10h
	
	dec fillCnt
	jz PRINT_BIRD_PART10 
	
	loop PRINT_BIRD_PART9_AGAIN
	  
	
PRINT_BIRD_PART10:
    mov bx, 9
PRINT_BIRD_PART10_AGAIN:
	dec height
	
	mov al, color
	mov cx, x
	mov dx, height
	mov ah, 0ch
	int 10h
	dec bx
	jz CHECK_WING
	loop PRINT_BIRD_PART10_AGAIN
	
CHECK_WING:
    cmp jumpCnt, 40
    je PRINT_BIRD_WING
    
    mov tempX, 27
    mov bx, height
    mov tempY, bx
    
    mov al, 0
	mov cx, tempX
	mov dx, tempY
	mov ah, 0ch
	int 10h
	
    mov fillCnt, 8
    mov fillCnt2, 8
    mov bx, 8
PRINT_BIRD_WING_UP:
    dec tempY
    
    mov al, color3
	mov cx, tempX
	mov dx, tempY
	mov ah, 0ch
	int 10h
	
	dec bx
	jz FILL_BIRD_PART6_UP
	
	jmp PRINT_BIRD_WING_UP
	
FILL_BIRD_PART6_UP:
    mov cx, fillCnt2
    add tempY, cx
    dec fillCnt2
    mov bx, fillCnt2
	
	mov al, 0
	mov cx, tempX
	mov dx, tempY
	mov ah, 0ch
	int 10h
	
	inc tempX 
	
	dec fillCnt
	jz PRINT_BIRD_WING_UP_PART2
	
	jmp PRINT_BIRD_WING_UP
	

PRINT_BIRD_WING_UP_PART2:
    mov bx, 9
PRINT_BIRD_WING_UP_PART2_AGAIN:
	dec tempX
	dec tempY
	
	mov al, 0
	mov cx, tempX
	mov dx, tempY
	mov ah, 0ch
	int 10h
	
	dec bx
	jz PRINT_BIRD_WING_UP_PART3
     
     
     
	jmp PRINT_BIRD_WING_UP_PART2_AGAIN
	                       
	                       
PRINT_BIRD_WING_UP_PART3:

	mov bx, 9
PRINT_BIRD_WING_UP_PART3_AGAIN:
	inc tempY
	
	mov al, 0
	mov cx, tempX
	mov dx, tempY
	mov ah, 0ch
	int 10h
	
	dec bx
	jz PRINT_BIRD_PART11
	
	jmp PRINT_BIRD_WING_UP_PART3_AGAIN 
	 
	
PRINT_BIRD_WING:
    mov tempX, 27
    mov bx, height
    mov tempY, bx
    
    mov al, 0
	mov cx, tempX
	mov dx, tempY
	mov ah, 0ch
	int 10h
	
    mov fillCnt, 8
    mov fillCnt2, 8
    mov bx, 8
PRINT_BIRD_WING_AGAIN:
    inc tempY
	
	mov al, color3
	mov cx, tempX
	mov dx, tempY
	mov ah, 0ch
	int 10h
	
	dec bx
	jz FILL_BIRD_PART6_DOWN
	
	jmp PRINT_BIRD_WING_AGAIN
	
FILL_BIRD_PART6_DOWN:
    mov cx, fillCnt2
    sub tempY, cx
    dec fillCnt2
    mov bx, fillCnt2
	
	mov al, 0
	mov cx, tempX
	mov dx, tempY
	mov ah, 0ch
	int 10h
	
	inc tempX 
	
	dec fillCnt
	jz PRINT_BIRD_WING_PART2
	
	jmp PRINT_BIRD_WING_AGAIN
	
	
PRINT_BIRD_WING_PART2:

    mov bx, 9
PRINT_BIRD_WING_PART2_AGAIN:
	dec tempX
	inc tempY
	
	mov al, 0
	mov cx, tempX
	mov dx, tempY
	mov ah, 0ch
	int 10h
	dec bx
	jz PRINT_BIRD_WING_PART3
	loop PRINT_BIRD_WING_PART2_AGAIN
	 
PRINT_BIRD_WING_PART3:
    mov bx, 9
PRINT_BIRD_WING_PART3_AGAIN:
	dec tempY
	
	mov al, 0
	mov cx, tempX
	mov dx, tempY
	mov ah, 0ch
	int 10h
	dec bx
	jz PRINT_BIRD_PART11
	loop PRINT_BIRD_WING_PART3_AGAIN 
	
PRINT_BIRD_PART11: ; tail part 1

    mov fillCnt, 8
    mov fillCnt2, 8 
    mov bx, 8
PRINT_BIRD_PART11_AGAIN:
	
	dec height
	
	
	cmp fillCnt, 5
	jbe MOV_AL_0
	mov al, color2;14
BACK_COLOR:
	mov cx, x
	mov dx, height
	mov ah, 0ch
	int 10h
	
	dec bx
	jz FILL_BIRD_PART7
	loop PRINT_BIRD_PART11_AGAIN
	
FILL_BIRD_PART7:
    mov cx, fillCnt2
    add height, cx
    dec fillCnt2
    mov bx, fillCnt2
    
	dec x
	dec height
	
	mov al, color
	mov cx, x
	mov dx, height
	mov ah, 0ch
	int 10h
	
	dec fillCnt
	jz PRINT_BIRD_PART12
	
	jmp PRINT_BIRD_PART11_AGAIN
	
MOV_AL_0:
    mov al, 0 
    jmp BACK_COLOR
    
    
	
PRINT_BIRD_PART12:  ;tail part2

    mov cx, x
	mov pointX6, cx
	
	mov cx, height
    mov pointY6, cx
    
    mov bx, 8
PRINT_BIRD_PART12_AGAIN:
	inc x
	
	mov al, color
	mov cx, x
	mov dx, height
	mov ah, 0ch
	int 10h
	dec bx
	jz PRINT_BIRD_PART13
	loop PRINT_BIRD_PART12_AGAIN	

PRINT_BIRD_PART13: ;before print eye
    mov bx, 7
    jmp SKIP_LEST_PART
BACK_TO_PART13:
    mov bx, 4 
SKIP_LEST_PART:
PRINT_BIRD_PART13_AGAIN:
	dec height
	
	mov al, color
	mov cx, x
	mov dx, height
	mov ah, 0ch
	int 10h
	dec bx
	jz PRINT_BIRD_PART14
	cmp bx, 4
	je PRINT_BIRD_EYE
	loop PRINT_BIRD_PART13_AGAIN 
	
PRINT_BIRD_EYE:
    mov tempX, 48
    mov bx, height
    mov tempY, bx 
    mov bx, 3
PRINT_BIRD_EYE_AGAIN:
	dec tempX
	
	mov al, 0
	mov cx, tempX
	mov dx, tempY
	mov ah, 0ch
	int 10h
	dec bx
	jz PRINT_BIRD_EYE_PART2
	loop PRINT_BIRD_EYE_AGAIN
	
PRINT_BIRD_EYE_PART2:
    inc tempY
    dec tempX
    mov bx, 3
PRINT_BIRD_EYE_PART2_AGAIN:
    inc tempX
	
	mov al, 0
	mov cx, tempX
	mov dx, tempY
	mov ah, 0ch
	int 10h
	dec bx
	jz PRINT_BIRD_EYE_PART3
	loop PRINT_BIRD_EYE_PART2_AGAIN
	
PRINT_BIRD_EYE_PART3: 
    inc tempY 
    inc tempX
    mov bx, 3
PRINT_BIRD_EYE_PART3_AGAIN:
	dec tempX
	
	mov al, 0
	mov cx, tempX
	mov dx, tempY
	mov ah, 0ch
	int 10h
	dec bx
	jz BACK_TO_PART13
	loop PRINT_BIRD_EYE_PART3_AGAIN 
		
PRINT_BIRD_PART14:
    
    mov bx, 3
PRINT_BIRD_PART14_AGAIN:
	inc x
	dec height
	
	mov al, color
	mov cx, x
	mov dx, height
	mov ah, 0ch
	int 10h
	dec bx
	jz CHECK_BARS_FLAG
	loop PRINT_BIRD_PART14_AGAIN
	                      
	                      
BEFORE_CHECK_BARS_FLAG:
    mov color, 11
    
    call CLEAR_SCREEN
    
    mov color, 0


CHECK_BARS_FLAG:
    cmp startFlag, 0
    je START_GAME
    
    cmp barsFlag, 0
    je PRINT_BARS
    
    cmp colorCnt, 0
    je PRINT_BARS_AGAIN
    
    jmp CLEAR_BARS
    
    
START_GAME:
    mov dh, 4
    mov dl, 14
    mov bh, 0
    mov ah, 2
    int 10h
    
    lea dx, flappy_bird
    mov ah, 9
    int 21h
    
    mov dh, 8
    mov dl, 8
    mov bh, 0
    mov ah, 2
    int 10h
            
    lea dx, welcome
    mov ah, 9
    int 21h
    
    mov dh, 9
    mov dl, 3
    mov bh, 0
    mov ah, 2
    int 10h
            
    lea dx, welcome2
    mov ah, 9
    int 21h
    
    inc startFlag
    
    mov ah, 0 
    int 16h
    cmp al, ' ' ;-----------wait for space input---------
    jne BEFORE_CHECK_BARS_FLAG
    
    mov color, 11
    
    call CLEAR_SCREEN
    
    mov color, 0
    
    jmp BIRDJUMP  
       
       
;-----------------------------check input---------------	           
	           
	           
	           
	           
	           
	           
CHECK_INPUT:
    mov colorCnt, 0
    
    cmp height, 175
    je FALLDAMAGE 
    
    cmp height, 0
    je TO_HIGH
    
    cmp jumpCnt, 40
    jne BIRDJUMP
    
    mov ah, 1
    int 16h
    jz NOPRESS
    
    mov ah, 0 
    int 16h
    cmp al, ' ' ;-----------wait for space input---------
    je BIRDJUMP
NOPRESS:
    
    jmp BIRDFALL
    
    
    
    
;----------------------fall damage-----------------    
FALLDAMAGE:
COLLISION:            

    call STOP_SOUND
;--------switch to text mode---------
    mov ch, 0
    mov cl, 7
    mov ah, 1
    int 10h
      
    mov ah,05 ;----------------clear screen----------
    mov al,00
    mov bh,07
    mov ch,00
    mov cl,00
    mov dh,24
    mov dl,79
    int 10h
    
    mov dh, 1
    mov dl, 4
    mov bh, 0
    mov ah, 2
    int 10h
    
    lea dx, your_score_is
    mov ah, 9
    int 21h
    
    call PRINT_SCORE
    
    mov dh, 2
    mov dl, 4
    mov bh, 0
    mov ah, 2
    int 10h
    
    lea dx, best_score
    mov ah, 9
    int 21h
    
    mov cx, score
    cmp best, cx
    ja SKIP_BEST
    mov best, cx
    
SKIP_BEST:
    call PRINT_BEST_SCORE
    
    mov dh, 12
    mov dl, 0
    mov bh, 0
    mov ah, 2
    int 10h
    
    lea dx, Quit_Or_Play_Again
    mov ah, 9
    int 21h
    
    ;mov dh, 4
    ;mov dl, 4
    ;mov bh, 0
    ;mov ah, 2
    ;int 10h
    
    ;lea dx, points_amount
    ;mov ah, 9
    ;int 21h
    
    ;mov cx, score
    ;add points, cx
    
    ;call PRINT_POINTS
    
    mov height, 100 
    
COLOR_CHANGED:
ILLEGAL_KEY:
    
    mov ah, 0 
    int 16h
    cmp al, 'y' ;-----------wait for space input---------
    je PLAYAGAIN
    
    cmp al, 'n'
    je DONT_PLAYAGAIN
    
    cmp al, 27
    je PRINT_COLOR_MENU
    
    cmp al, 'p' 
    je YELLOW
    
    cmp al, 'o' 
    je PINK
    
    cmp al, 'i' 
    je WHITE
    
    cmp al, 'u' 
    je RED
    
    cmp al, 't' 
    je BROWN
    
    cmp al, 'r' 
    je PURPLE 
    
    cmp al, 'l' 
    je WING_BROWN
    
    cmp al, 'k' 
    je WING_WHITE
    
    cmp al, 'j' 
    je WING_PINK
    
    cmp al, 'h' 
    je WING_RED
    
    cmp al, 'g' 
    je WING_YELLOW
    
    cmp al, 'f' 
    je WING_PURPLE
    
    
    jmp ILLEGAL_KEY
    
    
DONT_PLAYAGAIN:             
    mov ax, 4c00h ; exit to operating system.
    int 21h
    
TO_HIGH:
    mov jumpCnt, 40
    jmp BIRDFALL
    
  
PRINT_COLOR_MENU:
    mov color, 0
    
    call CLEAR_SCREEN
    
    mov dh, 0
    mov dl, 0
    mov bh, 0
    mov ah, 2
    int 10h
    
    lea dx, game_menu
    mov ah, 9
    int 21h
    
    mov dh, 3
    mov dl, 0
    mov bh, 0
    mov ah, 2
    int 10h
    
    lea dx, basic_input_menu
    mov ah, 9
    int 21h
    
    mov dh, 10
    mov dl, 0
    mov bh, 0
    mov ah, 2
    int 10h
    
    lea dx, color_menu
    mov ah, 9
    int 21h
    
    jmp COLOR_CHANGED
      
    
YELLOW:
    mov color2, 14             
    jmp COLOR_CHANGED 
    
PINK:
    mov color2, 13
    jmp COLOR_CHANGED
   
WHITE:
    mov color2, 15
    jmp COLOR_CHANGED
    
RED:
    mov color2, 12
    jmp COLOR_CHANGED
    
BROWN:
    mov color2, 6
    jmp COLOR_CHANGED
   
PURPLE:
    mov color2, 57
    jmp COLOR_CHANGED
             

WING_BROWN:    
    mov color3, 6
    jmp COLOR_CHANGED
    
WING_WHITE:    
    mov color3, 15
    jmp COLOR_CHANGED
    
WING_PINK:    
    mov color3, 13
    jmp COLOR_CHANGED
    
WING_RED:    
    mov color3, 12
    jmp COLOR_CHANGED 
    
WING_YELLOW:    
    mov color3, 14
    jmp COLOR_CHANGED
    
WING_PURPLE:    
    mov color3, 57
    jmp COLOR_CHANGED
    
    
    
    
;---------------------------print bars-------------------------------    
 



PRINT_BARS:
    call random
    mov lowerBar, al
    inc barsFlag

PRINT_BARS_AGAIN:
    
    mov bh, lowerBar
PRINT_LOWER_BAR_AGAIN:
    
    call CHECK_COLLISION
    
    cmp barX, 0
    jbe SKIP1
    
    cmp barX, 400
    ja SKIP1
    
    mov al, 10
	mov cx, barX
	mov dx, barY
	mov ah, 0ch
	int 10h
	
SKIP1: 

	dec barY
	dec bh
	jz PRINT_LOWER_BAR_PART2 
	
	
	
	jmp PRINT_LOWER_BAR_AGAIN

;-----------------------------------------------    
PRINT_LOWER_BAR_PART2:
    
    mov cx, barY
    mov barOpeningY, cx
                   
    mov cx, barX               
    mov barOpeningX, cx
    sub barOpeningX, 3
    
    mov bx, 60    
FILL_LOWER_BAR:


    
    cmp barX, 319
    jae PRINT_LOWER_BAR_PART2_AGAIN
    
    cmp barX, 0
    jbe PRINT_LOWER_BAR_PART2_AGAIN
    
    cmp barX, 400
    ja PRINT_LOWER_BAR_PART2_AGAIN
    
    mov al, 10
	mov cx, barX
	mov dx, barY
	mov ah, 0ch
	int 10h
	
	inc barY
    inc fillLowerCnt1
    
    cmp barY, 200
    jz PRINT_LOWER_BAR_PART2_AGAIN 

    jmp FILL_LOWER_BAR
    
;-----------------------------------------------------     
    
PRINT_LOWER_BAR_PART2_AGAIN:

    mov dx, fillLowerCnt1
    sub barY, dx
    mov fillLowerCnt1, 0
    
    inc fillLowerCnt2
    
    call CHECK_COLLISION
    
    cmp barX, 319
    jae SKIP2
    
    cmp barX, 0
    jbe SKIP3
    
    cmp barX, 400
    ja SKIP3
    
    mov al, 10
	mov cx, barX
	mov dx, barY
	mov ah, 0ch
	int 10h

	inc barDistance
	inc barX
	mov ax, barX
	mov tempBarX, ax
	
	jmp SKIP4
SKIP3:
    inc barX
    inc barDistance
    jmp skip4
SKIP2:
    cmp barX, 400
    ja SKIP3
SKIP4:
	
	dec bx
	jz PRINT_LOWER_BAR_OPENING
	
	cmp fillLowerCnt2, 2
	jae PRINT_LOWER_BAR_PART2_AGAIN
	
	jmp FILL_LOWER_BAR
	
;----------------------bar opening------------------------------	
	
PRINT_LOWER_BAR_OPENING:
    
    mov cx, barDistance
    mov tempBarDistance, cx
    add tempBarDistance, 6
     
    dec barOpeningY
    
    mov barOpeningCnt, 5
    
PRINT_LOWER_BAR_OPENING_AGAIN:
    
    call CHECK_COLLISION_OPENING
    
    cmp barOpeningX, 319
    jae SKIP_OPENING1
    
    cmp barOpeningX, 0
    jbe SKIP_OPENING2
    
    cmp barOpeningX, 400
    ja SKIP_OPENING2
    
    mov al, 2
    mov cx, barOpeningX
    mov dx, barOpeningY
    mov ah, 0ch
    int 10h
    
    
SKIP_OPENING2:

    inc barOpeningX
    jmp SKIP_OPENING3
    
SKIP_OPENING1:

    cmp barOpeningX, 400
    ja SKIP_OPENING2 
    
SKIP_OPENING3:
    
    dec tempBarDistance
    jz DEC_BAR_OPEMING_Y 
    
    jmp PRINT_LOWER_BAR_OPENING_AGAIN
    
;-----------------------------------------------------

DEC_BAR_OPEMING_Y:
    
    dec barOpeningCnt
    jz PRINT_LOWER_BAR_PART3
    
    dec barOpeningY 
    
    mov cx, barDistance
    mov tempBarDistance, cx
    add tempBarDistance, 6
    
    
    cmp barOpeningX, 319
    jae SUB6
    
    sub barOpeningX, 6
    sub barOpeningX, cx
    jmp PRINT_LOWER_BAR_OPENING_AGAIN
SUB6:
    sub barOpeningX, 3
    sub barOpeningX, cx
    jmp PRINT_LOWER_BAR_OPENING_AGAIN
    
    
;-----------------------------------------------------    
	
PRINT_LOWER_BAR_PART3:

    mov bh, lowerBar
PRINT_LOWER_BAR_PART3_AGAIN: 
    
    cmp barX, 0
    jbe SKIP5
    
    cmp barX, 400
    ja SKIP5
    
    mov al, 10
	mov cx, barX
	mov dx, barY
	mov ah, 0ch
	int 10h
    
SKIP5:
    
    inc barY
    dec bh
    jz PRINT_UPPER_BARS
     
    jmp PRINT_LOWER_BAR_PART3_AGAIN
    
     
     
     
                 
                    
                    
    
;----------------------print upper bars----------------
    
    
                   
                   
                   
    
PRINT_UPPER_BARS:
    
    cmp upperCnt, 0
    jne SKIP
    
    mov bh, gap 
    mov ch, lowerBar
    sub upperBar, bh
    sub upperBar, ch
    
SKIP:
    mov tempBarY, 0
    
    
    mov bh, upperBar
PRINT_UPPER_BAR_AGAIN:
    
    cmp barX, 0
    jbe SKIP6
    
    cmp barX, 400
    ja SKIP6
    
    mov al, 10
	mov cx, tempBarX
	mov dx, tempBarY
	mov ah, 0ch
	int 10h
	 
SKIP6:

	inc tempBarY
	dec bh
	jz PRINT_UPPER_BAR_OPENING
	
	jmp PRINT_UPPER_BAR_AGAIN
	

    
PRINT_UPPER_BAR_OPENING:
    
    mov cx, tempBarY
    mov barOpeningY2, cx
                   
    mov cx, tempBarX               
    mov barOpeningX2, cx
    sub barOpeningX2, 3
    
    mov cx, barDistance
    sub barOpeningX2, cx
    
    mov tempBarDistance, cx
    add tempBarDistance, 6
    
    inc barOpeningY2
    
    mov barOpeningCnt2, 5
    
PRINT_UPPER_BAR_OPENING_AGAIN:
    
    call CHECK_COLLISION_OPENING
    
    cmp barOpeningX2, 319
    jae SKIP_OPENING6
    
    cmp barOpeningX2, 0
    jbe SKIP_OPENING7
    
    cmp barOpeningX2, 400
    ja SKIP_OPENING7
    
    mov al, 2
    mov cx, barOpeningX2
    mov dx, barOpeningY2
    mov ah, 0ch
    int 10h
    
    
SKIP_OPENING7:

    inc barOpeningX2
    jmp SKIP_OPENING8
    
SKIP_OPENING6:

    cmp barOpeningX2, 400
    ja SKIP_OPENING7 
    
SKIP_OPENING8:
    
    dec tempBarDistance
    jz DEC_UPPER_BAR_OPEMING_Y 
    
    jmp PRINT_UPPER_BAR_OPENING_AGAIN
    
;-----------------------------------------------------

DEC_UPPER_BAR_OPEMING_Y:
    
    dec barOpeningCnt2
    jz PRINT_UPPER_BAR_PART2
    
    inc barOpeningY2 
    
    mov cx, barDistance
    mov tempBarDistance, cx
    add tempBarDistance, 6
    
    
    cmp barOpeningX2, 319
    jae SUB3_UPPER
    
    sub barOpeningX2, 6
    sub barOpeningX2, cx
    
    jmp PRINT_UPPER_BAR_OPENING_AGAIN
    
SUB3_UPPER:

    sub barOpeningX2, 3
    sub barOpeningX2, cx
    
    jmp PRINT_UPPER_BAR_OPENING_AGAIN
    
    
;-----------------------------------------------------
	
	
	
PRINT_UPPER_BAR_PART2:

    cmp fillUpperCnt2, 1
    je PRINT_UPPER_BAR_PART2_AGAIN
     
;--------------------------------------------------------

FILL_UPPER_BAR:
    
    
    cmp barX, 0
    jbe PRINT_UPPER_BAR_PART2_AGAIN
    
    cmp barX, 400
    ja PRINT_UPPER_BAR_PART2_AGAIN
    
    mov al, 10
	mov cx, barX
	mov dx, tempBarY
	mov ah, 0ch
	int 10h
	
	dec tempBarY
    inc fillUpperCnt1
    
    cmp tempBarY, 0
    jz PRINT_UPPER_BAR_PART2_AGAIN 

    jmp FILL_UPPER_BAR
    
;--------------------------------------------------------------------------    
PRINT_UPPER_BAR_PART2_AGAIN:
    
    mov dx, fillUpperCnt1
    add tempBarY, dx
    mov fillUpperCnt1, 0
    
    call CHECK_COLLISION
    
    cmp barX, 0
    jbe SKIP7
    
    cmp barX, 400
    ja SKIP7
    
    mov al, 10
	mov cx, barX
	mov dx, tempBarY
	mov ah, 0ch
	int 10h
SKIP7:
	dec barX
	dec barDistance
	jz PRINT_UPPER_BAR_PART3
	
	cmp barDistance, 2
	jbe FILL_UPPER_BAR
	                  
	cmp fillUpperCnt2, 0
	je FILL_UPPER_BAR                  
	                  
	jmp PRINT_UPPER_BAR_PART2_AGAIN
	
	PRINT_UPPER_BAR_PART3:

    mov bh, upperBar
PRINT_UPPER_BAR_PART3_AGAIN: 
    
    call CHECK_COLLISION
    
    cmp barX, 0
    jbe SKIP8
    
    cmp barX, 400
    ja SKIP8
    
    mov al, 10
	mov cx, barX
	mov dx, tempBarY
	mov ah, 0ch
	int 10h
    
SKIP8:

    dec tempBarY
    dec bh
    jz CHECK_BAR2_CNT 
     
    jmp PRINT_UPPER_BAR_PART3_AGAIN
    
    
CHECK_BAR2_CNT:

    cmp bar2Cnt, 0
    je CHECK_BARS_FLAG2
    
    dec bar2Cnt
    
    
    ;----------wait 0.027 second-------
    mov cx, 00
    mov dx, 90
    mov ah, 86h
    int 15h
    
    mov cx, 00
    mov dx, 90
    mov ah, 86h
    int 15h
    
    mov cx, 00
    mov dx, 90
    mov ah, 86h
    int 15h
    
    
    
    jmp PRINT_CHECK_COLOR_CNT_AND_JUMP_CNT
    
CHECK_BARS_FLAG2:
    cmp barsFlag2, 0
    je PRINT_BARS2
     
    jmp PRINT_BARS2_AGAIN   
       
       
       


    ;---------------------------print bars black-------------------------------    
 
 


    
CLEAR_BARS:

 
    
    
    mov bh, lowerBar
PRINT_LOWER_BAR_BLACK_AGAIN:
    
    cmp barX, 0
    jbe SKIP9
    
    cmp barX, 400
    ja SKIP9
    
    ;mov al, 11;0 ;opisite
	;mov cx, barX
	;mov dx, barY
	;mov ah, 0ch
	;int 10h
	
SKIP9:

	dec barY
	dec bh
	jz PRINT_LOWER_BAR_BLACK_PART2
	
	jmp PRINT_LOWER_BAR_BLACK_AGAIN
    
PRINT_LOWER_BAR_BLACK_PART2:
    
    mov bx, 60
PRINT_LOWER_BAR_BLACK_PART2_AGAIN:
    
    cmp barX, 319
    jae SKIP10
    
    cmp barX, 0
    jbe SKIP11
    
    cmp barX, 400
    ja SKIP11
    
    ;mov al, 0 ;opisite
	;mov cx, barX
	;mov dx, barY
	;mov ah, 0ch
	;int 10h
	
	inc barDistance
	inc barX
	mov ax, barX
	mov tempBarX, ax 
	jmp SKIP12
	
SKIP11:
    inc barDistance
    inc barX
    jmp SKIP12
SKIP10: 
    cmp barX, 400
    ja SKIP11
SKIP12:
	
	dec bx
	jz PRINT_LOWER_BAR_BLACK_PART3
	
	jmp PRINT_LOWER_BAR_BLACK_PART2_AGAIN
	
PRINT_LOWER_BAR_BLACK_PART3:

    mov bh, lowerBar
PRINT_LOWER_BAR_BLACK_PART3_AGAIN: 
    
    cmp barX, 0
    jbe SKIP13
    
    cmp barX, 400
    ja SKIP13
    
    mov al, 11;0 ;opisite
	mov cx, barX
	mov dx, barY
	mov ah, 0ch
	int 10h
    
SKIP13:
    
    inc barY
    dec bh
    jz PRINT_BAR_OPENING_BLACK
     
    jmp PRINT_LOWER_BAR_BLACK_PART3_AGAIN
    

PRINT_BAR_OPENING_BLACK:  
    
    
    mov bh, 5
PRINT_BAR_OPENING_BLACK_AGAIN:
    
    cmp barOpeningX, 0
    jbe SKIP_OPENING4
    
    cmp barOpeningX, 400
    ja SKIP_OPENING4
    
    mov al, 11;0 ;opisite
	mov cx, barOpeningX
	mov dx, barOpeningY
	mov ah, 0ch
	int 10h
	
SKIP_OPENING4:
    inc barOpeningY
    dec bh
    jz PRINT_UPPER_BARS_BLACK
    
    jmp PRINT_BAR_OPENING_BLACK_AGAIN
                    
                    
                    
    
;----------------------print upper bars black----------------
    
    
                   
                   
                   
    
PRINT_UPPER_BARS_BLACK:
    
    
    
    mov tempBarY, 0
    
    
    mov bh, upperBar
PRINT_UPPER_BAR_BLACK_AGAIN:
    
    cmp barX, 0
    jbe SKIP14
    
    cmp barX, 400
    ja SKIP14
    
    mov al, 11;0 ;opisite
	mov cx, tempBarX
	mov dx, tempBarY
	mov ah, 0ch
	int 10h
	
SKIP14:
	
	inc tempBarY
	dec bh
	jz PRINT_UPPER_BAR_BLACK_PART2
	
	loop PRINT_UPPER_BAR_BLACK_AGAIN
	
PRINT_UPPER_BAR_BLACK_PART2:
     

     
     mov al, 11;0 ;opisite
     mov cx, tempBarX
     mov dx, tempBarY
     mov ah, 0ch
     int 10h
     
    
PRINT_UPPER_BAR_BLACK_PART2_AGAIN:
    cmp barX, 0
    jbe SKIP15
    
    cmp barX, 400
    ja SKIP15
    
    ;mov al, 11;0 ;opisite
	;mov cx, barX
	;mov dx, tempBarY
	;mov ah, 0ch
	;int 10h
	
SKIP15:
	dec barX
	dec barDistance
	jz PRINT_UPPER_BAR_BLACK_PART3
	
	jmp PRINT_UPPER_BAR_BLACK_PART2_AGAIN
	
	PRINT_UPPER_BAR_BLACK_PART3:

    mov bh, upperBar
PRINT_UPPER_BAR_BLACK_PART3_AGAIN: 
    
    cmp barX, 0
    jbe SKIP16
    
    cmp barX, 400
    ja SKIP16
      
    ;mov al, 11;0 ;opisite
	;mov cx, barX
	;mov dx, tempBarY
	;mov ah, 0ch
	;int 10h
     
SKIP16:
    dec tempBarY
    dec bh
    jz PRINT_UPPER_BAR_OPENING_BLACK
     
    jmp PRINT_UPPER_BAR_BLACK_PART3_AGAIN
    
    
PRINT_UPPER_BAR_OPENING_BLACK:  
    
    
    mov bh, 5
PRINT_UPPER_BAR_OPENING_BLACK_AGAIN:
    
    cmp barOpeningX2, 0
    jbe SKIP_OPENING9
    
    cmp barOpeningX2, 400
    ja SKIP_OPENING9
    
    mov al, 11;0 ;opisite
	mov cx, barOpeningX2
	mov dx, barOpeningY2
	mov ah, 0ch
	int 10h
	
SKIP_OPENING9:
    dec barOpeningY2
    dec bh
    jz CHECK_BAR2_CNT_AGAIN
    
    jmp PRINT_UPPER_BAR_OPENING_BLACK_AGAIN
    
    
CHECK_BAR2_CNT_AGAIN:    
    
    cmp bar2Cnt, 0
    je CLEAR_BARS2
    
    jmp DEC_BAR_X













;---------------------------print bars2-------------------------------    
 



PRINT_BARS2:
    call random
    mov lowerBar2, al
    inc barsFlag2

PRINT_BARS2_AGAIN:
    
    mov bh, lowerBar2
PRINT_LOWER_BAR2_AGAIN:
    
    call CHECK_BAR2_COLLISION
    
    cmp barX2, 0
    jbe SKIP1_BAR2
                                                               ;1
    cmp barX2, 400
    ja SKIP1_BAR2
    
    mov al, 10
	mov cx, barX2
	mov dx, barY2
	mov ah, 0ch
	int 10h
	
SKIP1_BAR2: 

	dec barY2
	dec bh
	jz PRINT_LOWER_BAR2_PART2 
	
	
	
	jmp PRINT_LOWER_BAR2_AGAIN

;-----------------------------------------------    
PRINT_LOWER_BAR2_PART2:
    
    mov cx, barY2
    mov barOpeningYBar2, cx
                   
    mov cx, barX2               
    mov barOpeningXBar2, cx
    sub barOpeningXBar2, 3
    
    mov bx, 60    
FILL_LOWER_BAR2:


    
    cmp barX2, 319
    jae PRINT_LOWER_BAR2_PART2_AGAIN
                                                             ;1
    cmp barX2, 0
    jbe PRINT_LOWER_BAR2_PART2_AGAIN
    
    cmp barX2, 400
    ja PRINT_LOWER_BAR2_PART2_AGAIN
    
    mov al, 10
	mov cx, barX2
	mov dx, barY2
	mov ah, 0ch
	int 10h
	
	inc barY2
    inc fillLowerCnt1Bar2
    
    cmp barY2, 200
    jz PRINT_LOWER_BAR2_PART2_AGAIN 

    jmp FILL_LOWER_BAR2
    
;-----------------------------------------------------     
    
PRINT_LOWER_BAR2_PART2_AGAIN:

    mov dx, fillLowerCnt1Bar2
    sub barY2, dx
    mov fillLowerCnt1Bar2, 0
    
    inc fillLowerCnt2Bar2
    
    call CHECK_BAR2_COLLISION
    
    cmp barX2, 319
    jae SKIP2_BAR2
    
    cmp barX2, 0
    jbe SKIP3_BAR2
    
    cmp barX2, 400
    ja SKIP3_BAR2
    
    mov al, 10
	mov cx, barX2                                 ;1
	mov dx, barY2
	mov ah, 0ch
	int 10h

	inc barDistance2
	inc barX2
	mov ax, barX2
	mov tempBarX2, ax
	
	jmp SKIP4_BAR2
SKIP3_BAR2:
    inc barX2
    inc barDistance2
    jmp skip4_BAR2
SKIP2_BAR2:
    cmp barX2, 400
    ja SKIP3_BAR2
SKIP4_BAR2:
	
	dec bx
	jz PRINT_LOWER_BAR2_OPENING
	
	cmp fillLowerCnt2Bar2, 2
	jae PRINT_LOWER_BAR2_PART2_AGAIN
	
	jmp FILL_LOWER_BAR2
	
	
;----------------------bar opening2------------------------------	
	                     
	                     
PRINT_LOWER_BAR2_OPENING:
    
    mov cx, barDistance2
    mov tempBarDistance2, cx
    add tempBarDistance2, 6
     
    dec barOpeningYBar2
    
    mov barOpeningCntBar2, 5
    
PRINT_LOWER_BAR2_OPENING_AGAIN:
    
    call CHECK_BAR2_COLLISION_OPENING
    
    cmp barOpeningXBar2, 319
    jae SKIP_OPENING1_BAR2
             
    cmp barOpeningXBar2, 0
    jbe SKIP_OPENING2_BAR2
    
    cmp barOpeningXBar2, 400
    ja SKIP_OPENING2_BAR2
    
    mov al, 2
    mov cx, barOpeningXBar2                           ;1
    mov dx, barOpeningYBar2
    mov ah, 0ch
    int 10h
    
    
SKIP_OPENING2_BAR2:

    inc barOpeningXBar2
    jmp SKIP_OPENING3_BAR2
    
SKIP_OPENING1_BAR2:

    cmp barOpeningXBar2, 400
    ja SKIP_OPENING2_BAR2 
    
SKIP_OPENING3_BAR2:
    
    dec tempBarDistance2
    jz DEC_BAR2_OPEMING_Y 
    
    jmp PRINT_LOWER_BAR2_OPENING_AGAIN
    
;-----------------------------------------------------

DEC_BAR2_OPEMING_Y:
    
    dec barOpeningCntBar2
    jz PRINT_LOWER_BAR2_PART3
    
    dec barOpeningYBar2 
    
    mov cx, barDistance2
    mov tempBarDistance2, cx
    add tempBarDistance2, 6
    
                                                ;1
    cmp barOpeningXBar2, 319
    jae SUB6_BAR2
    
    sub barOpeningXBar2, 6
    sub barOpeningXBar2, cx
    jmp PRINT_LOWER_BAR2_OPENING_AGAIN
SUB6_BAR2:
    sub barOpeningXBar2, 3
    sub barOpeningXBar2, cx
    jmp PRINT_LOWER_BAR2_OPENING_AGAIN
    
    
;-----------------------------------------------------    
	
PRINT_LOWER_BAR2_PART3:

    mov bh, lowerBar2
PRINT_LOWER_BAR2_PART3_AGAIN: 
    
    cmp barX2, 0
    jbe SKIP5_BAR2
    
    cmp barX2, 400
    ja SKIP5_BAR2
    
    mov al, 10
	mov cx, barX2                                       ;1
	mov dx, barY2
	mov ah, 0ch
	int 10h
    
SKIP5_BAR2:
    
    inc barY2
    dec bh
    jz PRINT_UPPER_BARS2
     
    jmp PRINT_LOWER_BAR2_PART3_AGAIN
    
     
     
     
                 
                    
                    
    
;----------------------print upper bars2----------------
    
    
                   
                   
                   
    
PRINT_UPPER_BARS2:
    
    cmp upperCnt2, 0
    jne SKIP_BAR2
    
    mov bh, gap 
    mov ch, lowerBar2
    sub upperBar2, bh
    sub upperBar2, ch
    
SKIP_BAR2:
    inc upperCnt2
    mov tempBarY2, 0
    
    
    mov bh, upperBar2
PRINT_UPPER_BAR2_AGAIN:
    
    cmp barX2, 0                              ;1
    jbe SKIP6_BAR2
    
    cmp barX2, 400
    ja SKIP6_BAR2
    
    mov al, 10
	mov cx, tempBarX2
	mov dx, tempBarY2
	mov ah, 0ch
	int 10h
	 
SKIP6_BAR2:

	inc tempBarY2
	dec bh
	jz PRINT_UPPER_BAR2_OPENING
	
	jmp PRINT_UPPER_BAR2_AGAIN
	
;-------------------------------------------------
    
PRINT_UPPER_BAR2_OPENING:
    
    mov cx, tempBarY2
    mov barOpeningY2Bar2, cx
                   
    mov cx, tempBarX2               
    mov barOpeningX2Bar2, cx
    sub barOpeningX2Bar2, 3
    
    mov cx, barDistance2
    sub barOpeningX2Bar2, cx
    
    mov tempBarDistance2, cx
    add tempBarDistance2, 6
    
    inc barOpeningY2Bar2
    
    mov barOpeningCnt2Bar2, 5
    
PRINT_UPPER_BAR2_OPENING_AGAIN:
    
    call CHECK_BAR2_COLLISION_OPENING
    
    cmp barOpeningX2Bar2, 319
    jae SKIP_OPENING6_BAR2
    
    cmp barOpeningX2Bar2, 0
    jbe SKIP_OPENING7_BAR2                     ;1
    
    cmp barOpeningX2Bar2, 400
    ja SKIP_OPENING7_BAR2
    
    mov al, 2
    mov cx, barOpeningX2Bar2
    mov dx, barOpeningY2Bar2
    mov ah, 0ch
    int 10h
    
    
SKIP_OPENING7_BAR2:

    inc barOpeningX2Bar2
    jmp SKIP_OPENING8_BAR2
    
SKIP_OPENING6_BAR2:

    cmp barOpeningX2Bar2, 400
    ja SKIP_OPENING7_BAR2 
    
SKIP_OPENING8_BAR2:
    
    dec tempBarDistance2
    jz DEC_UPPER_BAR2_OPEMING_Y 
    
    jmp PRINT_UPPER_BAR2_OPENING_AGAIN
    
;-----------------------------------------------------

DEC_UPPER_BAR2_OPEMING_Y:
    
    dec barOpeningCnt2Bar2
    jz PRINT_UPPER_BAR2_PART2
    
    inc barOpeningY2Bar2 
    
    mov cx, barDistance2
    mov tempBarDistance2, cx
    add tempBarDistance2, 6
    
    
    cmp barOpeningX2Bar2, 319
    jae SUB3_UPPER_BAR2                                 ;1
    
    sub barOpeningX2Bar2, 6
    sub barOpeningX2Bar2, cx
    
    jmp PRINT_UPPER_BAR2_OPENING_AGAIN
    
SUB3_UPPER_BAR2:

    sub barOpeningX2Bar2, 3
    sub barOpeningX2Bar2, cx
    
    jmp PRINT_UPPER_BAR2_OPENING_AGAIN
    
    
;-----------------------------------------------------
	
	
	
PRINT_UPPER_BAR2_PART2:

    cmp fillUpperCnt2Bar2, 1                                     ;1
    je PRINT_UPPER_BAR2_PART2_AGAIN
     
;--------------------------------------------------------

FILL_UPPER_BAR2:
    
    
    cmp barX2, 0
    jbe PRINT_UPPER_BAR2_PART2_AGAIN
    
    cmp barX2, 400
    ja PRINT_UPPER_BAR2_PART2_AGAIN
    
    mov al, 10
	mov cx, barX2                                       ;1
	mov dx, tempBarY2
	mov ah, 0ch
	int 10h
	
	dec tempBarY2
    inc fillUpperCnt1Bar2
    
    cmp tempBarY2, 0
    jz PRINT_UPPER_BAR2_PART2_AGAIN 

    jmp FILL_UPPER_BAR2
    
;--------------------------------------------------------------------------    
PRINT_UPPER_BAR2_PART2_AGAIN:
    
    mov dx, fillUpperCnt1Bar2
    add tempBarY2, dx
    mov fillUpperCnt1Bar2, 0
    
    call CHECK_BAR2_COLLISION
    
    cmp barX2, 0
    jbe SKIP7_BAR2
    
    cmp barX2, 400
    ja SKIP7_BAR2
    
    mov al, 10
	mov cx, barX2                                              ;1
	mov dx, tempBarY2
	mov ah, 0ch
	int 10h
SKIP7_BAR2:
	dec barX2
	dec barDistance2
	jz PRINT_UPPER_BAR2_PART3
	
	cmp barDistance2, 2
	jbe FILL_UPPER_BAR2
	                  
	cmp fillUpperCnt2Bar2, 0
	je FILL_UPPER_BAR2                  
	                  
	jmp PRINT_UPPER_BAR2_PART2_AGAIN
	      
;-----------------------------------------------------------------------	      
	      
	PRINT_UPPER_BAR2_PART3:

    mov bh, upperBar2
PRINT_UPPER_BAR2_PART3_AGAIN: 
    
    call CHECK_BAR2_COLLISION
    
    cmp barX2, 0
    jbe SKIP8_BAR2
    
    cmp barX2, 400
    ja SKIP8_BAR2
    
    mov al, 10
	mov cx, barX2                                            ;1
	mov dx, tempBarY2
	mov ah, 0ch
	int 10h
    
SKIP8_BAR2:

    dec tempBarY2
    dec bh
    jz PRINT_CHECK_COLOR_CNT_AND_JUMP_CNT 
     
    jmp PRINT_UPPER_BAR2_PART3_AGAIN
    
  
       
       
       
       


    ;---------------------------print bars2 black-------------------------------    
 
 
 
;----------wait 0.72 second-------
    mov cx, 00
    mov dx, 90
    mov ah, 86h
    int 15h
    
    mov cx, 00
    mov dx, 90
    mov ah, 86h
    int 15h
    
    mov cx, 00
    mov dx, 90
    mov ah, 86h
    int 15h
    
    mov cx, 00
    mov dx, 90
    mov ah, 86h
    int 15h
    
    mov cx, 00
    mov dx, 90
    mov ah, 86h
    int 15h
    
    mov cx, 00
    mov dx, 90
    mov ah, 86h
    int 15h
    
    mov cx, 00
    mov dx, 90
    mov ah, 86h
    int 15h
    
    mov cx, 00
    mov dx, 90
    mov ah, 86h
    int 15h


    
CLEAR_BARS2:

 
;------------------------------------------------    
    
    mov bh, lowerBar2
PRINT_LOWER_BAR2_BLACK_AGAIN:
    
    cmp barX2, 0
    jbe SKIP9_BAR2
    
    cmp barX2, 400
    ja SKIP9_BAR2
    
    ;mov al, 11;0 ;opisite                     ;1
	;mov cx, barX2
	;mov dx, barY2
	;mov ah, 0ch
	;int 10h
	
SKIP9_BAR2:

	dec barY2
	dec bh
	jz PRINT_LOWER_BAR2_BLACK_PART2
	
	jmp PRINT_LOWER_BAR2_BLACK_AGAIN

;---------------------------------------------------
    
PRINT_LOWER_BAR2_BLACK_PART2:
    
    mov bx, 60
PRINT_LOWER_BAR2_BLACK_PART2_AGAIN:
    
    cmp barX2, 319
    jae SKIP10_BAR2
    
    cmp barX2, 0
    jbe SKIP11_BAR2
    
    cmp barX2, 400
    ja SKIP11_BAR2
    
    ;mov al, 0 ;opisite
	;mov cx, barX2
	;mov dx, barY2
	;mov ah, 0ch
	;int 10h                                         ;1
	
	inc barDistance2
	inc barX2
	mov ax, barX2
	mov tempBarX2, ax 
	jmp SKIP12_BAR2
	
SKIP11_BAR2:
    inc barDistance2
    inc barX2
    jmp SKIP12_BAR2
SKIP10_BAR2: 
    cmp barX2, 400
    ja SKIP11_BAR2
SKIP12_BAR2:
	
	dec bx
	jz PRINT_LOWER_BAR2_BLACK_PART3
	
	jmp PRINT_LOWER_BAR2_BLACK_PART2_AGAIN

;------------------------------------------------------------

PRINT_LOWER_BAR2_BLACK_PART3:

    mov bh, lowerBar2
PRINT_LOWER_BAR2_BLACK_PART3_AGAIN: 
    
    cmp barX2, 0
    jbe SKIP13_BAR2
    
    cmp barX2, 400
    ja SKIP13_BAR2
    
    mov al, 11;0 ;opisite                         ;1
	mov cx, barX2
	mov dx, barY2
	mov ah, 0ch
	int 10h
    
SKIP13_BAR2:
    
    inc barY2
    dec bh
    jz PRINT_BAR2_OPENING_BLACK
     
    jmp PRINT_LOWER_BAR2_BLACK_PART3_AGAIN

;------------------------------------------------------------    

PRINT_BAR2_OPENING_BLACK:  
    
    
    mov bh, 5
PRINT_BAR2_OPENING_BLACK_AGAIN:
    
    cmp barOpeningXBar2, 0
    jbe SKIP_OPENING4_BAR2
    
    cmp barOpeningXBar2, 400
    ja SKIP_OPENING4_BAR2
    
    mov al, 11;0 ;opisite                               ;1
	mov cx, barOpeningXBar2
	mov dx, barOpeningYBar2
	mov ah, 0ch
	int 10h
	
SKIP_OPENING4_BAR2:
    inc barOpeningYBar2
    dec bh
    jz PRINT_UPPER_BARS2_BLACK
    
    jmp PRINT_BAR2_OPENING_BLACK_AGAIN
                    
                    
                    
      
      
      
;----------------------print upper bars2 black----------------
    
    
    
    
                   
                   
                   
    
PRINT_UPPER_BARS2_BLACK:
    
    
    
    mov tempBarY2, 0
    
    
    mov bh, upperBar2
PRINT_UPPER_BAR2_BLACK_AGAIN:
    
    cmp barX2, 0
    jbe SKIP14_BAR2                                 ;1
    
    cmp barX2, 400
    ja SKIP14_BAR2
    
    mov al, 11;0 ;opisite
	mov cx, tempBarX2
	mov dx, tempBarY2
	mov ah, 0ch
	int 10h
	
SKIP14_BAR2:
	
	inc tempBarY2
	dec bh
	jz PRINT_UPPER_BAR2_BLACK_PART2
	
	loop PRINT_UPPER_BAR2_BLACK_AGAIN

;--------------------------------------------------
	
PRINT_UPPER_BAR2_BLACK_PART2:
     

     
     mov al, 11;0 ;opisite                     ;1
     mov cx, tempBarX2
     mov dx, tempBarY2
     mov ah, 0ch
     int 10h
     
;--------------------------------------------------    
PRINT_UPPER_BAR2_BLACK_PART2_AGAIN:

    cmp barX2, 0
    jbe SKIP15_BAR2
    
    cmp barX2, 400
    ja SKIP15_BAR2
    
    ;mov al, 11;0 ;opisite
	;mov cx, barX2
	;mov dx, tempBarY2
	;mov ah, 0ch                                     ;1
	;int 10h
	
SKIP15_BAR2:
	dec barX2
	dec barDistance2
	jz PRINT_UPPER_BAR2_BLACK_PART3
	
	jmp PRINT_UPPER_BAR2_BLACK_PART2_AGAIN

;----------------------------------------------------
	
PRINT_UPPER_BAR2_BLACK_PART3:

    mov bh, upperBar2
PRINT_UPPER_BAR2_BLACK_PART3_AGAIN: 
    
    cmp barX2, 0
    jbe SKIP16_BAR2
    
    cmp barX2, 400
    ja SKIP16_BAR2
                                               ;1
    ;mov al, 11;0 ;opisite
	;mov cx, barX2
	;mov dx, tempBarY2
	;mov ah, 0ch
	;int 10h
     
SKIP16_BAR2:
    dec tempBarY2
    dec bh
    jz PRINT_UPPER_BAR2_OPENING_BLACK
     
    jmp PRINT_UPPER_BAR2_BLACK_PART3_AGAIN

;------------------------------------------------------    
    
PRINT_UPPER_BAR2_OPENING_BLACK:  
    
    
    mov bh, 5
PRINT_UPPER_BAR2_OPENING_BLACK_AGAIN:
    
    cmp barOpeningX2Bar2, 0
    jbe SKIP_OPENING9_BAR2
    
    cmp barOpeningX2Bar2, 400
    ja SKIP_OPENING9_BAR2                             ;1
    
    mov al, 11;0 ;opisite
	mov cx, barOpeningX2Bar2
	mov dx, barOpeningY2Bar2
	mov ah, 0ch
	int 10h
	
SKIP_OPENING9_BAR2:
    dec barOpeningY2Bar2
    dec bh
    jz DEC_BAR_X
    
    jmp PRINT_UPPER_BAR2_OPENING_BLACK_AGAIN    
    
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
    
    
    
PRINT_CHECK_COLOR_CNT_AND_JUMP_CNT:
    mov fillLowerCnt2, 0
    mov fillUpperCnt2, 1
    mov fillLowerCnt2Bar2, 0
    mov fillUpperCnt2Bar2, 1
    
    cmp colorCnt, 1                         ;1
    je CHECK_INPUT
     
    inc colorCnt 
     
    cmp jumpCnt, 40
    jne BIRDJUMP
    
    
    jmp BIRDFALL
    
;------------------------------------------     
    
DEC_BAR_X:
    dec barX
    call DEC_BAR2_X
    inc upperCnt
    cmp barX, 0
    je INC_SCORE
    cmp barX2, 0
    je INC_SCORE 
    cmp barX, 65473
    je END_BAR1
    cmp barX2, 65473
    je END_BAR2
    jmp PRINT_CHECK_COLOR_CNT_AND_JUMP_CNT
    
;-------------------------------------------
    
INC_SCORE:
    inc score
    call PLAY_SOUND
    jmp PRINT_CHECK_COLOR_CNT_AND_JUMP_CNT 
    
    
END_BAR1:
    mov barX, 0
    mov barY, 0
CLEAR_BUG:
    mov al, 11
    mov cx, barX
    mov dx, barY
    mov ah, 0ch
    int 10h
    
    inc barY
    cmp barY, 200
    jne CLEAR_BUG
    
    mov barY, 0
    inc barX
    cmp barX, 6
    jne CLEAR_BUG
    
    mov barX, 317
    mov barY, 200
    mov tempBarX, 0
    mov tempBarY, 0
    mov upperCnt, 0
    mov barDistance, 0
    mov lowerBar, 0
    mov upperBar, 200
    mov barsFlag, 0 
    mov fillUpperCnt2, 0
    jmp PRINT_CHECK_COLOR_CNT_AND_JUMP_CNT
    
    
    
END_BAR2:
    mov barX2, 0
    mov barY2, 0
CLEAR_BUG2:
    mov al, 11
    mov cx, barX2
    mov dx, barY2
    mov ah, 0ch
    int 10h
    
    inc barY2
    cmp barY2, 200
    jne CLEAR_BUG2
    
    mov barY2, 0
    inc barX2
    cmp barX2, 6
    jne CLEAR_BUG2
    
    mov barX2, 317
    mov barY2, 200
    mov tempBarX2, 0
    mov tempBarY2, 0
    mov upperCnt2, 0
    mov barDistance2, 0
    mov lowerBar2, 0
    mov upperBar2, 200
    mov barsFlag2, 0 
    mov fillUpperCnt2Bar2, 0
    jmp PRINT_CHECK_COLOR_CNT_AND_JUMP_CNT
    
    
PLAYAGAIN:
    mov height, 100
    mov x, 25
    mov tempX, 0
    mov tempY, 0
    mov jumpCnt, 40
    mov color, 11
    mov colorCnt, 0
    mov score, 0
    
    mov barX, 317
    mov barY, 200
    mov tempBarX, 0
    mov tempBarY, 0
    mov upperCnt, 0
    mov barDistance, 0
    mov lowerBar, 0
    mov upperBar, 200
    mov barsFlag, 0
    
    mov barX2, 317
    mov barY2, 200
    mov tempBarX2, 0
    mov tempBarY2, 0
    mov upperCnt2, 0
    mov barDistance2, 0
    mov lowerBar2, 0
    mov upperBar2, 200
    mov barsFlag2, 0
    mov bar2Cnt, 190 
    jmp BACK_TO_CODE
    
    

proc DEC_BAR2_X
    
    cmp bar2Cnt, 0
    jne SKIP_DEC_BAR2_X
    
    dec barX2
    
SKIP_DEC_BAR2_X:

    ret

endp DEC_BAR2_X  

;----------------------generate a random number-------------------

 
; bl min
; bh max
proc random 
    push bx 
    
RANDOM_AGAIN:
    
    mov ah, 00h          
    int 1ah
    
    ;ror dl, 3
    ;xor dl, 10101010b
    mov al, dl
    xor al, dh
    xor al, ch
    xor al, cl
    rol al, 3
    xor al, 10110110b
    ror al, 2
    ;ror dl, 3
    ;xor dl, dh
    
    cmp al, 0
    je RANDOM_AGAIN
   
    mov bl, 5
    mov bh, 115
    sub bh, bl
    inc bh
    ;mov al, dl
    div bh 
    add ah, bl
    mov al, ah
    mov ah, 0
    
    
    
    
    
    pop bx
    
    
    
    ret
    
endp random


;--------------------print score------------------------------

proc PRINT_SCORE
    
    mov dh, 1
    mov dl, 59
    mov bh, 0
    mov ah, 2
    int 10h     ;set cursor position
    
    mov ax, score
    mov di, 0
    mov dx, 0 
     
PRINT_LABEL1:
    
    cmp ax, 0
    je PRINT_LABEL2
        
    mov bx, 10
    div bx
    push dx
    inc di
        
    xor dx, dx
    jmp PRINT_LABEL1
        
PRINT_LABEL2:
    
    cmp di, 0
    je PRINT_EXIT
    
    inc scoreCnt
    cmp scoreCnt, 3
    je PRINT_LABEL3
        
    pop dx 
    mov ax, dx
    add ax, 48
    mov bh, 11
    mov bl, 046h
    mov cx, 1
    mov ah, 09h
    int 10h     ;write it
        
    mov dh, 1
    mov dl, 60
    mov bh, 0
    mov ah, 2
    int 10h
        
    dec di
    jmp PRINT_LABEL2
    
PRINT_LABEL3:
    mov dh, 1
    mov dl, 61
    mov bh, 0
    mov ah, 2
    int 10h
    
    pop dx 
    mov ax, dx
    add ax, 48
    mov bh, 11
    mov bl, 046h
    mov cx, 1
    mov ah, 09h
    int 10h
    
    mov scoreCnt, 0
    dec di
    
    jmp PRINT_EXIT
       
PRINT_EXIT:
    mov scoreCnt, 0
    
    ret
    
endp PRINT_SCORE


;----------------------print best score--------------------
proc PRINT_BEST_SCORE
    
    mov dh, 2
    mov dl, 50
    mov bh, 0
    mov ah, 2
    int 10h     ;set cursor position
    
    mov ax, best
    mov di, 0
    mov dx, 0
    
PRINT_BEST_LABEL1:
    
    cmp ax, 0
    je PRINT_BEST_LABEL2
        
    mov bx, 10
    div bx
    push dx
    inc di
        
    xor dx, dx
    jmp PRINT_BEST_LABEL1

PRINT_BEST_LABEL2:
    
    cmp di, 0
    je PRINT_EXIT2
    
    inc scoreCnt
    cmp scoreCnt, 3
    je PRINT_BEST_LABEL3
        
    pop dx 
    mov ax, dx
    add ax, 48
    mov bh, 11
    mov bl, 046h
    mov cx, 1
    mov ah, 09h
    int 10h     ;write it
        
    mov dh, 2
    mov dl, 51
    mov bh, 0
    mov ah, 2
    int 10h
        
    dec di
    jmp PRINT_BEST_LABEL2
    
    
    PRINT_BEST_LABEL3:
    mov dh, 2
    mov dl, 52
    mov bh, 0
    mov ah, 2
    int 10h
    
    pop dx 
    mov ax, dx
    add ax, 48
    mov bh, 11
    mov bl, 046h
    mov cx, 1
    mov ah, 09h
    int 10h
    
    mov scoreCnt, 0
    
    jmp PRINT_EXIT2
       
PRINT_EXIT2:
    mov scoreCnt, 0
    
    ret
    
endp PRINT_BEST_SCORE
  
  
  
proc PRINT_SCORE_ON_LED
    
    mov ax, score
    out 199, ax
    
    ret
    
endp PRINT_SCORE_ON_LED



;------------------------print points----------------
proc PRINT_POINTS
    
    mov dh, 4
    mov dl, 52
    mov bh, 0
    mov ah, 2
    int 10h     ;set cursor position
    
    mov ax, points
    mov di, 0
    mov dx, 0 
     
PRINT_POINTS_LABEL1:
    
    cmp ax, 0
    je PRINT_POINTS_LABEL2
        
    mov bx, 10
    div bx
    push dx
    inc di
        
    xor dx, dx
    jmp PRINT_POINTS_LABEL1
        
PRINT_POINTS_LABEL2:
    
    cmp di, 0
    je PRINT_EXIT3
    
    inc scoreCnt
    cmp scoreCnt, 3
    je PRINT_POINTS_LABEL3
        
    pop dx 
    mov ax, dx
    add ax, 48
    mov bh, 11
    mov bl, 046h
    mov cx, 1
    mov ah, 09h
    int 10h     ;write it
        
    mov dh, 4
    mov dl, 53
    mov bh, 0
    mov ah, 2
    int 10h
        
    dec di
    jmp PRINT_POINTS_LABEL2
    
PRINT_POINTS_LABEL3:
    mov dh, 4
    mov dl, 54
    mov bh, 0
    mov ah, 2
    int 10h
    
    pop dx 
    mov ax, dx
    add ax, 48
    mov bh, 11
    mov bl, 046h
    mov cx, 1
    mov ah, 09h
    int 10h
    
    mov scoreCnt, 0
    dec di
    
    jmp PRINT_EXIT3
       
PRINT_EXIT3:
    mov scoreCnt, 0
    
    ret
    
endp PRINT_POINTS







;----------------------check collision-------------------


proc CHECK_COLLISION

mov collisionFlag, 0
BACK6:
    ;check if barX = birdX
    mov cx, barX
    cmp pointX1, cx
    je CHECK_Y_COLLISION1
BACK1:
    mov cx, barX
    cmp pointX2, cx
    je CHECK_Y_COLLISION2
BACK2:
    mov cx, barX
    cmp pointX3, cx
    je CHECK_Y_COLLISION3
BACK3:    
    mov cx, barX
    cmp pointX4, cx
    je CHECK_Y_COLLISION4
BACK4:    
    mov cx, barX
    cmp pointX5, cx
    je CHECK_Y_COLLISION5
BACK5:    
    mov cx, barX
    cmp pointX6, cx
    je CHECK_Y_COLLISION6
    
    jmp INC_COLLISION_FLAG 
    ;check if barY = birdY
CHECK_Y_COLLISION1:
    cmp collisionFlag, 1
    je CHECK_TEMP_BAR_Y_COLLISION1 

    mov cx, barY
    cmp pointY1, cx
    je COLLISION
    jmp BACK1
    
CHECK_Y_COLLISION2:
    cmp collisionFlag, 1
    je CHECK_TEMP_BAR_Y_COLLISION2
    
    mov cx, barY
    cmp pointY2, cx
    je COLLISION
    jmp BACK2
    
CHECK_Y_COLLISION3:
    cmp collisionFlag, 1
    je CHECK_TEMP_BAR_Y_COLLISION3
    
    mov cx, barY
    cmp pointY3, cx
    je COLLISION
    jmp BACK3
    
CHECK_Y_COLLISION4:
    cmp collisionFlag, 1
    je CHECK_TEMP_BAR_Y_COLLISION4
        
    mov cx, barY
    cmp pointY4, cx
    je COLLISION
    jmp BACK4
    
CHECK_Y_COLLISION5:
    cmp collisionFlag, 1
    je CHECK_TEMP_BAR_Y_COLLISION5
    
    mov cx, barY
    cmp pointY5, cx
    je COLLISION
    jmp BACK5
    
CHECK_Y_COLLISION6:
    cmp collisionFlag, 1
    je CHECK_TEMP_BAR_Y_COLLISION6
        
    mov cx, barY
    cmp pointY6, cx
    je COLLISION
    jmp INC_COLLISION_FLAG
    jmp BACK6
    
    
    ;check if tempBarY = birdY
    
CHECK_TEMP_BAR_Y_COLLISION1:
    mov cx, tempBarY
    cmp pointY1, cx
    je COLLISION
    jmp BACK1
    
CHECK_TEMP_BAR_Y_COLLISION2:
    mov cx, tempBarY
    cmp pointY2, cx
    je COLLISION
    jmp BACK2
    
CHECK_TEMP_BAR_Y_COLLISION3:
    mov cx, tempBarY
    cmp pointY3, cx
    je COLLISION
    jmp BACK3
    
CHECK_TEMP_BAR_Y_COLLISION4:
    mov cx, tempBarY
    cmp pointY4, cx
    je COLLISION
    jmp BACK4
    
CHECK_TEMP_BAR_Y_COLLISION5:    
    mov cx, tempBarY
    cmp pointY5, cx
    je COLLISION
    jmp BACK5
    
CHECK_TEMP_BAR_Y_COLLISION6:    
    mov cx, tempBarY
    cmp pointY6, cx
    je COLLISION
    jmp INC_COLLISION_FLAG
    
    
    
INC_COLLISION_FLAG:
    cmp collisionFlag, 1
    je NO_COLLISION

    inc collisionFlag
    jmp BACK6
    
NO_COLLISION:
    dec collisionFlag
    
    ret
    
endp CHECK_COLLISION




;-----------------------check opening collision-------------


proc CHECK_COLLISION_OPENING
    
    ;check if barOpeningX = birdX
    mov cx, barOpeningX
    cmp pointX1, cx
    je CHECK_BAR_OPENING_Y1
    
BACK_OPENING1:
    mov cx, barOpeningX
    cmp pointX2, cx
    je CHECK_BAR_OPENING_Y2
    
BACK_OPENING2:
    mov cx, barOpeningX
    cmp pointX3, cx
    je CHECK_BAR_OPENING_Y3
    
BACK_OPENING3:
    mov cx, barOpeningX
    cmp pointX4, cx
    je CHECK_BAR_OPENING_Y4
    
BACK_OPENING4:
    mov cx, barOpeningX
    cmp pointX5, cx
    je CHECK_BAR_OPENING_Y5
    
BACK_OPENING5:
    mov cx, barOpeningX
    cmp pointX6, cx
    je CHECK_BAR_OPENING_Y6
    jmp BACK_FLAG
    
    ;check if barOpeningY = birdY
CHECK_BAR_OPENING_Y1:
    mov cx, barOpeningY
    cmp pointY1, cx
    je COLLISION
    jmp BACK_OPENING1
    
CHECK_BAR_OPENING_Y2:
    mov cx, barOpeningY
    cmp pointY2, cx
    je COLLISION
    jmp BACK_OPENING2
    
CHECK_BAR_OPENING_Y3:
    mov cx, barOpeningY
    cmp pointY3, cx
    je COLLISION
    jmp BACK_OPENING3
    
CHECK_BAR_OPENING_Y4:
    mov cx, barOpeningY
    cmp pointY4, cx
    je COLLISION
    jmp BACK_OPENING4
    
CHECK_BAR_OPENING_Y5:
    mov cx, barOpeningY
    cmp pointY5, cx
    je COLLISION
    jmp BACK_OPENING5
    
CHECK_BAR_OPENING_Y6:
    mov cx, barOpeningY
    cmp pointY6, cx
    je COLLISION
    
  
  
  
  
BACK_OPENING6:    
    
    ;check if barOpeningX2 = birdX
    mov cx, barOpeningX2
    cmp pointX1, cx
    je CHECK_BAR_OPENING_Y7
    
BACK_OPENING7:
    mov cx, barOpeningX2
    cmp pointX2, cx
    je CHECK_BAR_OPENING_Y8
    
BACK_OPENING8:
    mov cx, barOpeningX2
    cmp pointX3, cx
    je CHECK_BAR_OPENING_Y9
    
BACK_OPENING9:
    mov cx, barOpeningX2
    cmp pointX4, cx
    je CHECK_BAR_OPENING_Y10
    
BACK_OPENING10:
    mov cx, barOpeningX2
    cmp pointX5, cx
    je CHECK_BAR_OPENING_Y11
    
BACK_OPENING11:
    mov cx, barOpeningX2
    cmp pointX6, cx
    je CHECK_BAR_OPENING_Y12
    jmp BACK_FLAG  
    
    
    
    ;check if barOpeningY2 = birdY
CHECK_BAR_OPENING_Y7:
    mov cx, barOpeningY2
    cmp pointY1, cx
    je COLLISION
    jmp BACK_OPENING7
    
CHECK_BAR_OPENING_Y8:
    mov cx, barOpeningY2
    cmp pointY2, cx
    je COLLISION
    jmp BACK_OPENING8
    
CHECK_BAR_OPENING_Y9:
    mov cx, barOpeningY2
    cmp pointY3, cx
    je COLLISION
    jmp BACK_OPENING9
    
CHECK_BAR_OPENING_Y10:
    mov cx, barOpeningY2
    cmp pointY4, cx
    je COLLISION
    jmp BACK_OPENING10
    
CHECK_BAR_OPENING_Y11:
    mov cx, barOpeningY2
    cmp pointY5, cx
    je COLLISION
    jmp BACK_OPENING11
    
CHECK_BAR_OPENING_Y12:
    mov cx, barOpeningY2
    cmp pointY6, cx
    je COLLISION
    
    
    
    BACK_FLAG:
    cmp collisionFlag, 1
    je NO_COLLISION2

    inc collisionFlag
    jmp BACK_OPENING6
    
NO_COLLISION2:
    dec collisionFlag
    
    ret
    
endp CHECK_COLLISION_OPENING
    
    
    
;----------------------check bar2 collision-------------------


proc CHECK_BAR2_COLLISION

mov collisionFlag, 0
BACK6_BAR2:
    ;check if barX2 = birdX
    mov cx, barX2
    cmp pointX1, cx
    je CHECK_Y2_COLLISION1
BACK1_BAR2:
    mov cx, barX2
    cmp pointX2, cx
    je CHECK_Y2_COLLISION2
BACK2_BAR2:
    mov cx, barX2
    cmp pointX3, cx
    je CHECK_Y2_COLLISION3
BACK3_BAR2:    
    mov cx, barX2
    cmp pointX4, cx
    je CHECK_Y2_COLLISION4
BACK4_BAR2:    
    mov cx, barX2
    cmp pointX5, cx
    je CHECK_Y2_COLLISION5
BACK5_BAR2:    
    ;mov cx, barX2
    ;cmp pointX6, cx
    ;je CHECK_Y2_COLLISION6
    
    jmp INC_COLLISION_FLAG_AGAIN
     
    ;check if barY2 = birdY
CHECK_Y2_COLLISION1:
    cmp collisionFlag, 1
    je CHECK_TEMP_BAR_Y2_COLLISION1 

    mov cx, barY2
    cmp pointY1, cx
    je COLLISION
    jmp BACK1_BAR2
    
CHECK_Y2_COLLISION2:
    cmp collisionFlag, 1
    je CHECK_TEMP_BAR_Y2_COLLISION2
    
    mov cx, barY2
    cmp pointY2, cx
    je COLLISION
    jmp BACK2_BAR2
    
CHECK_Y2_COLLISION3:
    cmp collisionFlag, 1
    je CHECK_TEMP_BAR_Y2_COLLISION3
    
    mov cx, barY2
    cmp pointY3, cx
    je COLLISION
    jmp BACK3_BAR2
    
CHECK_Y2_COLLISION4:
    cmp collisionFlag, 1
    je CHECK_TEMP_BAR_Y2_COLLISION4
        
    mov cx, barY2
    cmp pointY4, cx
    je COLLISION
    jmp BACK4_BAR2
    
CHECK_Y2_COLLISION5:
    cmp collisionFlag, 1
    je CHECK_TEMP_BAR_Y2_COLLISION5
    
    mov cx, barY2
    cmp pointY5, cx
    je COLLISION
    jmp BACK5_BAR2
    
CHECK_Y2_COLLISION6:
    cmp collisionFlag, 1
    je CHECK_TEMP_BAR_Y2_COLLISION6
        
    ;mov cx, barY2
    ;cmp pointY6, cx
    ;je COLLISION
    jmp INC_COLLISION_FLAG_AGAIN
    
    
    ;check if tempBarY2 = birdY
    
CHECK_TEMP_BAR_Y2_COLLISION1:
    mov cx, tempBarY2
    cmp pointY1, cx
    je COLLISION
    jmp BACK1_BAR2
    
CHECK_TEMP_BAR_Y2_COLLISION2:
    mov cx, tempBarY2
    cmp pointY2, cx
    je COLLISION
    jmp BACK2_BAR2
    
CHECK_TEMP_BAR_Y2_COLLISION3:
    mov cx, tempBarY2
    cmp pointY3, cx
    je COLLISION
    jmp BACK3_BAR2
    
CHECK_TEMP_BAR_Y2_COLLISION4:
    mov cx, tempBarY2
    cmp pointY4, cx
    je COLLISION
    jmp BACK4_BAR2
    
CHECK_TEMP_BAR_Y2_COLLISION5:    
    mov cx, tempBarY2
    cmp pointY5, cx
    je COLLISION
    jmp BACK5_BAR2
    
CHECK_TEMP_BAR_Y2_COLLISION6:    
   ; mov cx, tempBarY2
   ; cmp pointY6, cx
   ; je COLLISION
    
    
    
INC_COLLISION_FLAG_AGAIN:
    cmp collisionFlag, 1
    je NO_COLLISION_AGAIN

    inc collisionFlag
    jmp BACK6_BAR2
    
NO_COLLISION_AGAIN:
    dec collisionFlag
    
    ret
    
endp CHECK_BAR2_COLLISION
                    
                    

;----------------check bar2 opening collisn----------------
                    

proc CHECK_BAR2_COLLISION_OPENING
    
    ;check if barOpeningX2 = birdX
    mov cx, barOpeningXBar2
    cmp pointX1, cx
    je CHECK_BAR2_OPENING_Y1            
    
BACK_OPENING1_BAR2:
    mov cx, barOpeningXBar2
    cmp pointX2, cx
    je CHECK_BAR2_OPENING_Y2
    
BACK_OPENING2_BAR2:
    mov cx, barOpeningXBar2
    cmp pointX3, cx
    je CHECK_BAR2_OPENING_Y3
    
BACK_OPENING3_BAR2:
    mov cx, barOpeningXBar2
    cmp pointX4, cx
    je CHECK_BAR2_OPENING_Y4
    
BACK_OPENING4_BAR2:
    mov cx, barOpeningXBar2
    cmp pointX5, cx
    je CHECK_BAR2_OPENING_Y5
    
BACK_OPENING5_BAR2:
    ;mov cx, barOpeningXBar2
    ;cmp pointX6, cx
    ;je CHECK_BAR2_OPENING_Y6
    jmp BACK_FLAG_BAR2
    
    ;check if barOpeningY2 = birdY
CHECK_BAR2_OPENING_Y1:
    mov cx, barOpeningYBar2
    cmp pointY1, cx
    je COLLISION
    jmp BACK_OPENING1_BAR2
    
CHECK_BAR2_OPENING_Y2:
    mov cx, barOpeningYBar2
    cmp pointY2, cx
    je COLLISION
    jmp BACK_OPENING2_BAR2
    
CHECK_BAR2_OPENING_Y3:
    mov cx, barOpeningYBar2
    cmp pointY3, cx
    je COLLISION
    jmp BACK_OPENING3_BAR2
    
CHECK_BAR2_OPENING_Y4:
    mov cx, barOpeningYBar2
    cmp pointY4, cx
    je COLLISION
    jmp BACK_OPENING4_BAR2
    
CHECK_BAR2_OPENING_Y5:
    mov cx, barOpeningYBar2
    cmp pointY5, cx
    je COLLISION
    jmp BACK_OPENING5_BAR2
    
CHECK_BAR2_OPENING_Y6:
    ;mov cx, barOpeningYBar2
    ;cmp pointY6, cx
    ;je COLLISION
    
  
  
  
  
BACK_OPENING6_BAR2:    
    
    ;check if barOpeningX2_bar2 = birdX
    mov cx, barOpeningX2Bar2
    cmp pointX1, cx
    je CHECK_BAR2_OPENING_Y7
    
BACK_OPENING7_BAR2:
    mov cx, barOpeningX2Bar2
    cmp pointX2, cx
    je CHECK_BAR2_OPENING_Y8
    
BACK_OPENING8_BAR2:
    mov cx, barOpeningX2Bar2
    cmp pointX3, cx
    je CHECK_BAR2_OPENING_Y9
    
BACK_OPENING9_BAR2:
    mov cx, barOpeningX2Bar2
    cmp pointX4, cx
    je CHECK_BAR2_OPENING_Y10
    
BACK_OPENING10_BAR2:
    mov cx, barOpeningX2Bar2
    cmp pointX5, cx
    je CHECK_BAR2_OPENING_Y11
    
BACK_OPENING11_BAR2:
    ;mov cx, barOpeningX2Bar2
    ;cmp pointX6, cx
    ;je CHECK_BAR_OPENING_Y12
    jmp BACK_FLAG_BAR2  
    
    
    
    ;check if barOpeningY2 = birdY
CHECK_BAR2_OPENING_Y7:
    mov cx, barOpeningY2Bar2
    cmp pointY1, cx
    je COLLISION
    jmp BACK_OPENING7_BAR2
    
CHECK_BAR2_OPENING_Y8:
    mov cx, barOpeningY2Bar2
    cmp pointY2, cx
    je COLLISION
    jmp BACK_OPENING8_BAR2
    
CHECK_BAR2_OPENING_Y9:
    mov cx, barOpeningY2Bar2
    cmp pointY3, cx
    je COLLISION
    jmp BACK_OPENING9_BAR2
    
CHECK_BAR2_OPENING_Y10:
    mov cx, barOpeningY2Bar2
    cmp pointY4, cx
    je COLLISION
    jmp BACK_OPENING10_BAR2
    
CHECK_BAR2_OPENING_Y11:
    mov cx, barOpeningY2Bar2
    cmp pointY5, cx
    je COLLISION
    jmp BACK_OPENING11_BAR2
    
CHECK_BAR2_OPENING_Y12:
    ;mov cx, barOpeningY2Bar2
    ;cmp pointY6, cx
    ;je COLLISION
    
    
    
    BACK_FLAG_BAR2:
    cmp collisionFlag, 1
    je NO_COLLISION_BAR2

    inc collisionFlag
    jmp BACK_OPENING6_BAR2
    
NO_COLLISION_BAR2:
    dec collisionFlag
    
    ret
    
endp CHECK__BAR2_COLLISION_OPENING



;----------------------play sound------------------------








proc PLAY_SOUND
    
    inc soundCnt
    
    mov al, 0b6h         ; Prepare PIT: Channel 2, mode 3 (square wave), binary
    out 43h, al

    mov ax, 1193180 / 440 ; 440 Hz tone (A4)
    out 42h, al           ; Send low byte
    mov al, ah
    out 42h, al           ; Send high byte

    in al, 61h            ; Read port 61h
    or al, 3              ; Set bits 0 and 1 to enable speaker
    out 61h, al
    
    ret
    
endp PLAY_SOUND
 
   
 
proc STOP_SOUND
    
    mov soundCnt, 0
    
    in al, 61h
    and al, 0FCh          ; Clear bits 0 and 1 to disable speaker
    out 61h, al
    
    ret
    
endp STOP_SOUND




;------------clear screen--------------
proc CLEAR_SCREEN
    
    mov ah, 0ch
    mov al, color
    mov cx,0
    mov dx,0
    int 10h
    
SCREEN:
    int 10h
    inc cx
    cmp cx, 320
    je INC_Y
    cmp cx,320
    je INC_Y
    jmp SCREEN
    
    
INC_Y: 
    cmp dx, 200
    je END_CLEAR
    inc dx
    mov cx,0
    jmp SCREEN
    
END_CLEAR:
    ret

endp CLEAR_SCREEN    
    
    
  
ends

end start
