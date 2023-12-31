grammar ifcc;

axiom: function* prog function*;

block:
	'{' (
		assignment
		| declaration
		| callFunction ';'
		| if_stmt
		| while_stmt
		| returnstmt
		| stat_block
		| putchar
	)* returnstmt? '}';

function:
	type VAR '(' declParams? ')' ';'	# functiondecl
	| type VAR '(' defParams? ')' block	# functiondef;

putchar: 'putchar(' expr ')' ';';

declParams: type VAR (',' type VAR)*;
defParams: type VAR (',' type VAR)*;

callFunction: VAR '(' args? ')';

args: expr (',' expr)*;

prog:
	'int' 'main' '(' ')' '{' (
		assignment
		| declaration
		| callFunction ';'
		| if_stmt
		| while_stmt
		| returnstmt
		| stat_block
		| putchar
	)* returnstmt '}';

returnstmt: 'return' expr? ';';

declaration: type VAR (',' VAR)* ('=' expr)? ';';

assignment: VAR '=' expr ';';

if_stmt:
	'if' '(' expr ')' stat_block (
		'else if' '(' expr ')' stat_block
	)* ('else' stat_block)?;

stat_block:
	'{' (
		assignment
		| declaration
		| if_stmt
		| while_stmt
		| returnstmt
		| callFunction ';'
		| stat_block
		| putchar
	)* '}';

while_stmt: 'while' '(' expr ')' stat_block;

expr:
	op = ('-' | '!') expr										# unaryexpr
	| expr op = ('*' | '/' | '%') expr							# muldiv
	| expr op = ('+' | '-') expr								# addsub
	| expr op = ('<' | '>' | '==' | '!=' | '<=' | '>=') expr	# compexpr
	| expr op = ('&' | '|' | '^') expr							# bitexpr
	| CONST														# constexpr
	| VAR														# varexpr
	| CHAR														# charexpr
	| '(' expr ')'												# parexpr
	| callFunction												# callexpr;

type: 'void' # voidtype | 'int' # inttype | 'char' # chartype;

CHAR: '\'' . '\'';
CONST: [0-9]+;
VAR: ([a-zA-Z_][a-zA-Z0-9_]*);
COMMENT: ('/*' .*? '*/' | '//' .*? '\n') -> skip;
DIRECTIVE: '#' .*? '\n' -> skip;
WS: [ \t\r\n] -> channel(HIDDEN);
