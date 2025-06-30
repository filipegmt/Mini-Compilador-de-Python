parser grammar PythonParser;

options { tokenVocab=PythonLexer; }

// Ponto de entrada: múltiplas instruções, terminando com EOF
code: (stat | condicional | func | func_call | loop_while | loop_for)* EOF;

// Cada linha de código é uma expressão ou query, seguida de quebra de linha
stat: (expr | query) NEWLINE?;

// Expressões aritméticas
expr
    : ID                                           #idExpr
    | NUMBER                                       #numeroExpr
    | expr op=(PLUS | MINUS | TIMES | DIVIDE | MOD) expr  #operacaoExpr
    | LPAREN expr RPAREN                           #parensExpr
    | inline_func_call                             #funcCallExpr
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
bloco: INDENT (stat | condicional | func_call | loop_while | loop_for)+ DEDENT;

// === Regras adicionadas nas Fases anteriores ===

// Definição de função
func: DEF ID LPAREN (ID (VIRG ID)*)? RPAREN DOIS_PONTOS bloco;

// Chamada de função como instrução
func_call: ID LPAREN (expr (VIRG expr)*)? RPAREN NEWLINE?;

// Chamada de função inline (usada em expressões)
inline_func_call: ID LPAREN (expr (VIRG expr)*)? RPAREN;

// Estrutura de repetição while
loop_while: WHILE query DOIS_PONTOS bloco;

// === Regra adicionada para Fase 6.75 ===

// Estrutura de repetição for
loop_for: FOR ID IN ID DOIS_PONTOS bloco;
