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
    } while (symbol != -1 && size < 4000000);
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
    printf("'.': %d\n", amount[0]);
    printf("',': %d\n", amount[1]);
    printf("'!': %d\n", amount[2]);
    printf("'?': %d\n", amount[3]);
    printf("';': %d\n", amount[4]);
    return 0;
}
