bits 16
org 0x7C00
jmp 0x0000:start

start:
    mov si, hello_string
    call print_string
    prompt:
        mov si, newline_string
        call print_string
        mov si, prompt_string
        call print_string
        get_command:
            call get_keystroke

            ; Check if the character typed is "Enter"
            cmp ah, 0x1c
            je submit_command

            ; If the typed character was regular ASCII, print it
            call print_character
            jmp get_command
        submit_command:
            jmp prompt

get_keystroke: ; When a key is pressed, the ASCII character is stored in "al".
    mov ah, 0x00
    int 0x16
    ret

print_character: ; Print out the ASCII character stored in register "al".
    mov ah, 0x0e
    mov bh, 0x00
    mov bl, 0x07
    int 0x10
    ret

print_string: ; Print the characters in the string that "si" points to.
    next_character:
        mov al, [si]
        inc si
        or al, al
        jz exit_function
        call print_character
        jmp next_character
    exit_function:
        ret

newline_string db 0x0d, 0x0a, 0
input_string db '', 0
prompt_string db '$ ', 0
hello_string db 'Hello, World!', 0
times 510 - ($ - $$) db 0   ; Fill the rest of the sector with "00".
dw 0xAA55   ; Add boot signature at the end.