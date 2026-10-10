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
;1
;go to the label reg16, 
;read the value that's inside it,
;then copy it in rax
mov rax, [reg16]

;2
;go to the label reg16, 
;find the last 32 bits, 
;then copy it to eax
mov eax, [reg16]

;3
;go to the label reg16,
;find the last 16 bits,
;then copy it to ax
mov ax, [reg16]

;4
;go to the label reg16,
;find the last 8 bits,
;then copy it to al
mov al, [reg16]

;go to the label reg16,
;copy the location of where it resides,
;then copy it into rbx
;(aka a the equal of a pointer in C)
lea rbx, [reg16]

;---------------------------------------------
;defines data in the executable's .data section;
;when the program runs, the OS maps this data
;into the process's virtual memory
section .data

;defines 8 bytes at a memory address,
;labels that address "reg16",
;then puts the value "0xaaaaaaaaaaaaaaaa" into those 8 bytes
;that are defined at "reg16"
;dq = define quadword
reg16: dq 0xaabbccddeeff1122
;----------------------------------------------

;after all of this, rax should be 0xeeff1122
;step 1: 0xAABBCCDDEEFF1122
;step 2: 0x00000000EEFF1122 (writing to EAX zeros the upper 32 bits of rax)
;step 3: 0x00000000EEFF1122
;step 4: 0x00000000EEFF1122

;there are no visible changes beyond step 2 because 
;the rewrites do nothing but take the last bytes
;which were already there to begin with from step 2
