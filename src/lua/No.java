package lua;

import java.util.List;
import java.util.ArrayList;

public class No {
    private Token token;
    private List<No> filhos;

    public No() {
    	this.token = null;
    	this.filhos = new ArrayList<>();
    }

    public No(Token token){
        this.token = token;
        this.filhos = new ArrayList<>();
    }	

    public void addFilho(Token token){
        filhos.add(new No(token));
    }

    public void addFilho(No no){
        filhos.add(no);
    }
    
    @Override
    public String toString() {
        if (this.token != null)
        	imprime();
        return "";
    }
    
    public void imprime() {
    	this.imprime("", false);
    }
    
    private void imprime(String prefixo, boolean folha) {
        if(this.token != null && this.token.valor != null) {
        	String tabulacao = "", espaco = "";
            
            if(folha) {
            	tabulacao = "|__ ";
            	espaco ="    ";
            } else{
            	tabulacao = "";
            	espaco = "|   ";
            }    
            
            System.out.println(prefixo + tabulacao + this.token.valor);
            
            for (int i = 0; i < filhos.size() - 1; i++) {
                if(filhos.get(i) != null)
                	filhos.get(i).imprime(prefixo + espaco, false);
            }
            
            if (filhos.size() > 0 && filhos.get(filhos.size() - 1) != null)
                filhos.get(filhos.size() - 1).imprime(prefixo + espaco, true);
        }
    }
}
