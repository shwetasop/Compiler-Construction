all:
	flex calc.l
	bison -dv calc.y
	gcc lex.yy.c calc.tab.c  -o calc -lfl
	./calc
clean: 
	rm calc calc.tab.c calc.tab.h lex.yy.c calc.output  
	
