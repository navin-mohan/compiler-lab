%option noinput

%{

#include "scanner.h"
#include <stdio.h>

%}

keyword "int"|"char"|"double"|"float"|"void"|"long"|"short"|"static"|"volatile"|"register"|"break"|"continue"|"return"|"if"|"else"|"signed"|"unsigned"|"extern"|"if"|"else"|"goto"|"for"|"while"|"do"|"case"|"switch"|"union"|"struct"|"const"|"enum"
brackets "{"|"}"|"("|")"|"["|"]"
seperators ","|";"
arithmetic_operators "+"|"-"|"*"|"/"|"%"
bitwise_operators "^"|"&"|"|"|"<<"|">>"|"~"
logical_operators "&&"|"||"|"?"|(("<"|">"|"="|"!")"="?)
digit [0-9]
letter [a-zA-Z_]





%%

{keyword}                                        return KEYWORD;

{brackets}|{seperators}                          return DELIMITER;

{digit}+\.{digit}+(e("+"|"-")?{digit}+)?         return REAL_NUM;
{digit}+e(("+"|"-")?{digit}+)                    return REAL_NUM;
0[0-7]*                                          return DEC_NUM;
0x[{digit}a-fA-F]+                               return HEX_NUM;
{digit}+                                         return DEC_NUM;

"?"|":"|"."|"->"|"++"|"--"                       return OPERATOR;
({arithmetic_operators}|{bitwise_operators})"="? return OPERATOR;
{logical_operators}|"="                          return OPERATOR;


{letter}({letter}|{digit})*                      return IDENTIFIER;

\"[^\n]*\"                                       return STRING;
\'.\'                                            return CHAR;

[ \t\n]+                                   
.                                                printf("Unexpected character %s\n",yytext);

%%


int yywarp(){ return 1; }
