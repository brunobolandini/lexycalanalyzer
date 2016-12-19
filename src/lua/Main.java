package lua;

import java.io.FileReader;
import java.io.IOException;
import java.nio.file.Paths;


public class Main {

    public static void main(String[] args) throws IOException {

        String rootPath = Paths.get("", args).toAbsolutePath(). toString();
        String subPath = "/src/lua";

        String sourceCode = rootPath + subPath + "/program.lua";
 
        try {
            Parser p = new Parser(new Lexer(new FileReader(sourceCode)));
            Object result = p.parse().value;

            System.out.println("Compilacao concluida com sucesso...");
        } catch (Exception e) {
            e.printStackTrace();
        }
        
//        LexicalAnalyzer lexical = new LexicalAnalyzer(new FileReader(sourceCode));
//
//        LuaToken token;
//        
//        while ((token = lexical.yylex()) != null) {
//            System.out.println("<" + token.name + ", " + token.value+ "> (" + token.line+ " - " + token.column+ ")");
//            
//        }
    }
}
