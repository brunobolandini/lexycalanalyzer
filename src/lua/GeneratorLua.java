package lua;
import java.io.File;
import java.nio.file.Paths;

public class GeneratorLua {

    public static void main(String[] args) {

        String rootPath = Paths.get("", args).toAbsolutePath(). toString();
        String subPath = "/src/lua/";

        String file = rootPath + subPath + "Lexer.lex";

        File sourceCode = new File(file);

        jflex.Main.generate(sourceCode);

    }
}
