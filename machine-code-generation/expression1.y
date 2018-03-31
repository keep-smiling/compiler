%{
#include <stdio.h>
#include <stdlib.h>
extern char *yytext;
void insert();
struct node*  insertterminal();
void inorder(struct node *t);
void postorder(struct node *t);
int min(int a,int b);
void codegen(struct node *t,int b);
void insertsys(char val[]);
void prin();
void createtree();
int expv(char val[]);
struct node
{
    char ter[100];
    int lab;
    struct node *left,*right;
};

struct node *root;
struct node* feb[100];

char tempval[100];
char str[100][30];
int top=0;
int inx=0;
int res[100];
int r=0;
%}
%token NUM ID 
%right "="
%left "+" "-"
%left "*" "/"
%right UMINUS

%%

S : E {createtree();}
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
    for(i=1;i<=top;i++)
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
    //struct node *t3=insertterminal(str[1]);
     //struct node *t4=insertterminal(str[2]);
    //t4->left=t3;
    //t4->right=feb[0];
   //prin();
   printf("inorder traversal of syntax tree\n");
    inorder(feb[0]);
    postorder(feb[0]);
   printf("After Modification : \n");
   inorder(feb[0]);
   codegen(feb[0],1);

    printf("\n");

}
void inorder(struct node *t)
{
   
   if(t)
   {
      inorder(t->left);

      printf("%s \t %d \n",t->ter,t->lab);
      inorder(t->right);

   }   

}
void postorder(struct node *t)
{
    if(t->left==NULL && t->right==NULL)
   {
      t->lab=1;
      return;
   }
   postorder(t->left);
   postorder(t->right);
   int sav=min(t->left->lab,t->right->lab);
   t->lab=sav+1;
}
int min(int a,int b)
{
   if(a<b)
     return a;
   return b;
}
struct node * insertterminal(char val[])
{
    strcpy(tempval,val);
    struct node *t=(struct node*)malloc(sizeof(struct node));
    strcpy(t->ter,tempval);
    t->lab=0;
    t->left=t->right=NULL;
    return t;
}
void codegen(struct node *t,int b)
{
    if(t->left==NULL && t->right==NULL)
   {
       printf("LD   R%d  %s\n",b,t->ter);
       res[r++]=b;
       return;

   }
     else if(t->left->lab == t->right->lab)
    {
          
        codegen(t->left,b+1);
        codegen(t->right,b);
        char aaa[1000];
        if(strcmp(t->ter,"+"))
            strcpy(aaa,"ADD");
        
        else if(strcmp(t->ter,"-"))
            strcpy(aaa,"SUB");

        else if(strcmp(t->ter,"*"))
            strcpy(aaa,"MUL");

        else if(strcmp(t->ter,"/"))
            strcpy(aaa,"DIV");

       printf("%s  R%d  R%d  R%d\n",aaa,res[r-2],res[r-1],res[r-2]);
       r--;
    }
   else 
    {
          
        
        codegen(t->right,b);
        codegen(t->left,b);
        char aaa[1000];
        if(strcmp(t->ter,"+"))
            strcpy(aaa,"ADD");
        
        else if(strcmp(t->ter,"-"))
            strcpy(aaa,"SUB");

        else if(strcmp(t->ter,"*"))
            strcpy(aaa,"MUL");

        else if(strcmp(t->ter,"/"))
            strcpy(aaa,"DIV");

       printf("%s  R%d  R%d  R%d\n",aaa,res[r-2],res[r-1],res[r-2]);
       r--;
    }
  

}

