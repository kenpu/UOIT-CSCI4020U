grammar Expr2;

program : (expr NEWLINE)+
        ;

expr : term ('+'|'-' expr)?
     ;

term : INTEGER
     | '(' expr ')'
     ;


INTEGER : ('0' .. '9')+;
NEWLINE : ('\r')? '\n';
