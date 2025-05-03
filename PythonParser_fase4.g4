parser grammar PythonParser;

options { tokenVocab=PythonLexer; }

// Ponto de entrada: múltiplas instruções terminando com EOF
code: stat* EOF;

// Cada linha de código é uma expressão ou query, seguida de quebra de linha
stat: (expr | query) NEWLINE?;

// Definição de expressões suportadas
expr
    : ID                                           #idExpr
    | NUMBER                                       #numeroExpr
    | expr op=(PLUS | MINUS | TIMES | DIVIDE | MOD) expr  #operacaoExpr
    | LPAREN expr RPAREN                           #parensExpr
    ;

// Definição de queries suportadas
query
    : BOOLEANO                                     #valorBooleanoQuery
    | query op=(AND | OR) query                    #operacaoBooleanaQuery
    | LPAREN query RPAREN                          #parensQuery
    | expr op=(EQ | NEQ | LT | LTE | GT | GTE) expr  #relacaoExprQuery
    ;