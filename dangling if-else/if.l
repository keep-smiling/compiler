ALPHA [A-Za-z]
DIGIT [0-9]
%%
[ \t\n]          { printf("%s ",yytext); }
if               { printf("%s ",yytext); return IF; }
then              { printf("%s ",yytext);  return THEN; }
else              { printf("}\n%s ",yytext);  return ELSE; }
{DIGIT}+           { printf("%s ",yytext); return NUM; }
{ALPHA}({ALPHA}|{DIGIT})*        { printf("%s ",yytext); return ID; }
"<="                { printf("%s ",yytext); return LE; }
">="                { printf("%s ",yytext); return GE; }
"=="                { printf("%s ",yytext); return EQ; }
"!="                { printf("%s ",yytext); return NE; }
"||"                { printf("%s ",yytext); return OR; }
"&&"                { printf("%s ",yytext); return AND; }
"}"                 return yytext[0];
.                { printf("%s ",yytext); return yytext[0]; }
%%
