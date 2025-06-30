parser grammar PythonParser;

options { tokenVocab=PythonLexer; }

// Ponto de entrada: múltiplas instruções até EOF
code: (stat | conditional | func | func_call)* EOF;

// Cada linha de código
stat: expr NEWLINE?;

// Condicional if / elif / else
conditional
    : 'if' query ':' NEWLINE? stat+
      ('elif' query ':' NEWLINE? stat+)* 
      ('else' ':' NEWLINE? stat+)?
    ;

// Definição de função
func
    : 'def' ID '(' arg_list? ')' ':' NEWLINE? 'return' expr? NEWLINE?
    ;

// Chamada de função
func_call
    : ID '(' call_args? ')'
    ;

// Lista de argumentos na definição
arg_list
    : ID (',' ID)*
    ;

// Lista de argumentos na chamada
call_args
    : expr (',' expr)*
    ;

// Consultas booleanas e relacionais
query
    : 'True'
    | 'False'
    | NOT query
    | query (AND | OR) query
    | '(' query ')'
    | expr rel_op expr
    ;

rel_op
    : '<' | '>' | '<=' | '>=' | '==' | '!='
    ;

// Expressões
expr
    : ID
    | NUMBER
    | expr (PLUS | MINUS | TIMES | DIVIDE | MOD | POWER) expr
    | LPAREN expr RPAREN
    | 'None'
    | func_call
    ;
