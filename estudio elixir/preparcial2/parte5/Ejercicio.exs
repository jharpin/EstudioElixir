Code.require_file("Util.exs")
Code.require_file("Ventas.exs")
Code.require_file("Reserva.exs")
Code.require_file("Estudiantes.exs")
Code.require_file("Notas.exs")

defmodule Ejercicios do
  import Util

  # ---------------------------
  # RSC1: Reporte de Ventas
  # ---------------------------
  def reporte_ventas(input \\ "ventas.csv", output \\ "reporte_clientes.csv") do
    [_ | filas] = leer_csv(input)

    ventas =
      Enum.map(filas, fn [id, cliente, valor] ->
        %Venta{id: id, cliente: cliente, valor: String.to_integer(valor)}
      end)

    agrupado =
      Enum.group_by(ventas, & &1.cliente, & &1.valor)

    filas_final =
      Enum.map(agrupado, fn {cliente, valores} ->
        total = Enum.sum(valores)

        clas =
          cond do
            total >= 300_000 -> "ALTO"
            total >= 150_000 -> "MEDIO"
            true -> "BAJO"
          end

        [cliente, Integer.to_string(total), clas]
      end)

    escribir_csv(output, [["cliente", "total", "clasificacion"] | filas_final])
    IO.puts("Archivo generado: #{output}")
  end

  # ---------------------------
  # RSC2: Reservas válidas
  # ---------------------------
  def validar_reservas(input \\ "reservas.csv", output \\ "reservas_ok.csv") do
    [_ | filas] = leer_csv(input)

    reservas =
      Enum.map(filas, fn [id, cod, nom, cupos, usuario, cant] ->
        %Reserva{
          id: id,
          recurso: %Recurso{codigo: cod, nombre: nom, cupos: String.to_integer(cupos)},
          usuario: usuario,
          cantidad: String.to_integer(cant)
        }
      end)

    # Verificar si hay alguna reserva inválida
    invalida = Enum.find(reservas, fn r -> r.cantidad > r.recurso.cupos end)

    if invalida do
      IO.puts("Error: reserva inválida -> ID #{invalida.id}")
    else
      filas_final =
        for r <- reservas do
          restantes = r.recurso.cupos - r.cantidad
          [r.id, r.recurso.codigo, r.recurso.nombre, r.recurso.cupos, r.usuario, r.cantidad, restantes]
        end

      escribir_csv(output, [["id", "codigo", "nombre", "cupos", "usuario", "cantidad", "restantes"] | filas_final])
      IO.puts("Archivo generado: #{output}")
    end
  end

  # ---------------------------
  # RSC3: Promedios de estudiantes
  # ---------------------------
  def promedios_estudiantes(estudiantes_path \\ "estudiantes.csv", notas_path \\ "notas.csv", output \\ "promedios.csv") do
    [_ | est_datos] = leer_csv(estudiantes_path)
    [_ | not_datos] = leer_csv(notas_path)

    estudiantes = Enum.map(est_datos, fn [id, nom] -> %Estudiante{id: id, nombre: nom} end)
    notas = Enum.map(not_datos, fn [eid, _, nota] -> %Nota{estudiante_id: eid, nota: String.to_integer(nota)} end)

    filas_final =
      for e <- estudiantes do
        notas_est = Enum.filter(notas, &(&1.estudiante_id == e.id))

        prom =
          if notas_est == [] do
            0
          else
            Enum.sum(for n <- notas_est, do: n.nota) / length(notas_est)
          end

        [e.id, e.nombre, Float.to_string(prom)]
      end

    escribir_csv(output, [["id", "nombre", "promedio"] | filas_final])
    IO.puts("Archivo generado: #{output}")
  end
end
