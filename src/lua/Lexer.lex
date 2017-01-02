package lua;

import java_cup.runtime.Symbol;
import java_cup.sym;


%%

%cup
%public
%class Lexer
%line
%column


comeca_comentario = "--[["
conteudo_comentario = ([^-]|[^\[{2}])*
termina_comentario = "--]]"


comentario_em_bloco = {comeca_comentario}{conteudo_comentario}{termina_comentario}
comentario_curto = -{2}[^\[][^\]][^\n]*
expoente = [-+]?[0-9]*\.?[0-9]+([eE][-+]?[0-9]+)?
float = [0-9]+\.[0-9]*
inteiro = 0|[1-9][0-9]*
brancos = [\n| |\t|\r|]
name = [_|a-z|A-Z][a-z|A-Z|0-9|_]*
stringLua = \"(([^\\]+)|(\\.))*\"
number = {float} | {inteiro} | {expoente}
comentario = {comentario_em_bloco} | {comentario_curto}


//comentario number string id
%%


<YYINITIAL> {

{comentario_curto} {System.out.println("COMENTARIO CURTO");}
{comentario_em_bloco} {System.out.println("COMENTARIO LONGO");}
"and" {System.out.println("OPERADOR-E");return new Symbol(Sym.OPERADOR_E, yychar, yyline, yytext()); }
"break" {System.out.println("QUEBRA DE LACO");return new Symbol(Sym.QUEBRA_LACO, yychar, yyline, yytext()); }
"do" {System.out.println("LACO FACA");return new Symbol(Sym.LACO_FACA, yychar, yyline, yytext()); }
"elseif" {System.out.println("senao SE");return new Symbol( Sym.SENAO_SE, yychar, yyline, yytext()); }
"else" {System.out.println("senao");return new Symbol( Sym.SENAO, yychar, yyline, yytext()); }
"end" {System.out.println("FIM");return new Symbol( Sym.FIM_DO_LACO, yychar, yyline, yytext()); }
"false" {System.out.println("FALSO");return new Symbol( Sym.VALOR_FALSO, yychar, yyline, yytext()); }
"for" {System.out.println("LACO PARA");return new Symbol( Sym.LACO_PARA, yychar, yyline, yytext()); }
"function" {System.out.println("FUNCAO");return new Symbol( Sym.FUNCAO, yychar, yyline, yytext()); }
"local function" {System.out.println("FUNCAO LOCAL");return new Symbol ( Sym.FUNCAO_LOCAL, yychar, yyline, yytext()); } 
"if" {System.out.println("SE");return new Symbol( Sym.SE_CONDICIONAL, yychar, yyline, yytext()); }
"in" {System.out.println("DENTRO");return new Symbol( Sym.DENTRO, yychar, yyline, yytext()); }
"local" {System.out.println("DEFINICAO_LOCAL");return new Symbol( Sym.DEFINICAO_LOCAL, yychar, yyline, yytext()); }
"nil"  {System.out.println("NUL");return new Symbol( Sym.NULO, yychar, yyline, yytext()); }
"not"  {System.out.println("NEGACAO");return new Symbol( Sym.NEGACAO, yychar, yyline, yytext()); }
"or"  {System.out.println("OPERADOR_OU");return new Symbol( Sym.OPERADOR_OU, yychar, yyline, yytext()); }
"repeat"  {System.out.println("REPETIR");return new Symbol( Sym.REPETICAO, yychar, yyline, yytext()); }
"then"  {System.out.println("ENTAO");return new Symbol( Sym.ENTAO, yychar, yyline, yytext()); }
"true" {System.out.println("VERDADEIRO");return new Symbol( Sym.VALOR_VERDADEIRO, yychar, yyline, yytext()); }
"until"  {System.out.println("ATE");return new Symbol( Sym.ATE_LIMITE_LACO, yychar, yyline, yytext()); }
"while"  {System.out.println("ENQUANTO");return new Symbol( Sym.LACO_ENQUANTO, yychar, yyline, yytext()); }
"return"  {System.out.println("RETORNE");return new Symbol( Sym.RETORNO, yychar, yyline, yytext()); }



">=" {System.out.println(">=");return new Symbol( Sym.MAIOR_IGUAL_QUE, yychar, yyline, yytext()); }
"<=" {System.out.println("<=");return new Symbol( Sym.MENOR_IGUAL_QUE, yychar, yyline, yytext()); }
">" {System.out.println(">");return new Symbol( Sym.MAIOR_QUE, yychar, yyline, yytext()); }
"<" {System.out.println("<");return new Symbol( Sym.MENOR_QUE, yychar, yyline, yytext()); }
"==" {System.out.println("==");return new Symbol( Sym.IGUAL_COMPARATIVO, yychar, yyline, yytext()); }
"=" {System.out.println("=");return new Symbol( Sym.ATRIBUICAO, yychar, yyline, yytext()); }
"~=" {System.out.println("~=");return new Symbol( Sym.DIFERENTE, yychar, yyline, yytext()); }
"+"  {System.out.println("+");return new Symbol( Sym.SOMA, yychar, yyline, yytext()); }
"-" {System.out.println("-");return new Symbol( Sym.SUBTRACAO, yychar, yyline, yytext()); }
"*" {System.out.println("*");return new Symbol( Sym.MULTIPLICACAO, yychar, yyline, yytext()); }
"/" {System.out.println("/");return new Symbol( Sym.DIVISAO, yychar, yyline, yytext()); }
"^" {System.out.println("^");return new Symbol( Sym.EXPONENCIACAO, yychar, yyline, yytext()); }
"%" {System.out.println("%");return new Symbol( Sym.RESTO, yychar, yyline, yytext()); }
"#" {System.out.println("#");return new Symbol( Sym.TAMANHO, yychar, yyline, yytext()); }
";" {System.out.println("PONTO_E_VIRGULA"); return new Symbol( Sym.PONTO_E_VIRGULA, yychar, yyline, yytext()); }
":" {System.out.println(":");return new Symbol( Sym.DOIS_PONTOS, yychar, yyline, yytext()); }
"(" {System.out.println("(");return new Symbol( Sym.ABRE_PARENTESIS, yychar, yyline, yytext()); }
")" {System.out.println(")");return new Symbol( Sym.FECHA_PARENTESIS, yychar, yyline, yytext()); }
"{" {System.out.println("{");return new Symbol( Sym.ABRE_CHAVES, yychar, yyline, yytext()); }
"}"  {System.out.println("}");return new Symbol( Sym.FECHA_CHAVES, yychar, yyline, yytext()); }
"["  {System.out.println("[");return new Symbol( Sym.ABRE_COLCHETES, yychar, yyline, yytext()); }
"]" {System.out.println("]");return new Symbol( Sym.FECHA_COLCHETES, yychar, yyline, yytext()); }
"..." {System.out.println("tres pontos");return new Symbol( Sym.EXPRESSAO_VARARG, yychar, yyline, yytext()); }
".." {System.out.println("dois pontos");return new Symbol( Sym.CONCATENAR_STRING, yychar, yyline, yytext()); }
"." {System.out.println("ponto");return new Symbol( Sym.PONTO, yychar, yyline, yytext()); }
"," {System.out.println("VIRGULA");return new Symbol( Sym.VIRGULA, yychar, yyline, yytext()); }



{number} {System.out.println("number");return new Symbol( Sym.NUMERO, yychar, yyline, yytext()); }
{brancos} { }
{stringLua} {System.out.println("StringLua"); return new Symbol( Sym.STRING_LUA, yychar, yyline, yytext()); }
{name} {System.out.println("nome"); return new Symbol( Sym.NOME, yychar, yyline, yytext()); }
}
. { throw new RuntimeException("Caractere inválido " + yytext() + " na linha " + yyline + ", coluna " +yycolumn); }