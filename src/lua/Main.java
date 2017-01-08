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
        	Parser p = new Parser(new Lexer(new FileReader(sourceCode)));
            Object result = p.parse().value;
            System.out.println("Compilacao concluida com sucesso...");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
