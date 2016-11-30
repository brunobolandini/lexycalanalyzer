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

inteiro = 0|[1-9][0-9]*
brancos = [\n| |\t|\r]
name = [_|a-z|A-Z][a-z|A-Z|0-9|_]*
stringLua = \"[^\"]*\"



program = "program"

%%

{inteiro} { return createToken("inteiro", yytext()); }
{program} { return createToken(yytext(), "");} 
{brancos} { yytext(); }
{stringLua} {return createToken("string lua", yytext()); }

. { throw new RuntimeException("Caractere inválido " + yytext() + " na linha " + yyline + ", coluna " +yycolumn); }