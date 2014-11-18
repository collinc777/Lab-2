	.file	"ocode.c"
	.section	.text.startup,"ax",@progbits
	.p2align 4,,15
	.globl	main
	.type	main, @function
main:
.LFB0:
	.cfi_startproc
	rep
	ret
	.cfi_endproc
.LFE0:
	.size	main, .-main
	.text
	.p2align 4,,15
	.globl	copy_block
	.type	copy_block, @function
copy_block:
.LFB1:
	.cfi_startproc
	pushl	%esi
	.cfi_def_cfa_offset 8
	.cfi_offset 6, -8
	xorl	%eax, %eax
	pushl	%ebx
	.cfi_def_cfa_offset 12
	.cfi_offset 3, -12
	movl	20(%esp), %edx
	movl	12(%esp), %ebx
	movl	16(%esp), %ecx
	testl	%edx, %edx
	jle	.L3
	.p2align 4,,7
	.p2align 3
.L4:
	movl	(%ebx), %esi
	addl	$4, %ebx
	movl	%esi, (%ecx)
	xorl	%esi, %eax
	addl	$4, %ecx
	subl	$1, %edx
	jne	.L4
.L3:
	popl	%ebx
	.cfi_def_cfa_offset 8
	.cfi_restore 3
	popl	%esi
	.cfi_def_cfa_offset 4
	.cfi_restore 6
	ret
	.cfi_endproc
.LFE1:
	.size	copy_block, .-copy_block
	.ident	"GCC: (Ubuntu/Linaro 4.6.3-1ubuntu5) 4.6.3"
	.section	.note.GNU-stack,"",@progbits
