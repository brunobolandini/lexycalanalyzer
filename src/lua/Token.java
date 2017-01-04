package lua;

public class Token {
	
	private String valor;
	
	public Token(String valor) {
		this.valor = valor;
	}
	
	@Override
	public String toString() {
		return valor;
	}

}
