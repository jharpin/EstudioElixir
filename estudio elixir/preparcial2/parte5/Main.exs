Code.require_file("Ejercicio.exs")

defmodule Main do
  def main do
    IO.puts("""
==========================
   MENÚ DE REPORTES RSC
==========================
1) Reporte de ventas por cliente
2) Validar reservas
3) Promedio general de estudiantes
==========================
""")

    opcion = IO.gets("Seleccione una opción: ") |> String.trim()

    case opcion do
      "1" -> Ejercicios.reporte_ventas()
      "2" -> Ejercicios.validar_reservas()
      "3" -> Ejercicios.promedios_estudiantes()
      _ -> IO.puts(" Opción no válida")
    end
  end
end

Main.main()
