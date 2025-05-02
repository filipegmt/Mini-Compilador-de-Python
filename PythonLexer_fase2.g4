lexer grammar PythonLexer;

// 1. Palavras-chave (não usadas no parser atual, mas mantidas para futuras extensões)
DEF     : 'def';
CLASS   : 'class';
IF      : 'if';
ELSE    : 'else';
ELIF    : 'elif';
FOR     : 'for';
WHILE   : 'while';
IN      : 'in';
RETURN  : 'return';
PRINT   : 'print';
AND     : 'and';
OR      : 'or';
NOT     : 'not';
TRUE    : 'True';
FALSE   : 'False';
NONE    : 'None';

// 2. Operadores usados no parser
PLUS    : '+';
MINUS   : '-';
TIMES   : '*';
DIVIDE  : '/';
MOD     : '%';
EQUAL   : '==';
ASSIGN  : '=';
LT      : '<';
GT      : '>';
LE      : '<=';
GE      : '>=';
NE      : '!=';

// 3. Literais e identificadores
NUMBER
    : [0-9]+ ('.' [0-9]*)?      // 5 ou 5. ou 5.0
    | '.' [0-9]+               // .5
    ;

STRING
    : '"'  ( ~["\\\r\n])* '"'
    | '\'' ( ~['\\\r\n])* '\''
    ;

ID      : [a-zA-Z_][a-zA-Z_0-9]*;

// 4. Delimitadores (usados no parser: parênteses)
LPAREN     : '(';
RPAREN     : ')';
LBRACKET   : '[';
RBRACKET   : ']';
COMMA      : ',';
DOT        : '.';
COLON      : ':';
SEMI       : ';';

// 5. Outros tokens
NEWLINE    : '\r'? '\n';
WS         : [ \t]+ -> skip;
COMMENT    : '#' ~[\r\n]* -> skip;
LINE_JOIN  : '\\\r'? '\n' -> skip;

// 6. Escape para strings
// fragment ESC_SEQ : '\\' [btnr"'\"\\];
