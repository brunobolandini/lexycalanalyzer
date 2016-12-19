package lua;

import java_cup.runtime.*;

%%

%{


private LuaToken createToken(String name, String value) {
    return new LuaToken( name, value, yyline, yycolumn);
}

%}

%cup
%public
%class LexicalAnalyzer
%type Symbol
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
brancos = [\n| |\t|\r]
name = [_|a-z|A-Z][a-z|A-Z|0-9|_]*
stringLua = \"(([^\\]+)|(\\.))*\"
number = {float} | {inteiro} | {expoente}
comentario = {comentario_em_bloco} | {comentario_curto}


//comentario number string id
%%

//     and       break     do        else      elseif
//     end       false     for       function  if
//     in        local     nil       not       or
//     repeat    return    then      true      until     while

{comentario_curto} {return new Symbol(Sym.COMENTARIO_CURTO);}
{comentario_em_bloco} {return new Symbol(Sym.COMENTARIO_EM_BLOCO);}


"and" {return new Symbol(Sym.OPERADOR_E);}
"break" {return new Symbol(Sym.QUEBRA_LACO);}
"do" {return new Symbol(Sym.LACO_FACA);}
"elseif" {return new Symbol( Sym.SENAO_SE);}
"else" {return new Symbol( Sym.SENAO);}
"end" {return new Symbol( Sym.FIM_DO_LACO);}
"false" {return new Symbol( Sym.VALOR_FALSO);}
"for" {return new Symbol( Sym.LACO_PARA);}
"function" {return new Symbol( Sym.FUNCAO);}
"if" {return new Symbol( Sym.SE_CONDICIONAL);}
"in" {return new Symbol( Sym.DENTRO);}
"local" {return new Symbol( Sym.DEFINICAO_LOCAL);}
"nil"  {return new Symbol( Sym.NULO);}
"not"  {return new Symbol( Sym.NEGACAO);}
"or"  {return new Symbol( Sym.OPERADOR_OU);}
"repeat"  {return new Symbol( Sym.REPETICAO);}
"then"  {return new Symbol( Sym.ENTAO);}
"true" {return new Symbol( Sym.VALOR_VERDADEIRO);}
"until"  {return new Symbol( Sym.ATE_LIMITE_LACO);}
"while"  {return new Symbol( Sym.LACO_ENQUANTO);}
"return"  {return new Symbol( Sym.RETORNO);}



">=" {return new Symbol( Sym.MAIOR_IGUAL_QUE);}
"<=" {return new Symbol( Sym.MENOR_IGUAL_QUE);}
">" {return new Symbol( Sym.MAIOR_QUE);}
"<" {return new Symbol( Sym.MENOR_QUE);}
"==" {return new Symbol( Sym.IGUAL_COMPARATIVO); }
"=" {return new Symbol( Sym.ATRIBUICAO);}
"~=" {return new Symbol( Sym.DIFERENTE); }
"+"  {return new Symbol( Sym.SOMA); }
"-" {return new Symbol( Sym.SUBTRACAO); }
"*" {return new Symbol( Sym.MULTIPLICACAO); }
"/" {return new Symbol( Sym.DIVISAO); }
"^" {return new Symbol( Sym.EXPONENCIACAO); }
"%" {return new Symbol( Sym.RESTO); }
"#" {return new Symbol( Sym.TAMANHO); }
";" {return new Symbol( Sym.PONTO_E_VIRGULA); }
":" {return new Symbol( Sym.DOIS_PONTOS); }
"(" {return new Symbol( Sym.ABRE_PARENTESIS);}
")" {return new Symbol( Sym.FECHA_PARENTESIS);}
"{" {return new Symbol( Sym.ABRE_CHAVES);}
"}"  {return new Symbol( Sym.FECHA_CHAVES);}
"["  {return new Symbol( Sym.ABRE_COLCHETES);}
"]" {return new Symbol( Sym.FECHA_COLCHETES);}
"..." {return new Symbol( Sym.EXPRESSAO_VARARG); }
".." {return new Symbol( Sym.CONCATERNAR_STRING);}
"." {return new Symbol( Sym.PONTO);}
"," {return new Symbol( Sym.VIRGULA);}



{number} {return new Symbol( Sym.NUMERO);}
{brancos} { return; }
{stringLua} {return new Symbol( Sym.STRING_LUA); }
{name} {return new Symbol( Sym.NOME); }

. { throw new RuntimeException("Caractere inválido " + yytext() + " na linha " + yyline + ", coluna " +yycolumn); }