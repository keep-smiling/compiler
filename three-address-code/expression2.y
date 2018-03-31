%{
#include <stdio.h>
#include <stdlib.h>
extern char *yytext;
void insert();
void code();
void codeminus();
void codeassign();
int tope=0;
char str[100][30];
char i[2]="0";
char tempo[100];
%}
%token NUM ID 
%right "="
%left "+" "-"
%left "*" "/"
%right UMINUS

%%

A : ID {insert();} '=' E {codeassign();}
  ;
E : E '+' {insert();} T {code();}
   | E '-'{insert();} T {code();}
   | T
   ;
T : T '*' {insert();} F {code();}
   | T '/' {insert();} F {code();} 
   | F 
   ;
F : '(' E ')'
  | '-' {insert();} F {codeminus();}
  | ID {insert();}
  | NUM {insert();}
  ;

%%

#include "lex.yy.c"
int main()
{
  yyparse();
  return 0;
} 

void insert()
{
  strcpy(str[++tope],yytext);
}
void code()
{
    strcpy(tempo,"t");
    //char a=i+'0';
    strcat(tempo,i);
    printf("%s = %s %s %s \n",tempo,str[tope-2],str[tope-1],str[tope]);
    tope=tope-2;
    strcpy(str[tope],tempo);
   i[0]++;
}
void codeminus()
{
   strcpy(tempo,"t");
   //char b=i+'0';
    strcat(tempo,i);
   printf("%s = -%s\n",tempo,str[tope]);
   tope--;
   strcpy(str[tope],tempo);
   i[0]++;

}
void codeassign()
{
   printf("%s = %s\n",str[tope-1],str[tope]);
   tope=tope-2;
}


