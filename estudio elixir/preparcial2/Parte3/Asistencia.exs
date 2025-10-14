Code.require_file("Util.exs")

defmodule Asistencia do
  import Util

  def consolidar(input \\ "asistencia.csv", output \\ "resumen_asistencia.csv") do
    filas = leer_csv(input)
    [_encabezado | datos] = filas

    resumen =
      Enum.reduce(datos, %{}, fn [_fecha, estudiante, estado], acc ->
        Map.update(acc, estudiante, %{P: 0, T: 0, A: 0}, fn m ->
          Map.update!(m, String.to_atom(estado), &(&1 + 1))
        end)
      end)

    filas_salida =
      [["estudiante", "total_P", "total_T", "total_A"]] ++
        Enum.map(resumen, fn {est, %{P: p, T: t, A: a}} ->
          [est, "#{p}", "#{t}", "#{a}"]
        end)

    escribir_csv(output, filas_salida)
    IO.puts("Archivo generado: #{output}")
  end
end
