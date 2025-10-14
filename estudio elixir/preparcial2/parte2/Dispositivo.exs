defmodule Dispositivo do
defstruct [:id, :tipo, :marca, :estado]
def new(id, tipo, marca, estado) do
%Dispositivo{id: id, tipo: tipo, marca: marca, estado: estado}
end
def apto_prestamo?(%Dispositivo{estado: estado}) do
estado in ["nuevo", "usado"]
end
def actualizar_estado(%Dispositivo{} = disp, nuevo_estado) do
%Dispositivo{disp | estado: nuevo_estado}
end
end
laptop = Dispositivo.new("L001", "laptop", "Dell", "nuevo")
Dispositivo.apto_prestamo?(laptop)
laptop_danado = Dispositivo.actualizar_estado(laptop, "dañado")
Dispositivo.apto_prestamo?(laptop_danado)
laptop_reparado = Dispositivo.actualizar_estado(laptop_danado, "usado")
Dispositivo.apto_prestamo?(laptop_reparado)

IO.puts("Laptop original apta?: #{Dispositivo.apto_prestamo?(laptop)}")
IO.puts("Laptop dañada apta?: #{Dispositivo.apto_prestamo?(laptop_danado)}")
IO.puts("Laptop reparada apta?: #{Dispositivo.apto_prestamo?(laptop_reparado)}")

IO.inspect(laptop)
IO.inspect(laptop_danado)
IO.inspect(laptop_reparado)
