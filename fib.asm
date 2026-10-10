section .text
global _start

_start:
;NASM needed

;manual fibbanoci sequence

mov rax, 0
inc rbx
add rbx, rax
mov rcx, rbx
add rcx, rax
add rax, rbx
add rbx, rax
add rax, rbx
;...