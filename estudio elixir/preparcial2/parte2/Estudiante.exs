defmodule Estudiante do
defstruct [:id, :nombre, :correo, :semestre]
def new(id, nombre, correo, semestre) do
%Estudiante{id: id, nombre: nombre, correo: correo, semestre: semestre}
end
def promover(%Estudiante{semestre: sem} = est) do
%Estudiante{est | semestre: sem + 1}
end
def correo_institucional?(%Estudiante{correo: correo}) do
String.ends_with?(correo, "@uq.edu.co")
end
end

est = Estudiante.new("2020001", "Ana García", "ana@uq.edu.co", 3)
# Promover
est_promovido = Estudiante.promover(est)
# semestre: 4
# Validar correo
Estudiante.correo_institucional?(est)
# true
est2 = Estudiante.new("2020002", "Carlos", "carlos@gmail.com", 5)
Estudiante.correo_institucional?(est2)
# false
IO.puts("Estudiante original: #{est.nombre}, semestre: #{est.semestre}")
IO.puts("Estudiante promovido: #{est_promovido.nombre}, semestre: #{est_promovido.semestre}")

IO.puts("Correo institucional de #{est.nombre}?: #{Estudiante.correo_institucional?(est)}")
IO.puts("Correo institucional de #{est2.nombre}?: #{Estudiante.correo_institucional?(est2)}")

IO.inspect(est)
IO.inspect(est_promovido)
IO.inspect(est2)
