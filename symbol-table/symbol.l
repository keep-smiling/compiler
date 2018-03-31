alpha [A-Za-z]
digit [0-9]

%%

[\t \n]
"int"  return INT;
"float" return FLOAT;
"double" return DOUBLE;
"char"   return CHAR;
{digit}+    return NUM;
{alpha}({alpha}|{digit})* return ID;
.                return yytext[0];
