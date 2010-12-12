grammar Tutorial;

@header {
  import java.util.HashMap;
  import java.util.Vector;
}

@members {
  void p(String expr, float value) {
    System.out.println("\"" + expr + "\" = " + value); 
  }
  HashMap<String, Float> symTable = new HashMap<String, Float>(); 
  
  void p_symtable() {
    for(String key : this.symTable.keySet()) {
      p("\t" + key, symTable.get(key));
    }
  }
}

program 
  : (statement COMMENT? NEWLINE)+ EOF
  ;
  
statement
  : expr {p($expr.text, $expr.value);}
  | ID '=' expr 
    {
      this.symTable.put($ID.text, $expr.value);
      p($ID.text, $expr.value);
    }
  | 'list' {p_symtable();}
  | array_expr
    { 
      System.out.print("[");
      for(float f : $array_expr.value)
        System.out.print(f + ", ");
      System.out.println("]");
    }
  |
  ;
  
expr returns [float value] 
  : t1=term {$value = $t1.value;}
    (
    op=('+'|'-') t2=term
    {
      $value = ($op.text.equals("+")) ? ($value + $t2.value) : ($value - $t2.value);
    }
    )*
  ;

term returns [float value]
  : a1=atom {$value = $a1.value;} 
    (
    op=('*'|'/') a2=atom
    {
      $value = ($op.text.equals("*")) ? ($value * $a2.value) : ($value / $a2.value);
    }
    )*
  ;

atom returns [float value]
  : NUMBER
    {$value = Float.parseFloat($NUMBER.text);}
  | '(' expr ')'
    {$value = $expr.value;}
  | ID
    {$value = symTable.get($ID.text);}
  ;

array returns [Vector<Float> value]
  @init {
    $value = new Vector<Float>();
  }
  : '[' (atom {$value.add($atom.value);})* ']'
  ;

array_expr returns [Vector<Float> value]
  @init {
    $value = new Vector<Float>();
  }
  : a1=array
    {
      for(float f : $a1.value)
        $value.add(f);
    } 
    (
    op='+' a2=array
    {
      int n = Math.min($a2.value.size(), $value.size());
      for(int i=0; i < n; i++)
        $value.set(i, $value.get(i) + $a2.value.get(i));
    }
    )*
  ;

NUMBER
  : ('0' .. '9')+ ('.' ('0' .. '9')+)?
  | '.' ('0' .. '9')+
  ;

WHITESPACE : (' ' | '\t') {skip();};

NEWLINE : '\r'? '\n';

ID : ('a' .. 'z')+ ;

COMMENT : '//' ~('\n')*;