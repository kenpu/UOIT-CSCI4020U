all: test_basic lex_wc lex_mult_wc lex_comment_wc

test_basic: test_basic.c basic.l
	lex basic.l
	gcc -o test_basic test_basic.c lex.yy.c

wc.yy.c : wc.l
	lex -o wc.yy.c wc.l
lex_wc : wc.yy.c
	gcc -o lex_wc wc.yy.c -ll

mult_wc.yy.c : mult_wc.l
	lex -o mult_wc.yy.c mult_wc.l
lex_mult_wc : mult_wc.yy.c
	g++ -o lex_mult_wc mult_wc.yy.c -ll

comment_wc.yy.c : comment_wc.l
	lex -o comment_wc.yy.c comment_wc.l
lex_comment_wc : comment_wc.yy.c
	g++ -o lex_comment_wc comment_wc.yy.c -ll

clean:
	rm -f lex_*wc *.yy.c test_basic 
