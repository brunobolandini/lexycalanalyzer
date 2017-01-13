package lua;

import java.util.List;
import java.util.ArrayList;

public class Semantic {

	private No no;
	private List<TableSymbol> declaradas;
	
	public Semantic (No tree) {
		if (tree != null)
			this.no = tree;
		this.declaradas = new ArrayList<>();
	}
	
	public Semantic (Object tree) {
		if (tree != null)
			this.no = (No) tree;
		this.declaradas = new ArrayList<>();
	}
	
	public Semantic (No tree, List<TableSymbol> tabela) {
		if (tree != null)
			this.no = tree;
		if (tabela.size() > 0)
			this.declaradas = tabela;
		else
			this.declaradas = new ArrayList<>();
	}
	
	public Semantic (Object tree, List<TableSymbol> tabela) {
		if (tree != null)
			this.no = (No) tree;
		if (tabela.size() > 0)
			this.declaradas = tabela;
		else
			this.declaradas = new ArrayList<>();
	}
	
	public Boolean doSemanticAnalysis() {
		String token = this.no.getToken();
		
		if(!token.isEmpty()) {
			
			//se for declaracao, armazena a variavel na tabela
			if(token.equals("local") || token.equals("function")) {
				
				//salva a variavel na tabela
				TableSymbol declaredVariable;
				switch(token) {
					case "local":
						declaredVariable = new TableSymbol(this.no.getFilho(0).getToken(), "variable");
						this.declaradas.add(declaredVariable);
						break;
					case "function":
						declaredVariable = new TableSymbol(this.no.getFilho(0).getToken(), "function");
						this.declaradas.add(declaredVariable);
						//se tiver algum argumento, tem que ser adicionado tambem
						if (this.no.getNeto(1,1) != null && !this.no.getNeto(1,1).getToken().equals(")")) {
							declaredVariable = new TableSymbol(this.no.getNeto(1,1).getToken(), "argument");
							this.declaradas.add(declaredVariable);
						}							
						break;
					default:
						declaredVariable = new TableSymbol(this.no.getFilho(0).getToken());
						this.declaradas.add(declaredVariable);
						break;
				}
				
				if (this.no.getFilhos() != null) {
					//Continua a recursao para os filhos, com excessao do filho com o nome declarado
					for (No filho : this.no.getFilhos()) {
						if (!filho.getToken().equals(declaredVariable.getId()) && filho != null) {
							//Desce recursivamente, passando a tabela atualizada
							Semantic novaAnalise = new Semantic(filho, this.declaradas);
							if (!novaAnalise.doSemanticAnalysis())
								return false;;
						}
					}
				}
			}
			
			//se nao, verifica se e palavra reservada
			//caso sim, desce na recursao
			else if (this.reservada(token)) {
				if (this.no.getFilhos() != null) {
					for (No filho : this.no.getFilhos()) {
						if (filho != null) {
							//Desce recursivamente, passando a tabela atualizada
							Semantic novaAnalise = new Semantic(filho, this.declaradas);
							if (!novaAnalise.doSemanticAnalysis())
								return false;
						}
					}
				}
			}
			
			//se nao, e um nome ou valor
			else {
				
				//VERIFICADO:
				//1 - SE A VARIAVEL FOI DECLARADA
				//2 - SE COMECA COM UM NUMERO, E UM NUMERO E NAO UM NOME
				//3 - VERIFICAR SE E UMA STRING (SE COMECA COM ")
				//4 - SE E ARGUMENTO DE UMA FUNCAO, AI NAO PRECISA ESTAR DECLARADO
				
				//FALTA VERIFICAR:
				//
				//2 - CASO DO PRINT NAO DECLARADO
				//OUTROS A VERIFICAR
				
				
				//se constar na tabela de declaracoes, desce recursivamente
				if(this.declarada(token) || Character.isDigit(token.charAt(0)) || token.charAt(0) == '"') {
					if (this.no.getFilhos() != null) {
						for (No filho : this.no.getFilhos()) {
							if (filho != null) {
								//Desce recursivamente, passando a tabela atualizada
								Semantic novaAnalise = new Semantic(filho, this.declaradas);
								if (!novaAnalise.doSemanticAnalysis())
									return false;
								
							}
						}
					}
				}
				else {
					System.out.println("Erro Semantico: '" + token + "' nao foi declarado no escopo!");
					return false;
				}
			}
		}
		return true;
	}
	
	public Boolean declarada(String token) {
		for (TableSymbol tb : this.declaradas) {
			if (tb.getId().equals(token))
				return true;
		}
		return false;
	}

	public Boolean reservada(String token) {
		String[] palavrasReservadas = {"and","break","do","elseif","else","end","false","for",
									   "function","local function","if","in","local","nil","not",
									   "or","repeat","then","true","until","while","return"};
		String[] tokens = {">=","<=",">","<","==","=","~=","+","-","*","/","^","%",
						   "#",";",":","(",")","{","}","[","]","...","..",".",","};
		
		for (String palavra: palavrasReservadas) {
			if(token.equals(palavra))
				return true;
		}    	
		
		for (String palavra: tokens) {
			if(token.equals(palavra))
				return true;
		}

		return false;
	}
	
}
