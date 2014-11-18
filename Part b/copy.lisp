;Collin Caram
;chc829
(! copy-code
   '(

     (align 4)
     (pos 14608)
     ; Source block
     src
     (dword 1)
     (dword 2)
     (dword 3)
     (dword 4)
     (dword 5)
     (dword 6)
     (dword 7)
     (dword 8)
     ; Destination block
     
     (pos 17024)
     dest
     (dword 111)
     (dword 222)
     (dword 333)
     (dword 444)
     (dword 555)
     (dword 666)
     (dword 777)
     (dword 888)
     end

     main
     (irmovl  stack_top %esp)
     (irmovl  stack_top %ebp)
     (irmovl 8 %ecx)
     (pushl %ecx)
     (irmovl  dest %ebx)
     (pushl %ebx)  
     (irmovl  src %ebx)
     (pushl %ebx)
     
     (call    copy_block)
     (halt)

     copy_block
     (pushl %ebp)
     (rrmovl %esp %ebp)
     (pushl %ebx)
     (pushl %esi)
     (mrmovl 8 (%ebp) %ecx) ;gets src
     (mrmovl 12 (%ebp) %ebx) ;gets dst
     (mrmovl 16 (%ebp) %edx) ;gets len
     (xorl %eax %eax)
     (andl %edx %edx)
     (jle End)

     L4
     (mrmovl 0 (%ecx) %esi)
     (iaddl 4 %ecx)
     (rmmovl %esi 0 (%ebx))
     (iaddl 4 %ebx)
     (xorl %esi %eax)
     (pushl %esi)
     (irmovl 1 %esi)
     (subl %esi %edx)
     (popl %esi)
     (jne L4)
     
     End
     (popl %esi)
     (popl %ebx)
     (rrmovl %ebp %esp)
     (popl %ebp)
     (ret)

     ;; Stack
     (pos 8192)
     stack_top

     ))

(y86-prog (@ copy-code))

(! location 0)
(! symbol-table
   (hons-shrink-alist
    (y86-symbol-table (@ copy-code) (@ location) 'symbol-table)
    'shrunk-symbol-table))

; The function Y86-ASM assembles a program into a memory image.

(!! init-mem
    (hons-shrink-alist
     (y86-asm (@ copy-code) (@ location) (@ symbol-table) 'fib-iterative)
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
;(time$ (y86 x86-32 10000)) (m32-get-regs-and-flags x86-32)
(time$ (y86 x86-32 105))
(m32-get-mem-words (cdr (hons-get 'src (@ symbol-table))) 8 x86-32)
(m32-get-mem-words (cdr (hons-get 'dest (@ symbol-table))) 8 x86-32)
(m32-get-regs-and-flags x86-32)