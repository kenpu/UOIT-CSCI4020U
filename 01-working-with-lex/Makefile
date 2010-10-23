all: test_basic run

lex.yy.c: basic.l
	lex basic.l

test_basic: test_basic.c lex.yy.c
	gcc -o $@ $^

run: test_basic
	echo "123 Hello World DEF" | ./test_basic

clean:
	rm -f test_basic lex.yy.c
