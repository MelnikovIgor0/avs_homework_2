	.intel_syntax noprefix
	.text
	.comm	cstring,4000000,32
	.globl	count_symbol
	.type	count_symbol, @function
count_symbol:
	push	rbp
	mov	rbp, rsp
	push	r15                                # r15 это регистр, который используется в качестве переменной kol (в функции count_symbol)
	push	r12                                # r12 это регистр, который используется в качестве переменной счетчика цикла i (как в мейне, так и в функции)
	mov	DWORD PTR -20[rbp], edi
	mov	eax, esi
	mov	BYTE PTR -24[rbp], al
	mov	r12d, 0                                # r12 это регистр, который используется в качестве переменной счетчика цикла i (как в мейне, так и в функции)
	mov	r15d, 0                                # r15 это регистр, который используется в качестве переменной kol (в функции count_symbol)
	mov	r12d, 0                                # r12 это регистр, который используется в качестве переменной счетчика цикла i (как в мейне, так и в функции)
	jmp	.L2
.L4:
	mov	eax, r12d                              # r12 это регистр, который используется в качестве переменной счетчика цикла i (как в мейне, так и в функции)
	cdqe
	lea	rdx, cstring[rip]
	movzx	eax, BYTE PTR [rax+rdx]
	cmp	BYTE PTR -24[rbp], al
	jne	.L3
	mov	eax, r15d                              # r15 это регистр, который используется в качестве переменной kol (в функции count_symbol)
	add	eax, 1
	mov	r15d, eax                              # r15 это регистр, который используется в качестве переменной kol (в функции count_symbol)
.L3:
	mov	eax, r12d                              # r12 это регистр, который используется в качестве переменной счетчика цикла i (как в мейне, так и в функции)
	add	eax, 1
	mov	r12d, eax                              # r12 это регистр, который используется в качестве переменной счетчика цикла i (как в мейне, так и в функции)
.L2:
	mov	eax, r12d                              # r12 это регистр, который используется в качестве переменной счетчика цикла i (как в мейне, так и в функции)
	cmp	DWORD PTR -20[rbp], eax
	jg	.L4
	mov	eax, r15d                              # r15 это регистр, который используется в качестве переменной kol (в функции count_symbol)
	pop	r12                                    # r12 это регистр, который используется в качестве переменной счетчика цикла i (как в мейне, так и в функции)
	pop	r15                                    # r15 это регистр, который используется в качестве переменной kol (в функции count_symbol)
	pop	rbp
	ret
	.size	count_symbol, .-count_symbol
	.section	.rodata
.LC0:
	.string	"input string is too big!"
.LC1:
	.string	"'.': %d\n"
.LC2:
	.string	"',': %d\n"
.LC3:
	.string	"'!': %d\n"
.LC4:
	.string	"'?': %d\n"
.LC5:
	.string	"';': %d\n"
	.text
	.globl	main
	.type	main, @function
main:
	push	rbp
	mov	rbp, rsp
	push	r13                                # r13 это регистр, который используется в качестве переменной size в мейне
	push	r12                                # r12 это регистр, который используется в качестве переменной счетчика цикла i (как в мейне, так и в функции)
	sub	rsp, 16
	mov	DWORD PTR -20[rbp], edi
	mov	QWORD PTR -32[rbp], rsi
	mov	r12d, 0                                # r12 это регистр, который используется в качестве переменной счетчика цикла i (как в мейне, так и в функции)
	mov	r13d, 0                                # r13 это регистр, который используется в качестве переменной size в мейне
.L8:
	mov	rax, QWORD PTR stdin[rip]
	mov	rdi, rax
	call	fgetc@PLT
	mov	r11d, eax                              # r11 это регистр, который используется в качестве переменной symbol из мейна
	mov	eax, r13d                              # r13 это регистр, который используется в качестве переменной size в мейне
	lea	edx, 1[rax]
	mov	r13d, edx                              # r13 это регистр, который используется в качестве переменной size в мейне
	mov	ecx, r11d                              # r11 это регистр, который используется в качестве переменной symbol из мейна
	cdqe
	lea	rdx, cstring[rip]
	mov	BYTE PTR [rax+rdx], cl
	mov	eax, r11d                              # r11 это регистр, который используется в качестве переменной symbol из мейна
	cmp	al, -1
	je	.L7
	mov	eax, r13d                              # r13 это регистр, который используется в качестве переменной size в мейне
	cmp	eax, 3999999
	jle	.L8
.L7:
	mov	eax, r11d                              # r11 это регистр, который используется в качестве переменной symbol из мейна
	cmp	al, -1
	je	.L9
	mov	eax, r13d                              # r13 это регистр, который используется в качестве переменной size в мейне
	cmp	eax, 3999999
	jle	.L9
	lea	rdi, .LC0[rip]
	mov	eax, 0
	call	printf@PLT
	mov	eax, 0
	jmp	.L10
.L9:
	mov	eax, r13d                              # r13 это регистр, который используется в качестве переменной size в мейне
	sub	eax, 1
	cdqe
	lea	rdx, cstring[rip]
	mov	BYTE PTR [rax+rdx], 0
	mov	eax, r13d                              # r13 это регистр, который используется в качестве переменной size в мейне
	mov	esi, 46
	mov	edi, eax
	call	count_symbol
	mov	esi, eax
	lea	rdi, .LC1[rip]
	mov	eax, 0
	call	printf@PLT
	mov	eax, r13d                              # r13 это регистр, который используется в качестве переменной size в мейне
	mov	esi, 44
	mov	edi, eax
	call	count_symbol
	mov	esi, eax
	lea	rdi, .LC2[rip]
	mov	eax, 0
	call	printf@PLT
	mov	eax, r13d                              # r13 это регистр, который используется в качестве переменной size в мейне
	mov	esi, 33
	mov	edi, eax
	call	count_symbol
	mov	esi, eax
	lea	rdi, .LC3[rip]
	mov	eax, 0
	call	printf@PLT
	mov	eax, r13d                              # r13 это регистр, который используется в качестве переменной size в мейне
	mov	esi, 63
	mov	edi, eax
	call	count_symbol
	mov	esi, eax
	lea	rdi, .LC4[rip]
	mov	eax, 0
	call	printf@PLT
	mov	eax, r13d                              # r13 это регистр, который используется в качестве переменной size в мейне
	mov	esi, 59
	mov	edi, eax
	call	count_symbol
	mov	esi, eax
	lea	rdi, .LC5[rip]
	mov	eax, 0
	call	printf@PLT
	mov	eax, 0
.L10:
	add	rsp, 16
	pop	r12
	pop	r13
	pop	rbp
	ret
