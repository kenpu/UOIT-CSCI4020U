import org.antlr.runtime.ANTLRInputStream;
import org.antlr.runtime.Token;
import java.io.IOException;

public class TryLexer
{
  public static void main(String[] args) throws IOException {
    ANTLRInputStream input = new ANTLRInputStream(System.in);
    BasicLexer lexer = new BasicLexer(input);
    Token t;
    while(true) {
      t = lexer.nextToken();
      System.out.println("<" 
                       + t.getType() + ", " 
                       + t.getText() + ">");
      if( t == Token.EOF_TOKEN || t.getType() < 0 )
        break;
    }
  }
}

