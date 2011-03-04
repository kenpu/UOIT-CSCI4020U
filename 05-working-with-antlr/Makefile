CLASSPATH = .:../lib/antlr-3.3.jar
antlr = java -cp $(CLASSPATH) org.antlr.Tool
javac = javac -cp $(CLASSPATH)
java = java -cp $(CLASSPATH)

all: Test.class

Expr1 : Expr1.g
	$(antlr) Expr1.g

Expr2 : Expr2.g
	$(antlr) Expr2.g

Test.class : Test.java Expr1 Expr2
	$(javac) Test.java

run:
	echo 'Good:'; echo '(45 + (1-90)) -(73+9)' | $(java) Test
	echo 'Bad:"; echo '(45 + 1-90)) -(73+9)' | $(java) Test

clean:
	rm -f *Parser.java *Lexer.java *.tokens *.class
