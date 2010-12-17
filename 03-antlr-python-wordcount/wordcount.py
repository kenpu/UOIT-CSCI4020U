from antlr3 import *
from wordcountLexer import wordcountLexer, NL

input = ANTLRStringStream("hello world\nabout a boy\n")
lexer = wordcountLexer(input)
lexer.wordcount = 0
lexer.linecount = 0
t = lexer.nextToken()
while not t == EOF_TOKEN:
  if not t.getType() == NL:
    print "<%d> %s" % (t.getType(), t.getText())
  t = lexer.nextToken()

print "There are %d words\nThere are %d lines" % (lexer.wordcount,
lexer.linecount)
