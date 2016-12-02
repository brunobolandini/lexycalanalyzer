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

exponent = [-+]?[0-9]*\.?[0-9]+([eE][-+]?[0-9]+)?
float = [0-9]+\.[0-9]*
inteiro = 0|[1-9][0-9]*
brancos = [\n| |\t|\r]
name = [_|a-z|A-Z][a-z|A-Z|0-9|_]*
stringLua = \"(([^\\]+)|(\\.))*\"
number = {float} | {inteiro} 
nomeComposto = {name"."name}

//comentario number string id
%%
//     and       break     do        else      elseif
//     end       false     for       function  if
//     in        local     nil       not       or
//     repeat    return    then      true      until     while
//     +     -     *     /     %     ^     #
//     ==    ~=    <=    >=    <     >     =
//     (     )     {     }     [     ]
//     ;     :     ,     .     ..    ...

">=" {return createToken("maior igual que", yytext());}
"<=" {return createToken("menor igual que", yytext();)}
">" {return createToken("maior que"", yytext();)}
"<" {return createToken("menor que", yytext();)}
"==" {return createToken("igual comparativo", yytext()); }
"=" {return createToken("atribuicao", yytext());)}
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

"if" {return createToken("if (condicional)", yytext()); }


{number} {return createToken("number", yytext());}
{brancos} { yytext(); }
{stringLua} {return createToken("string lua", yytext()); }
{name} {return createToken("name", yytext()); }

. { throw new RuntimeException("Caractere inválido " + yytext() + " na linha " + yyline + ", coluna " +yycolumn); }