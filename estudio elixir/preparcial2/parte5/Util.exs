defmodule Util do
  # Leer CSV (retorna lista de listas)
  def leer_csv(path) do
    File.read!(path)
    |> String.split("\n", trim: true)
    |> Enum.map(&String.split(&1, ","))
  end

  # Escribir CSV (recibe lista de listas)
  def escribir_csv(path, filas) do
    contenido =
      filas
      |> Enum.map(&Enum.join(&1, ","))
      |> Enum.join("\n")

    File.write!(path, contenido)
  end

  def suma_lista([]), do: 0
  def suma_lista([h | t]), do: h + suma_lista(t)
end
