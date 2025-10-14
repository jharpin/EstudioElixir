defmodule Libro do
defstruct [:isbn, :titulo, :autor, :anio, :prestado]
def new(isbn, titulo, autor, anio) do
%Libro{isbn: isbn, titulo: titulo, autor: autor, anio: anio, prestado:
false}
end
def prestar(%Libro{} = libro), do: %Libro{libro | prestado: true}
def devolver(%Libro{} = libro), do: %Libro{libro | prestado: false}
def disponible?(%Libro{prestado: prestado}), do: not prestado
end
libro = Libro.new("978-123", "Elixir in Action", "Saša Jurić", 2019)
libro_prestado = Libro.prestar(libro)
libro_devuelto = Libro.devolver(libro_prestado)
Libro.disponible?(libro) # true
Libro.disponible?(libro_prestado) # false
Libro.disponible?(libro_devuelto) # true

#impresiones
IO.puts("Libro original disponible?: #{Libro.disponible?(libro)}")
IO.puts("Libro prestado disponible?: #{Libro.disponible?(libro_prestado)}")
IO.puts("Libro devuelto disponible?: #{Libro.disponible?(libro_devuelto)}")

IO.inspect(libro)
IO.inspect(libro_prestado)
IO.inspect(libro_devuelto)
