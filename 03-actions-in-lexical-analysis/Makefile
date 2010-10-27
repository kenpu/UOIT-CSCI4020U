ANTLR = java -cp ../lib/antlr-3.3.jar org.antlr.Tool
JAVAC = javac -cp ../lib/antlr-3.3.jar
.SUFFIXES: .java .class .g
.g.class:
	$(ANTLR) $<
	$(JAVAC) $(<:.g=.java)

all: wc wcLexer.class

wc: wc.l
	lex wc.l
	gcc -o wc lex.yy.c

clean:
	rm -f lex.yy.c wc wcLexer.java wcLexer.class wcLexer.tokens

