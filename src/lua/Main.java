package lua;

import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import java.nio.file.Paths;
import java.util.Scanner;

public class Main {
    public static void main(String[] args) throws IOException {
        
    	String rootPath = Paths.get("", args).toAbsolutePath(). toString();
        String subPath = "/src/lua";
        String sourceCode = rootPath + subPath + "/program.lua";
 
        try {
        	FileReader fr = new FileReader(sourceCode);
        	Lexer l = new Lexer(fr);
        	Parser p = new Parser(l);
            Object result = p.parse().value;
            System.out.println("Compila��o conclu�da com sucesso!");
            
            Semantic analiseSemantica = new Semantic(result);
            if (analiseSemantica.doSemanticAnalysis())
            	System.out.println("A An�lise Sem�ntica ocorreu corretamente!");
            
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
