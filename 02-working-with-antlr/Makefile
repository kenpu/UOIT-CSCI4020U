CP = ../lib/antlr-3.3.jar:.
ANTLR = java -cp $(CP) org.antlr.Tool
JAVAC = javac -cp $(CP)

all : TryLexer.class BasicLexer.class

BasicLexer.class : BasicLexer.g
	$(ANTLR) $<
	$(JAVAC) BasicLexer.java

TryLexer.class : TryLexer.java BasicLexer.class
	$(JAVAC) $<

run:
	echo "123 Hello Word 321" | java -cp $(CP) TryLexer

clean:
	rm -f *.class *.tokens BasicLexer.java 
