(! sum-code
  '(
    ;data segment
    (align 4)
    ele1                    
    (dword 7)
    (dword ele2)
    ele2                    
    (dword 12)
    (dword ele3)
    ele3
    (dword 17)
    (dword 0)

    NULL
    (dword 0)

    ;code segment
    main                              
    (irmovl stack_top %esp)
    (irmovl stack_top %ebp)
    (irmovl ele1 %edx)
    (pushl   %edx)
    (call    sum-list)
    (halt)


	sum-list
	(pushl %ebp)
	(rrmovl %esp %ebp)
	(mrmovl 8 (%esp)	%edx) ;get pointer to linked list
	(xorl %eax %eax)
	(andl %edx %edx)
	(jne L4)

	L4
	(mrmovl 0 (%edx)	%ecx)
	(addl %ecx  %eax)
	(mrmovl 4 (%edx)	%edx)
	(andl %edx %edx)
	(jne L4)

	End
	(rrmovl %ebp %esp)
	(popl %ebp)
    (ret)
    
    (pos 4096)
    stack_top

    ))

(y86-prog (@ sum-code))

(! location 0)
(! symbol-table
   (hons-shrink-alist
    (y86-symbol-table (@ sum-code) (@ location) 'symbol-table)
    'shrunk-symbol-table))

; The function Y86-ASM assembles a program into a memory image.

(!! init-mem
    (hons-shrink-alist
     (y86-asm (@ sum-code) (@ location) (@ symbol-table) 'fib-iterative)
     'shrunk-fib-iterative))

; Initialize the Y86 state, note we need initial values for various
; registers.  Here, we clear the registers (not really necessary) and
; the memory

(m86-clear-regs x86-32)       ; Clear registers
(m86-clear-mem  x86-32 8192)  ; Clear memory location 0 to 8192

(! init-pc (cdr (hons-get 'main (@ symbol-table))))
(! y86-status nil)   ; Initial value for the Y86 status register

(init-y86-state
 (@ y86-status)  ; Y86 status
 (@ init-pc)     ; Initial program counter
 nil             ; Initial registers, if NIL, then all zeros
 nil             ; Initial flags, if NIL, then all zeros
 (@ init-mem)    ; Initial memory
 x86-32
 )

; Lines that can be typed that just shows the Y86 machine status and
; some of the memory after single stepping.
; (y86-step x86-32) (m32-get-regs-and-flags x86-32)
; (rmb 4 (rgfi *mr-esp* x86-32) x86-32)

; Step ISA 10,000 steps or to HALT.
(time$ (y86 x86-32 10000)) (m32-get-regs-and-flags x86-32)