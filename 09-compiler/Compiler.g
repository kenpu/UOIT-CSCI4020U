grammar Compiler;

@header {
import org.antlr.runtime.*;
import java.io.*;
import java.util.Map;
import java.util.HashMap;
}
@members {
public PrintWriter out;
public int loopCounter = 0;
public Map<String, Integer> variables = new HashMap<String, Integer>();

/* assume integer valued values */
public void j(String s) {
  out.println(s);
}
public void j_assign(int var) {
	out.println("istore " + var);
}
public void j_print_loop(int var, int repeat) {
	loopCounter ++;
	int loopVar = 10 - loopCounter;
	if(loopVar < variables.size()) {
		System.out.println("Heap space overflow by loops");
		System.exit(0);
	}
	out.println("ldc " + repeat);
	out.println("istore " + loopVar);
	out.println("LOOP_" + loopCounter + ":");
	out.println("getstatic java/lang/System/out Ljava/io/PrintStream;");
	out.println("iload " + var);
	out.println("invokevirtual java/io/PrintStream/println(I)V");
	out.println("iinc " + loopVar + " -1");
	out.println("iload " + loopVar);
	out.println("ifne LOOP_" + loopCounter);
}
public static void main(String[] args) throws Exception {
	CharStream input = new ANTLRFileStream(args[0]);
	Lexer lexer = new CompilerLexer(input);
	CommonTokenStream tokens = new CommonTokenStream(lexer);
	PrintWriter out = new PrintWriter(new FileOutputStream("a.j"));
	CompilerParser parser = new CompilerParser(tokens);
	parser.out = out;	
	out.println(".class public blah");
	out.println(".super java/lang/Object");
	out.println(".method public <init>()V");
	out.println("aload_0");
  	out.println("invokenonvirtual java/lang/Object/<init>()V");
  	out.println("return");
  	out.println(".end method");
	out.println(".method public static main([Ljava/lang/String;)V");
	out.println(".limit stack 10");
	out.println(".limit locals 10");
	parser.prog();
	out.println("return");
	out.println(".end method");
	out.close();
}
}

prog : (statement NEWLINE)+ EOF;

statement
	: 'make' ID expr
	  {
	  	int var = 0;
	  	if(this.variables.containsKey($ID.text))
	  		var = this.variables.get($ID.text);
	  	else {
	  		var = this.variables.size();
	  		this.variables.put($ID.text, var);
	  	}
	  	this.j_assign(var);
	  }
	| 'print' varname=ID ('for' repeat=NUM 'times')?
	  {
	  	int var = 0;
	  	int loop = 1;
	  	if(variables.containsKey($varname.text))
	  		var = variables.get($varname.text);
	  	else {
	  		System.out.println("Compiling error: " + $varname.text + " is not declared.");
	  		System.exit(0);
	  	}
	  	if($repeat != null) {
	  		loop = Integer.parseInt($repeat.text);
	  	}
	  	j_print_loop(var, loop);
	  }
	;
	
expr 
  : ID
    {
    out.println("iload " + variables.get($ID.text));
    }
  | NUM
    {
    out.println("ldc " + $NUM.text);
    }
  | '(' '+' expr expr ')'
    {
    out.println("iadd");
    }
  | '(' '*' expr expr ')'
    {
    out.println("imul");
    }
  | '(' '/' expr expr ')'
    {
    out.println("idiv");
    }
  | '(' '-' expr expr ')'
    {
    out.println("isub");
    }
  | '(' 'sin' expr ')'
    {
      j("i2d");
      j("ldc 180");
      j("i2d");
      j("ddiv");
      j("getstatic java/lang/Math/PI D");
      j("dmul");
      j("invokestatic java/lang/Math/sin(D)D");
      j("ldc 100");
      j("i2d");
      j("dmul");
      j("invokestatic java/lang/Math/round(D)J");
      j("l2i");
    }
  ;
  
  

ID
	: ('a' .. 'z')+
	;

NUM 
	: ('0' .. '9')+ 
	;

NEWLINE : '\r'? '\n';
WS : (' '|'\t') {skip();};
