;functions: we will learn how to do functions 
;in Assembly, just like in C.
section .text
global _start

_start:

;akin to a function: allows you to access
;the instructions below easily using a label

;but this is ran anyway even without calling it.
;so we need to put exit first to ensure our main "function"
;isnt ran automatically by the CPU.

;so we use the "jmp" before exit to "jump over" the exit label
;in order to reach the "print" function.

;jmp print

;without the "jmp" command above, the CPU would automatically run
;"exit" and terminate the program either way. 

;exit:
;mov rax, 60
;mov rsi, 0
;syscall

;print:
;mov rax, 1
;mov rdi, 1
;mov rsi, s1
;mov rdx, 6
;syscall

;jmp exit

;we jump back to exit to terminate our program cleanly.
;but we cant call exit after print is executed, as the CPU
;runs the program going v down v, so we must figure out a way
;to call our functions globally from any line (see below)

;so we must agree on a register to store our "return" label to (r15)
;in order to make the label global. if the label is in a register, then all of the other
;labels can globally call "r15" and run the contents of "r15", which achieves
;the same result as calling the label directly.

lea r15, [exit]
jmp print

exit:
mov rax, 60
mov rsi, 0
syscall
;we store the label "exit" into r15 as to make 
;it global to the other labels on the stack.

print:
mov rax, 1
mov rdi, 1
mov rsi, s1
mov rdx, 7
syscall
;jmp r15 ;(old) we jump to r15, which houses our "exit" label
jmp print2 ;we jump to "print2" to continue the cycle


;(not needed) example of interfunction cooperation
print2:
mov rax, 1
mov rdi, 1
mov rsi, s2
mov rdx, 6
syscall
jmp r15 ;we jump to r15, which houses our "exit" label

section .data

s1: dw "Hello, "
s2: dw "World!"
