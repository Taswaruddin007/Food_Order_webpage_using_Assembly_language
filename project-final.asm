.MODEL SMALL

print MACRO string
    push ax
    push dx 
    
    mov ah, 9
    lea dx, string
    int 21h
    
    pop dx
    pop ax
ENDM   

take_input MACRO 
    mov ah, 1
    int 21h
    mov bl, al 
ENDM

.STACK 100H

.DATA

;============================== Display =================================
;Logo
banner  db 201, 46 dup(205), 187,13,10
        db 186, '                                              ', 186,13,10
        db 186, '      W E L C O M E   T O   F O O D I E Z     ', 186,13,10
        db 186, '                                              ', 186,13,10
        db 200, 46 dup(205), 188,13,10
        db '            Your hunger ends here!',13,10, "$"

;variables and arrays_start_shanto

;HOME PAGEE ~ Sign up/Log in page
home_page   db 13, 10, 201, 46 dup(205), 187,13,10
            db 186, '           S I G N U P / L O G I N            ', 186 ,13,10
            db 204, 46 dup(205), 185,13,10
            db 186, '   1. Sign up                                 ', 186, 13,10
            db 186, '   2. Login                                   ', 186, 13,10
            db 186, 46 dup(196), 186,13,10
            db 186, '   3. Exit                                    ', 186,13,10
            db 200, 46 dup(205), 188,13,10
            db '      Enter your choice (1-3): $'

;invalid_input_in_homepage
invalid_input_in_homepage   db 13, 10, 201, 46 dup(205), 187,13,10
                            db 186, '           S I G N U P / L O G I N            ', 186 ,13,10
                            db 204, 46 dup(205), 185,13,10
                            db 186, '   1. Sign up                                 ', 186, 13,10
                            db 186, '   2. Login                                   ', 186, 13,10
                            db 186, 46 dup(196), 186,13,10
                            db 186, '   3. Exit                                    ', 186,13,10
                            db 200, 46 dup(205), 188,13,10
                            db '             Input invalid!!!',13,10            
                            db '       Please enter a valid value (1-3): $'
            
;Login page
login_page    db 13, 10, 201, 46 dup(205), 187,13,10
            db 186, '                  L O G I N                   ', 186 ,13,10
            db 204, 46 dup(205), 185,13,10
            db 186, '   1. Username:                               ', 186, 13,10
            db 186, '   2. Password:                               ', 186, 13,10
            db 200, 46 dup(205), 188,13,10
            db '     Enter your usrname/pass$'

;Signup page
signup_page    db 13, 10, 201, 46 dup(205), 187,13,10
            db 186, '               S I G N U P                    ', 186 ,13,10
            db 204, 46 dup(205), 185,13,10
            db 186, '   1. Username:                               ', 186, 13,10
            db 186, '   2. Password:                               ', 186, 13,10
            db 200, 46 dup(205), 188,13,10
            db ' Enter your usrname(max 6chars)/pass(max 8chars)$'            

username db 6 dup(0) ; username length is 6
password db 8 dup(0) ; password length is 8 

set_username db 6 dup(0) ; set_username length is 6
set_password db 8 dup(0) ; set_password length is 8 

fname db 'database.txt', 0
fhandle dw ? ;file handle will be saved here

coma db ','
colon db ':'
dollar db '$'

credentials db 255 dup(0)  ; Buffer to store credentials from file
msg_found db 13, 10, 'Login successful! Welcome to FOODIEZ!$'
msg_notfound db 13, 10, 'Invalid username or password. Please try again.$'
isMatch db 0  ;
success_signup db 13, 10, 'Sign up successful! Please login to continue.$'

;variables and arrays_end_shanto

;Categories
categories  db 13, 10, 201, 46 dup(205), 187,13,10
            db 186, '             C A T E G O R I E S              ', 186 ,13,10
            db 204, 46 dup(205), 185,13,10
            db 186, '   1. Breakfast                               ', 186, 13,10
            db 186, '   2. Lunch                                   ', 186, 13,10
            db 186, '   3. Dinner                                  ', 186,13,10
            db 186, '   4. Snacks                                  ', 186,13,10
            db 186, '   5. Drinks                                  ', 186,13,10 
            db 186, 46 dup(31), 186,13,10
            db 186, '   6. Exit                                    ', 186,13,10
            db 200, 46 dup(205), 188,13,10
            db '      Enter your choice (1-6): $'


;Breakfast Menu 
   
breakfast_menu  db 13, 10, 201, 46 dup(205), 187,13,10
                db 186, '             B R E A K F A S T                ', 186 ,13,10
                db 204, 46 dup(205), 185,13,10
                db 186, '   1. Porota                         - BDT 10 ', 186, 13,10
                db 186, '   2. Ruti                           - BDT 10 ', 186, 13,10                
                db 186, '   3. Daal                           - BDT 20 ', 186,13,10
                db 186, '   4. Egg                            - BDT 25 ', 186,13,10
                db 186, '   5. Mixed Vegetables               - BDT 20 ', 186,13,10
                db 186, '   6. Halwa                          - BDT 30 ', 186,13,10
                db 186, '   7. Coffee                         - BDT 20 ', 186,13,10
                db 186, '   8. Milk Tea                       - BDT 15 ', 186,13,10 
                db 186, 46 dup(31), 186,13,10
                db 186, '   9. Previous page                           ', 186,13,10
                db 200, 46 dup(205), 188,13,10
                db '      Enter your choice (1-9): $'

breakfast_price dw 10, 10, 20, 25, 20, 30, 20, 15 


; Lunch Menu (8 items) 
     
lunch_menu db 13, 10, 201, 46 dup(205), 187,13,10
        db 186, '                   L U N C H                  ', 186,13,10
        db 204, 46 dup(205), 185,13,10
        db 186, '   1. Kacchi Biryani               - BDT 180  ', 186,13,10
        db 186, '   2. Tehari                       - BDT 100  ', 186,13,10
        db 186, '   3. Beef Polao                   - BDT 150  ', 186,13,10
        db 186, '   4. Chicken Polao                - BDT 130  ', 186,13,10
        db 186, '   5. Beef Khichuri                - BDT 150  ', 186,13,10  
        db 186, '   6. Egg Polao                    - BDT 60   ', 186,13,10 
        db 186, '   7. Chatni                       - BDT 20   ', 186,13,10 
        db 186, '   8. Jali Kabab                   - BDT 40   ', 186,13,10 
        db 186, 46 dup(31), 186,13,10
        db 186, '   9. Previous page                           ', 186,13,10
        db 200, 46 dup(205), 188,13,10
        db '      Enter your choice (1-9): $' 
        
lunch_price dw 180, 100, 150, 130, 150, 60, 20, 40

; Dinner Menu (8 items)
            
dinner_menu db 13, 10, 201, 46 dup(205), 187,13,10
            db 186, '                  D I N N E R                 ', 186,13,10
            db 204, 46 dup(205), 185,13,10
            db 186, '   1. Plain Rice                   - BDT 30   ', 186,13,10
            db 186, '   2. Fish Curry                   - BDT 130  ', 186,13,10
            db 186, '   3. Beef Curry                   - BDT 170  ', 186,13,10
            db 186, '   4. Chicken Curry                - BDT 150  ', 186,13,10
            db 186, '   5. Mixed Vegetable              - BDT 30   ', 186,13,10  
            db 186, '   6. Egg Polao                    - BDT 30   ', 186,13,10 
            db 186, '   7. Chicken Liver                - BDT 100  ', 186,13,10 
            db 186, '   8. Beef Liver                   - BDT 120  ', 186,13,10 
            db 186, 46 dup(31), 186,13,10
            db 186, '   9. Previous page                           ', 186,13,10
            db 200, 46 dup(205), 188,13,10
            db '      Enter your choice (1-9): $' 
dinner_price dw 30, 130, 170, 150, 30, 30, 100, 120

; Snacks Menu (8 items)

snacks_menu db 13, 10, 201, 46 dup(205), 187,13,10
            db 186, '                  S N A C K S                 ', 186,13,10
            db 204, 46 dup(205), 185,13,10
            db 186, '   1. Singara                      - BDT 10   ', 186,13,10
            db 186, '   2. Samosa                       - BDT 10   ', 186,13,10
            db 186, '   3. Chicken Roll                 - BDT 35   ', 186,13,10
            db 186, '   4. Vegetable Roll               - BDT 20   ', 186,13,10
            db 186, '   5. Shawarma                     - BDT 60   ', 186,13,10  
            db 186, '   6. Chicken Burger               - BDT 130  ', 186,13,10 
            db 186, '   7. French Fries                 - BDT 90   ', 186,13,10 
            db 186, '   8. Chicken Fry                  - BDT 100  ', 186,13,10 
            db 186, 46 dup(31), 186,13,10
            db 186, '   9. Previous page                           ', 186,13,10
            db 200, 46 dup(205), 188,13,10
            db '      Enter your choice (1-9): $'             
            
snack_price dw 10, 10, 35, 20, 60, 130, 90, 100

; Drinks Menu (8 items)
            
drinks_menu db 13, 10, 201, 46 dup(205), 187,13,10
            db 186, '                  S N A C K S                 ', 186,13,10
            db 204, 46 dup(205), 185,13,10
            db 186, '   1. Mineral Water                - BDT 15   ', 186,13,10
            db 186, '   2. Coca Cola                    - BDT 20   ', 186,13,10
            db 186, '   3. Pepsi                        - BDT 20   ', 186,13,10
            db 186, '   4. Lemonade                     - BDT 30   ', 186,13,10
            db 186, '   5. Orange Juice                 - BDT 50   ', 186,13,10  
            db 186, '   6. Apple Juice                  - BDT 70   ', 186,13,10 
            db 186, '   7. Milk Shake                   - BDT 100  ', 186,13,10 
            db 186, '   8. Lacchi                       - BDT 90   ', 186,13,10 
            db 186, 46 dup(31), 186,13,10
            db 186, '   9. Previous page                           ', 186,13,10
            db 200, 46 dup(205), 188,13,10
            db '      Enter your choice (1-9): $' 
            
drinks_price dw 15, 20, 20, 30, 50, 70, 100, 90

;============================== Display =================================
msg db 'Food item: $'

quantity_msg db 13, 10, '      Enter quantity (1-9): $'
                                              
total_msg db 13, 10, 'Total price: BDT $'
invalid_msg db 13, 10, 'Invalid input! Press any key to continue...', 13, 10, '$'
bill_msg db 13, 10, '=== Your Bill ===', 13, 10, '$'

final_msg db 13, 10, 13, 10, '1. Main Menu', 13, 10, '2. Exit', 13, 10, 13, 10, 'Select option: $'
thanks_msg db 'Thanks for using our service!$'

options_msg db 13, 10, "1. Main Menu", 13, 10, "2. Order another item from this category", 13, 10, "3. Show Bill", 13, 10, 13, 10, "Select option: $"

no_discount1 db "You will get discount upto 20%, if you buy foods more than 500TK. $"

newline db 13, 10, '$'

cat_arr db 16 dup(?)    ;Stores category of selected item
item_arr db 16 dup(?)   ;Stores selected item in category 
quantity_arr db 16 dup(?)   ; Stores quantity of selected item

is_logged_in db 0 ; Flag (1=logged in)
 
; We can only iterate through array by moving index to SI/DI. 
index dw 0  ; One index used for all three arrays related to showing order 


current_cat db '0' ; Current Category
chosen_item db '0' 

offset1 dw ?

current_price dw ?
current_quantity db ?
total_price dw 0

;Discount calculation
discount_percentage dw 0
discount_amount dw 0
final_price dw 0

;Messages for discount display
discount_msg db "Discount: $"
percent_msg db "%$"
discount_amount_msg db "Discount Amount: $"
final_price_msg db "Final Price: $"


.CODE
MAIN PROC

; initialize DS

MOV AX,@DATA
MOV DS,AX

;======================= Shanto's part_start =======================;

;------------------------ Open database ------------------------;

mov ah, 3dh
lea dx, fname
mov al, 2          ; Open for read/write
int 21h
jc create_file     ; If file doesn't exist, create it
mov fhandle, ax
jmp show_banner

create_file:
    mov ah, 3ch    ; Create file
    lea dx, fname
    mov cx, 0      ; Normal file attribute
    int 21h
    mov fhandle, ax

show_banner:
print banner
print home_page

main_screen:
mov ah, 1
int 21h
cmp al, '1'
je signup
cmp al, '2'
je login
cmp al, '3'
je exit
jmp invalid_range

invalid_range:
call beep 
call beep
call beep
call clear_console
print banner
print invalid_input_in_homepage
jmp main_screen 

login:
call clear_console
print banner
print login_page

;---------- move cursor after username ----------;
mov ah, 02h
mov bh, 0
mov dh, 10
mov dl, 17
int 10h

;---------- input username ----------;
mov si, 0
user_again:
mov ah, 1h
int 21h

cmp al, 13 ;checks if ENTER is pressed
je exit_username_input

cmp al, 8 ;checks if backspace if pressed
je handle_backspace_usr

mov username[si], al
inc si

cmp si, 6  ;check if maxium length for username-6 is reached
jl user_again
je exit_username_input 

handle_backspace_usr:
    cmp si, 0h
    je user_again
    dec si
    mov ah, 2
    mov dl, ' '              ; Space to clear
    int 21h
    ; Move the cursor back and clear the character
    mov dl, 8                ; Backspace
    int 21h
    mov dl, ' '              ; Space to clear
    int 21h
    mov dl, 8                ; Backspace again
    int 21h
    jmp user_again 

exit_username_input:
mov username[si], 0  ; Null terminator

;---------- move cursor after password ----------;
mov ah, 02h
mov bh, 0
mov dh, 11
mov dl, 17
int 10h

;---------- input password ----------;
mov si, 0
pass_again:
mov ah, 1h
int 21h

cmp al, 13 ;checks if ENTER is pressed
je exit_password_input

cmp al, 8 ;checks if backspace if pressed
je handle_backspace_pass

mov password[si], al
inc si

cmp si, 8  ;check if maxium length for password-8 is reached
jl pass_again
je exit_password_input 

handle_backspace_pass:
    cmp si, 0h
    je pass_again
    dec si
    mov ah, 2
    mov dl, ' '              ; Space to clear
    int 21h
    ; Move the cursor back and clear the character
    mov dl, 8                ; Backspace
    int 21h
    mov dl, ' '              ; Space to clear
    int 21h
    mov dl, 8                ; Backspace again
    int 21h
    jmp pass_again 

exit_password_input:
mov password[si], 0  ; Null terminator

;---------- read database ----------;
; First, move to beginning of file
mov ah, 42h          ; SEEK - move file pointer
mov al, 0            ; AL=0 means from beginning of file
mov bx, fhandle
mov cx, 0            ; High part of offset
mov dx, 0            ; Low part of offset
int 21h

; Now read the file contents into credentials buffer
mov ah, 3fh          ; Read from file
mov bx, fhandle      ; File handle in BX
lea dx, credentials  ; Load destination buffer address
mov cx, 254          ; Maximum bytes to read (leave room for terminator)
int 21h              ; Read file
mov si, ax           ; Save number of bytes read in SI
mov credentials[si], 0 ; Add null terminator

;---------- check credentials ----------;
;CALL checkCredentials
;
    ; Initialize registers
    lea si, credentials                   ; SI points to credentialsentials database
    mov isMatch, 0                 ; Reset match flag

parse_loop:
    cmp [si], 0                    ; Check if we've reached the end of credentials
    je parse_done                  ; If end, we're done

    cmp [si], ','                  ; Check if we've found a usernamename start
    jne next_char                  ; If not, move to next character
    
    ; Found start of usernamename, now validate it
    inc si                         ; Move past the comma
    call check_usernamename            ; Call usernamename check routine
    cmp al, 1                      ; Did usernamename match?
    jne find_next_username             ; If not, move to next username
    
    ; usernamename matched, now check password
    call check_password            ; Call password check routine
    cmp al, 1                      ; Did password match?
    jne find_next_username             ; If not, move to next username
    
    ; Both matched - we have a valid credentialsential pair!
    mov [isMatch], 1               ; Set match flag to true
    jmp parse_done                 ; Exit the loop

find_next_username:
    ; Skip to next comma to find start of next username
    push si                        ; Save current position
    
find_comma:
    lodsb                          ; Load byte at SI into AL and increment SI
    cmp al, 0                      ; Check for end of string
    je find_comma_done             ; If end of string, exit loop
    cmp al, ','                    ; Check for comma
    jne find_comma                 ; If not comma, continue searching
    dec si                         ; Move back to the comma
    
find_comma_done:
    mov si, si                     ; Update source pointer (in case we hit end)
    jmp parse_loop                 ; Continue parsing

next_char:
    inc si                         ; Move to next character
    jmp parse_loop                 ; Continue parsing

parse_done:
    ;; Exit program
;    mov ah, 4Ch                    ; DOS function: terminate program
;    int 21h                        ; Call DOS service
;    
CMP isMatch, 1
JNE not_match
    
call clear_console
print banner
LEA DX, msg_found
MOV AH, 09H
INT 21H
MOV AH, 1H
INT 21H
JMP select_cat
    
not_match:
call beep  ; makes a beep sound
call beep 
call beep
call clear_console
print banner
LEA DX, msg_notfound
MOV AH, 09H
INT 21H
mov ah, 1h       ; Wait for key press before returning to menu
int 21h
call clear_console
print banner
print home_page
jmp main_screen



signup:
call clear_console
print banner
print signup_page

;---------- move cursor after set username ----------;
mov ah, 02h
mov bh, 0
mov dh, 10
mov dl, 17
int 10h

;---------- set username ----------;
mov si, 0
setuser_again:
mov ah, 1h
int 21h

cmp al, 13 ;checks if ENTER is pressed
je exit_setuser_input

cmp al, 8 ;checks if backspace if pressed
je handle_backspace_setuser

mov set_username[si], al
inc si

cmp si, 6  ;check if maxium length for username-6 is reached
jl setuser_again
je exit_setuser_input 

handle_backspace_setuser:
    cmp si, 0h
    je setuser_again
    dec si
    mov ah, 2
    mov dl, ' '              ; Space to clear
    int 21h
    ; Move the cursor back and clear the character
    mov dl, 8                ; Backspace
    int 21h
    mov dl, ' '              ; Space to clear
    int 21h
    mov dl, 8                ; Backspace again
    int 21h
    jmp setuser_again 

exit_setuser_input:
mov set_username[si], 0  ; Null terminator
mov di, si
;---------- move cursor after password ----------;
mov ah, 02h
mov bh, 0
mov dh, 11
mov dl, 17
int 10h

;---------- set password ----------;
mov si, 0
setpass_again:
mov ah, 1h
int 21h

cmp al, 13 ;checks if ENTER is pressed
je exit_setpass_input

cmp al, 8 ;checks if backspace if pressed
je handle_backspace_setpass

mov set_password[si], al
inc si

cmp si, 8  ;check if maxium length for username-6 is reached
jl setpass_again
je exit_setpass_input 

handle_backspace_setpass:
    cmp si, 0h
    je setpass_again
    dec si
    mov ah, 2
    mov dl, ' '              ; Space to clear
    int 21h
    ; Move the cursor back and clear the character
    mov dl, 8                ; Backspace
    int 21h
    mov dl, ' '              ; Space to clear
    int 21h
    mov dl, 8                ; Backspace again
    int 21h

exit_setpass_input:
mov set_password[si], 0  ; Null terminator

; move file pointer to end
mov bx, fhandle
mov ah, 42h
mov al, 2            ; Move from end of file
mov cx, 0
mov dx, 0
int 21h

; Write comma if not at beginning of file
mov ax, dx           ; Check if file pointer is at position 0
or ax, cx
jz skip_comma        ; If at position 0, skip writing comma

; write comma
mov ah, 40h
mov bx, fhandle
lea dx, coma
mov cx, 1
int 21h

skip_comma:
; write the username
mov ah, 40h
mov bx, fhandle
lea dx, set_username
mov cx, di          ; Use the actual length of the username
int 21h

; write colon to mark end of username
mov ah, 40h
mov bx, fhandle
lea dx, colon
mov cx, 1
int 21h

; write the password
mov ah, 40h
mov bx, fhandle
lea dx, set_password
mov cx, si          ; Use the actual length of the password
int 21h

; write comma
mov ah, 40h
mov bx, fhandle
lea dx, coma
mov cx, 1
int 21h

call clear_console
print banner
lea dx, success_signup
mov ah, 09h
int 21h

mov ah, 1h          ; Wait for key press before returning to menu
int 21h
call clear_console
print banner
print home_page
jmp main_screen
;======================= Shanto's part_end =======================;

;Show menu
;main_screen:
;
;    CALL clear_console
;    print banner
;    print home_page
;    
;    mov ah, 1
;    int 21h
;    mov bl, al
;    
;    CALL clear_console
;    
;    cmp bl, '1'
;    je signup
;    cmp bl, '2'
;    je login
;    cmp bl, '3'
;    je exit
;    
;    jmp invalid
    
;Category selection   
select_cat:
    CALL clear_console
    print categories
    
    mov ah, 1
    int 21h
    ;mov bl, al
    
    ;mov current_cat, bl
    mov current_cat, al
    
    cat_compare:
    cmp current_cat, '1'
    je breakfast
    cmp current_cat, '2'
    je lunch
    cmp current_cat, '3'
    je dinner
    cmp current_cat, '4'
    je snacks
    cmp current_cat, '5'
    je drinks
    cmp current_cat, '6'
    je show_bill
    
    jmp invalid

;Invalid input handler    
invalid:
    mov current_cat, '0'; Resets the current category
    
    CALL clear_console 
    print invalid_msg
    
    mov ah, 1
    int 21h
         
    jmp select_cat

;Options menu after item selection            
options:
    print options_msg
    take_input
    
    cmp bl, '1'  ; Main menu
    je select_cat
    cmp bl, '2'  ;New item from same menu
    je cat_compare
    cmp bl, '3' ; Show bill
    je show_bill 
    
    jmp invalid
    
;If user orders from same category again
;same_cat:
;    
;    mov bl, current_cat
;    
;    cmp bl, '1'
;    je breakfast
;    cmp bl, '2'
;    je lunch
;    cmp bl, '3'
;    je dinner
;    cmp bl, '4'
;    je snacks
;    cmp bl, '5'
;    je drinks
;    
;    jmp invalid
    
breakfast:
    ; number of current category stored during select_cat
    CALL clear_console
    print breakfast_menu
    
    mov bx, offset breakfast_price
    CALL selection_process
    
    jmp options 
    
lunch:
    CALL clear_console
    print lunch_menu
    
    mov bx, offset lunch_price
    CALL selection_process
    
    jmp options 
dinner:
    CALL clear_console
    print dinner_menu
    
    mov bx, offset dinner_price
    CALL selection_process
    jmp options 
     
snacks:
    CALL clear_console
    print snacks_menu
    
    mov bx, offset snack_price
    CALL selection_process
    jmp options 

drinks:
    CALL clear_console
    print drinks_menu
    
    
    mov bx, offset drinks_price
    CALL selection_process
    jmp options 
    
       

    
;exit to DOS
exit:
    
    ; close file
    mov ah, 3eh
    mov bx, fhandle
    int 21h
    
    CALL clear_console
    print thanks_msg               
    MOV AX,4C00H
    INT 21H
    
MAIN ENDP 


clear_console PROC
    push ax
    mov ax, 3
    int 10h
    pop ax
    ret
clear_console ENDP 

is_valid PROC
    cmp bl, '1'
    jl is_invalid
    cmp bl, '9'
    jg is_invalid
    
    ret
    
    is_invalid:
        add sp, 2; removes return address from stack for balance
        jmp invalid
    ;Else valid
    
is_valid ENDP 

add_to_arr PROC
    mov si, index
    mov cat_arr[si], dl         ; Category from DL
    mov item_arr[si], dh        ; Item from DH
    mov quantity_arr[si], bl    ; Quantity from BL
    
    lea dx, newline
    mov ah, 9
    int 21h
    
    mov al, item_arr[si] ; Get item no. from arr
    sub al, '1'
    mov ah, 0
    mov si, ax ; Move item index to SI to finding price
    
    add si, si ; si = si*2 to find mem add in 16-bit array
    
    
    mov bx, offset1
    mov ax, [bx+si]   ; Mem address of needed price
    mov current_price, ax
    
    mov di, index
    mov bl, quantity_arr[di]  ; Quantity of current item
    sub bl, '0'               ; Convert to number
    mov current_quantity, bl
  ;  mov bl, bl   ; // Purpose?
    mov bh, 0
    mov ax, current_price
    mul bx
    add total_price, ax
    
    ; Show current total
    print total_msg
    mov ax, total_price  ;Parameter pass to print_number proc 
    
    CALL print_number
    
    inc index
    ret
add_to_arr ENDP 


selection_process PROC
    
    mov offset1, bx
        
    take_input             ; Item selection
    mov chosen_item, bl    ; Store the chosen item
    CALL is_valid
    
    cmp chosen_item, '9'
    jne continue
    ;If exit
    mov current_cat, '0'    ;Resets the current category
    add SP, 2               ;Adjust stack pointer to remove the return address if exit
    jmp select_cat
    
    continue:
    print quantity_msg
     
    take_input             ; Quantity
    mov ah, 0              ; Clear AH to preserve only AL
    mov cl, al             ; Store quantity in CX
    CALL is_valid
   
    ;Parameter pass
    mov dl, current_cat    ; Category in DL
    mov dh, chosen_item    ; Item in DH
    mov bl, cl             ; Quantity in BL
    
     
    CALL add_to_arr
    
    ret
selection_process ENDP

print_number PROC
    push bx
    push cx
    push dx
    
    mov bx, 10
    xor cx, cx
    
    divide:
    xor dx, dx
    div bx
    push dx
    inc cx
    test ax, ax
    jnz divide
        
    print_digits:
    pop dx
    add dl, '0'
    mov ah, 02h
    int 21h
    loop print_digits
    
    pop dx
    pop cx
    pop bx
    ret
print_number ENDP
 
 
calculate_discount PROC
    push ax
    push bx
    push cx
    push dx
    
    mov discount_percentage, 0
    mov discount_amount, 0
    
    ;check for 2000 or higher
    cmp total_price, 2000
    jb check_smaller_discount
    
    mov discount_percentage, 20
    jmp calculate_amount
    
    check_smaller_discount:
        cmp total_price, 500
        jb no_discount
        
        ;calculate discount percentage
        mov ax, total_price
        mov bx, 500
        div bx
        
        ;multiply quotient by 5 to get discount percentage
        mov bx, 5
        mul bx
        
        mov discount_percentage, ax
        
    calculate_amount:
        mov ax, total_price
        mul discount_percentage
        mov bx, 100
        div bx
        
        mov discount_amount, ax
        
        mov ax, total_price
        sub ax, discount_amount
        mov final_price, ax
        
    no_discount:
        pop dx
        pop cx
        pop bx
        pop ax
    ret
    
calculate_discount ENDP
        

show_bill PROC
    CALL clear_console
    print bill_msg
    
    ;calculate discount before showing bill
    CALL calculate_discount
        
    print total_msg
    
    mov ax, total_price
    CALL print_number
    
    lea dx, newline
    mov ah, 9
    int 21h
    
    cmp discount_percentage, 0
    je no_discount_display
    
    print discount_msg
    mov ax, discount_percentage
    call print_number
    print percent_msg
    
    lea dx, newline
    mov ah, 9
    int 21h
    
    ;show discount amount
    print discount_amount_msg
    mov ax, discount_amount
    CALL print_number
    
    lea dx, newline
    mov ah, 9
    int 21h
    
    ;show final price after discount
    print final_price_msg
    mov ax, final_price 
    CALL print_number
    
    lea dx, newline
    mov ah, 9
    int 21h
    
    no_discount_display:
        print no_discount1
    
        print final_msg
        mov ah, 01h
        int 21h
        
        cmp al, '1'
        je main_screen
        cmp al, '2'
        je exit
        
        jmp invalid
    
    
    ret
show_bill ENDP

BEEP PROC
    PUSH AX     ; Save registers
    PUSH BX
    PUSH CX
    PUSH DX
    
    mov dx,7
    mov ah,2
    int 21h
        
    POP DX       ; Restore registers
    POP CX
    POP BX
    POP AX
    RET
BEEP ENDP

;------------------------------------------------------
; check_usernamename - Checks if current position matches username
; Input: SI = current position in credentials
; Output: AL = 1 if matched, 0 if not matched
;         SI = position after usernamename (at the colon)
;------------------------------------------------------
check_usernamename proc
    push bx                        ; Save registers
    push cx
    push di
    
    lea di, username                   ; DI points to usernamename to check
    mov cx, 0                      ; Initialize counter for username length
    mov bx, si                     ; Save starting position
    
usernamename_loop:
    mov al, [si]                   ; Get char from credentials
    
    ; Check for end conditions
    cmp al, ':'                    ; End of usernamename in credentials?
    je username_compare_done
    
    cmp al, ','                    ; Unexpected end of usernamename?
    je usernamename_mismatch
    
    cmp al, 0                      ; End of credentials string?
    je usernamename_mismatch
    
    ; Compare with username character
    cmp cx, 6                      ; Are we past the max username length?
    jae usernamename_mismatch      ; If yes, cannot match
    
    cmp al, [di]                   ; Compare with username character
    jne usernamename_mismatch      ; If not equal, no match
    
    ; Move to next characters
    inc si
    inc di
    inc cx                         ; Increment counter
    jmp usernamename_loop

username_compare_done:
    ; Check if we've used all entered username characters
    cmp byte ptr [di], 0           ; Is next username char null?
    je username_match              ; If yes, we have a match
    
    ; If username length is 6, that's still valid (max length)
    cmp cx, 6
    je username_match
    
    ; Otherwise, mismatch
    jmp usernamename_mismatch

username_match:
    mov al, 1                      ; Set return value to true
    jmp usernamename_done

usernamename_mismatch:
    ; usernamename doesn't match
    mov al, 0                      ; Set return value to false
    mov si, bx                     ; Restore position

usernamename_done:
    pop di                         ; Restore registers
    pop cx
    pop bx
    ret
check_usernamename endp

;------------------------------------------------------
; check_password - Checks if password after colon matches pass
; Input: SI = position at the colon
; Output: AL = 1 if matched, 0 if not matched
;         SI = position after password (at the comma)
;------------------------------------------------------
check_password proc
    push bx                        ; Save registers
    push cx
    push di
    
    mov bx, si                     ; Save colon position
    inc si                         ; Move past the colon
    lea di, password                  ; DI points to password to check
    mov cx, 0                      ; Initialize counter for password length

password_loop:
    mov al, [si]                   ; Get char from credentials
    
    ; Check for end conditions
    cmp al, ','                    ; End of password in credentials?
    je password_compare_done
    
    cmp al, 0                      ; End of credentials string?
    je password_mismatch
    
    ; Compare with password character
    cmp cx, 8                      ; Are we past the max password length?
    jae password_mismatch          ; If yes, cannot match
    
    cmp al, [di]                   ; Compare with password character
    jne password_mismatch          ; If not equal, no match
    
    ; Move to next characters
    inc si
    inc di
    inc cx                         ; Increment counter
    jmp password_loop

password_compare_done:
    ; Check if we've used all entered password characters
    cmp byte ptr [di], 0           ; Is next password char null?
    je password_match              ; If yes, we have a match
    
    ; If password length is 8, that's still valid (max length)
    cmp cx, 8
    je password_match
    
    ; Otherwise, mismatch
    jmp password_mismatch

password_match:
    mov al, 1                      ; Set return value to true
    jmp password_done

password_mismatch:
    ; Password doesn't match
    mov al, 0                      ; Set return value to false
    mov si, bx                     ; Restore position

password_done:
    pop di                         ; Restore registers
    pop cx
    pop bx
    ret
check_password endp

    END MAIN