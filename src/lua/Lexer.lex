package lua;

import java_cup.runtime.Symbol;
import java_cup.sym;


%%

%cup
%public
%class Lexer
%line
%column

//comeca_comentario = "--[["
//conteudo_comentario = ([^-]|[^\[{2}])*
//termina_comentario = "--]]"


//comentario_em_bloco = {comeca_comentario}{conteudo_comentario}{termina_comentario}
//comentario_curto = -{2}[^\[][^\]][^\n]*
expoente = [-+]?[0-9]*\.?[0-9]+([eE][-+]?[0-9]+)?
float = [0-9]+\.[0-9]*
inteiro = 0|[1-9][0-9]*
brancos = [\n| |\t|\r]
name = [_|a-z|A-Z][a-z|A-Z|0-9|_]*
stringLua = \"(([^\\]+)|(\\.))*\"
number = {float} | {inteiro} | {expoente}
//comentario = {comentario_em_bloco} | {comentario_curto}


//comentario number string id
%%

//{comentario_curto} {return new Symbol(Sym.COMENTARIO_CURTO, yychar, yyline, yytext()); }
//{comentario_em_bloco} {return new Symbol(Sym.COMENTARIO_EM_BLOCO, yychar, yyline, yytext()); }

<YYINITIAL> {

"and" {return new Symbol(Sym.OPERADOR_E, yychar, yyline, yytext()); }
"break" {return new Symbol(Sym.QUEBRA_LACO, yychar, yyline, yytext()); }
"do" {return new Symbol(Sym.LACO_FACA, yychar, yyline, yytext()); }
"elseif" {return new Symbol( Sym.SENAO_SE, yychar, yyline, yytext()); }
"else" {return new Symbol( Sym.SENAO, yychar, yyline, yytext()); }
"end" {return new Symbol( Sym.FIM_DO_LACO, yychar, yyline, yytext()); }
"false" {return new Symbol( Sym.VALOR_FALSO, yychar, yyline, yytext()); }
"for" {return new Symbol( Sym.LACO_PARA, yychar, yyline, yytext()); }
"function" {return new Symbol( Sym.FUNCAO, yychar, yyline, yytext()); }
"local function" {return new Symbol ( Sym.FUNCAO_LOCAL, yychar, yyline, yytext()); } 
"if" {return new Symbol( Sym.SE_CONDICIONAL, yychar, yyline, yytext()); }
"in" {return new Symbol( Sym.DENTRO, yychar, yyline, yytext()); }
"local" {return new Symbol( Sym.DEFINICAO_LOCAL, yychar, yyline, yytext()); }
"nil"  {return new Symbol( Sym.NULO, yychar, yyline, yytext()); }
"not"  {return new Symbol( Sym.NEGACAO, yychar, yyline, yytext()); }
"or"  {return new Symbol( Sym.OPERADOR_OU, yychar, yyline, yytext()); }
"repeat"  {return new Symbol( Sym.REPETICAO, yychar, yyline, yytext()); }
"then"  {return new Symbol( Sym.ENTAO, yychar, yyline, yytext()); }
"true" {return new Symbol( Sym.VALOR_VERDADEIRO, yychar, yyline, yytext()); }
"until"  {return new Symbol( Sym.ATE_LIMITE_LACO, yychar, yyline, yytext()); }
"while"  {return new Symbol( Sym.LACO_ENQUANTO, yychar, yyline, yytext()); }
"return"  {return new Symbol( Sym.RETORNO, yychar, yyline, yytext()); }



">=" {return new Symbol( Sym.MAIOR_IGUAL_QUE, yychar, yyline, yytext()); }
"<=" {return new Symbol( Sym.MENOR_IGUAL_QUE, yychar, yyline, yytext()); }
">" {return new Symbol( Sym.MAIOR_QUE, yychar, yyline, yytext()); }
"<" {return new Symbol( Sym.MENOR_QUE, yychar, yyline, yytext()); }
"==" {return new Symbol( Sym.IGUAL_COMPARATIVO, yychar, yyline, yytext()); }
"=" {return new Symbol( Sym.ATRIBUICAO, yychar, yyline, yytext()); }
"~=" {return new Symbol( Sym.DIFERENTE, yychar, yyline, yytext()); }
"+"  {return new Symbol( Sym.SOMA, yychar, yyline, yytext()); }
"-" {return new Symbol( Sym.SUBTRACAO, yychar, yyline, yytext()); }
"*" {return new Symbol( Sym.MULTIPLICACAO, yychar, yyline, yytext()); }
"/" {return new Symbol( Sym.DIVISAO, yychar, yyline, yytext()); }
"^" {return new Symbol( Sym.EXPONENCIACAO, yychar, yyline, yytext()); }
"%" {return new Symbol( Sym.RESTO, yychar, yyline, yytext()); }
"#" {return new Symbol( Sym.TAMANHO, yychar, yyline, yytext()); }
";" {return new Symbol( Sym.PONTO_E_VIRGULA, yychar, yyline, yytext()); }
":" {return new Symbol( Sym.DOIS_PONTOS, yychar, yyline, yytext()); }
"(" {return new Symbol( Sym.ABRE_PARENTESIS, yychar, yyline, yytext()); }
")" {return new Symbol( Sym.FECHA_PARENTESIS, yychar, yyline, yytext()); }
"{" {return new Symbol( Sym.ABRE_CHAVES, yychar, yyline, yytext()); }
"}"  {return new Symbol( Sym.FECHA_CHAVES, yychar, yyline, yytext()); }
"["  {return new Symbol( Sym.ABRE_COLCHETES, yychar, yyline, yytext()); }
"]" {return new Symbol( Sym.FECHA_COLCHETES, yychar, yyline, yytext()); }
"..." {return new Symbol( Sym.EXPRESSAO_VARARG, yychar, yyline, yytext()); }
".." {return new Symbol( Sym.CONCATENAR_STRING, yychar, yyline, yytext()); }
"." {return new Symbol( Sym.PONTO, yychar, yyline, yytext()); }
"," {return new Symbol( Sym.VIRGULA, yychar, yyline, yytext()); }



{number} {return new Symbol( Sym.NUMERO, yychar, yyline, yytext()); }
{brancos} { }
{stringLua} {return new Symbol( Sym.STRING_LUA, yychar, yyline, yytext()); }
{name} {return new Symbol( Sym.NOME, yychar, yyline, yytext()); }
}
. { throw new RuntimeException("Caractere inválido " + yytext() + " na linha " + yyline + ", coluna " +yycolumn); }