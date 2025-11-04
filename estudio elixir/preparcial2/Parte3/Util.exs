defmodule Util do
  # Leer CSV simple (sin comillas ni comas internas)
  def leer_csv(path) do
    path
    |> File.read!()
    |> String.split("\n", trim: true)
    |> Enum.map(&String.split(&1, ","))
  end

  # Escribir CSV desde lista de listas
  def escribir_csv(path, filas) do
    contenido =
      filas
      |> Enum.map(&Enum.join(&1, ","))
      |> Enum.join("\n")

    File.write!(path, contenido)
  end
end
