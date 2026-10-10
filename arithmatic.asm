section .text
global _start

_start:

;NASM needed

; move values to different regs

;move 5 into the reg. rax
mov rax, 5 

;move the value in rax to rbx
mov rbx, rax

;move the data stored at 0x401000 to rdx
mov rdx, [0x401000]

;----------------
;addition and subtraction
;----------------

;add three to rax
add rax, 3

;add the val. of rbx to rax
add rax, rbx

;subtract 2 from rax
sub rax, 2

;subtract rbx from rax
sub rax, rbx

;increment rax by 1
inc rax

;decrement rax by one
dec rax

