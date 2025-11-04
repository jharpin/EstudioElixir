Code.require_file("Util.exs")

defmodule Asistencia do
  import Util

  def consolidar(input \\ "asistencia.csv", output \\ "resumen_asistencia.csv") do
    filas = leer_csv(input)
    [encabezado | datos] = filas

    # datos = [["2025-10-01", "Ana", "P"], ["2025-10-02", "Ana", "A"], ...]

    resumen =
      datos
      |> Enum.group_by(fn [_fecha, estudiante, _estado] -> estudiante end)
      |> Enum.map(fn {estudiante, registros} ->
        total_p = contar_estado(registros, "P")
        total_t = contar_estado(registros, "T")
        total_a = contar_estado(registros, "A")
        [estudiante, Integer.to_string(total_p), Integer.to_string(total_t), Integer.to_string(total_a)]
      end)

    encabezado_salida = ["estudiante", "total_P", "total_T", "total_A"]
    escribir_csv(output, [encabezado_salida | resumen])

    IO.puts("Archivo generado: #{output}")
  end

  defp contar_estado(registros, tipo) do
    Enum.count(registros, fn [_fecha, _estudiante, estado] ->
      String.trim(estado) == tipo
    end)
  end
end
