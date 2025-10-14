defmodule Main4 do
  def suma_de_cola(0, cont), do: cont
  def suma_de_cola(n, cont), do: suma_de_cola(n - 1, cont + n)

end
