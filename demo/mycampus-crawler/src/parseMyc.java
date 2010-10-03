import myc.MycampusLexer;
import myc.MycampusParser;
import myc.Section;
import myc.SectionHandler;

import org.antlr.runtime.ANTLRInputStream;
import org.antlr.runtime.CharStream;
import org.antlr.runtime.CommonTokenStream;

import com.google.gson.Gson;


public class parseMyc implements SectionHandler {
	
	Gson gson;
	public parseMyc() {
		this.gson = new Gson();
	}
	public void process(Section sec) {
		String json = this.gson.toJson(sec);
		System.out.println(json);
	}
	
	public static void main(String[] args) throws Exception {
		CharStream input = new ANTLRInputStream(System.in);
		MycampusLexer lexer = new MycampusLexer(input);
		MycampusParser parser = new MycampusParser(new CommonTokenStream(lexer));
		SectionHandler handler = new parseMyc();
		parser.handler = handler;
		parser.start();
	}
}
