grammar Expr2;
options {
  backtrack=true;
}

program : (expr NEWLINE)+
        ;

expr : term (('+'|'-') expr)*
     ;

term : INTEGER
     | '(' expr ')'
     ;


INTEGER : ('0' .. '9')+;
NEWLINE : '\n';
/* Ignore whitespaces */
WS : (' ' | '\t')+ {skip();};
