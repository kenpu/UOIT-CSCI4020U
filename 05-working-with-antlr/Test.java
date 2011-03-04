import org.antlr.runtime.ANTLRInputStream;
import org.antlr.runtime.CharStream;
import org.antlr.runtime.CommonTokenStream;

public class Test {
  public static void main(String[] args) {
    try {
      CharStream input = new ANTLRInputStream(System.in);
      Expr2Lexer lexer = new Expr2Lexer(input);
      Expr2Parser parser = new Expr2Parser(new CommonTokenStream(lexer));
      parser.program();
    } catch(Exception e) {
      System.err.println("Error: " + e.getMessage());
    }
  }
}
