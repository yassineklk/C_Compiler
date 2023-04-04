grammar ifcc;

axiom: prog;

prog:
	'int' 'main' '(' ')' '{' (assignment | declaration)* returnstmt '}';

returnstmt: 'return' expr ';';

declaration: 'int' VAR (',' VAR)* ('=' expr)? ';';

assignment: VAR '=' expr ';';

expr:
	expr op=('*' | '/') expr					# muldiv
	| expr op=('+' | '-') expr					# addsub
	| expr op=('&' | '|' | '^') expr			# bitexpr
	| expr op=('<' | '>' | '==' | '!=') expr	# compexpr
	| op=('-' | '!') expr						# unaryexpr
	| CONST										# constexpr
	| VAR										# varexpr
	| '(' expr ')'								# parexpr;

CONST: [0-9]+;
COMMENT: '/*' .*? '*/' -> skip;
DIRECTIVE: '#' .*? '\n' -> skip;
WS: [ \t\r\n] -> channel(HIDDEN);
VAR: ([a-zA-Z_][a-zA-Z0-9_]*);