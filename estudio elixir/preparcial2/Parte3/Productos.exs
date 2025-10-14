Code.require_file("util.exs")

defmodule Productos do
  import Util

  @iva 0.19

  def calcular_iva(input \\ "productos.csv", output \\ "productos_iva.csv") do
    filas = leer_csv(input)
    [encabezado | datos] = filas

    nuevas_filas =
      [["codigo", "nombre", "precio", "iva", "precio_con_iva"]] ++
        Enum.map(datos, fn [codigo, nombre, precio_str] ->
          precio =
            precio_str
            |> String.trim()
            |> (fn s ->
                  case Float.parse(s) do
                    {num, _} -> num
                    :error ->
                      case Integer.parse(s) do
                        {num, _} -> num * 1.0
                        :error -> raise "Formato inválido en precio: #{s}"
                      end
                  end
                end).()

          iva = Float.round(precio * @iva, 2)
          total = Float.round(precio + iva, 2)
          [codigo, nombre, "#{precio}", "#{iva}", "#{total}"]
        end)

    escribir_csv(output, nuevas_filas)
    IO.puts("Archivo generado: #{output}")
  end
end
