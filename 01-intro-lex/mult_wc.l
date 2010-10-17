%{
#include <stdio.h>
#include <stdlib.h>
unsigned charCount = 0, wordCount = 0, lineCount = 0;
unsigned fcharCount = 0, fwordCount = 0, flineCount = 0;
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
  unsigned int totalWord = 0, totalChar = 0, totalLine = 0;
  for(int i=1; i < argc; i++)
  {
    yyin = (FILE*) fopen(argv[i], "r");
    yylex();
    printf("%d %d %d %s\n", lineCount, wordCount, charCount, argv[i]);
    totalWord += wordCount;
    totalChar += charCount;
    totalLine += lineCount;
    wordCount = charCount = lineCount = 0;
  }
  printf("%d %d %d total\n", totalLine, totalWord, totalChar);
}
