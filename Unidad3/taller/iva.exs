Code.require_file("elementos_iva.ex", __DIR__)

defmodule Iva do
  @cantidad 50_000

  # Calcula el precio final de un solo producto
  def calcular_precio(%ElementosIVA{nombre: nombre, precio_sin_iva: sin_iva, iva: iva}) do
    precio_final = sin_iva * (1 + iva)
    {nombre, precio_final}
  end

  # Genera una lista grande de productos simulados
  def generar_productos do
    Enum.map(1..@cantidad, fn n ->
      %ElementosIVA{
        nombre: "Producto_#{n}",
        stock: Enum.random(1..100),
        precio_sin_iva: Enum.random(100..1000),
        iva: 0.19
      }
    end)
  end

  # Procesamiento secuencial
  def calcular_secuencial(lista) do
    Enum.map(lista, &calcular_precio/1)
  end

  # Procesamiento concurrente
  def calcular_concurrente(lista) do
    lista
    |> Enum.map(fn prod -> Task.async(fn -> calcular_precio(prod) end) end)
    |> Task.await_many()
  end
  
  def iniciar do
    productos = generar_productos()

    IO.puts("\n Calculando precios de #{@cantidad} productos...\n")

    # Tiempo secuencial
    tiempo_secuencial =
      Benchmark.determinar_tiempo_ejecucion({__MODULE__, :calcular_secuencial, [productos]})

    # Tiempo concurrente
    tiempo_concurrente =
      Benchmark.determinar_tiempo_ejecucion({__MODULE__, :calcular_concurrente, [productos]})

    # Calcular speedup usando Benchmark
    mensaje = Benchmark.generar_mensaje(tiempo_concurrente, tiempo_secuencial)

    IO.puts("Resultados:\n")
    IO.puts("  - Tiempo secuencial:   #{tiempo_secuencial} µs")
    IO.puts("  - Tiempo concurrente:  #{tiempo_concurrente} µs")
    IO.puts("  - #{mensaje}")

    # Ejemplo de algunos resultados
    IO.puts("Ejemplos de precios finales:")
    Enum.take(calcular_concurrente(productos), 5)
    |> Enum.each(fn {nombre, precio} ->
      IO.puts("  #{nombre} -> #{Float.round(precio, 2)} COP")
    end)
  end
end

Iva.iniciar()
