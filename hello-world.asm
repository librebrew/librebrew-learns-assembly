;learn how to use syscalls
;in order to interact with
;the operating system, 
;if there is one.

;a file descriptor allows you to read, write, and error to
;both the terminal and a file.

;file descriptor table:
;0 = STDIN 
;1 = STDOUT
;2 = STDERR

;syscall argument order:
;0 - RAX, used for the syscall number
;1st arg. - RDI, used for the file descriptor method
;2nd arg. - RSI, used for the address of the bytes being printed/read
;3rd arg. - RDX, used for the length of the bytes at the address
;4th arg. - RCX
;5th arg. - R8
;6th arg. - R9

;example of ordering:
;SYSCALL(WRITE, TERMINAL, ADDR, LEN)

;the above is OS specific
;what works here, may not work on windows


section .text
global _start


_start:

;arguments for a syscall:
mov rax, 1 ;syscall WRITE
mov rdi, 1 ;we write "1" for the STDOUT file descriptor 
mov rsi, string ;find the address of "string"

;mov rdx, 5 ;(old) tell the syscall handler how long the thing we want to print is

mov rdx, strlen ;move into RDX the value of "strlen", 
;which will the the length of the string we are trying to print

syscall ;notifies the syscall handler to execute our command

section .data

;string: db 'H', 'e', 'l', 'l', 'o'

;define a double byte under "string" with value "Hello, World!"
string: db "Hello, World!"

;calculate lenth of "string"
strlen equ $ - string
