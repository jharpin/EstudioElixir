defmodule Carrera do
  @moduledoc """
  Simulación de una carrera de carros en Elixir
  Comparando ejecución secuencial vs paralela
  """

  # Simula que un carro corre - tarda un tiempo aleatorio
  def correr_carro(numero) do
    tiempo = :rand.uniform(3000) + 1000  # Entre 1 y 4 segundos
    IO.puts("  Carro #{numero} INICIA la carrera!")

    # Simula el tiempo que tarda en correr
    Process.sleep(tiempo)

    IO.puts(" Carro #{numero} TERMINA! (tardó #{tiempo}ms)")
    {numero, tiempo}
  end

  # VERSIÓN SECUENCIAL - Un carro después del otro
  def carrera_secuencial(num_carros) do
    IO.puts("\n" <> String.duplicate("=", 50))
    IO.puts(" CARRERA SECUENCIAL (uno por uno)")
    IO.puts(String.duplicate("=", 50) <> "\n")

    tiempo_inicio = System.monotonic_time(:millisecond)

    # Cada carro corre uno después del otro
    resultados = Enum.map(1..num_carros, fn numero ->
      correr_carro(numero)
    end)

    tiempo_total = System.monotonic_time(:millisecond) - tiempo_inicio

    IO.puts("\n  Tiempo total secuencial: #{tiempo_total}ms")
    mostrar_ganador(resultados)
  end

  # VERSIÓN PARALELA - Todos corren al mismo tiempo
  def carrera_paralela(num_carros) do
    IO.puts("\n" <> String.duplicate("=", 50))
    IO.puts(" CARRERA PARALELA (todos al mismo tiempo)")
    IO.puts(String.duplicate("=", 50) <> "\n")

    tiempo_inicio = System.monotonic_time(:millisecond)

    # Creamos un proceso para cada carro
    padre = self()

    # Lanzamos todos los procesos al mismo tiempo
    Enum.each(1..num_carros, fn numero ->
      spawn(fn ->
        resultado = correr_carro(numero)
        # Enviamos el resultado al proceso padre
        send(padre, {:resultado, resultado})
      end)
    end)

    # Recolectamos los resultados de todos los carros
    resultados = Enum.map(1..num_carros, fn _ ->
      receive do
        {:resultado, res} -> res
      end
    end)

    tiempo_total = System.monotonic_time(:millisecond) - tiempo_inicio

    IO.puts("\n  Tiempo total paralelo: #{tiempo_total}ms")
    mostrar_ganador(resultados)
  end

  # Muestra quién ganó la carrera
  defp mostrar_ganador(resultados) do
    {ganador, tiempo_ganador} = Enum.min_by(resultados, fn {_num, tiempo} -> tiempo end)
    IO.puts("\ ¡El GANADOR es el Carro #{ganador}! (tiempo: #{tiempo_ganador}ms)")
  end

  # Función principal para ejecutar ambas carreras
  def demo do
    num_carros = 4

    IO.puts("\  Simulación de Carrera de #{num_carros} carros")
    IO.puts("Comparando: Secuencial vs Paralelo\n")

    # Primera carrera: SECUENCIAL
    carrera_secuencial(num_carros)

    # Pausa entre carreras
    Process.sleep(1000)

    # Segunda carrera: PARALELA
    carrera_paralela(num_carros)

    IO.puts("\n" <> String.duplicate("=", 50))
    IO.puts("NOTA:")
    IO.puts("- Secuencial: Los carros corren uno por uno")
    IO.puts("- Paralelo: Todos corren al mismo tiempo")
    IO.puts("- El paralelo es MUCHO más rápido! ")
    IO.puts(String.duplicate("=", 50) <> "\n")
  end
end

# Para ejecutar:
# 1. Guarda este archivo como carrera.exs
# 2. Ejecuta: elixir carrera.exs
# O en iex:
# c("carrera.exs")
# Carrera.demo()

Carrera.demo()
