parser grammar PythonParser;

options { tokenVocab=PythonLexer; }

// Ponto de entrada: múltiplas instruções ou condicionais, terminando com EOF
code: (stat | condicional)* EOF;

// Cada linha de código é uma expressão ou query, seguida de quebra de linha
stat: (expr | query) NEWLINE?;

// Expressões aritméticas
expr
    : ID                                           #idExpr
    | NUMBER                                       #numeroExpr
    | expr op=(PLUS | MINUS | TIMES | DIVIDE | MOD) expr  #operacaoExpr
    | LPAREN expr RPAREN                           #parensExpr
    ;

// Queries booleanas
query
    : BOOLEANO                                     #valorBooleanoQuery
    | query op=(AND | OR) query                    #operacaoBooleanaQuery
    | LPAREN query RPAREN                          #parensQuery
    | expr op=(EQ | NEQ | LT | LTE | GT | GTE) expr  #relacaoExprQuery
    ;

// Estruturas condicionais suportadas
condicional
    : IF query DOIS_PONTOS bloco                                                      #ifCondicional
    | IF query DOIS_PONTOS bloco ELSE DOIS_PONTOS bloco                               #ifElseCondicional
    | IF query DOIS_PONTOS bloco ELIF query DOIS_PONTOS bloco ELSE DOIS_PONTOS bloco #ifElifElseCondicional
    | IF query DOIS_PONTOS bloco (ELIF query DOIS_PONTOS bloco)+ ELSE DOIS_PONTOS bloco #ifMultiplosElifElseCondicional
    ;

// Bloco indentado
bloco: INDENT (stat | condicional)+ DEDENT;
