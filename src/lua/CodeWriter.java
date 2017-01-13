package lua;

import java.io.File;
import java.io.FileWriter;
import java.io.IOException;

public class CodeWriter {	
	
	CodeWriter(Object tree) throws IOException{
		if (tree == null ){
			return;
		}
		
		/* TRATAR A ARVORE AQUI */
		
		File f = new File("lua/GeneratedCode.java");
		FileWriter fw = new FileWriter(f);		
		fw.append("package lua;\n");
		fw.append("public class GeneratedCode {\n");		
		fw.append("	public static void main(String args[]){\n");
		fw.append("		System.out.println(\"teste\");\n	}\n}");
		fw.close();
	}

}
