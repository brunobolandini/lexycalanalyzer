package main;
import java.io.File;
import java.nio.file.Paths;

public class Generator {

    public static void main(String[] args) {

    	String rootPath = Paths.get("", args).toAbsolutePath(). toString();
        String subPath = "/src/main/";


        String file = rootPath + subPath + "language.lex";


        File sourceCode = new File(file);

        jflex.Main.generate(sourceCode);

    }
}
