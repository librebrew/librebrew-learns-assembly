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
section .text
global _start

_start:

;go to the label reg16, find out its starting memory address 
;(0x402000), then copy it into rax. (the equal of a pointer in C)
lea rax, [reg16]

;adding 8 to rax lets us view reg17's
;value, because reg17 resides on 0x402008,
;and rax is a pointer to reg16, which resides
;on 0x402000.
add rax, 8

;since rax is now 0x402008, copy the value
;at that address into rbx for viewing
mov rbx, [rax]

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