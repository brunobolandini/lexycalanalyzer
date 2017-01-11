package lua;

import java.util.HashMap;

public class TabelaSimbolos {

	private TabelaSimbolos pai;
	private HashMap<String, Integer> vars;
	private int livre;

	public TabelaSimbolos(TabelaSimbolos pai) {
		this.pai = pai;
		vars = new HashMap<String, Integer>();
		livre = 0;
	}

	public TabelaSimbolos() {
		this(null);
	}

	void insere(String nome) {
		if (!vars.containsKey(nome)) {
			vars.put(nome, livre++);
		} else {
			throw new RuntimeException("Entrada " + nome + " redeclarada no mesmo escopo");
		}
	}

	Integer get(String nome) {
		Integer pos = vars.get(nome);
		if (pos == null && pai != null)
			return pai.get(nome);
		else
			return pos;
	}

}
