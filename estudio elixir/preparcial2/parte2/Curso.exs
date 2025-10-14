defmodule Curso do

defstruct [:codigo, :nombre, :creditos, :docente]
def new(codigo, nombre, creditos, docente) do
%Curso{codigo: codigo, nombre: nombre, creditos: creditos, docente:
docente}
end
def alta_carga?(%Curso{creditos: creditos}), do: creditos >= 4
def cambiar_docente(%Curso{} = curso, nuevo_docente) do
%Curso{curso | docente: nuevo_docente}
end
end

curso = Curso.new("CS101", "Programación", 3, "Dr. García")
Curso.alta_carga?(curso)
curso_actualizado = Curso.cambiar_docente(curso, "Dra. López")
curso.docente
IO.inspect(curso)
IO.inspect(curso_actualizado)
