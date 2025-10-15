Code.require_file("Util.exs")

defmodule Estudiante do
  defstruct id: nil, notas: []
end

defmodule Usuario do
  defstruct id: nil, correo: nil
end

defmodule Ejercicios do
  import Util

  def promedios_estudiantes([]), do: []
  def promedios_estudiantes([%Estudiante{id: id, notas: notas} | t]) do
    promedio = promedio(notas)
    [{id, promedio} | promedios_estudiantes(t)]
  end

 
  def filtrar_usuarios([], _dominio), do: []
  def filtrar_usuarios([%Usuario{correo: correo} = u | t], dominio) do
    if String.ends_with?(correo, dominio) do
      [u | filtrar_usuarios(t, dominio)]
    else
      filtrar_usuarios(t, dominio)
    end
  end
end
