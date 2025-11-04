defmodulo ejercicio do
  defstruct nombre: "", edad: 0, cargo: "", salario: 0.0
  def crear_empledo(nombre,edad,cargo,salario) do
    %ejercicio{nombre: nombre,edad: edad,cargo: cargo,salario: salario}
  end
  def nuevo_salario(%ejercicio{salario: salario}) do
  nuevo_salario = empleado.salario + (empleado.salario * porcentaje/100)
  end
end
