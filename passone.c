#include<stdio.h>
#include<string.h>
#include<stdlib.h>

void passone(char label[10], char opcode[10], char operand[10], char code[10], char mnemonic[10]);
void display();

int main() {
    char label[10], opcode[10], operand[10];
    char code[10], mnemonic[10];
    passone(label, opcode, operand, code, mnemonic);
    return 0;
}

void passone(char label[10], char opcode[10], char operand[10], char code[10], char mnemonic[10]) {
    int locctr, start, length;
    FILE *fp1, *fp2, *fp3, *fp4, *fp5;
    fp1 = fopen("input.txt", "r");
    fp2 = fopen("optab.txt", "r");
    fp3 = fopen("symtab.txt", "w");
    fp4 = fopen("intermediate.txt", "w");
    fp5 = fopen("length.txt", "w");

    if (!fp1 || !fp2 || !fp3 || !fp4 || !fp5) {
        printf("Error opening file(s)\n");
        exit(1);
    }

    fscanf(fp1, "%s\t%s\t%s", label, opcode, operand);
    if (strcmp(opcode, "START") == 0) {
        start = atoi(operand);
        locctr = start;
        fprintf(fp4, "%s\t%s\t%s\n", label, opcode, operand);
        fscanf(fp1, "%s\t%s\t%s", label, opcode, operand);
    } else {
        locctr = 0;
    }

    while (strcmp(opcode, "END") != 0) {
        fprintf(fp4, "%d\t%s\t%s\t%s\n", locctr, label, opcode, operand);
        if (strcmp(label, "**") != 0) {
            fprintf(fp3, "%s\t%d\n", label, locctr);
        }

        int found = 0;
        while (fscanf(fp2, "%s\t%s", code, mnemonic) != EOF) {
            if (strcmp(opcode, code) == 0) {
                locctr += 3;
                found = 1;
                break;
            }
        }
        rewind(fp2);

        if (!found) {
            if (strcmp(opcode, "WORD") == 0)
                locctr += 3;
            else if (strcmp(opcode, "RESW") == 0)
                locctr += (3 * atoi(operand));
            else if (strcmp(opcode, "BYTE") == 0) {
                if (operand[0] == 'C')
                    locctr += strlen(operand) - 3;
                else if (operand[0] == 'X')
                    locctr += (strlen(operand) - 3) / 2;
            } else if (strcmp(opcode, "RESB") == 0)
                locctr += atoi(operand);
        }

        fscanf(fp1, "%s\t%s\t%s", label, opcode, operand);
    }

    fprintf(fp4, "%d\t%s\t%s\t%s\n", locctr, label, opcode, operand);

    fclose(fp4);
    fclose(fp3);
    fclose(fp2);
    fclose(fp1);

    display();

    length = locctr - start;
    fprintf(fp5, "%d", length);
    fclose(fp5);
    printf("\nThe length of the code is %d\n", length);
}

void display() 
{
    int ch;
    FILE *fp1, *fp2, *fp3;

    printf("\nThe contents of Input Table:\n\n");
    fp1 = fopen("input.txt", "r");
    while ((ch = fgetc(fp1)) != EOF)
        printf("%c", ch);
    fclose(fp1);

    printf("\nThe contents of Intermediate File:\n\n");
    fp2 = fopen("intermediate.txt", "r");
    while ((ch = fgetc(fp2)) != EOF)
        printf("%c", ch);
    fclose(fp2);

    printf("\nThe contents of Symbol Table:\n\n");
    fp3 = fopen("symtab.txt", "r");
    while ((ch = fgetc(fp3)) != EOF)
        printf("%c", ch);
    fclose(fp3);
}
