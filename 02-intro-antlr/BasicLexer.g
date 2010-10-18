lexer grammar BasicLexer;

Number 
  : ('0' .. '9')+
  ;
Whitespace
  : (' ' | '\t' | '\r' | '\n')
  ;
fragment Letter : ('a' .. 'z' | 'A' .. 'Z');
Lastname
  : ('A' .. 'Z') Letter+
  ;
Word : Letter+ ;

