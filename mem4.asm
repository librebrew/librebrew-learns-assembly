;continuation of mem3:
;--- little endian ---
;db = define byte
;dw = define word

section .text
global _start

_start:

;unrelated, move the memory address of "mem"
;into rax
lea rax, [mem]

;move into rbx the value of the label "mem"
mov rbx, [mem]


;defines data in the executable's .data section;
;when the program runs, the OS maps this data
;into the process's virtual memory
section .data


mem: db 0x1, 0x2, 0x3, 0x4
;these 4 bytes are stored in exactly the order written,
;one byte at a time: 0x1 at the lowest address, then 0x2,
;0x3, 0x4 after it.

     dw 0xabcd
;this is a single 2-byte value, so it follows little-endian
;rules instead: least significant byte (cd) stored first,
;and most significant byte (ab) stored last.

;value of mem:
;0x402000: 01
;0x402001: 02
;0x402002: 03
;0x402003: 04
;0x402004: cd
;0x402005: ab
;0x402006: 
;0x402007: 