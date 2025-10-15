Code.require_file("Promedio.exs")

defmodule Main do
  def main do
    estudiantes = [
      %Estudiante{id: 1, notas: [3, 4, 5]},
      %Estudiante{id: 2, notas: [2, 3, 4]},
      %Estudiante{id: 3, notas: [5, 5, 4]}
    ]

    IO.puts("== RS1: Promedio por estudiante ==")
    IO.inspect(Ejercicios.promedios_estudiantes(estudiantes))

    usuarios = [
      %Usuario{id: 1, correo: "ana@uq.edu.co"},
      %Usuario{id: 2, correo: "maria@gmail.com"},
      %Usuario{id: 3, correo: "juan@uq.edu.co"}
    ]

    IO.puts("\n== RS2: Filtrar usuarios uq.edu.co ==")
    IO.inspect(Ejercicios.filtrar_usuarios(usuarios, "@uq.edu.co"))
  end
end


Main.main()
