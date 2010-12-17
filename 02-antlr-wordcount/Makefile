CP = ../lib/antlr-3.1.2.jar:.

wordcountLexer.class : wordcountLexer.java
	javac -cp $(CP) wordcountLexer.java

wordcountLexer.java : wordcountLexer.g
	java -cp $(CP) org.antlr.Tool wordcountLexer.g

clean:
	rm -f wordcountLexer.java wordcountLexer.class wordcountLexer.tokens

run:
	java -cp $(CP) wordcountLexer
