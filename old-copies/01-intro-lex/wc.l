%{
#include <stdio.h>
#include <stdlib.h>
unsigned charCount = 0, wordCount = 0, lineCount = 0;
%}

word [^ \t\n]+
eol \n

%%
{word}  {wordCount ++; charCount += yyleng; }
{eol}   {charCount ++; lineCount ++;}
.       {charCount++;}

%%

int main(int argc, char **argv)
{
  if(argc == 2) {
    FILE *file = fopen(argv[1], "r");
    yyin = file;
  }
  yylex();
  printf("%d %d %d\n", lineCount, wordCount, charCount);
  return(0);
}
