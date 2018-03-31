%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#define atoa(x) #x
extern char *yytext;


struct list
{
  int n;
  struct list *next;
};

struct Bnode
{
  struct list *t;
  struct list *f;
  //struct Bnode *next;
};


struct treenode
{
   char str[1000];
   char op[1000];
   struct treenode *next;
};

struct treenode *arr[10000];
int index1=0;

struct res
{
   int n;
   char str[1000];
   int n3;
   char boc[100];
   struct res *next;
};
struct res *first=NULL;
struct Bnode *ro[1000];
int marker[100];
int nextinstr=100;
int top=0;
int inx=0;

char temp1[1000];
char temp2[1000];
char temp3[1000];
void fun1(char t1[1000],char t2[1000],char t3[1000]);
void makelist1(int n1,char t1[1000],char t2[1000],char t3[1000]);
void makelist2(int n1);
void print();
void fun2();
void fun3();
void fun4();
void fun5();
void fun6();
void fun7();
void fun8();
void fun12(int val);
void fun9();
void fun10();
void fun11();
void fun13();
void fun14();
void fun15();
void fun16();
void fun17();
void fun18();
void printq();
void backpatch1(struct list *t);
void backpatch2(struct list *t);
struct list * merge1(struct list *f1,struct list *f2);
struct list * merge2(struct list *t1,struct list *t2);

char op[1000][1000];
char arg1[1000][1000];
char arg2[1000][1000];
char result[1000][1000];
int shakthi=0;

struct list *s[1000];
struct list *l[1000];
struct list *N[1000];
int top1=0;
int top2=0;
int top3=0;

//expression

void insert();
void code();
void codeminus();
void codeassign();
int tope=0;
char str[100][30];
char i[2]="0";
char tempo[100];

//array expression

void insertarray();
void codearray();
void codearrayminus();
void codearrayassign();
int toparray=0;
char strarray[100][30];
char iarray[2]="0";
char temparray[100];
void last();
void last1();
void last2();
void last3();
int valarray=1;

%}

%token NUM ID AND OR NOT LT LE GT GE TR FL IF ELSE WHILE EQ NE
%right "="
%left "+" "-"
%left "*" "/"
%right UMINUS

%%
P : S {print(); printq();};

S : IF '(' B ')' M S H 

  | WHILE M '(' B ')' M S{fun10();}
 
  | '{' L '}' {s[top1++]=l[top2-1]; top2--;}

  | A { struct list *v1=NULL; s[top1++]=v1;}
  
  ;

A : S1;
S1 : H1 '=' E1 {codearrayassign();} ';'
  | L1 {last2();} '=' E1 {codearrayassign();} ';'
  ;
E1 : E1 '+' {insertarray();} T1 {last3();} 
  | E1 '-' {insertarray();} T1 {last3();}
  | T1
  | L1 {last2();}
  ;
T1 : T1 '*' {insertarray();} F1 {last3();}
   | T1 '/' {insertarray();} F1 {last3();} 
   | F1 
   | L1 {last2();}
   ;
F1 : '(' E1 ')'
   | '-' {insertarray();} F1 {codearrayminus();}
   | L1{last2();}
   | H1
   ;
L1 : H1 '[' E1 ']' {last1();} 
  | L1 '[' E1 ']' {last();}
   
  ;
H1 : ID{insertarray();} 
   | NUM{insertarray();};
N : {fun7();};

L : L M S {backpatch1(l[top2-1]);top2--;l[top2++]=s[top1-1];top1--;}

  | S  {l[top2++]=s[top1-1];top1--;}

  ; 
H : N ELSE M S{fun9();}
  
  | {fun8();}
  
  ;
B : B OR M B {fun4();}
  
  | B AND M B {fun3();}

  | NOT B {fun2();}

  | '(' B ')'

  | ID {strcpy(temp1,yytext);} H1  NUM { strcpy(temp3,yytext); fun1(temp1,temp2,temp3); } 

  | TR { fun5();}
 
  | FL {fun6();}
  ;
H1 : LT {strcpy(temp2,"<");}
   | LE {strcpy(temp2,"<=");}
   | GT {strcpy(temp2,">");}
   | GE {strcpy(temp2,">=");} 
   | EQ {strcpy(temp2,"==");}
   | NE {strcpy(temp2,"!=");} 
  ;
M :  {marker[inx++]=nextinstr;} ;


%%

#include "lex.yy.c"
int main()
{
  yyparse();
  return 0;
} 
void fun8()
{
 struct Bnode *b=ro[top-1];
 top--;
 backpatch1(b->t);
 struct list *temp=merge1(b->f,s[top1-1]);
 s[top1-1]=temp;
}
void fun9()
{
  struct Bnode *b=ro[top-1];
 top--;
  backpatch1(b->f);
  backpatch1(b->t);
  struct list *tem1=merge1(s[top1-2],N[top3-1]);
  top3--;
  struct list *tem2=merge1(tem1,s[top1-1]);
  top1=top1-2;
  s[top1++]=tem2;
}
void fun11()
{
//printf("%d : %s %s %s \n",nextinstr,temp1,temp2,temp3);

struct res *temp=(struct res *)malloc(sizeof(struct res));
  temp->n=nextinstr;
  temp->n3=0; 
 strcpy(temp->str,temp1);
    strcat(temp->str," ");
    strcat(temp->str,temp2);
    strcat(temp->str,"  ");
    strcat(temp->str,temp3);
    //strcat(temp->str,"  goto  ");
  if(first==NULL)
  {
    
    first=temp;
  }  
  else
 {
  struct res *temp2=first;
  while(temp2->next)
  {
     temp2=temp2->next;
  }
  temp2->next=temp;
  }
nextinstr++;
}
void fun10()
{
  struct Bnode *b=ro[top-1];
 top--;
   backpatch1(b->t);
  int val=marker[inx-1];
   backpatch1(s[top1-1]);
  
  s[top-1]=b->f;
 //printf("%d : goto %d",nextinstr,marker[inx-1]);
 fun12(val);
 inx--;
   
}
void fun12(int val)
{
  struct res *temp=(struct res *)malloc(sizeof(struct res));
  temp->n=nextinstr;
  temp->n3=val; 
 strcpy(temp->str," goto  ");
  if(first==NULL)
  {
    
    first=temp;
  }  
  else
 {
  struct res *temp2=first;
  while(temp2->next)
  {
     temp2=temp2->next;
  }
  temp2->next=temp;
  }  

}
void fun7()
{
  struct list *temp=(struct list*)malloc(sizeof(struct list));
  temp->n=nextinstr;
  temp->next=NULL;
  makelist2(nextinstr);
  nextinstr++;
  N[top3++]=temp;
}
void fun5()
{
  struct Bnode *root=(struct Bnode *)malloc(sizeof(struct Bnode));
   root->t=(struct list * )malloc(sizeof(struct list));
   root->f=NULL;
    root->t->n=nextinstr;
   root->t->next=NULL;
   makelist2(nextinstr);
   ro[top++]=root;
  
}
void fun6()
{
  struct Bnode *root=(struct Bnode *)malloc(sizeof(struct Bnode));
   root->f=(struct list * )malloc(sizeof(struct list));
   root->t=NULL;
    root->f->n=nextinstr;
   root->f->next=NULL;
   makelist2(nextinstr);
   ro[top++]=root;
  
}
void fun4()
{
   struct Bnode *root=(struct Bnode *)malloc(sizeof(struct Bnode));
   root->t=(struct list * )malloc(sizeof(struct list));
   root->f=(struct list * )malloc(sizeof(struct list));

   struct Bnode *b1=ro[top-2];
   struct Bnode *b2=ro[top-1];
   backpatch2(b1->f);
   root->t=merge2(b1->t,b2->t);
   root->f=b2->f;

   top=top-2;
   ro[top++]=root;

}
void backpatch2(struct list *t)
{
   int val=marker[inx-1];
   inx--;
   while(t)
   {
    struct res *temp=first;
    while(temp)
   {
       if(temp->n==t->n)
           temp->n3=val;
     temp=temp->next;
   }
    t=t->next;
   }

}
struct list * merge2(struct list *f1,struct list *f2)
{
    struct list *temp=f1;
    if(temp==NULL)
       return f2;
    while(temp->next)
    {
       temp=temp->next;
    }
    temp->next=f2;
    return f1;
}
void fun3()
{
  struct Bnode *root=(struct Bnode *)malloc(sizeof(struct Bnode));
   root->t=(struct list * )malloc(sizeof(struct list));
   root->f=(struct list * )malloc(sizeof(struct list));

   struct Bnode *b1=ro[top-2];
   struct Bnode *b2=ro[top-1];
   backpatch1(b1->t);

   root->t=b2->t;
   root->f=merge1(b1->f,b2->f);

   top=top-2;
   ro[top++]=root;
   
  
}
struct list * merge1(struct list *f1,struct list *f2)
{
    struct list *temp=f1;
    if(temp==NULL)
       return f2;
    while(temp->next)
    {
       temp=temp->next;
    }
    temp->next=f2;
    return f1;
}
void backpatch1(struct list *t)
{
   int val=marker[inx-1];
   inx--;
   while(t)
   {
    struct res *temp=first;
    while(temp)
   {
       if(temp->n==t->n)
           temp->n3=val;

     temp=temp->next;
   }
    t=t->next;
   }

}

void fun2()
{
   struct Bnode *root=(struct Bnode *)malloc(sizeof(struct Bnode));
   root->t=(struct list * )malloc(sizeof(struct list));
   root->f=(struct list * )malloc(sizeof(struct list));

   struct Bnode *temp=ro[top-1];
   root->t=temp->f;
   root->f=temp->t;
   ro[top-1]=root;
}
void fun1(char t1[1000],char t2[1000],char t3[1000])
{
   struct Bnode *root=(struct Bnode *)malloc(sizeof(struct Bnode));
   root->t=(struct list * )malloc(sizeof(struct list));
   root->f=(struct list * )malloc(sizeof(struct list));
   root->t->n=nextinstr;
   root->t->next=NULL;
   makelist1(nextinstr,t1,t2,t3);

   nextinstr++;
   root->f->n=nextinstr;
   root->f->next=NULL;
   makelist2(nextinstr);
   nextinstr++;
   ro[top++]=root;

}
void makelist1(int n1, char t1[1000],char t2[1000], char t3[1000])
{
  struct res *temp=(struct res *)malloc(sizeof(struct res));
  temp->n=n1;
  temp->n3=0;
    strcpy(temp->str,"if  ");
    strcat(temp->str,t1);
    strcat(temp->str,"  ");
    strcat(temp->str,t2);
    strcat(temp->str,"  ");
    strcat(temp->str,t3);
    strcat(temp->str,"  goto  ");
    //////////////////////////////////////////////////
    
    /*strcpy(temparray,"t");
    strcat(temparray,iarray);
    //printf("%d : %s = %s %s %s \n",nextinstr,temparray,strarray[toparray-2],strarray[toparray-1],strarray[toparray]);
    //fun13();
    strcpy(op[shakthi],t2);
    strcpy(arg1[shakthi],t1);
    strcpy(arg2[shakthi],t3);
    strcpy(result[shakthi],temparray);
    shakthi++;
    //toparray=toparray-2;
    //nextinstr++;
    strcpy(strarray[toparray++],temparray);
   iarray[0]++;
    strcpy(op[shakthi],"if ");
    strcpy(arg1[shakthi],t1);
    strcpy(arg2[shakthi],t3);
    strcpy(result[shakthi],temparray);
    shakthi++;*/
    
    //////////////////////////////////////////////////
    
    
  if(first==NULL)
  {
    
    first=temp;
  }  
  else
 {
  struct res *temp2=first;
  while(temp2->next)
  {
     temp2=temp2->next;
  }
  temp2->next=temp;
  }


}

void makelist2(int n1)
{

    struct res *temp=(struct res *)malloc(sizeof(struct res));
    temp->n=n1;
    temp->n3=0;
     strcpy(temp->str,"goto  ");
   if(first==NULL)
  {
     first=temp;
   }
   else
  {
     struct res *temp2=first;
     while(temp2->next)
     {
          temp2=temp2->next;
     }
     temp2->next=temp;
  }

}
void print()
{
   struct res *temp=first;
   while(temp)
  {
     if(temp->n3!=0)
        printf("%d : %s  %d\n",temp->n,temp->str,temp->n3);
     else
        printf("%d : %s \n",temp->n,temp->str);
     temp=temp->next;
   }

  struct res *ts=(struct res *)malloc(sizeof(struct res));
  ts->n=ts->n3=0;
  strcpy(ts->str,"B");
  ts->next=first;
  first=ts;

  temp=first;
  while(temp)
  {
     if(temp->n3!=0 && temp->n3!=100)
     {
         int val=temp->n3-1;
         struct res *tem2=first;
         while(tem2)
         {
             if(tem2->n==val)
                break;
           tem2=tem2->next;
         }
         struct res *ts1=(struct res *)malloc(sizeof(struct res));
         ts1->n=ts1->n3=0;
         strcpy(ts1->str,"B");
         ts1->next=tem2->next;
         tem2->next=ts1;
        
         struct res *ts2=(struct res *)malloc(sizeof(struct res));
         ts2->n=ts2->n3=0;
         strcpy(ts2->str,"B");
         ts2->next=temp->next;
         temp->next=ts2;
     }
    temp=temp->next;
     
  }

printf("\n\n");
  temp=first;
  int block=1;
   while(temp)
  {
    if(temp->n==0)
     {
       temp->n3=block;
         block++;
     }
     temp=temp->next;
   }
  temp=first;
  while(temp)
  {
     if(temp->n3>100)
    {
        int val=temp->n3-1;
        struct res *tem2=first;
       while(tem2)
      {
          if(tem2->n==val)
            break;
          tem2=tem2->next;
       }
       tem2=tem2->next;
       strcpy(temp->boc,"B");
       temp->n3=tem2->n3;
       
     } 
     if(temp->n3==100)
     {
         strcpy(temp->boc,"B");
         temp->n3=1;
     } 
     
      
     temp=temp->next;
  }

  temp=first;
   while(temp)
  {
     if(temp->n==0)
          printf("%s%d : \n",temp->str,temp->n3);
     else if(temp->n3!=0)
        printf("\t%s  %s%d\n",temp->str,temp->boc,temp->n3);
     else
        printf("\t%s \n",temp->str);
     temp=temp->next;
   }

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
    printf("%d : %s = %s %s %s \n",nextinstr,tempo,str[tope-2],str[tope-1],str[tope]);
    tope=tope-2;
    nextinstr++;
    strcpy(str[tope],tempo);
   i[0]++;
}
void codeminus()
{
   strcpy(tempo,"t");
   //char b=i+'0';
    strcat(tempo,i);
   printf("%d : %s = -%s\n",nextinstr,tempo,str[tope]);
   tope--;
   nextinstr++;
   strcpy(str[tope],tempo);
   i[0]++;

}
void codeassign()
{
   printf("%d : %s = %s\n",nextinstr,str[tope-1],str[tope]);
   nextinstr++;
   tope=tope-2;
}

// array expression

void insertarray()
{
  strcpy(strarray[++toparray],yytext);
  //printf("%s \n",strarray[toparray]);
}
void last3()
{
    strcpy(temparray,"t");
    strcat(temparray,iarray);
    //printf("%d : %s = %s %s %s \n",nextinstr,temparray,strarray[toparray-2],strarray[toparray-1],strarray[toparray]);
    fun13();
    strcpy(op[shakthi],strarray[toparray-1]);
    strcpy(arg1[shakthi],strarray[toparray-2]);
    strcpy(arg2[shakthi],strarray[toparray]);
    strcpy(result[shakthi],temparray);
    shakthi++;
    toparray=toparray-2;
    nextinstr++;
    strcpy(strarray[toparray],temparray);
   iarray[0]++;
}
void codearray()
{
    strcpy(temparray,"t");
    //char a=i+'0';
    strcat(temparray,iarray);
    //printf("%d : %s = %s %s %s \n",nextinstr,temparray,strarray[toparray-2],strarray[toparray-1],strarray[toparray]);
    fun13();
    strcpy(op[shakthi],strarray[toparray-1]);
    strcpy(arg1[shakthi],strarray[toparray-2]);
    strcpy(arg2[shakthi],strarray[toparray]);
    strcpy(result[shakthi],temparray);
    shakthi++;
    toparray=toparray-2;
    nextinstr++;
    strcpy(strarray[toparray],temparray);
   iarray[0]++;
}
void fun13()
{
     struct res *temp=(struct res *)malloc(sizeof(struct res));
  temp->n=nextinstr;
  temp->n3=0; 
 strcpy(temp->str,temparray);
  strcat(temp->str,"="); 
 strcat(temp->str,strarray[toparray-2]);
  strcat(temp->str,strarray[toparray-1]);
   strcat(temp->str,strarray[toparray]);
  if(first==NULL)
  {
    
    first=temp;
  }  
  else
 {
  struct res *temp2=first;
  while(temp2->next)
  {
     temp2=temp2->next;
  }
  temp2->next=temp;
  }  
}
void last()
{
    strcpy(temparray,"t");
    strcat(temparray,iarray);
    //printf("%d : %s = %s * %d\n",nextinstr,temparray,strarray[toparray],valarray);
   fun14();
   // valarray/=4;
   strcpy(op[shakthi],"*");
    strcpy(arg1[shakthi],strarray[toparray]);
    strcpy(arg2[shakthi],"1");
    strcpy(result[shakthi],temparray);
    shakthi++;
   nextinstr++;
    strcpy(strarray[toparray],temparray);
    iarray[0]++;
    strcpy(temparray,"t");
    strcat(temparray,iarray);
    //printf("%d : %s = %s + %s\n",nextinstr,temparray,strarray[toparray-1],strarray[toparray]);
    fun15();
    strcpy(op[shakthi],"+");
    strcpy(arg1[shakthi],strarray[toparray-1]);
    strcpy(arg2[shakthi],strarray[toparray]);
    strcpy(result[shakthi],temparray);
    shakthi++;
    nextinstr++;
    toparray=toparray-1;
    strcpy(strarray[toparray],temparray);
    iarray[0]++;
}
void last1()
{
   strcpy(temparray,"t");
    strcat(temparray,iarray);
    //printf("%d : %s = %s * %d\n",nextinstr,temparray,strarray[toparray],valarray);
   fun14();
   strcpy(op[shakthi],"*");
    strcpy(arg1[shakthi],strarray[toparray]);
    strcpy(arg2[shakthi],"1");
    strcpy(result[shakthi],temparray);
    shakthi++;
   nextinstr++;
   // valarray/=4;
   nextinstr++;
    strcpy(strarray[toparray],temparray);
    iarray[0]++; 
}
void fun14()
{
   struct res *temp=(struct res *)malloc(sizeof(struct res));
  temp->n=nextinstr;
  temp->n3=0; 
 strcpy(temp->str,temparray);
  strcat(temp->str,"="); 
 strcat(temp->str,strarray[toparray]);
 strcat(temp->str,"*");
  strcat(temp->str,"1");
   //strcat(temp->str,strarray[toparray]);
  if(first==NULL)
  {
    
    first=temp;
  }  
  else
 {
  struct res *temp2=first;
  while(temp2->next)
  {
     temp2=temp2->next;
  }
  temp2->next=temp;
  } 
}
void fun15()
{
   struct res *temp=(struct res *)malloc(sizeof(struct res));
  temp->n=nextinstr;
  temp->n3=0; 
 strcpy(temp->str,temparray);
  strcat(temp->str,"="); 
 //strcat(temp->str,strarray[toparray-2]);
  strcat(temp->str,strarray[toparray-1]);
   strcat(temp->str,"+");
   strcat(temp->str,strarray[toparray]);
  if(first==NULL)
  {
    
    first=temp;
  }  
  else
 {
  struct res *temp2=first;
  while(temp2->next)
  {
     temp2=temp2->next;
  }
  temp2->next=temp;
  } 
}


void last2()
{
  strcpy(temparray,"t");
    strcat(temparray,iarray);
   // printf("%d : %s = %s [ %s ] \n",nextinstr,temparray,strarray[toparray-1],strarray[toparray]);
    fun16();
    strcpy(op[shakthi],"=[ ]");
    strcpy(arg1[shakthi],strarray[toparray-1]);
    strcpy(arg2[shakthi],strarray[toparray]);
    strcpy(result[shakthi],temparray);
    shakthi++;
   nextinstr++;
    toparray=toparray-1;
    nextinstr++;
     strcpy(strarray[toparray],temparray);
    iarray[0]++;
}
void fun16()
{
  struct res *temp=(struct res *)malloc(sizeof(struct res));
  temp->n=nextinstr;
  temp->n3=0; 
 strcpy(temp->str,temparray);
  strcat(temp->str,"="); 
 
  strcat(temp->str,strarray[toparray-1]);
  strcat(temp->str,"[");
   strcat(temp->str,strarray[toparray]);
  strcat(temp->str,"]");
  if(first==NULL)
  {
    
    first=temp;
  }  
  else
 {
  struct res *temp2=first;
  while(temp2->next)
  {
     temp2=temp2->next;
  }
  temp2->next=temp;
  }  
}
void codearrayminus()
{
   strcpy(temparray,"t");
   //char b=i+'0';
    strcat(temparray,iarray);
   //printf("%d : %s = -%s\n",nextinstr,temparray,strarray[toparray]);
    strcpy(op[shakthi],"minus");
    strcpy(arg1[shakthi],strarray[toparray]);
    strcpy(arg2[shakthi]," ");
    strcpy(result[shakthi],temparray);
    shakthi++;
   fun17();
   toparray--;
   nextinstr++;
   strcpy(strarray[toparray],temparray);
   iarray[0]++;

}
void fun17()
{
 struct res *temp=(struct res *)malloc(sizeof(struct res));
  temp->n=nextinstr;
  temp->n3=0; 
 strcpy(temp->str,temparray);
  strcat(temp->str,"="); 
 strcat(temp->str,"-");
  //strcat(temp->str,strarray[toparray-1]);
   strcat(temp->str,strarray[toparray]);
  if(first==NULL)
  {
    
    first=temp;
  }  
  else
 {
  struct res *temp2=first;
  while(temp2->next)
  {
     temp2=temp2->next;
  }
  temp2->next=temp;
  } 
}
void codearrayassign()
{
   //printf("%d : %s = %s\n",nextinstr,strarray[toparray-1],strarray[toparray]);
   fun18();
    strcpy(op[shakthi],"=");
    strcpy(arg1[shakthi],strarray[toparray]);
    strcpy(arg2[shakthi]," ");
    strcpy(result[shakthi],strarray[toparray-1]);
    shakthi++;
   nextinstr++;
   toparray=toparray-2;
}
void fun18()
{
 struct res *temp=(struct res *)malloc(sizeof(struct res));
  temp->n=nextinstr;
  temp->n3=0; 
 strcat(temp->str,strarray[toparray-1]);
  strcat(temp->str,"="); 
 //strcat(temp->str,strarray[toparray-2]);
  
   strcat(temp->str,strarray[toparray]);
  if(first==NULL)
  {
    
    first=temp;
  }  
  else
 {
  struct res *temp2=first;
  while(temp2->next)
  {
     temp2=temp2->next;
  }
  temp2->next=temp;
  } 
}
void printq()
{
  int i;
  printf("\n");
  printf("op     arg1     arg2    result\n");
  for(i=0;i<shakthi;i++)
  {
     if( ! (strcmp(op[i],"~")==0) )
      printf("%s\t%s\t%s\t%s\n",op[i],arg1[i],arg2[i],result[i]);
  }
  int j;
  for(i=0;i<shakthi;i++)
  {
    for(j=i+1;j<shakthi;j++)
    {
        if( (strcmp(op[i],op[j])==0) && (strcmp(arg1[i],arg1[j])==0) && (strcmp(arg2[i],arg2[j])==0) )
        {
             int z;
             for(z=j+1;z<shakthi;z++)
             {
                   if(strcmp(arg1[z],result[j])==0) strcpy(arg1[z],result[i]);
                   if(strcmp(arg2[z],result[j])==0) strcpy(arg2[z],result[i]);
               }
               strcpy(op[j],"~");
        }
    }  
  }
  
  for(i=0;i<shakthi;i++)
  {
      if( (strcmp(op[i],"+")==0) && ( (strcmp(arg1[i],"0")==0)  ||  (strcmp(arg2[i],"0")==0)  ) )
      {
          int z;
          char val11[1000];
          if( strcmp(arg1[i],"0")==0 )
            strcpy(val11,arg2[i]);
          else
            strcpy(val11,arg1[i]);
          
          for(z=i+1;z<shakthi;z++)
          {
              if(strcmp(arg1[z],result[i])==0) strcpy(arg1[z],val11);
              if(strcmp(arg2[z],result[i])==0) strcpy(arg2[z],val11);
          
          }
          strcpy(op[i],"~");
      }
  }
  
  for(i=0;i<shakthi;i++)
  {
      if( (strcmp(op[i],"*")==0) && ( (strcmp(arg1[i],"1")==0)  ||  (strcmp(arg2[i],"1")==0)  ) )
      {
          int z;
          char val11[1000];
          if( strcmp(arg1[i],"1")==0 )
            strcpy(val11,arg2[i]);
          else
            strcpy(val11,arg1[i]);
          
          for(z=i+1;z<shakthi;z++)
          {
              if(strcmp(arg1[z],result[i])==0) strcpy(arg1[z],val11);
              if(strcmp(arg2[z],result[i])==0) strcpy(arg2[z],val11);
          
          }
          strcpy(op[i],"~");
      }
  }
  
  
  printf("\n Optimized code \n");
  for(i=0;i<shakthi;i++)
  {
     if( ! (strcmp(op[i],"~")==0) )
      printf("%s\t%s\t%s\t%s\n",op[i],arg1[i],arg2[i],result[i]);
  }
  
  for(i=0;i<shakthi;i++)
  {
     if( ! (strcmp(op[i],"~")==0) )
     {
     // printf("%s\t%s\t%s\t%s\n",op[i],arg1[i],arg2[i],result[i]);
         struct treenode *ts=(struct treenode *)malloc(sizeof(struct treenode));
         arr[index1++]=ts;
         strcpy(ts->str,result[i]);
         strcpy(ts->op,op[i]);
         struct treenode *ts1=(struct treenode *)malloc(sizeof(struct treenode));
         ts->next=ts1;
         strcpy(ts1->str,arg1[i]);
         strcpy(ts1->op,"~");
         struct treenode *ts2=(struct treenode *)malloc(sizeof(struct treenode));
         strcpy(ts2->str,arg1[i]);
         strcpy(ts2->op,"~");
         ts1->next=ts2;
         ts2->next=NULL;
         
         
      }
  }
  struct resvalue 
  {
     char saarr[1000];
     char val[1000];
  };
  int sindex=0;
  struct resvalue* saval[1000];
  for(i=0;i<shakthi;i++)
  {
      if( ! (strcmp(op[i],"~")==0) )
      {
            if( strcmp(op[i],"=")==0 )
            {
                struct resvalue * sat1=(struct resvalue *)malloc(sizeof(struct resvalue));
                strcpy(sat1->saarr,result[i]);
                strcpy(sat1->val,arg1[i]);
                saval[sindex++]=sat1;
                
                int j;
                for(j=0;j<shakthi;j++)
                {
                   if(  strcmp(arg1[j],result[i])==0  )  strcpy(arg1[j],arg1[i]);
                   if(  strcmp(arg2[j],result[i])==0  )  strcpy(arg2[j],arg1[i]);                 
                }            
            }
            else 
            {
                 struct resvalue * sat1=(struct resvalue *)malloc(sizeof(struct resvalue));
                 int ops1=arg1[i][0]-'0';
                 int ops2=arg2[i][0]-'0';
                 int ops3;
                 if( (strcmp(op[i],"+")==0) ) ops3=ops1+ops2;
                 if( (strcmp(op[i],"-")==0) ) ops3=ops1-ops2;
                 if( (strcmp(op[i],"*")==0) ) ops3=ops1*ops2;
                 if( (strcmp(op[i],"/")==0) ) ops3=ops1/ops2;
                 strcpy(sat1->saarr,result[i]);
                 char opres[100];
                 opres[0]=ops3+'0';
                 //itoa(ops3, opres, 10);
                 //strcpy(opres,(char)ops3);
                 strcpy(sat1->val,opres);
                 saval[sindex++]=sat1;
                 
                 int j;
                 for(j=0;j<shakthi;j++)
                 {
                     if(strcmp(arg1[j],result[i])==0 ) strcpy(arg1[j],opres);
                     if(strcmp(arg2[j],result[i])==0 ) strcpy(arg2[j],opres);                 
                 }
                 
            }
            
      
     }
  } 
  printf("Result     value\n");
  for(i=0;i<sindex;i++)
  {
     printf("%s\t%s\n",saval[i]->saarr,saval[i]->val);
  }   
}



