package lua;

import java.util.List;
import java.util.ArrayList;
import java_cup.runtime.*;
import java_cup.*;
import java.util.*;

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
    
    public String getToken() {
    	return this.token.toString();
    }

    public void addFilho(Token token){
        filhos.add(new No(token));
    }

    public void addFilho(No no){
        filhos.add(no);
    }
    
    public List<No> getFilhos() {
    	if(this.filhos.size() > 0)
    		return this.filhos;
    	else
    		return null;
    }
    
    public No getFilho(int position) {
    	if(this.filhos.size() > position) {
    		if(this.filhos.get(position) != null)
    			return this.filhos.get(position);
    	}
    	return null;
    }	
    
    public No getNeto(int posFilho, int posNeto) {
    	if(this.filhos.size() > posFilho) {
    		if(this.filhos.get(posFilho).filhos.size() > posNeto) {
    			if(this.filhos.get(posFilho).filhos.get(posNeto) != null)
        			return this.filhos.get(posFilho).filhos.get(posNeto);
    		}
    	}
    	return null;
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
            	tabulacao = " -- ";
            	espaco ="    ";
            } else{
            	tabulacao = "|-- ";
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
