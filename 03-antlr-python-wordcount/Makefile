PYTHONPATH = .:../lib/antlr_python_runtime-3.1.2-py2.5.egg
JAVAPATH = .:../lib/antlr-3.1.2.jar

wordcountLexer.py : wordcountLexer.g
	java -cp $(JAVAPATH) org.antlr.Tool wordcountLexer.g

clean:
	rm -rf *Lexer.py *.pyc *.tokens

run:
	PYTHONPATH=$(PYTHONPATH) python wordcount.py

