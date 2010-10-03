package myc;

import org.antlr.runtime.ANTLRInputStream;
import org.antlr.runtime.CharStream;
import org.antlr.runtime.CommonTokenStream;

public class tryParser {
	public static void main(String[] args) throws Exception {
		CharStream input = new ANTLRInputStream(System.in);
		MycampusLexer lexer = new MycampusLexer(input);
		MycampusParser parser = new MycampusParser(new CommonTokenStream(lexer));
		parser.start();
	}
}
