%{
#include <stdio.h>
#include <stdlib.h>
unsigned commentCount = 0, otherCount = 0;
bool inComment = false;
%}

%%
^[\t ]*"#" { inComment = true; }
\n     {
          if(inComment) {
            inComment = false;
          }
        }

.       {
          if(inComment)
            commentCount ++;
          else
            otherCount ++;
        }

%%

int main(int argc, char **argv)
{
  if(argc == 2) {
    FILE *file = fopen(argv[1], "r");
    yyin = file;
  }
  yylex();
  printf("%d in comment.\n", commentCount);
  printf("%d in other.\n", otherCount);
  return(0);
}
