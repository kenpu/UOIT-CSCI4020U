import org.antlr.runtime.ANTLRFileStream;
import org.antlr.runtime.CharStream;
import org.antlr.runtime.CommonTokenStream;
import org.antlr.runtime.Lexer;


public class SuperCalc {
	public static void main(String[] args) {
		if(args.length == 0) {
			System.out.println("Usage: SuperCalc <file.calc>");
			System.exit(0);
		}
		String calcFile = args[0];
		
		try {
			CharStream input = new ANTLRFileStream(calcFile);
			Lexer lexer = new TutorialLexer(input);
			CommonTokenStream tokens = new CommonTokenStream(lexer);
			TutorialParser parser = new TutorialParser(tokens);
			parser.program();
			
		} catch(Exception e) {
			System.out.println("Error:" + e.getMessage());
		}
	}
}
