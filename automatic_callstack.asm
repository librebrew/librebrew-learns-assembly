;callstack: we will be using the callstack tha the CPU gives us
;in order to see how it's used.

;the callstack is a plot in memory that saves return addresses
;for later use during runtime. without it, we would have to
;manually save return addresses in registers, which would mean
;overwriting information if we needed to save more than one.

;what we do below is use the CPU's built-in callstack, which
;is managed through the RSP register. unlike our previous
;implementation, we no longer need to manually allocate memory
;or use R15 as a pointer to our own callstack.

;when we execute CALL, the CPU automatically pushes the memory
;address of the instruction immediately following CALL onto the
;stack, then jumps to the specified label. this allows us to
;save return addresses without manually moving them into registers
;or writing them into memory ourselves.

;when we execute RET, the CPU retrieves the return address from
;the top of the stack, removes that entry by adjusting RSP, and
;jumps to the retrieved address, effectively returning to where
;execution left off.

;the stack grows downward towards lower memory addresses, meaning
;that each CALL decreases RSP by 8 bytes when pushing a return
;address, while each RET increases RSP by 8 bytes when retrieving
;one.

;this allows us to perform nested function calls, saving multiple
;return addresses without having to dedicate a separate register
;to each one.

;essentially, we are using the CPU's built-in implementation of
;CALL and RET to manage our callstack automatically, rather than
;recreating their functionality manually using our own memory
;region and R15 as our stack pointer.
section .text
global _start

_start:

;put the address of our next instruction on the stack,
;stack automatically, then jump to the label specified
call print_hello ;call and jump to print_hello

;------------------------

exit: ;since "call print_hello" already ran, we can now run "exit"
mov rax, 60
xor rdi, rdi
syscall

;------------------------

print_hello:
mov rax, 1
mov rdi, 1
lea rsi, [hello]
mov rdx, hello_len
syscall

;put the address of our next instruction on the stack,
;stack automatically, then jump to the label specified
call print_world ;call print_world

ret ;return to _start

;------------------------

print_world:
mov rax, 1
mov rdi, 1
lea rsi, [world]
mov rdx, world_len
syscall

ret ;return to print_hello

;------------------------

section .data
hello: db "hello, "
hello_len equ $ - hello

world: db "world!"
world_len equ $ - world
