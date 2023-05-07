%{
#include "parser.tab.h"
%}



%%


[ \t]   ;    /* skip whitespace */
"print"   { return PRINT; }
"true"   { return TRUE; }
"false"   { return FALSE; }
"if"   { return IF; }
"else"   { return ELSE; }
"for"   { return FOR; }
"AND"   { return AND; }
"OR"   { return OR; }
"NOT"   { return NOT; }

"<"     { return '<'; }
">"     { return '>'; }
"<="    { return LE; }
">="    { return GE; }
"=="    { return EQ; }
"!="    { return NEQ; }

\".*\"    { yylval.strval = yytext; return TEXT; }
[a-zA-Z]+ { yylval = *yytext - 'a'; return ID; }
[0-9]+  { yylval = atoi(yytext); return INTEGER; }
[\n]    { return EOL; }
.       { return yytext[0]; }


%%

int yywrap(void) {
    return 1;
}
