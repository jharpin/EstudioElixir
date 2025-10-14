defmodule Recursion do
  def matryoska_recursiva(cant) do
  if cant === 0 do  #caso base-> final de la recursión
    IO.puts("No hay más matryoskas")
  else #caso recursivo-> inicio de la recursión
    IO.puts("Abriendo matryoska #{cant}")
  matryoska_recursiva(cant - 1)
  IO.puts("Cerrando matryoska #{cant}")


  end
end
end
Recursion.matryoska_recursiva(5)
