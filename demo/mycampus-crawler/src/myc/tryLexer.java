package myc;

import org.antlr.runtime.ANTLRInputStream;
import org.antlr.runtime.CharStream;
import org.antlr.runtime.Token;

public class tryLexer {
	public static void main(String[] args) throws Exception {
		CharStream s1 = new ANTLRInputStream(System.in);
		MycampusLexer lexer = new MycampusLexer(s1);
		
		Token t;
		while( (t=lexer.nextToken()) != Token.EOF_TOKEN) {
			if(t.getChannel() != 99)
      {
      String tokenName = (t.getType() >= 0 ?  MycampusParser.tokenNames[t.getType()] : "unknown");
			System.out.println("T[" + tokenName + "]: " + t.getText());
      }
		}
	}
}
