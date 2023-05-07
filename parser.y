%{
#include <stdio.h>
#include <stdlib.h>
extern int yylex(void);
extern char *yytext;
void yyerror(char *);
int variables[26];
%}




%token INTEGER
%token STRING
%token TEXT
%token EOL
%token ID
%token PRINT
%token BOOLEAN
%token TRUE FALSE
%left IF ELSE FOR
%left AND OR
%nonassoc NOT
%left '+' '-'
%left '*' '/'
%nonassoc '='
%nonassoc '<' '>' 
%nonassoc EQ NEQ LE GE

%%

program:
    /* empty */
    | program line
    ;

line:
    EOL
    | expr EOL { printf("= %d\n", $1); }
    ;

expr:
    INTEGER 
    | ID              { $$ = variables[$1];  }
    | ID '=' expr     { variables[$1] = $3; $$ = $3; }
    | '(' expr ')'    { $$ = $2; }
    | expr '+' expr   { $$ = $1 + $3; }
    | expr '-' expr   { $$ = $1 - $3; }
    | expr '*' expr   { $$ = $1 * $3; }
    | expr '/' expr   { $$ = $1 / $3; }
    STRING
    | 'p' '(' expr ')' { printf("%d\n", $3); }      
    | TRUE           { $$ = 1; }
    | FALSE          { $$ = 0; }
    | expr AND expr  { $$ = ($1 && $3); }
    | expr OR expr   { $$ = ($1 || $3); }
    | NOT expr       { $$ = !$2; }
    | expr '<' expr  { $$ = ($1 < $3); }
    | expr '>' expr  { $$ = ($1 > $3); }
    | expr EQ expr   { $$ = ($1 == $3); }
    | expr NEQ expr  { $$ = ($1 != $3); }
    | expr LE expr   { $$ = ($1 <= $3); }
    | expr GE expr   { $$ = ($1 >= $3); }
    | IF '(' expr ')' expr ELSE expr 
        { $$ = $3 ? $5 : $7; }
    
    ;
%%

int main(void) {
    yyparse();
    return 0;
}

void yyerror(char *s) {
    fprintf(stderr, "error: %s\n", yytext);
}
