defmodule Util do
  def promedio(lista) do
    Enum.sum(lista) / length(lista)
  end
end
