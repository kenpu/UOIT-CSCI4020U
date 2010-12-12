wordcount.yy.c : wordcount.l
	lex -o wordcount.yy.c wordcount.l
wordcount : wordcount.yy.c
	gcc -o wordcount wordcount.yy.c -ll


clean:
	rm -f wordcount.yy.c wordcount

