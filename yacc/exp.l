%{
#include "y.tab.h"
#include <stdio.h>

void yyerror(char* s);
int yylex();

int processInt(char* text);

%}

%%
"print"            { return println; }
"exit"             { return exit_statement; }
[a-zA-Z]           { yylval.id = yytext[0];return identifier; }
[0-9]+             { yylval.num = processInt(yytext); return number; }
[ \t\n]            ;
[-\+\*/;=\(\)]     { return yytext[0];}
.                  {ECHO; printf("Unexpected character %s",yytext);}
%%

int yywrap(void) { return 1; }

int processInt(char* text){
    int k = atoi(text) ;
    return k;
}