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
            System.out.println("Compilacao concluida com sucesso!");
            
            
            //VERIFICADO:
    		//1 - SE A VARIAVEL FOI DECLARADA
    		//2 - SE COMECA COM UM NUMERO, E UM NUMERO E NAO UM NOME
    		//3 - VERIFICAR SE E UMA STRING (SE COMECA COM ")
    		//4 - SE E ARGUMENTO DE UMA FUNCAO, AI NAO PRECISA ESTAR DECLARADO
    		//5 - DECLARACAO DE MAIS DE UMA VARIAVEL NA MESMA LINHA
    		//6 - CASO DO PRINT NAO DECLARADO
    		//7 - ESCOPOS DIFERENTES
    		//8 - VARIAVEL DECLARADA DUAS VEZES
            //9 - DECLARACAO DE MAIS DE UM ARGUMENTO NA MESMA FUNCAO
    		
    		//FALTA VERIFICAR:				
            //10 - VARIAVEL GLOBAL (sem 'local')
            
            Semantic analiseSemantica = new Semantic(result);
            if (analiseSemantica.doSemanticAnalysis())
            	System.out.println("A Analise Semantica ocorreu corretamente!");
            
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
