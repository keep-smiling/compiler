

alpha [A-Za-z]
digit [0-9]

%%
[\t \n]
{alpha}({alpha}|{digit})* return ID;
{digit}+  { return NUM;}
.  return yytext[0];  


%%
