%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
extern char * yytext;
void tablep();
void display();
void display2();
char temp[100][100];
int i=0;
int j;
char dotemp[1000][1000];
int ido=0;
char dotemp1[100][100];
int ido1=0;
%}
%token ID NUM FOR LE GE EQ NE OR AND DO WHILE 


%%

START     : S {printf("Input accepted\n"); exit(0);} ;    
    
S         : ST | ST2 ;

ST2        : DO '{' BODY2 '}' WHILE  '('  E5  ')'  ';' 	{display(); display2();display();printf("}");} ;
BODY2      : BODY2 BODY2  
           | EDO ';'  {strcpy(dotemp[ido],";");ido++;}
           | S
           |
           ;
E5     : E5 '<'{strcpy(dotemp1[ido1],"<");ido1++;} E5
         | E5 '>' {strcpy(dotemp1[ido1],">");ido1++;} E5
         | E5 LE {strcpy(dotemp1[ido1],"<=");ido1++;} E5
         | E5 GE {strcpy(dotemp1[ido1],"<=");ido1++;} E5
         | E5 EQ {strcpy(dotemp1[ido1],"==");ido1++;} E5
         | E5 NE {strcpy(dotemp1[ido1],"!=");ido1++;} E5
         | E5 OR {strcpy(dotemp1[ido1],"||");ido1++;} E5
         | E5 AND {strcpy(dotemp1[ido1],"&&");ido1++;} E5
         | ID  {strcpy(dotemp1[ido1],yytext);ido1++;}
         | NUM {strcpy(dotemp1[ido1],yytext);ido1++;}
         ;             


EDO        :EDO '='  {strcpy(dotemp[ido],yytext);ido++;}  EDO 
          | EDO  '+'  L1DO 
          | EDO '-' L2DO
          | EDO '*' {strcpy(dotemp[ido],yytext);ido++;} EDO
          | EDO '/' {strcpy(dotemp[ido],yytext);ido++;}  EDO
          | EDO '<' {strcpy(dotemp[ido],yytext);ido++;}  EDO
          | EDO '>' {strcpy(dotemp[ido],yytext);ido++;} EDO
          | EDO LE {strcpy(dotemp[ido],yytext);ido++;} EDO
          | EDO GE {strcpy(dotemp[ido],yytext);ido++;} EDO
          | EDO EQ {strcpy(dotemp[ido],yytext);ido++;} EDO
          | EDO NE {strcpy(dotemp[ido],yytext);ido++;} EDO
          | EDO OR {strcpy(dotemp[ido],yytext);ido++;} EDO
          | EDO AND {strcpy(dotemp[ido],yytext);ido++;} EDO
          | ID  {strcpy(dotemp[ido],yytext);ido++;}
          | NUM {strcpy(dotemp[ido],yytext);ido++;} 
          ;
L1DO        : NUM { strcpy(dotemp[ido],"+");ido++;    strcpy(dotemp[ido],yytext);ido++;}
          | '+' { strcpy(dotemp[ido],"+");ido++;    strcpy(dotemp[ido],yytext);ido++;}
          ;
L2DO        : NUM { strcpy(dotemp[ido],"-");ido++;    strcpy(dotemp[ido],yytext);ido++;}
          | '-' { strcpy(dotemp[ido],"-");ido++;    strcpy(dotemp[ido],yytext);ido++;}
          ;           
           
           
           
           

ST       : FOR '(' E ';' { printf(";\nWHILE ( "); } E2 {printf(")\n");}  ';' {printf("{\n");}  E3 ')' DEF
           ;
DEF    : '{' BODY '}' { tablep();  printf(";\n}\n");}
           | E';' {printf(";\n");   tablep(); printf(";\n}\n");  }
           | ST
           |
           ;
BODY  : BODY BODY
           | E ';' {printf(" ; \n");}        
           | ST
           |             
           ;        

E3        :E3 '=' {strcpy(temp[i],yytext);i++;} E3 
          | E3  '+'  L3 
          | E3 '-' L4
          | E3 '*' {strcpy(temp[i],yytext);i++;} E3
          | E3 '/' {strcpy(temp[i],yytext);i++;} E3
          | ID  {strcpy(temp[i],yytext);i++;}
          | NUM {strcpy(temp[i],yytext);i++;}
          ;
L3        : NUM {strcpy(temp[i],"+");i++;  strcpy(temp[i],yytext);i++;}
          | '+' {strcpy(temp[i],"+");i++;  strcpy(temp[i],yytext);i++;}
          ;
L4        : NUM {strcpy(temp[i],"-");i++;  strcpy(temp[i],yytext);i++;}
          | '-' {strcpy(temp[i],"-");i++;   strcpy(temp[i],yytext);i++;}
          ;


        
        

E        :E '=' {printf("%s",yytext);} E 
          | E  '+'  L1 
          | E '-' L2
          | E '*' {printf("%s",yytext);} E
          | E '/' {printf("%s",yytext);} E
          | E '<' {printf("%s",yytext);} E
          | E '>' {printf("%s",yytext);} E
          | E LE E
          | E GE E
          | E EQ E
          | E NE E
          | E OR E
          | E AND E
          | ID  {printf("%s",yytext);}
          | NUM {printf("%s",yytext);}
          ;
L1        : NUM {printf("+%s",yytext);}
          | '+' {printf("+%s",yytext);}
          ;
L2        : NUM {printf("-%s",yytext);}
          | '-' {printf("-%s",yytext);}
          ;
E2     : E2 '<'{printf("%s",yytext);} E2
         | E2 '>' {printf("%s",yytext);} E2
         | E2 LE E2
         | E2 GE E2
         | E2 EQ E2
         | E2 NE E2
         | E2 OR E2
         | E2 AND E2
         | ID  {printf("%s",yytext);}
         | NUM {printf("%s",yytext);}
         ;    
%%

#include "lex.yy.c"
main() {
    //printf("Enter the expression:\n");
    yyparse();
}
void tablep()
{
  for(j=i-3;j<i;j++)
    printf("%s",temp[j]);
  i=i-3;
} 
void display()
{
  printf("\n");
   for(j=0;j<ido;j++)
   {
     printf("%s ",dotemp[j]);
     if(strcmp(dotemp[j],";")==0)
       printf("\n");
    }
  
}
void display2()
{
   printf("WHILE(");
   for(j=0;j<ido1;j++)
     printf("%s",dotemp1[j]);
   printf(")\n{\n");

}     
      

