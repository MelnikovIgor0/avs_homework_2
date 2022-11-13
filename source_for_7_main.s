	.intel_syntax noprefix
	.text
	.comm	cstring,4000000,32
	.globl	count_symbol
	.type	count_symbol, @function
    .section	.rodata
.LC0:
	.string	"r"
.LC1:
	.string	"input string is too big!"
.LC2:
	.string	"w"
.LC3:
	.string	"'.': %d\n"
.LC4:
	.string	"',': %d\n"
.LC5:
	.string	"'!': %d\n"
.LC6:
	.string	"'?': %d\n"
.LC7:
	.string	"';': %d\n"
	.text
	.globl	main
	.type	main, @function
main:
	endbr64
	push	rbp
	mov	rbp, rsp
	sub	rsp, 48
	mov	DWORD PTR -36[rbp], edi
	mov	QWORD PTR -48[rbp], rsi
	mov	DWORD PTR -4[rbp], 0
	mov	rax, QWORD PTR -48[rbp]
	add	rax, 8
	mov	rax, QWORD PTR [rax]
	lea	rsi, .LC0[rip]
	mov	rdi, rax
	call	fopen@PLT
	mov	QWORD PTR -16[rbp], rax
	jmp	.L7
.L9:
	mov	eax, DWORD PTR -4[rbp]
	lea	edx, 1[rax]
	mov	DWORD PTR -4[rbp], edx
	cdqe
	lea	rcx, cstring[rip]
	movzx	edx, BYTE PTR -17[rbp]
	mov	BYTE PTR [rax+rcx], dl
.L7:
	mov	rax, QWORD PTR -16[rbp]
	mov	rdi, rax
	call	getc@PLT
	mov	BYTE PTR -17[rbp], al
	cmp	BYTE PTR -17[rbp], -1
	je	.L8
	cmp	DWORD PTR -4[rbp], 3999998
	jle	.L9
.L8:
	mov	rax, QWORD PTR -16[rbp]
	mov	rdi, rax
	call	fclose@PLT
	cmp	BYTE PTR -17[rbp], -1
	je	.L10
	cmp	DWORD PTR -4[rbp], 3999998
	jle	.L10
	lea	rdi, .LC1[rip]
	mov	eax, 0
	call	printf@PLT
	mov	eax, 0
	jmp	.L11
.L10:
	mov	eax, DWORD PTR -4[rbp]
	cdqe
	lea	rdx, cstring[rip]
	mov	BYTE PTR [rax+rdx], 0
	mov	rax, QWORD PTR -48[rbp]
	add	rax, 16
	mov	rax, QWORD PTR [rax]
	lea	rsi, .LC2[rip]
	mov	rdi, rax
	call	fopen@PLT
	mov	QWORD PTR -32[rbp], rax
	mov	eax, DWORD PTR -4[rbp]
	mov	esi, 46
	mov	edi, eax
	call	count_symbol
	mov	edx, eax
	mov	rax, QWORD PTR -32[rbp]
	lea	rsi, .LC3[rip]
	mov	rdi, rax
	mov	eax, 0
	call	fprintf@PLT
	mov	eax, DWORD PTR -4[rbp]
	mov	esi, 44
	mov	edi, eax
	call	count_symbol
	mov	edx, eax
	mov	rax, QWORD PTR -32[rbp]
	lea	rsi, .LC4[rip]
	mov	rdi, rax
	mov	eax, 0
	call	fprintf@PLT
	mov	eax, DWORD PTR -4[rbp]
	mov	esi, 33
	mov	edi, eax
	call	count_symbol
	mov	edx, eax
	mov	rax, QWORD PTR -32[rbp]
	lea	rsi, .LC5[rip]
	mov	rdi, rax
	mov	eax, 0
	call	fprintf@PLT
	mov	eax, DWORD PTR -4[rbp]
	mov	esi, 63
	mov	edi, eax
	call	count_symbol
	mov	edx, eax
	mov	rax, QWORD PTR -32[rbp]
	lea	rsi, .LC6[rip]
	mov	rdi, rax
	mov	eax, 0
	call	fprintf@PLT
	mov	eax, DWORD PTR -4[rbp]
	mov	esi, 59
	mov	edi, eax
	call	count_symbol
	mov	edx, eax
	mov	rax, QWORD PTR -32[rbp]
	lea	rsi, .LC7[rip]
	mov	rdi, rax
	mov	eax, 0
	call	fprintf@PLT
	mov	rax, QWORD PTR -32[rbp]
	mov	rdi, rax
	call	fclose@PLT
	mov	eax, 0
.L11:
	leave
	ret
