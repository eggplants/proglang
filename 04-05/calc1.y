%{
#define YYSTYPE double
%}
%left	'+' '-'
%left	'*' '/'
%%
lines:	/* empty */
	| lines '\n'
	| lines expr '\n' { printf("\t%f\n", $2); }
	;
expr:	number { $$ = $1; }
	| expr '+' expr { $$ = $1 + $3; }
	| expr '-' expr { $$ = $1 - $3; }
	| expr '*' expr { $$ = $1 * $3; }
	| expr '/' expr { $$ = $1 / $3; }
	| '(' expr ')'  { $$ = $2; }
	;
number: digit_sequence { $$ = $1; }
	;
digit_sequence: digit { $$ = $1; }
	| digit_sequence digit { $$ = 10 * $1 + $2; }
	;
digit: '0' { $$ = 0; }
	| '1' { $$ = 1; }
	| '2' { $$ = 2; }
	| '3' { $$ = 3; }
	| '4' { $$ = 4; }
	| '5' { $$ = 5; }
	| '6' { $$ = 6; }
	| '7' { $$ = 7; }
	| '8' { $$ = 8; }
	| '9' { $$ = 9; }
	;	
%%
#include <stdio.h>
#include <ctype.h>

int main(int argc, char *argv[])
{
	yyparse();
}

int yylex()
{
	int c = getchar();
	if (c == EOF)
		return 0;
	return c;
}


int yyerror(char *s)
{
	fprintf(stderr, "calc1: %s\n", s);
}

/* eof */
