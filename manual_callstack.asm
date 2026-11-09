;callstack: we will be defining our own callstack today
;in order to understand how the CPU's callstack works internally.

;the callstack is a plot in memory that saves return addresses
;for later use during runtime. without it, we would have to
;manually save return addresses in registers, which would mean
;overwriting information if we needed to save more than one.

;what we do below is define "callstack" as a plot of 4096 bytes,
;then we make r15 as a pointer to it. we then move a label's
;memory address into rax, then proceed to move THAT address into
;r15's memory address, which goes to "callstack" because r15 is
;a pointer to "callstack"'s memory address.

;we then increment r15 by 8 to move the pointer down in memory, 
;effectively making room for another return address. this is because 
;we are following the conventional x86-64 stack direction, which 
;grows downward towards lower memory addresses.

;when we want to retrieve a return address, we move the value
;stored at the memory address of r15 into a register, then
;decrement r15 by 8 to effectively remove that entry from our
;callstack.

;this allows us to save multiple return addresses without having
;to dedicate a separate register to each one.

;essentially, we are recreating the functionality of CALL and RET
;manually, using our own memory region and r15 as our stack pointer.


section .text
global _start

_start:
;put into r15 the memory address of "callstack".
lea r15, [callstack]

;move the beginning of the stack to the memory address of "callstack",
;which is 0x402000 (for viewing purposes).
lea rsp, [callstack]

;put into rax the memory address of "resume_here"
lea rax, [resume_here]

;put the newly stored memory address at rax into the address of r15,
;which would be the memory address of "callstack", aka 0x402000
mov [r15], rax

;increment by 8 to move down 
add r15, 8

jmp print_hello

;------------------------

resume_here:
  jmp exit
  
;------------------------

exit:
mov rax, 60
xor rdi, rdi ;zero out RDI
syscall

;------------------------

print_hello:
mov rax, 1
mov rdi, 1
lea rsi, hello ;start of string
lea rdx, hello_len ;len of string
syscall

;put into rax the memory address of "resume_hello"
lea rax, [resume_hello]

;put the newly stored memory address at rax into the address of r15,
;which would be the memory address of "resume_hello", aka 
mov [r15], rax
;lea r15, [resume_hello]
jmp print_world

;------------------------

resume_hello:

;subtract to go up in memory
sub r15, 8

;move into rax the address pointed to by r15
mov rax, [r15]

;jump to the address that RAX has.
jmp rax

;decrement and read

;------------------------

print_world:
mov rax, 1
mov rdi, 1
lea rsi, world ;start of string
lea rdx, world_len ;len of string
syscall

;you cannot jump to a register, 
;so we need to jump to its memory address,
;otherwise it would give us a SIGSEGV.
;jmp [r15]

;subtract to go up in memory
sub r15, 8

;move into rax the address pointed to by r15
mov rax, [r15]

;jump to the address that RAX has.
jmp rax

;the above is just equal to "jmp [r15]".
;decrement and read

;remember: r15 is how you go up and down in memory.
;increment it and you'll go down,
;decrement it and you'll go up.
;------------------------

section .data

;reserve 4096 bytes with value 0x00 (mainly does this at the starting point of the stack
;which would be 0x402000 due to the RSP modification we did above)
callstack: times 4096 db 0x00 ;500 instructions * 8 bytes = 4096 bytes / 4kb 

hello: db "hello, "
hello_len equ $ - hello

world: db "world!"
world_len equ $ - world
