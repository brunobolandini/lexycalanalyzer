package lua;

import java_cup.runtime.*;

%%

%{


private LuaToken createToken(String name, String value) {
    return new LuaToken( name, value, yyline, yycolumn);
}

%}

%public
%class LexicalAnalyzer
%type LuaToken
%line
%column

comentario_em_bloco = \[((=*)\[([^])*?)\]\2\]
cometario_curto =  --.*
expoente = [-+]?[0-9]*\.?[0-9]+([eE][-+]?[0-9]+)?
float = [0-9]+\.[0-9]*
inteiro = 0|[1-9][0-9]*
brancos = [\n| |\t|\r]
name = [_|a-z|A-Z][a-z|A-Z|0-9|_]*
stringLua = \"(([^\\]+)|(\\.))*\"
number = {float} | {inteiro} | {expoente}


//comentario number string id
%%
{cometario_curto} {return createToken("comentario_curto",yytext());}
{comentario_em_bloco} {return createToken("comentario_em_bloco", yytext());}
"and" {return createToken("operador e", yytext());}
"break" {return createToken("quebra laco", yytext());}
"do" {return createToken("laco faca", yytext());}
"elseif" {return createToken("senao se",yytext());}
"else" {return createToken("senao", yytext());}
"end" {return createToken("fim do laco", yytext());}
"false" {return createToken("valor falso", yytext());}
"for" {return createToken("laco para", yytext());}
"function" {return createToken("funcao", yytext());}
"if" {return createToken("se condicional", yytext());}
"in" {return createToken("dentro", yytext());}
"local" {return createToken("definicao local", yytext());}
"nil"  {return createToken("nulo", yytext());}
"not"  {return createToken("negacao", yytext());}
"or"  {return createToken("ou", yytext());}
"repeat"  {return createToken("repeticao", yytext());}
"then"  {return createToken("entao", yytext());}
"true" {return createToken("valor verdadeiro", yytext());}
"until"  {return createToken("ate limite laco", yytext());}
"while"  {return createToken("laco enquanto", yytext());}

">=" {return createToken("maior igual que", yytext());}
"<=" {return createToken("menor igual que", yytext());}
">" {return createToken("maior que", yytext());}
"<" {return createToken("menor que", yytext());}
"==" {return createToken("igual comparativo", yytext()); }
"=" {return createToken("atribuicao", yytext());}
"~=" {return createToken("diferente", yytext()); }
"+"  {return createToken("soma", yytext()); }
"-" {return createToken("subtracao", yytext()); }
"*" {return createToken("multiplicacao", yytext()); }
"/" {return createToken("divisao", yytext()); }
"^" {return createToken("exponenciacao", yytext()); }
"%" {return createToken("resto(mod)", yytext()); }
"#" {return createToken("tamanho", yytext()); }
";" {return createToken("ponto e virgula", yytext()); }
":" {return createToken("dois pontos", yytext()); }
"(" {return createToken("abre parentesis", yytext());}
")" {return createToken("fecha parentesis", yytext());}
"{" {return createToken("abre chaves", yytext());}
"}"  {return createToken("fecha chaves", yytext());}
"["  {return createToken("abre colchetes", yytext());}
"]" {return createToken("fecha colchetes", yytext());}
"..." {return createToken("vararg expression", yytext()); }
".." {return createToken("concaternar string", yytext());}
"." {return createToken("ponto", yytext());}
"," {return createToken("virgula", yytext());}

{number} {return createToken("number", yytext());}
{brancos} { yytext(); }
{stringLua} {return createToken("string lua", yytext()); }
{name} {return createToken("name", yytext()); }

. { throw new RuntimeException("Caractere inválido " + yytext() + " na linha " + yyline + ", coluna " +yycolumn); }