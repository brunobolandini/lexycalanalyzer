#!/bin/bash

# Navegar para pasta lua:
cd src/lua


# Para criação do Lexer.java:
java -jar ../../jflex-1.6.1.jar Lexer.lex 

# Para criação do Parser.java e Sym.java:
java -jar ../../java-cup-11a.jar -parser Parser -symbols Sym Parser.cup


# EXECUÇÃO POR LINHA DE COMANDO:

# (MAC)
cd ..
javac -classpath ../jflex-1.6.1.jar:../java-cup-11a.jar lua/*.java
java -cp .:../jflex-1.6.1.jar:../java-cup-11a.jar lua.Main

