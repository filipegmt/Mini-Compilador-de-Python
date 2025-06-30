parser grammar PythonParser;

options { tokenVocab=PythonLexer; }

// Ponto de entrada: múltiplas instruções terminando com EOF
code: stat* EOF;

// Cada linha de código é uma expressão seguida de quebra de linha
stat: (expr | query | conditional | function | function_call | while | for) NEWLINE?;
query: 'True' | 'False'
    | NOT query
    | query op=(AND | OR) query
    | '('query')'
    | expr ('<' | '>' | '<=' | '>=' | '==' | '!=') expr
    ;

conditional: 'if' query ':' NEWLINE? stat ('elif' query ':' NEWLINE? stat)* ('else' ':' NEWLINE? stat)?
    ;
    
function: 'def' ID '(' (ID | ID (',' ID)*) ')' ':' NEWLINE? 'return' expr? NEWLINE?
    ;
    
function_call: ID '(' (expr | expr ',' expr)?')'
    ;
    
while: 'while' query ':' NEWLINE? stat
    ;

for: 'for' ID 'in' 'range' '(' expr (',' expr)? (',' expr)? ')' ':' NEWLINE? stat
    ;
    
// Definição de expressões suportadas
expr: ID
    | NUMBER
    | expr (PLUS | MINUS | TIMES | DIVIDE | MOD | POWER) expr
    | LPAREN expr RPAREN
    | 'None'
    // ? = 0 ou 1, + = 1 ou Multiplos, * = 0 ou Multiplos
    ;
