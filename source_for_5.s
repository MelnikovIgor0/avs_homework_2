	.intel_syntax noprefix
	.text
	.comm	cstring,4000000,32
	.globl	count_symbol
	.type	count_symbol, @function
count_symbol:
	push	rbp
	mov	rbp, rsp
	mov	DWORD PTR -20[rbp], edi             # присваиваю переменной rbp[-20] значение из регистра edi (переданный первый параметр функции count_symbol (переменная size))
	mov	eax, esi                            # присваиваю регистру eax значение регистра esi (переданный второй параметр функции count_symbol (символ, число вхождений которого ищу))
	mov	BYTE PTR -24[rbp], al
	mov	DWORD PTR -4[rbp], 0                # присваиваю rbp[-4] значение 0 (rbp[-4] это аналог локальной переменной i)
	mov	DWORD PTR -8[rbp], 0                # присваиваю rbp[-8] значение 0 (rbp[-8] это аналог локальной переменной kol)
	mov	DWORD PTR -4[rbp], 0
	jmp	.L2
.L4:
	mov	eax, DWORD PTR -4[rbp]
	cdqe
	lea	rdx, cstring[rip]
	movzx	eax, BYTE PTR [rax+rdx]
	cmp	BYTE PTR -24[rbp], al
	jne	.L3
	add	DWORD PTR -8[rbp], 1
.L3:
	add	DWORD PTR -4[rbp], 1
.L2:
	mov	eax, DWORD PTR -4[rbp]
	cmp	eax, DWORD PTR -20[rbp]
	jl	.L4
	mov	eax, DWORD PTR -8[rbp]              # присваиваю регистру eax значение rbp[-8] (локальная переменная kol, возвращаемое значение функции)
	pop	rbp                                 
	ret                                     # выход из функции count_symbol
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
	sub	rsp, 32
	mov	DWORD PTR -20[rbp], edi
	mov	QWORD PTR -32[rbp], rsi
	mov	DWORD PTR -4[rbp], 0
.L8:
	mov	rax, QWORD PTR stdin[rip]
	mov	rdi, rax
	call	fgetc@PLT
	mov	BYTE PTR -5[rbp], al
	mov	eax, DWORD PTR -4[rbp]
	lea	edx, 1[rax]
	mov	DWORD PTR -4[rbp], edx
	cdqe
	lea	rcx, cstring[rip]
	movzx	edx, BYTE PTR -5[rbp]
	mov	BYTE PTR [rax+rcx], dl
	cmp	BYTE PTR -5[rbp], -1
	je	.L7
	cmp	DWORD PTR -4[rbp], 3999999
	jle	.L8
.L7:
	cmp	BYTE PTR -5[rbp], -1
	je	.L9
	cmp	DWORD PTR -4[rbp], 3999999
	jle	.L9
	lea	rdi, .LC0[rip]
	mov	eax, 0
	call	printf@PLT
	mov	eax, 0
	jmp	.L10
.L9:
	mov	eax, DWORD PTR -4[rbp]
	sub	eax, 1
	cdqe
	lea	rdx, cstring[rip]
	mov	BYTE PTR [rax+rdx], 0
	mov	eax, DWORD PTR -4[rbp]
	mov	esi, 46                      # присваиваю регистру esi значение 46 (код символа '.'), чтобы передать его как параметр функции count_symbol
	mov	edi, eax                     # присваиваю регистру edi значение регистра eax, чтобы передать его как параметр функции count_symbol (а там лежало rbp[-4], аналог переменной i)
	call	count_symbol             # вызов функии подсчета количества символов
	mov	esi, eax                     # присваиваю регистру esi значение регистра eax (в eax лежало значение, возвращенное функцией count_symbol)
	lea	rdi, .LC1[rip]
	mov	eax, 0
	call	printf@PLT
	mov	eax, DWORD PTR -4[rbp]
	mov	esi, 44                      # присваиваю регистру esi значение 44 (код символа ','), чтобы передать его как параметр функции count_symbol
	mov	edi, eax                     # присваиваю регистру edi значение регистра eax, чтобы передать его как параметр функции count_symbol (а там лежало rbp[-4], аналог переменной i)
	call	count_symbol             # вызов функии подсчета количества символов
	mov	esi, eax                     # присваиваю регистру esi значение регистра eax (в eax лежало значение, возвращенное функцией count_symbol)
	lea	rdi, .LC2[rip]
	mov	eax, 0
	call	printf@PLT
	mov	eax, DWORD PTR -4[rbp]
	mov	esi, 33                      # присваиваю регистру esi значение 33 (код символа '!'), чтобы передать его как параметр функции count_symbol
	mov	edi, eax                     # присваиваю регистру edi значение регистра eax, чтобы передать его как параметр функции count_symbol (а там лежало rbp[-4], аналог переменной i)
	call	count_symbol             # вызов функии подсчета количества символов
	mov	esi, eax                     # присваиваю регистру esi значение регистра eax (в eax лежало значение, возвращенное функцией count_symbol)
	lea	rdi, .LC3[rip]
	mov	eax, 0
	call	printf@PLT
	mov	eax, DWORD PTR -4[rbp]
	mov	esi, 63                      # присваиваю регистру esi значение 63 (код символа '?'), чтобы передать его как параметр функции count_symbol
	mov	edi, eax                     # присваиваю регистру edi значение регистра eax, чтобы передать его как параметр функции count_symbol (а там лежало rbp[-4], аналог переменной i)
	call	count_symbol             # вызов функии подсчета количества символов
	mov	esi, eax                     # присваиваю регистру esi значение регистра eax (в eax лежало значение, возвращенное функцией count_symbol)
	lea	rdi, .LC4[rip]
	mov	eax, 0
	call	printf@PLT
	mov	eax, DWORD PTR -4[rbp]
	mov	esi, 59                      # присваиваю регистру esi значение 59 (код символа ';'), чтобы передать его как параметр функции count_symbol
	mov	edi, eax                     # присваиваю регистру edi значение регистра eax, чтобы передать его как параметр функции count_symbol (а там лежало rbp[-4], аналог переменной i)
	call	count_symbol             # вызов функии подсчета количества символов
	mov	esi, eax                     # присваиваю регистру esi значение регистра eax (в eax лежало значение, возвращенное функцией count_symbol)
	lea	rdi, .LC5[rip]
	mov	eax, 0
	call	printf@PLT
	mov	eax, 0
.L10:
	leave
	ret
