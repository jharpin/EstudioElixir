Code.require_file("Benchmark.ex", __DIR__)

defmodule Concurrencia do
  @cantidad_pasos 5

  def main do
    Benchmark.determinar_tiempo_ejecucion({Concurrencia, :simulacion, [@cantidad_pasos]})
    |> generar_mensaje()
    |> IO.puts()
  end

  def simulacion(cantidad_pasos) do
    cocineros = [
      {" Carlos", 2000},
      {"\t Beatriz", 1500},
      {"\t\t Diana", 1000},
      {"\t\t\t Felipe", 500}
    ]

    Enum.each(cocineros, fn cocinero ->
      preparar_plato(cocinero, cantidad_pasos)
    end)
  end

  def preparar_plato({nombre, demora}, cantidad_pasos) do
    IO.puts("#{nombre} -> (Comienza a cocinar)")

    Enum.each(1..cantidad_pasos, fn paso ->
      :timer.sleep(demora)
      IO.puts("\t#{nombre} - ingrediente #{paso}")
    end)

    IO.puts("#{nombre} -> (Plato terminado)\n")
  end

  def generar_mensaje(tiempo) do
    "\nEl tiempo total de preparación fue de #{tiempo} microsegundos."
  end
end

Concurrencia.main()
