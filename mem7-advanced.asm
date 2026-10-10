;continuation of mem5:
;set 1024 bytes to a specific value, then overwrite a small portion
;with a custom value
;db = define byte
;dw = define word
;dd = define double-word
section .text
global _start

_start:
;set the beginning of the stack to the memory address of "mem"
lea rsp, [mem]

;put the memory address of "mem" into rsi
lea rsi, [mem]


;put 0x00375a02ffc0d713 into rax
mov rax, 0x00375a02ffc0d713

;change the memory address of "mem" to the value of rax
mov [rsi], rax

;advance rsi by 8 bytes, which moves us to a new memory address
add rsi, 8

;---------------------------------------------

;put 0xa4cdce6be1935500 into rax
mov rax, 0xa4cdce6be1935500

;modify the new line with the new value from rax
mov [rsi], rax

;advance rsi by 8 bytes, which moves us to a new memory address
add rsi, 8

;---------------------------------------------

;put 0x081cc7258d50c20b into rax
mov rax, 0x081cc7258d50c20b

;modify the new line with the new value from rax
mov [rsi], rax

;advance rsi by 8 bytes, which moves us to a new memory address
add rsi, 8

;---------------------------------------------

;essentially the bullshit we're doing above goes in this order:

;allocate 1024 bytes with value "0xff"
;load the memory address of "mem" into the stack pointer
;overwrite it with the value from rax, which is "0x00375a02ffc0d713"
;move down another line
;add a new value to rax
;overwrite the value of the new line with the new value from rax

;repeat one more time, and you're left with three values on three lines
;all of this can be viewed with the "stack memory" tab on "x86_64 playground"
;or via a disassembler

section .data

;set 1024 bytes of the stack to 0xff
mem: times 1024 db 0xff
;this is a risky operation, consult the previous files for more information
