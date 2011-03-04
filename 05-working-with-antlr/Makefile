CLASSPATH = .:../lib/antlr-3.3.jar
antlr = java -cp $(CLASSPATH) org.antlr.Tool
javac = javac -cp $(CLASSPATH)
java = java -cp $(CLASSPATH)

all: Expr1 Expr2

Expr1 : Expr1.g
	$(antlr) Expr1.g

Expr2 : Expr2.g
	$(antlr) Expr2.g

clean:
	rm -f *Parser.java *Lexer.java *.tokens
