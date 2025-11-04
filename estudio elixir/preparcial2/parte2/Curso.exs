defmodule Curso do

defstruct [:codigo, :nombre, :creditos, :docente]
def new(codigo, nombre, creditos, docente) do
%Curso{codigo: codigo, nombre: nombre, creditos: creditos, docente:
docente}
end
def alta_carga?(%Curso{creditos: creditos}),
  do: IO.puts(if(creditos >= 4, do: "Curso de alta carga", else: "Curso de baja carga"))

def cambiar_docente(%Curso{} = curso, nuevo_docente) do
%Curso{curso | docente: nuevo_docente}
end
end

curso = Curso.new("CS101", "Programación", 4, "Dr. García")
Curso.alta_carga?(curso)
curso_actualizado = Curso.cambiar_docente(curso, "Dra. López")
IO.inspect(curso)
IO.inspect(curso_actualizado)
