parser grammar PythonParser;

options { tokenVocab=PythonLexer; }

// Ponto de entrada: múltiplas instruções terminando com EOF
code: stat* EOF;

// Cada linha de código é uma expressão seguida de quebra de linha
stat: expr NEWLINE?;

// Definição de expressões suportadas
expr
    : ID                                           #idExpr
    | NUMBER                                       #numeroExpr
    | expr op=(PLUS | MINUS | TIMES | DIVIDE | MOD) expr  #operacaoExpr
    | LPAREN expr RPAREN                           #parensExpr
    ;