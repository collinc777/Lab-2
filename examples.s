	.file	"examples.c"
	.text
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
	.globl	sum_list
	.type	sum_list, @function
sum_list:
.LFB1:
	.cfi_startproc
	movl	4(%esp), %edx
	movl	$0, %eax
	testl	%edx, %edx
	je	.L3
.L4:
	addl	(%edx), %eax
	movl	4(%edx), %edx
	testl	%edx, %edx
	jne	.L4
.L3:
	rep
	ret
	.cfi_endproc
.LFE1:
	.size	sum_list, .-sum_list
	.globl	rsum_list
	.type	rsum_list, @function
rsum_list:
.LFB2:
	.cfi_startproc
	pushl	%ebx
	.cfi_def_cfa_offset 8
	.cfi_offset 3, -8
	subl	$24, %esp
	.cfi_def_cfa_offset 32
	movl	32(%esp), %ebx
	movl	$0, %eax
	testl	%ebx, %ebx
	je	.L8
	movl	4(%ebx), %eax
	movl	%eax, (%esp)
	call	rsum_list
	addl	(%ebx), %eax
.L8:
	addl	$24, %esp
	.cfi_def_cfa_offset 8
	popl	%ebx
	.cfi_def_cfa_offset 4
	.cfi_restore 3
	ret
	.cfi_endproc
.LFE2:
	.size	rsum_list, .-rsum_list
	.globl	copy_block
	.type	copy_block, @function
copy_block:
.LFB3:
	.cfi_startproc
	pushl	%esi
	.cfi_def_cfa_offset 8
	.cfi_offset 6, -8
	pushl	%ebx
	.cfi_def_cfa_offset 12
	.cfi_offset 3, -12
	movl	12(%esp), %ecx
	movl	16(%esp), %ebx
	movl	20(%esp), %edx
	movl	$0, %eax
	testl	%edx, %edx
	jle	.L11
.L12:
	movl	(%ecx), %esi
	addl	$4, %ecx
	movl	%esi, (%ebx)
	addl	$4, %ebx
	xorl	%esi, %eax
	subl	$1, %edx
	jne	.L12
.L11:
	popl	%ebx
	.cfi_def_cfa_offset 8
	.cfi_restore 3
	popl	%esi
	.cfi_def_cfa_offset 4
	.cfi_restore 6
	ret
	.cfi_endproc
.LFE3:
	.size	copy_block, .-copy_block
	.ident	"GCC: (Ubuntu/Linaro 4.6.3-1ubuntu5) 4.6.3"
	.section	.note.GNU-stack,"",@progbits
