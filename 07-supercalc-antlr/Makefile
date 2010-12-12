CLASSPATH = .:../lib/antlr-3.3.jar
antlr = java -cp $(CLASSPATH) org.antlr.Tool
javac = javac -cp $(CLASSPATH)
java = java -cp $(CLASSPATH)

all:
	$(antlr) Tutorial.g
	$(javac) SuperCalc.java

run:
	$(java) SuperCalc test.calc

clean:
	rm -f *Parser.java *Lexer.java *.tokens *.class
