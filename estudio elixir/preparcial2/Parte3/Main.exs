Code.require_file("productos.exs")
Code.require_file("docentes.exs")
Code.require_file("asistencia.exs")
Code.require_file("clientes.exs")
defmodule Main do



IO.puts("""
============================
      MENÚ DE TAREAS
============================
1) Calcular IVA (productos.csv)
2) Filtrar docentes titulares (docentes.csv)
3) Consolidar asistencia (asistencia.csv)
4) Normalizar clientes (clientes.csv)
============================
""")

opcion = IO.gets("Seleccione una opción: ") |> String.trim()

case opcion do
  "1" -> Productos.calcular_iva()
  "2" -> Docentes.filtrar_titulares()
  "3" -> Asistencia.consolidar()
  "4" -> Clientes.normalizar()
  _ -> IO.puts("Opción no válida")
end
end

