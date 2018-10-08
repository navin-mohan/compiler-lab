CC = gcc
CFLAGS = -Wall

LDLIBS += -ll

EXE = exp

RM = /bin/rm -f

all: $(EXE)

$(EXE): lex.yy.c 
	$(CC) $^ y.tab.c $(LDLIBS) -o $(EXE)

lex.yy.c: y.tab.h
	lex $(EXE).l

y.tab.h: $(EXE).y
	yacc -d $(EXE).y

clean:
	$(RM) $(EXE) lex.yy.c y.tab.c y.tab.h