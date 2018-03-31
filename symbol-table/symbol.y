%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
void insertsymbol(int val,char ch);
void printtable();
extern char * yytext;
char temp[100];
char symbol[100][100];
char declare[100];
int i=0,j,flag;
int type[100];
char sak[100];
char values[100][100];
int scope[100];
int cat=0;


%}

%token INT FLOAT DOUBLE CHAR ID NUM

%%
S   : ST      { printtable();	} ;
ST    : '{' {cat++;} START '}' {cat--;} ;
START : START START 
      | SA
      | ST
      
      ;
SA    :  INT L1 ';' 
      |  FLOAT L2 ';'
      |  DOUBLE L3 ';'
      |  CHAR L4 ';'
      
      ;
L1    :  L1 ',' ID { strcpy(temp,yytext); } E1    
      | ID { strcpy(temp,yytext); } E1 
     
      ;
E1    : '=' NUM {strcpy(sak,yytext); insertsymbol(0,'Y'); }
      | {insertsymbol(0,'N');}
      ;
L2    : L2 ',' ID { strcpy(temp,yytext); } E2 
      | ID { strcpy(temp,yytext);  } E2
      ;
E2    : '=' NUM {strcpy(sak,yytext); insertsymbol(1,'Y'); }
      | {insertsymbol(1,'N');}      
      ; 
      
L3    : L3 ',' ID {strcpy(temp,yytext); } E3
      | ID {strcpy(temp,yytext); } E3
      ;
E3    : '=' NUM {strcpy(sak,yytext); insertsymbol(2,'Y');}
      | {insertsymbol(2,'N');}
      ;
            
      
L4    : L4 ',' ID {strcpy(temp,yytext); } E4
      | ID {strcpy(temp,yytext); } E4
      ;
E4    : '=' NUM { strcpy(sak,yytext); insertsymbol(3,'Y');}
      | {insertsymbol(3,'N');}
      ;
%%

#include "lex.yy.c"

int main() {
    //printf("Enter the expression:\n");
    yyparse();    
    return 0;
}
void insertsymbol(int val, char ch)
{
    flag=0;
    for(j=0;j<i;j++)
    {
       if(strcmp(temp,symbol[j])==0 && scope[j]==cat )
        flag=1;
    }
    if(flag==0)
    {
        strcpy(symbol[i],temp);
        type[i]=val;
        scope[i]=cat;
        //declare[i]='N';
        if(ch=='Y')
        {
            strcpy(values[i],sak);
            declare[i]='Y';
        }
        else
        {
           strcpy(values[i],"0");
           declare[i]='N';           
        }
        
        i++;
    }
    else
    {
       printf("Already decleared == %s \n",temp);
    }
    
}
void printtable()
{
   for(j=0;j<i;j++)
   {
     if(type[j]==0) {printf("INT  ");}
     else if(type[j]==1) {printf("FLOAT  ");}
     else if(type[j]==2) {printf("DOUBLE  ");}
     else if(type[j]==3) {printf("CHAR  ");}
     printf("%s  %c  %s %d\n",symbol[j],declare[j],values[j],scope[j]);
     
   }
} 
