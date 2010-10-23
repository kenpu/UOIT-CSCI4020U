%{
    #include <stdio.h>
    #include <stdlib.h>
    /* ... more header files if necessary */
    /* ... you can declare functions if you want */
%}

/* You can declare some patterns here for use later.
   but this is not necessary */
digits [0-9]+
lowercase [a-z]+
%%

[A-Z]+    { return 100; /* Yield a token of type 100 */ }
[A-Z]{lowercase} { return 200; /* Another type of token */ }
{digits}    {return 300; /*Yet another type of tokens */}
[ \t\n]+  ; /* Just ignore white spaces */
.         { printf("."); /* All other things will be a dot 
                            on the screen */ }

%%

/* Function implementations go here */

int yywrap() {
  return 1; /* Tell lex that we only process standard input */
}
