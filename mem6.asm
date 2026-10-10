;continuation of mem5:
;--- write to memory at runtime ---
;db = define byte
;dw = define word

section .text
global _start

_start:

;put the value 0x123456 into rax
mov rax, 0x123456 ;padded, so the real value is 0x0000000000123456

;load the memory address of "mem"
;into rbx
lea rbx, [mem]

;write rax's value into the 8 bytes at "mem" in memory
mov [mem], rax

;read those same 8 bytes back out of memory into rcx
;(rcx should now equal 0x123456, same as rax)
mov rcx, [mem]


;load the address of "mem" into the stack pointer
;why? to tell the CPU:
;"hey, the beginning of your stack now lives at 0x402000"
lea rsp, [mem]
;note: the memory beyond this point isn't reserved for the
;stack, so pushing here is like a minefield; 
;you may write into unrelated data or unmapped memory, 
;causing a crash or silent corruption


;defines data in the executable's .data section;
;when the program runs, the OS maps this data
;into the process's virtual memory
section .data


;"times" repeats the next directive N times;
;so basically: "for 1024 times, you shall define a byte with value 0xff"
mem: times 1024 db 0xff

;(before "mov [mem], rax" runs, all 1024 bytes are set to 0xff)
;value of mem after "mov [mem], rax" executes:
;0x402000: 56
;0x402001: 34
;0x402002: 12
;0x402003: 00
;0x402004: 00
;0x402005: 00
;0x402006: 00
;0x402007: 00
;(bytes 0x402008 onward remain 0xff, untouched by this code)
