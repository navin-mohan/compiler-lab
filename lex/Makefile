CC = gcc
CFLAGS = -Wall

LDLIBS += -ll

EXE = scanner

RM = /bin/rm -f

all: $(EXE)

$(EXE): lex.yy.c scanner.c
	$(CC) $^ $(LDLIBS) -o $(EXE)

lex.yy.c: scanner.l
	lex scanner.l

clean:
	$(RM) $(EXE) lex.yy.c