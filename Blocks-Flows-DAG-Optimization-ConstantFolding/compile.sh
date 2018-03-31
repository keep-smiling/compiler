lex first.l
yacc first.y
gcc y.tab.c -ll -ly
./a.out<in.txt

