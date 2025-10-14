defmodule Util do
  # --- Función para contar múltiplos ---
  def contar_multiplos([]), do: 0
  def contar_multiplos([head | tail]) do
    if rem(head, 3) == 0 or rem(head, 5) == 0 do
      1 + contar_multiplos(tail)
    else
      contar_multiplos(tail)
    end
  end
# --- Función para mostrar múltiplos ---
def mostrar_multiplos([]), do: []
def mostrar_multiplos([head | tail]) do
  if rem(head, 3) == 0 or rem(head, 5) == 0 do
    nueva_lista=[head | mostrar_multiplos(tail)]
    IO.inspect(nueva_lista, charlists: :as_lists)
  else
    mostrar_multiplos(tail)
  end
end
def min_max([]), do: {:error, :lista_vacia}
def min_max([elemento]), do: {elemento, elemento}
def min_max([head | tail]) do
{min_tail, max_tail} = min_max(tail)
min_actual = if head < min_tail, do: head, else: min_tail
max_actual = if head > max_tail, do: head, else: max_tail
{min_actual, max_actual}
end

# --- Función para eliminar duplicados ---
def eliminar_duplicados(lista), do: eliminar_aux(lista, [])
defp eliminar_aux([], acum), do: Enum.reverse(acum)
defp eliminar_aux([head | tail], acum) do
if esta_en?(head, acum) do
eliminar_aux(tail, acum)
else
eliminar_aux(tail, [head | acum])
end
end
defp esta_en?(_elem, []), do: false
defp esta_en?(elem, [h | t]) do
elem == h or esta_en?(elem, t)
end

# --- Función para encontrar combinación que sume un objetivo ---

def encontrar(lista, objetivo), do: buscar(lista, objetivo, [])
defp buscar(_lista, 0, acum), do: Enum.reverse(acum)
defp buscar([], _obj, _acum), do: {:error, :sin_solucion}
defp buscar([h | t], obj, acum) do
case buscar(t, obj - h, [h | acum]) do
{:error, :sin_solucion} -> buscar(t, obj, acum)
solucion -> solucion
end
end

  # --- Función para mostrar mensajes ---
  def mostrar_mensaje(mensaje) do
    IO.puts(mensaje)
  end
end
