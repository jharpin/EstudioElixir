defmodule Main do
  def main do
    lista = [1,2,3,4,5,6,7,8,9,10,11,90]
    lista2 = [3,5,7,2,8,1,4,6,59,3,5,7,2,8,1,4,6,59]
    lista3=[ 5, 2, 8]
    Util.mostrar_mensaje("Múltiplos de 3 o 5 en la lista: #{inspect(Util.mostrar_multiplos(lista), charlists: :as_lists)}")

    Util.mostrar_mensaje("Cantidad de múltiplos de 3 o 5: #{Util.contar_multiplos(lista)}")

    Util.mostrar_mensaje("los pares de la lista son #{inspect(Util.min_max(lista2))}")

    Util.mostrar_mensaje("Lista sin duplicados: #{inspect(Util.eliminar_duplicados(lista2), charlists: :as_lists)}")

    Util.mostrar_mensaje("Combinación que suma 10: #{inspect(Util.encontrar(lista3, 10), charlists: :as_lists)}")
  end
end

Main.main()
