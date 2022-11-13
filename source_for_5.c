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
