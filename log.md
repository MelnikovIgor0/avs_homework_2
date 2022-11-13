# Отчет по ИДЗ №2 по курсу архитектуры вычислительных систем.

Мельников Игорь Сергеевич, группа БПИ218. Вариант 22.

Разработать программу, вычисляющую число вхождений различных знаков препинания в заданной ASCII-строке.

// комментарий: знаками препинания я считаю '.', ',', '?', '!', ';'. Ввод с консоли прекращается комбинацией ctrl+d.

## Задания на 4 балла

### Исходный код программы на C (файл source_for_4.c):

```c
#include <stdio.h>
#include <stdlib.h>

char cstring[4000000];
int amount[5];

int main(int argc, char* argv[]) {
    char symbol;
    int i, size = 0;
    for (i = 0; i < 5; i++) {
        amount[i] = 0;
    }
    do {
        symbol = fgetc(stdin);
        cstring[size++] = symbol;
    } while (symbol != -1 && size < 5);
    if (symbol != -1 && size >= 4000000) {
        printf("input string is too big!");
        return 0;
    }
    cstring[size - 1] = '\0';
    for (i = 0; i < size; i++) {
        if (cstring[i] == '.') {
            amount[0]++;
        }
        if (cstring[i] == ',') {
            amount[1]++;
        }
        if (cstring[i] == '!') {
            amount[2]++;
        }
        if (cstring[i] == '?') {
            amount[3]++;
        }
        if (cstring[i] == ';') {
            amount[4]++;
        }
    }
    printf("\n'.': %d\n", amount[0]);
    printf("',': %d\n", amount[1]);
    printf("'!': %d\n", amount[2]);
    printf("'?': %d\n", amount[3]);
    printf("';': %d\n", amount[4]);
    return 0;
}
```

### Получение ассемблерного файла без использования оптимизаций:

```sh
gcc -O0 -Wall -masm=intel -S source_for_4.c -o source_for_4.s
```

### Получение ассемблерного файла с использованием оптимизаций:

```sh
gcc -masm=intel -fno-asynchronous-unwind-tables -fno-jump-tables -fno-stack-protector -fno-exceptions ./source_for_4.c -S -o ./source_for_4.s
```

### Провожу преобразования в ассемблерном коде, убираю ненужные конструкции

### Комментирую ассемблирный код (файл source_for_4.s):
```assembly
	.intel_syntax noprefix                   # показывает, что синтаксис intel
	.text                                    # начало секции
	.comm	cstring,4000000,32               # массив cstring элементов char
	.comm	amount,20,16                     # массив amount элементов int
	.section	.rodata                      # секция .rodata
.LC0:                                        # метка .LC0
	.string	"input string is too big!"       # строка, сообщение о том что введенная строка слишком большая
.LC1:                                        # метка .LC1
	.string	"'.': %d\n"                      # строка, используемая для указания формата вывода количества точек
.LC2:                                        # метка .LC2
	.string	"',': %d\n"                      # строка, используемая для указания формата вывода количества запятых
.LC3:                                        # метка .LC3
	.string	"'!': %d\n"                      # строка, используемая для указания формата вывода количества восклицательных знаков
.LC4:                                        # метка .LC4
	.string	"'?': %d\n"                      # строка, используемая для указания формата вывода количества вопросительных знаков
.LC5:                                        # метка .LC5
	.string	"';': %d\n"                      # строка, используемая для указания формата вывода количества точек с запятой
	.text                                    # секция с кодом
	.globl	main                             # объявлюю символ main
	.type	main, @function                  # указание, что main это функция
main:                                        # метка main
	push	rbp                              # сохраняю rbp на стеке
	mov	rbp, rsp                             # присваиваю регистру rbp значение из rsp
	sub	rsp, 32                              # сдвигаю регистр rsp на 32 (вычитаю 32)
	mov	DWORD PTR -20[rbp], edi              # аргумент argc кладется в edi
	mov	QWORD PTR -32[rbp], rsi              # аргумент argv кладется в rsi
	mov	DWORD PTR -8[rbp], 0                 # присваиваю rbp[-8] значение 0 (rbp[-8] это аналог переменной i)
	mov	DWORD PTR -4[rbp], 0                 # присваиваю rbp[-4] значение 0 (rbp[-4] это аналог переменной size)
	jmp	.L2                                  # переход на метку .L2
.L3:                                         # метка .L3
	mov	eax, DWORD PTR -4[rbp]               # присваиваю регистру eax значение rbp[-4] (rbp[-4] это аналог переменной i)
	cdqe                                     # расширение 32 битного значения в eax до 64 битного в rax
	lea	rdx, 0[0+rax*4]                      # присваиваю регистру rdx значение rax * 4
	lea	rax, amount[rip]                     # присваиваю регистру rax значение &amount[rip] (адрес начала массива amount)
	mov	DWORD PTR [rdx+rax], 0               # присваиваю по ссылке *(rdx+rax) значение 0
	add	DWORD PTR -4[rbp], 1                 # увеличиваю значение переменной rbp[-4] на 1 (rbp[-4] это аналог переменной i)
.L2:                                         # метка .L2
	cmp	DWORD PTR -4[rbp], 4                 # сравниваю значение rbp[-4] и 4 (rbp[-4] это аналог переменной i)
	jle	.L3                                  # в случае, если результат сравнения <=, то перехожу на метку .L3
.L5:                                         # метка .L5
	mov	rax, QWORD PTR stdin[rip]            # присваиваю регистру rax значение &stdin[rip] (ссылка на поток stdin)
	mov	rdi, rax                             # присваиваю регистру rdi значение регистра rax
	call	fgetc@PLT                        # вызываю макрос fgetc
	mov	BYTE PTR -9[rbp], al                 # присваиваю rbp[-9] значение регистра al (rbp[-9] это аналог переменной symbol)
	mov	eax, DWORD PTR -8[rbp]               # присваиваю регистру eax значение rbp[-8]
	lea	edx, 1[rax]                          # присваиваю регистру edx значение по ссылке rax + 1
	mov	DWORD PTR -8[rbp], edx               # присваиваю rbp[-8] значение регистра edx (rbp[-8] это аналог переменной i)
	cdqe                                     # расширение 32 битного значения в eax до 64 битного в rax
	lea	rcx, cstring[rip]                    # присваиваю регистру rcx значение &cstring[rip] (адрес начала массива cstring)
	movzx	edx, BYTE PTR -9[rbp]            # присваивает регистру edx значение rbp[-9] с расширением нулями (rbp[-9] это аналог переменной symbol)
	mov	BYTE PTR [rax+rcx], dl               # присваиваю по ссылке *(rax + rcx) значение регистра dl
	cmp	BYTE PTR -9[rbp], -1                 # сравниваю значение rbp[-9] и -1 (rbp[-9] это аналог переменной symbol)
	je	.L4                                  # в случае, если рещультат предыдущего сравнения =, то перехожу на метку .L4
	cmp	DWORD PTR -8[rbp], 3999999           # сравниваю значение rbp[-8] и 3999999 (rbp[-8] это аналог переменной i)
	jle	.L5                                  # в случае, если результат предыдущего сравнения <, то перехожу на метку .L5
.L4:                                         # метка .L4
	cmp	BYTE PTR -9[rbp], -1                 # сравниваю значение rbp[-9] и -1
	je	.L6                                  # в случае, если результат предыдущего сравнения <, то перехожу на метку .L6
	cmp	DWORD PTR -8[rbp], 3999999           # сравниваю значение rbp[-8] и 3999999 (rbp[-8] это аналог переменной i)
	jle	.L6                                  # в случае, если результат предыдущего сравнения <=, то перехожу на метку .L6
	lea	rdi, .LC0[rip]                       # присваиваю регистру rdi значение &.LC0[rip] (ссылка на строку с сообщением о том, что строка слишком длинная)
	mov	eax, 0                               # присваиваю регистру eax значение 0
	call	printf@PLT                       # вызываю макрос printf
	mov	eax, 0                               # присваиваю регистру eax значение 0
	jmp	.L7                                  # перехожу на метку .L7
.L6:                                         # метка .L6
	mov	eax, DWORD PTR -8[rbp]               # присваиваю регистру eax значение rbp[-8] (rbp[-8] это аналог переменной i)
	sub	eax, 1                               # увеличиваю значение регистра eax на 1
	cdqe                                     # расширение 32 битного значения в eax до 64 битного в rax
	lea	rdx, cstring[rip]                    # присваиваю регистру rdx значение &cstring[rip] (адрес начала массива cstring)
	mov	BYTE PTR [rax+rdx], 0                # присваиваю по ссылке *(rax + rdx) значение 0
	mov	DWORD PTR -4[rbp], 0                 # присваиваю регистру rbp[-4] значение 0 (rbp[-4] это аналог переменной size)
	jmp	.L8                                  # перехожу на метку .L8
.L14:                                        # метка .L14
	mov	eax, DWORD PTR -4[rbp]               # присваиваю регистру eax значение rbp[-4] (rbp[-4] это аналог переменной size)
	cdqe                                     # расширение 32 битного значения в eax до 64 битного в rax
	lea	rdx, cstring[rip]                    # присваиваю регистру rdx значение &cstring[rip] с расширением (ссылка на начало массива cstring)
	movzx	eax, BYTE PTR [rax+rdx]          # присваиваю регистру eax значение по ссылке (rax+rdx)
	cmp	al, 46                               # сравниваю значение регистра al и 46
	jne	.L9                                  # в случае, если результат предыдущего сравнения !=, то перехожу на метку .L9
	mov	eax, DWORD PTR amount[rip]           # присваиваю регистру eax значение &amount[rip] (ссылка на начало массива amount)
	add	eax, 1                               # увеличиваю значение регистра eax на 1
	mov	DWORD PTR amount[rip], eax           # присваиваю по ссылке amount[rip] значение регистра eax
.L9:                                         # метка .L9
	mov	eax, DWORD PTR -4[rbp]               # присваиваю регистру eax значение rbp[-4] (rbp[-4] это аналог переменной size)
	cdqe                                     # расширение 32 битного значения в eax до 64 битного в rax
	lea	rdx, cstring[rip]                    # присваиваю регистру rdx значение &cstring[rip] (ссылка на начало массива cstring)
	movzx	eax, BYTE PTR [rax+rdx]          # присваиваю регистру eax значение по ссылке *(rax + rdx) с расширением нулями
	cmp	al, 44                               # сравниваю значение регистра al и 44
	jne	.L10                                 # в случае, если результат предыдущего сравнения !=, то перехожу на метку .L10
	mov	eax, DWORD PTR amount[rip+4]         # присваиваю регистру eax значение amount[rip + 4] (элемент массива с индексом 1)
	add	eax, 1                               # увеличиваю значение регистра eax на 1
	mov	DWORD PTR amount[rip+4], eax         # присваиваю по ссылке amount[rip + 4] значение eax
.L10:                                        # метка .L10
	mov	eax, DWORD PTR -4[rbp]               # присваиваю регистру eax значение rbp[-4] (это аналог переменной size)
	cdqe                                     # расширение 32 битного значения в eax до 64 битного в rax
	lea	rdx, cstring[rip]                    # присваиваю регистру rdx значение &cstring[rip] (ссылка на начало массива cstring)
	movzx	eax, BYTE PTR [rax+rdx]          # присваиваю регистру eax значение по ссылке *(rax + rdx) с расширением нулями
	cmp	al, 33                               # сравниваю значение регистра al и 33
	jne	.L11                                 # в случае, если результат предыдущего сравнения !=, то перехожу на метку .L11
	mov	eax, DWORD PTR amount[rip+8]         # присваиваю регистру eax значение amount[rip + 8] (элемент массива с индексом 2)
	add	eax, 1                               # увеличиваю значение регистра eax на 1
	mov	DWORD PTR amount[rip+8], eax         # присваиваю по amount[rip + 8] значение регистра eax
.L11:                                        # метка .L11
	mov	eax, DWORD PTR -4[rbp]               # присваиваю регистру eax значение rbp[-4] (rbp[-4] это аналог переменной size)
	cdqe                                     # расширение 32 битного значения в eax до 64 битного в rax
	lea	rdx, cstring[rip]                    # присваиваю регистру rdx значение &cstring[rip] (ссылка на начало массива cstring)
	movzx	eax, BYTE PTR [rax+rdx]          # присваиваю регистру eax значение по ссылке *(rax + rdx) с расширением нулями
	cmp	al, 63                               # сравниваю значение регистра al и 63
	jne	.L12                                 # в случае, если результат предыдущего сравнения !=, то перехожу на метку .L12
	mov	eax, DWORD PTR amount[rip+12]        # присваиваю регистру eax значение amount[rip + 12] (элемент массива с индексом 3)
	add	eax, 1                               # увеличиваю значение регистра eax на 1
	mov	DWORD PTR amount[rip+12], eax        # присваиваю зпо ссылке amount[rip + 12] значение регистра eax
.L12:                                        # метка .L12
	mov	eax, DWORD PTR -4[rbp]               # присваиваю регистру eax значение rbp[-4] (rbp[-4] это аналог переменной size)
	cdqe                                     # расширение 32 битного значения в eax до 64 битного в rax
	lea	rdx, cstring[rip]                    # присваиваю регистру rdx значение &cstring[rip] (ссылка на начало массива cstring)
	movzx	eax, BYTE PTR [rax+rdx]          # присваиваю регистру eax значение по ссылке *(rax + rdx) с расширением нулями
	cmp	al, 59                               # сравниваю значение регистра al и 59
	jne	.L13                                 # в случае, если результат предыдущего сравнения !=, перехожу на метку .L13
	mov	eax, DWORD PTR amount[rip+16]        # присваиваю регистру eax значение по ссылке amount[rip + 16] (элемент массива с индексом 4)
	add	eax, 1                               # увеличиваю значение регистра eax на 1
	mov	DWORD PTR amount[rip+16], eax        # присваиваю по ссылке amount[rip + 16] значение регистра eax
.L13:                                        # метка .L13
	add	DWORD PTR -4[rbp], 1                 # увеличиваю значение rbp[-4] на 1 (rbp[-4] это аналог переменной size)
.L8:                                         # метка .L8
	mov	eax, DWORD PTR -4[rbp]               # присваиваю регистру eax значение rbp[-4] (rbp[-4] это аналог переменной size)
	cmp	eax, DWORD PTR -8[rbp]               # сравниваю значение регистра eax и rbp[-8] (rbp[-8] это аналог переменной i)
	jl	.L14                                 # в случае, если результат предыдущего сравнения <, то перехожу на метку .L14
	mov	eax, DWORD PTR amount[rip]           # присваиваю регистру eax значение amount[rip] (ссылка на элемент массива с индексом 0)
	mov	esi, eax                             # присваиваю регистру esi значение регистра eax
	lea	rdi, .LC1[rip]                       # присваиваю регистру rdi значение .LC1[rip] (строка для формата вывода количества точек в строке)
	mov	eax, 0                               # присваиваю регистру eax значение 0
	call	printf@PLT                       # вызываю макрос printf
	mov	eax, DWORD PTR amount[rip+4]         # присваиваю регистру eax значение amount[rip + 4] (элемент массива с индексом 1)
	mov	esi, eax                             # присваиваю регистру esi значение регистра eax
	lea	rdi, .LC2[rip]                       # присваиваю регистру rdi значение .LC2[rip] (строка для формата вывода количества запятых в строке)
	mov	eax, 0                               # присваиваю регистру eax значение 0
	call	printf@PLT                       # вызываю макрос printf
	mov	eax, DWORD PTR amount[rip+8]         # присваиваю регистру eax значение amount[rip + 8] (элемент массива с индексом 2)
	mov	esi, eax                             # присваиваю регистру esi значение регистра eax
	lea	rdi, .LC3[rip]                       # присваиваю регистру rdi значение .LC3[rip] (строка для формата вывода количества восклицательных знаков в строке)
	mov	eax, 0                               # присваиваю регистру eax значение 0
	call	printf@PLT                       # вызываю макрос printf
	mov	eax, DWORD PTR amount[rip+12]        # присваиваю регистру eax значение amount[rip + 12] (элемент массива с индексом 3)
	mov	esi, eax                             # присваиваю регистру esi значение регистра eax
	lea	rdi, .LC4[rip]                       # присваиваю регистру rdi значение .LC4[rip] (строка для формата вывода количества вопросительных знаков в строке)
	mov	eax, 0                               # присваиваю регистру eax значение 0
	call	printf@PLT                       # вызываю макрос printf
	mov	eax, DWORD PTR amount[rip+16]        # присваиваю регистру eax значение amount[rip + 16] (элемент массива с индексом 4)
	mov	esi, eax                             # присваиваю регистру esi значение регистра eax
	lea	rdi, .LC5[rip]                       # присваиваю регистру rdi значение .LC5[rip] (строка для формата вывода количества точек с запятой в строке)
	mov	eax, 0                               # присваиваю регистру eax значение 0
	call	printf@PLT                       # вызываю макрос printf
	mov	eax, 0                               # присваиваю регистру eax значение 0
.L7:                                         # метка .L7
	leave                                    # выход из функции
	ret                                      # выход из функции
```

### Получение исполняемого файла из ассемблерной программы:
```sh
gcc source_for_4.s -o source_for_4
```

### Делаю прогон тестов для source_for_4 (тесты приложены в архиве tests.tar.gz):
Тест 1:
Ввод:
"lol"
Вывод программы на C:
"
'.': 0
',': 0
'!': 0
'?': 0
';': 0
"
Вывод программы на ассемблере:
"
'.': 0
',': 0
'!': 0
'?': 0
';': 0
"
Вердикт: OK

Тест 2:
Ввод:
"It is Wednesday, my dudes!"
Вывод программы на C:
"
'.': 0
',': 1
'!': 1
'?': 0
';': 0
"
Вывод программы на ассемблере:
"
'.': 0
',': 1
'!': 1
'?': 0
';': 0
"
Вердикт: OK

Тест 3:
Ввод:
""
Вывод программы на C:
"
'.': 0
',': 0
'!': 0
'?': 0
';': 0
"
Вывод программы на ассемблере:
"
'.': 0
',': 0
'!': 0
'?': 0
';': 0
"
Вердикт: OK

Тест 4:
Ввод:
".,!?;"
Вывод программы на C:
"
'.': 1
',': 1
'!': 1
'?': 1
';': 1
"
Вывод программы на ассемблере:
"
'.': 1
',': 1
'!': 1
'?': 1
';': 1
"
Вердикт: OK

### Программа проходит все составленные тесты

## Задания на 5 баллов

### Модифицирую код на C так, чтобы выделить в нем функцию, которая принимает параметры и содержит локальные переменные (файл source_for_5.c):

```c
#include <stdio.h>
#include <stdlib.h>

char cstring[4000000];

int count_symbol(int size, char symbol) {
    int i = 0, kol = 0;
    for (i = 0; i < size; i++) {
        if (cstring[i] == symbol) {
            kol++;
        }
    }
    return kol;
}

int main(int argc, char* argv[]) {
    char symbol;
    int i, size = 0;
    do {
        symbol = fgetc(stdin);
        cstring[size++] = symbol;
    } while (symbol != -1 && size < 4000000);
    if (symbol != -1 && size >= 4000000) {
        printf("input string is too big!");
        return 0;
    }
    cstring[size - 1] = '\0';
    printf("'.': %d\n", count_symbol(size, '.'));
    printf("',': %d\n", count_symbol(size, ','));
    printf("'!': %d\n", count_symbol(size, '!'));
    printf("'?': %d\n", count_symbol(size, '?'));
    printf("';': %d\n", count_symbol(size, ';'));
    return 0;
}
```

### Получение ассемблированного файла с использованием оптимизаций:

```sh
gcc -masm=intel -fno-asynchronous-unwind-tables -fno-jump-tables -fno-stack-protector -fno-exceptions ./source_for_5.c -S -o ./source_for_5.s
```

### Проставляю комментарии в ассемблерный код (файл source_for_5.s):

```assembly
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
```

### Получение исполняемого файла из ассемблерной программы:

```sh
gcc source_for_5.s -o source_for_5
```

### Делаю прогон тестов для source_for_5 (тесты приложены в архиве tests.tar.gz):

Тест 1:
Ввод:
"lol"
Вывод программы на C:
"
'.': 0
',': 0
'!': 0
'?': 0
';': 0
"
Вывод программы на ассемблере:
"
'.': 0
',': 0
'!': 0
'?': 0
';': 0
"
Вердикт: OK

Тест 2:
Ввод:
"It is Wednesday, my dudes!"
Вывод программы на C:
"
'.': 0
',': 1
'!': 1
'?': 0
';': 0
"
Вывод программы на ассемблере:
"
'.': 0
',': 1
'!': 1
'?': 0
';': 0
"
Вердикт: OK

Тест 3:
Ввод:
""
Вывод программы на C:
"
'.': 0
',': 0
'!': 0
'?': 0
';': 0
"
Вывод программы на ассемблере:
"
'.': 0
',': 0
'!': 0
'?': 0
';': 0
"
Вердикт: OK

Тест 4:
Ввод:
".,!?;"
Вывод программы на C:
"
'.': 1
',': 1
'!': 1
'?': 1
';': 1
"
Вывод программы на ассемблере:
"
'.': 1
',': 1
'!': 1
'?': 1
';': 1
"
Вердикт: OK

### Программа проходит все составленные тесты

## Задания на 6 баллов

### Модифицирую ассемблерный код из файла source_for_5.s так, чтобы максимально использовать регистры (файл source_for_6.s):

```assembly
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
```

### Получение исполняемого файла из ассемблерной программы:

```sh
gcc source_for_6.s -o source_for_6
```

### Делаю прогон тестов для source_for_6 (тесты приложены в архиве tests.tar.gz):

Тест 1:
Ввод:
"lol"
Вывод программы на C:
"
'.': 0
',': 0
'!': 0
'?': 0
';': 0
"
Вывод программы на ассемблере:
"
'.': 0
',': 0
'!': 0
'?': 0
';': 0
"
Вердикт: OK

Тест 2:
Ввод:
"It is Wednesday, my dudes!"
Вывод программы на C:
"
'.': 0
',': 1
'!': 1
'?': 0
';': 0
"
Вывод программы на ассемблере:
"
'.': 0
',': 1
'!': 1
'?': 0
';': 0
"
Вердикт: OK

Тест 3:
Ввод:
""
Вывод программы на C:
"
'.': 0
',': 0
'!': 0
'?': 0
';': 0
"
Вывод программы на ассемблере:
"
'.': 0
',': 0
'!': 0
'?': 0
';': 0
"
Вердикт: OK

Тест 4:
Ввод:
".,!?;"
Вывод программы на C:
"
'.': 1
',': 1
'!': 1
'?': 1
';': 1
"
Вывод программы на ассемблере:
"
'.': 1
',': 1
'!': 1
'?': 1
';': 1
"
Вердикт: OK

### Программа проходит все составленные тесты

## Задания на 7 баллов

### Модифицирую код на c (тот, что был на 5 баллов), чтобы он вводил и выводил через файлы (файл source_for_7.c):

```c
#include <stdio.h>
#include <stdlib.h>

char cstring[4000000];

int count_symbol(int size, char symbol) {
    int i = 0, kol = 0;
    for (i = 0; i < size; i++) {
        if (cstring[i] == symbol) {
            kol++;
        }
    }
    return kol;
}

int main(int argc, char* argv[]) {
    char symbol;
    int i, size = 0;
    FILE *file_input_stream = fopen(argv[1], "r");
    while((symbol = getc(file_input_stream)) != EOF && size + 1 < 4000000) {
        cstring[size++] = symbol;
    }
    fclose(file_input_stream);
    if (symbol != -1 && size + 1 >= 4000000) {
        printf("input string is too big!");
        return 0;
    }
    cstring[size] = '\0';
    FILE *file_output_stream = fopen(argv[2], "w");
    fprintf(file_output_stream, "'.': %d\n", count_symbol(size, '.'));
    fprintf(file_output_stream, "',': %d\n", count_symbol(size, ','));
    fprintf(file_output_stream, "'!': %d\n", count_symbol(size, '!'));
    fprintf(file_output_stream, "'?': %d\n", count_symbol(size, '?'));
    fprintf(file_output_stream, "';': %d\n", count_symbol(size, ';'));
    fclose(file_output_stream);
    return 0;
}
```

### Получение ассемблированного файла с использованием оптимизаций (source_for_7.s):

```sh
gcc -masm=intel -fno-asynchronous-unwind-tables -fno-jump-tables -fno-stack-protector -fno-exceptions ./source_for_7.c -S -o ./source_for_7.s
```

### Теперь разбиваю файл source_for_7.s на 2 единицы компиляции (файлы source_for_7_count_symbol.s и source_for_7_main.s)

### Получаю исполняемый файл (файл source_for_7):

```sh
gcc source_for_7.s -o source_for_7
```

### Делаю прогон тестов для source_for_7 (тесты приложены в архиве tests.tar.gz):

Тест 1:
Ввод:
"lol"
Вывод программы на C:
"
'.': 0
',': 0
'!': 0
'?': 0
';': 0
"
Вывод программы на ассемблере:
"
'.': 0
',': 0
'!': 0
'?': 0
';': 0
"
Вердикт: OK

Тест 2:
Ввод:
"It is Wednesday, my dudes!"
Вывод программы на C:
"
'.': 0
',': 1
'!': 1
'?': 0
';': 0
"
Вывод программы на ассемблере:
"
'.': 0
',': 1
'!': 1
'?': 0
';': 0
"
Вердикт: OK

Тест 3:
Ввод:
""
Вывод программы на C:
"
'.': 0
',': 0
'!': 0
'?': 0
';': 0
"
Вывод программы на ассемблере:
"
'.': 0
',': 0
'!': 0
'?': 0
';': 0
"
Вердикт: OK

Тест 4:
Ввод:
".,!?;"
Вывод программы на C:
"
'.': 1
',': 1
'!': 1
'?': 1
';': 1
"
Вывод программы на ассемблере:
"
'.': 1
',': 1
'!': 1
'?': 1
';': 1
"
Вердикт: OK

### Программа проходит все составленные тесты
