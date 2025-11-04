Code.require_file("Util.exs")

defmodule Docentes do
  import Util

  def filtrar_titulares(input \\ "docentes.csv", output \\ "docentes_titulares.csv") do
    filas = leer_csv(input)
    [encabezado | datos] = filas

    filtrados =
      Enum.filter(datos, fn [_id, _nombre, categoria] ->
        categoria
        |> String.trim()          # elimina espacios, tabulaciones o \r
        |> String.downcase() == "titular"   # lo convierte en minúsculas por seguridad
      end)

    escribir_csv(output, [encabezado | filtrados])

    if length(filtrados) > 0 do
      IO.puts("Archivo generado con #{length(filtrados)} docentes titulares: #{output}")
    else
      IO.puts("No se encontraron docentes con categoría Titular en #{input}")
    end
  end
end
