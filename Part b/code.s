	.file	"code.c"
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
	pushl	%edi
	.cfi_def_cfa_offset 8
	.cfi_offset 7, -8
	xorl	%eax, %eax
	pushl	%esi
	.cfi_def_cfa_offset 12
	.cfi_offset 6, -12
	pushl	%ebx
	.cfi_def_cfa_offset 16
	.cfi_offset 3, -16
	movl	24(%esp), %ebx
	movl	16(%esp), %ecx
	movl	20(%esp), %edx
	testl	%ebx, %ebx
	jle	.L3
	.p2align 4,,7
	.p2align 3
.L4:
	movl	(%ecx), %edi
	subl	$4, %ebx
	movl	%edi, (%edx)
	movl	4(%ecx), %esi
	movl	%esi, 4(%edx)
	xorl	%edi, %esi
	xorl	%esi, %eax
	movl	8(%ecx), %esi
	xorl	%esi, %eax
	movl	%esi, 8(%edx)
	movl	12(%ecx), %esi
	addl	$16, %ecx
	movl	%esi, 12(%edx)
	xorl	%esi, %eax
	addl	$16, %edx
	testl	%ebx, %ebx
	jg	.L4
.L3:
	popl	%ebx
	.cfi_def_cfa_offset 12
	.cfi_restore 3
	popl	%esi
	.cfi_def_cfa_offset 8
	.cfi_restore 6
	popl	%edi
	.cfi_def_cfa_offset 4
	.cfi_restore 7
	ret
	.cfi_endproc
.LFE1:
	.size	copy_block, .-copy_block
	.ident	"GCC: (Ubuntu/Linaro 4.6.3-1ubuntu5) 4.6.3"
	.section	.note.GNU-stack,"",@progbits
