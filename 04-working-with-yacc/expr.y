%{
#include <stdio.h>
void yyerror(char *);
%}
%token INTEGER

%%

program : program expr '\n'
        |
        ;

expr  : INTEGER
      | expr '+' expr
      | expr '-' expr
      | '(' expr ')'
      ;

%%

void yyerror(char *err) {
  printf("Error: %s\n" , err);
}

int main(void) {
  yyparse();
  return 0;
}
