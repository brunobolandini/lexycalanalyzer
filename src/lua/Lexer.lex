package lua;

import java_cup.runtime.*;
import java_cup.*;
import java.util.*;

%%

%{

	private Symbol symbol(int symbol_code, int yyline, int yycolumn) {
		return new Symbol(symbol_code, yyline, yycolumn);
	}
	
	private Symbol symbol(int symbol_code, int yyline, int yycolumn, Object value) {
		return new Symbol(symbol_code, yyline, yycolumn, value);
	}
	
	private Token createToken(String valor) {
	    Token token = new Token(valor);
	    return token;
	}

%}

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

{comentario_curto} 		{ System.out.printf(" COMENTARIO CURTO"); }
{comentario_em_bloco} 	{ System.out.printf(" COMENTARIO LONGO"); }
"and" 					{ System.out.printf(" OPERADOR-E"); return new Symbol(Sym.OPERADOR_E, createToken(yytext())); }
"break" 				{ System.out.printf(" QUEBRA DE LACO"); return new Symbol(Sym.QUEBRA_LACO, createToken(yytext())); }
"do" 					{ System.out.printf(" LACO FACA"); return new Symbol(Sym.LACO_FACA, createToken(yytext())); }
"elseif" 				{ System.out.printf(" senao SE"); return new Symbol(Sym.SENAO_SE, createToken(yytext())); }
"else" 					{ System.out.printf(" senao"); return new Symbol(Sym.SENAO, createToken(yytext())); }
"end" 					{ System.out.println(" FIM"); return new Symbol(Sym.FIM_DO_LACO, createToken(yytext())); }
"false" 				{ System.out.printf(" FALSO"); return new Symbol(Sym.VALOR_FALSO, createToken(yytext())); }
"for" 					{ System.out.printf(" LACO PARA"); return new Symbol(Sym.LACO_PARA, createToken(yytext())); }
"function" 				{ System.out.printf(" FUNCAO"); return new Symbol(Sym.FUNCAO, createToken(yytext())); }
"local function" 		{ System.out.printf(" FUNCAO LOCAL"); return new Symbol (Sym.FUNCAO_LOCAL, createToken(yytext())); } 
"if" 					{ System.out.printf(" SE"); return new Symbol(Sym.SE_CONDICIONAL, createToken(yytext())); }
"in" 					{ System.out.printf(" DENTRO"); return new Symbol(Sym.DENTRO, createToken(yytext())); }
"local" 				{ System.out.printf(" DEFINICAO_LOCAL"); return new Symbol(Sym.DEFINICAO_LOCAL, createToken(yytext())); }
"nil"  					{ System.out.printf(" NUL"); return new Symbol(Sym.NULO, createToken(yytext())); }
"not"  					{ System.out.printf(" NEGACAO"); return new Symbol(Sym.NEGACAO, createToken(yytext())); }
"or"  					{ System.out.printf(" OPERADOR_OU"); return new Symbol(Sym.OPERADOR_OU, createToken(yytext())); }
"repeat"  				{ System.out.printf(" REPETIR"); return new Symbol(Sym.REPETICAO, createToken(yytext())); }
"then"  				{ System.out.printf(" ENTAO"); return new Symbol(Sym.ENTAO, createToken(yytext())); }
"true" 					{ System.out.printf(" VERDADEIRO"); return new Symbol(Sym.VALOR_VERDADEIRO, createToken(yytext())); }
"until"  				{ System.out.printf(" ATE"); return new Symbol(Sym.ATE_LIMITE_LACO, createToken(yytext())); }
"while"  				{ System.out.printf(" ENQUANTO"); return new Symbol(Sym.LACO_ENQUANTO, createToken(yytext())); }
"return"  				{ System.out.printf(" RETORNE"); return new Symbol(Sym.RETORNO, createToken(yytext())); }

">=" 					{ System.out.printf(" >="); return new Symbol(Sym.MAIOR_IGUAL_QUE, createToken(yytext())); }
"<=" 					{ System.out.printf(" <="); return new Symbol(Sym.MENOR_IGUAL_QUE, createToken(yytext())); }
">" 					{ System.out.printf(" >"); return new Symbol(Sym.MAIOR_QUE, createToken(yytext())); }
"<" 					{ System.out.printf(" <"); return new Symbol(Sym.MENOR_QUE, createToken(yytext())); }
"==" 					{ System.out.printf(" =="); return new Symbol(Sym.IGUAL_COMPARATIVO, createToken(yytext())); }
"=" 					{ System.out.printf(" ="); return new Symbol(Sym.ATRIBUICAO, createToken(yytext())); }
"~=" 					{ System.out.printf(" ~="); return new Symbol(Sym.DIFERENTE, createToken(yytext())); }
"+"  					{ System.out.printf(" +"); return new Symbol(Sym.SOMA, createToken(yytext())); }
"-" 					{ System.out.printf(" -"); return new Symbol(Sym.SUBTRACAO, createToken(yytext())); }
"*" 					{ System.out.printf(" *"); return new Symbol(Sym.MULTIPLICACAO, createToken(yytext())); }
"/" 					{ System.out.printf(" /"); return new Symbol(Sym.DIVISAO, createToken(yytext())); }
"^" 					{ System.out.printf(" ^"); return new Symbol(Sym.EXPONENCIACAO, createToken(yytext())); }
"%" 					{ System.out.printf(" %"); return new Symbol(Sym.RESTO, createToken(yytext())); }
"#" 					{ System.out.printf(" #"); return new Symbol(Sym.TAMANHO, createToken(yytext())); }
";" 					{ System.out.printf(" PONTO_E_VIRGULA"); return new Symbol(Sym.PONTO_E_VIRGULA, createToken(yytext())); }
":" 					{ System.out.printf(" :"); return new Symbol(Sym.DOIS_PONTOS, createToken(yytext())); }
"(" 					{ System.out.printf(" ("); return new Symbol(Sym.ABRE_PARENTESIS, createToken(yytext())); }
")" 					{ System.out.printf(" )"); return new Symbol(Sym.FECHA_PARENTESIS, createToken(yytext())); }
"{" 					{ System.out.printf(" {"); return new Symbol(Sym.ABRE_CHAVES, createToken(yytext())); }
"}"  					{ System.out.printf(" }"); return new Symbol(Sym.FECHA_CHAVES, createToken(yytext())); }
"["  					{ System.out.printf(" ["); return new Symbol(Sym.ABRE_COLCHETES, createToken(yytext())); }
"]" 					{ System.out.printf(" ]"); return new Symbol(Sym.FECHA_COLCHETES, createToken(yytext())); }
"..." 					{ System.out.printf(" tres pontos"); return new Symbol(Sym.EXPRESSAO_VARARG, createToken(yytext())); }
".." 					{ System.out.printf(" dois pontos"); return new Symbol(Sym.CONCATENAR_STRING, createToken(yytext())); }
"." 					{ System.out.printf(" ponto"); return new Symbol(Sym.PONTO, createToken(yytext())); }
"," 					{ System.out.printf(" VIRGULA"); return new Symbol(Sym.VIRGULA, createToken(yytext())); }

{number} 				{ System.out.printf(" number"); return new Symbol(Sym.NUMERO, createToken(yytext())); }
{brancos} 				{ }
{stringLua} 			{ System.out.printf(" StringLua"); return new Symbol(Sym.STRING_LUA, createToken(yytext())); }
{name} 					{ System.out.printf(" nome"); return new Symbol(Sym.NOME, createToken(yytext())); }

}
. { throw new RuntimeException("Caractere invalido " + yytext() + " na linha " + yyline + ", coluna " +yycolumn); }