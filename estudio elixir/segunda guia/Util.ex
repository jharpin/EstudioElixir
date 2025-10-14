defmodule Util do
    def mostrar_mensaje (mensaje) do
    System.cmd("java",["-cp", ".", "Mensaje", mensaje])
  end
    def obtener_dato (dato) do
    System.cmd("java", ["-cp", ".", "Mensaje", "input", dato])
    |> elem(0)
    |> String.trim()
  end
end
