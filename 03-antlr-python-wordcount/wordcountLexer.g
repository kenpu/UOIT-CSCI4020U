lexer grammar wordcountLexer;

options {
  language = Python;
}

WORD : LETTER+ {self.wordcount +=1;};

WS : (' ' | '\t')+ {self.skip();};

NL : '\n' {self.linecount += 1;};

fragment LETTER : ~(' ' | '\t' | '\n');
