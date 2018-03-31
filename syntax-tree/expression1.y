%{
#include <stdio.h>
#include <stdlib.h>
extern char *yytext;
void insert();
struct node*  insertterminal();
void inorder(struct node *t);
void insertsys(char val[]);
void prin();
void createtree();
int expv(char val[]);
struct node
{
    char ter[100];
    struct node *left,*right;
};

struct node *root;
struct node* feb[100];

char tempval[100];
char str[100][30];
int top=0;
int inx=0;
%}
%token NUM ID 
%right "="
%left "+" "-"
%left "*" "/"
%right UMINUS

%%

S : ID {insert();} '=' {insertsys("=");} E {createtree();}
  ;
E : E '+'  T {insertsys("+");}
   | E '-' T {insertsys("-");}
   | T
   ;
T : T '*' F {insertsys("*");}
   | T '/'  F  {insertsys("/");}
   | F 
   ;
F : '(' E ')'
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
   strcpy(str[++top],yytext);
}
void insertsys(char val[])
{
   strcpy(str[++top],val);
}
void prin()
{ 
    int i;
    for(i=1;i<=top;i++)
      printf("%s   ",str[i]);

   printf("\n");
   

}
int expv(char val[])
{
    if( val[0]=='+' || val[0]=='-' || val[0]=='*' || val[0]=='/' )
       return 1;
    return 0;
}
void createtree()
{
    int i;
    for(i=3;i<=top;i++)
    {
         //printf("%d\n",expv(str[i]));
         if(expv(str[i])==0)
         {
            struct node * t1=insertterminal(str[i]);
	    //inx++;
            //printf("%s\n",t1->ter);
            feb[inx++]=t1;
         }
        else
         {
             struct node *t2=insertterminal(str[i]);
             //printf("%s\n",t2->ter);
            
             t2->right=feb[inx-1];
	    
             t2->left=feb[inx-2];
             inx=inx-2;
             feb[inx++]=t2;   
         }

    }
    struct node *t3=insertterminal(str[1]);
     struct node *t4=insertterminal(str[2]);
    t4->left=t3;
    t4->right=feb[0];
   //prin();
   printf("inorder traversal of syntax tree\n");
    inorder(t4);
    printf("\n");

}
void inorder(struct node *t)
{
    if(t)
   {
      inorder(t->left);

      printf("%s",t->ter);
      inorder(t->right);

   }
}
struct node * insertterminal(char val[])
{
    strcpy(tempval,val);
    struct node *t=(struct node*)malloc(sizeof(struct node));
    strcpy(t->ter,tempval);
    t->left=t->right=NULL;
    return t;
}


