Code.require_file("Util.exs")

defmodule Clientes do
  import Util

  def normalizar(input \\ "clientes.csv", output \\ "clientes_normalizado.csv") do
    filas = leer_csv(input)
    [encabezado | datos] = filas

    normalizados =
      Enum.map(datos, fn [id, nombre, correo] ->
        nombre_titulo =
          nombre
          |> String.trim()
          |> String.downcase()
          |> String.split(" ")
          |> Enum.map(&String.capitalize/1)
          |> Enum.join(" ")

        correo_min = String.downcase(String.trim(correo))

        [id, nombre_titulo, correo_min]
      end)

    escribir_csv(output, [encabezado | normalizados])
    IO.puts("Archivo generado: #{output}")
  end
end
