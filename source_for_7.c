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
