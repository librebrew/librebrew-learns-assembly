;continuation of mem5:
;--- write to memory at runtime ---
;db = define byte
;dw = define word
;dd = long word
section .text
global _start

_start:
lea rsp, [wow1]
;mov rax, [wow1]

section .data

wow1: dq 0x00375a02ffc0d713, 0xa4cdce6be1935500, 0x081cc7258d50c20b
      dd 0x1a1a1a
;note: you can use "db 0x1a, 0x1a, 0x1a" instead of "dd 0x1a1a1a"


