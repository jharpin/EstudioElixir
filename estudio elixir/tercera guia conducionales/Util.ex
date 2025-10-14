defmodule Util do
  def mostrar_mensaje(mensaje) do
    System.cmd("java", ["-cp", ".", "Mensaje", mensaje])
  end


  def pedir(dato, :String)do
  System.cmd("java",["-cp", ".", "Mensaje", "input", dato])
  |>elem(0)
  |>String.trim()
  end

  def pedir(dato, :Integer) do
    try do
      dato
      |>pedir(:String)
      |>String.to_integer()
    rescue
      ArgumentError ->
        mostrar_mensaje("Error: Por favor ingresa un número entero válido.")

        dato
        |>pedir(:Integer)
    end
  end

  def pedir(dato, :float) do
    try do
      dato
      |>pedir(:String)
      |>String.to_float()
    rescue
      ArgumentError ->
        mostrar_mensaje("Error: Por favor ingresa un número decimal válido.")
        dato
        |>pedir(:float)
    end
  end
def pedir(dato, :tuple) do
  try do
    dato
    |> pedir(:String)
    |> Code.eval_string() # convierte "{1,2}" en {1,2}
    |> elem(0)            # toma la tupla evaluada
  rescue
    ArgumentError ->
      mostrar_mensaje("Error: Por favor ingresa una tupla válida. Ejemplo: {1,2}")
      pedir(dato, :tuple)
  end
end
end
