%{
int yylex();
void yyerror(char* s);

#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>


int sym_tab[52];

int getSymbol(char sym);
void setSymbol(char sym,int val);

%}

%union {int num; char id;}
%start line
%token println
%token exit_statement
%token <num> number
%token <id> identifier
%type <num> line exp term factor n
%type <id> assignment


%%

line:  assignment ';'                  {;} //do nothing
       | exit_statement ';'            {exit(0);}
       | println exp ';'               {printf("%d\n",$2);} 
       | line assignment ';'           {;}
       | line println exp ';'          {printf("%d\n",$3);}
       | line exit_statement ';'       {exit(0);}
       ;

assignment: identifier '=' exp         {setSymbol($1,$3);}
       ;


exp:   term                            {$$ = $1;}
       | exp '+' term                  {$$ = $1 + $3;}
       | exp '-' term                  {$$ = $1 - $3;}
       ;

term:  factor                          {$$ = $1;}
       |  term '*' factor              {$$ = $1 * $3;}
       |  term '/' factor              {$$ = $1 / $3;}
       ;

factor: n                              {$$ = $1;}
        | '-' n                        {$$ = -$2;}
        | '+' n                        {$$ = $2;}
        ;

n:     number                          {$$ = $1;}
       | identifier                    {$$ = getSymbol($1);}
       | '(' exp ')'                   {$$ = $2;}
       ;

%%

int getSymTabIndex(char id){
    int index = id - 'A';

    return index;
}

int getSymbol(char id){
    int index = getSymTabIndex(id);
    if(index >= 52){
        printf("Invalid Identifier\n");
        return -1;
    }

    return sym_tab[index];
}

void setSymbol(char id,int val){
    int index = getSymTabIndex(id);
    printf("setting %c to %d\n",id,val);
    if(index >= 52){
        printf("Invalid Identifier: %d\n",index);
    }else{
        sym_tab[index] = val;
    }

}


int main(void){
    for(int i=0;i<52;++i) sym_tab[i] = 0;

    return yyparse();
}

void yyerror(char* s){
    fprintf(stderr,"%s\n",s);
}