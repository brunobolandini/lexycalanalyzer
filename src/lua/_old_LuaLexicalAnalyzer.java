//package lua;
//
//import java.io.FileReader;
//import java.io.IOException;
//import java.nio.file.Paths;
//
//
//public class LuaLexicalAnalyzer {
//
//    public static void main(String[] args) throws IOException {
//
//        String rootPath = Paths.get("", args).toAbsolutePath(). toString();
//        String subPath = "/src/lua";
//
//        String sourceCode = rootPath + subPath + "/program.lua";
//
//        LexicalAnalyzer lexical = new LexicalAnalyzer(new FileReader(sourceCode));
//
//        LuaToken token;
//        
//        while ((token = lexical.yylex()) != null) {
//            System.out.println("<" + token.name + ", " + token.value+ "> (" + token.line+ " - " + token.column+ ")");
//            
//        }
//    }
//}
