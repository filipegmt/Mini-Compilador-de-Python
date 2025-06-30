parser grammar PythonParser;

options { tokenVocab=PythonLexer; }

// Ponto de entrada: múltiplas instruções até EOF
code: (stat NEWLINE?)* EOF;

// Linha de código: uma ou mais instruções
stat: simple_stat | compound_stat;

// Instruções simples
simple_stat
    : expr
    | query
    | function_call
    ;

// Instruções compostas
compound_stat
    : conditional
    | function
    | while_loop
    | for_loop
    ;

// Consultas booleanas e relacionais
query
    : 'True'
    | 'False'
    | NOT query
    | query (AND | OR) query
    | '(' query ')'
    | comparison
    ;

comparison
    : expr rel_op expr
    ;

rel_op
    : '<' | '>' | '<=' | '>=' | '==' | '!='
    ;

// Condicional if / elif / else
conditional
    : 'if' query ':' NEWLINE? stat+
      ('elif' query ':' NEWLINE? stat+)* 
      ('else' ':' NEWLINE? stat+)?
    ;

// Definição de função
function
    : 'def' ID '(' arg_list? ')' ':' NEWLINE? 'return' expr? NEWLINE?
    ;

arg_list
    : ID (',' ID)*
    ;

// Chamada de função
function_call
    : ID '(' call_args? ')'
    ;

call_args
    : expr (',' expr)*
    ;

// Estrutura while
while_loop
    : 'while' query ':' NEWLINE? stat+
    ;

// Estrutura for com range
for_loop
    : 'for' ID 'in' 'range' '(' expr (',' expr)? (',' expr)? ')' ':' NEWLINE? stat+
    ;

// Expressões
expr
    : ID
    | NUMBER
    | expr (PLUS | MINUS | TIMES | DIVIDE | MOD | POWER) expr
    | LPAREN expr RPAREN
    | 'None'
    ;
