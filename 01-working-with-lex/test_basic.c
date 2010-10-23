#include <stdio.h>
char *yytext;
int yyleng;
int yylex(void);

int main(int argc, char **argv) {
    int token_type;
    while(token_type = yylex()) {
        printf("<%d, \"%s\">\n", token_type, yytext);
    }
}

