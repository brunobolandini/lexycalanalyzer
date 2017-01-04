package lua;

import java.util.List;
import java.util.ArrayList;

public class No {
	private Token token;
	private List<No> filhos;
	
	public No(Token token){
		this.token = token;
		this.filhos = new ArrayList<>();
	}
	
	public No(){
		this.token = null;
		this.filhos = new ArrayList<>();
	}
	
	public void addFilho(Token token){
		filhos.add(new No(token));
	}
	
	public void addFilho(No no){
		filhos.add(no);
	}
	
}
