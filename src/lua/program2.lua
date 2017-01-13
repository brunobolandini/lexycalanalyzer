-- funcao que calcula a raiz quadrada de um numero
-- recebe um numero "n"
function square(n)
  local square = 0
  square = n * n
  return square
end

--imprime a soma
print("Quadrado de 2: ", square(2))