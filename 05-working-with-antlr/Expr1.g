grammar Expr1;

options {
  backtrack = true;
}

program : expr NEWLINE program
        |
        ;

expr : term 
     | term '+' expr
     | term '-' expr
     ;

term : INTEGER
     | '(' expr ')'
     ;


INTEGER : ('0' .. '9')+;
NEWLINE : ('\r')? '\n';
