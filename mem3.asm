;---------------------------------
;references:
;8 bits = 1 byte
;16 bits = 2 bytes/word
;32 bits = 4 bytes/double word
;64 bits = 8 bytes/quad word
;---------------------------------
;load effective addresses = (lea)
;---------------------------------
;subsets are overlapping portions of the same register.
;rax = 64 bits, 8 bytes
;eax = 32 bits, 4 bytes (subset of rax)
;ax  = 16 bits, 2 bytes (subset of eax)
;ah/al = 8 bits high and low of ax (subsets of ax)

;if you want to use the whole register, use rax
;if you want to use half, use eax
;if you want a quarter, use ax
;etc until ah/al

;all of this applies to most of the other registers
;---------------------------------
;continuation of mem2, use "x86_64 playground" online for
;debug and disassembly information
section .text
global _start

_start:

;go to the label reg16, find out its starting memory address 
;(0x402000), then copy it into rax. (the equal of a pointer in C)
lea rax, [reg16]

;suppose we wanted to see half of reg16's data,
;and half of reg17's data in the same register.
; v v v v v v v v v v v v v v v v v v v v v v v 
;we do that by adding 4 to the memory 
;address stored in rax, which is 0x402000. 
add rax, 4

;since rax now has the value 0x402004, copy the 8 bytes
;starting at 0x402004 into rbx for viewing
mov rbx, [rax]
;this reads 8 bytes total: 0x402004 through 0x40200b,
;since rbx is a 64 bit/8 byte register.

;the value of rbx should now be 0xbbbbbbbb01234567

;---------------------------------------------
;defines data in the executable's .data section;
;when the program runs, the OS maps this data
;into the process's virtual memory
section .data

;defines a quadword (8 bytes) at a memory address,
;labels that address "reg16",
;then puts the value "0x0123456789abcdef" 
;into the quadword defined defined at "reg16"
;dq = define quadword
reg16: dq 0x0123456789abcdef


;defines a quadword (8 bytes) at a memory address,
;labels that address "reg17",
;then puts the value "0xbbbbbbbbbbbbbbbb" 
;into the quadword defined defined at "reg17"
reg17: dq 0xbbbbbbbbbbbbbbbb

;value of reg16:
;0x402000: ef
;0x402001: cd
;0x402002: ab
;0x402003: 89
;0x402004: 67
;0x402005: 45
;0x402006: 23
;0x402007: 01

;value of reg17
;0x402008: bb
;0x402009: bb
;0x40200a: bb
;0x40200b: bb
;0x40200c: bb
;0x40200d: bb
;0x40200e: bb
;0x40200f: bb