lexer grammar wordcountLexer;

@header {
/* If we have package declarations, it should go here. */
import org.antlr.runtime.ANTLRStringStream;
import org.antlr.runtime.CharStream;
import org.antlr.runtime.Token;
}

@members {
  public int wordcount = 0;
  public int linecount = 0;

  public static void main(String[] argv) {
    CharStream input = new ANTLRStringStream("Hello world\nabout a boy\n");
    Token t;
    wordcountLexer lexer = new wordcountLexer(input);
    while( (t=lexer.nextToken()) != Token.EOF_TOKEN )
    {
      if(t.getType() != wordcountLexer.NL)
        System.out.println("<" + t.getType() + ">" + t.getText());
    }

    System.out.println("Total words:" + lexer.wordcount);
    System.out.println("Total lines:" + lexer.linecount);
  }
}

WORD : LETTER+ {this.wordcount ++;};

WS : (' ' | '\t')+ {skip();};

NL : '\n' {this.linecount ++;};

fragment LETTER : ~(' ' | '\t' | '\n');
