expr.exe : y.tab.c lex.yy.c
	gcc -o expr.exe y.tab.c lex.yy.c

y.tab.c : expr.y
	yacc -d expr.y

lex.yy.c : expr.l
	lex expr.l

clean:
	rm -f *.c *.h *.exe
