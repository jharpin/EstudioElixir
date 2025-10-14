
defmodule Recursion2 do #RECURSIVIDAD DIRECTA
  # Caso base -> cuando ya no quedan matryoskas
  def matryoska_recursiva(0) do
    IO.puts("No hay más matryoskas")
  end

  # Caso recursivo -> cuando aún hay matryoskas
  def matryoska_recursiva(cant) do
    IO.puts("Abriendo matryoska #{cant}")
    matryoska_recursiva(cant - 1)
    IO.puts("Cerrando matryoska #{cant}")
  end
end

Recursion2.matryoska_recursiva(5)
