grammar E;
options {
  backtrack=true;
}

@members {
  void p(String message) {
    System.out.println(message);
  }
}

program : (e NEWLINE {p("e=" + $e.value);})+ EOF
        ;

e returns [int value]
  : f {$value = $f.value;}
    (op=('+'|'-') x=e
     {
       if($op.text.equals("+"))
         $value = $f.value + $x.value;
       else
         $value = $f.value - $x.value;
     }
    )*
  ;

f returns [int value]
  : x=INTEGER {$value = Integer.parseInt($x.text);}
  | '(' e {$value=$e.value;} ')'
  ;


INTEGER : ('0' .. '9')+;
NEWLINE : '\n';
/* Ignore whitespaces */
WS : (' ' | '\t')+ {skip();};
