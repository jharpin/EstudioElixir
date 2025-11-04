defmodule ProductosIVA do
  @tasa_iva 0.19

  def procesar(archivo_entrada, archivo_salida) do
    # Leer el archivo CSV
    contenido = File.read!(archivo_entrada)

    # Separar encabezado y líneas
    [encabezado | lineas] = String.split(contenido, "\n", trim: true)

    # Procesar cada línea
    productos_con_iva =
      Enum.map(lineas, fn linea ->
        [codigo, nombre, precio_str] = String.split(linea, ",")
        precio = String.to_float(precio_str)
        iva = precio * @tasa_iva
        precio_con_iva = precio + iva

        "#{codigo},#{nombre},#{precio},#{iva},#{precio_con_iva}"
      end)

    # Crear nuevo contenido con encabezado extendido
    nuevo_encabezado = "codigo,nombre,precio,iva,precio_con_iva"
    contenido_salida = [nuevo_encabezado | productos_con_iva]

    # Escribir el archivo de salida
    File.write!(archivo_salida, Enum.join(contenido_salida, "\n"))
  end
end
