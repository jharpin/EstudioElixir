defmodule ChatServidor do
  @nombre_servicio :chat_servidor

  def main() do
    IO.puts("\n" <> IO.ANSI.green() <> "╔═══════════════════════════════════════╗")
    IO.puts("║   🚀 SERVIDOR DE CHAT INICIADO 🚀   ║")
    IO.puts("╚═══════════════════════════════════════╝" <> IO.ANSI.reset())
    IO.puts("Esperando conexiones...\n")

    Process.register(self(), @nombre_servicio)

    # Estado inicial: mapa vacío de clientes {pid => nombre}
    bucle_servidor(%{})
  end

  defp bucle_servidor(clientes) do
    receive do
      # Cuando un cliente se conecta
      {:conectar, pid_cliente, nombre_usuario} ->
        if usuario_existe?(clientes, nombre_usuario) do
          send(pid_cliente, {:error, "El nombre '#{nombre_usuario}' ya está en uso"})
          bucle_servidor(clientes)
        else
          # Agregar cliente al mapa
          nuevos_clientes = Map.put(clientes, pid_cliente, nombre_usuario)

          # Notificar al cliente que se conectó exitosamente
          send(pid_cliente, {:conectado, nombre_usuario})

          # Notificar a todos que hay un nuevo usuario
          mensaje_entrada = "🟢 #{nombre_usuario} se ha unido al chat"
          broadcast(nuevos_clientes, mensaje_entrada, :sistema)

          log_servidor("#{nombre_usuario} conectado (#{map_size(nuevos_clientes)} usuarios)")
          bucle_servidor(nuevos_clientes)
        end

      # Cuando un cliente envía un mensaje
      {:mensaje, pid_cliente, texto} ->
        nombre = Map.get(clientes, pid_cliente, "Desconocido")
        timestamp = obtener_timestamp()
        mensaje_formateado = "[#{timestamp}] #{nombre}: #{texto}"

        broadcast(clientes, mensaje_formateado, nombre, pid_cliente)
        bucle_servidor(clientes)

      # Cuando un cliente solicita la lista de usuarios
      {:listar_usuarios, pid_cliente} ->
        lista = clientes
        |> Map.values()
        |> Enum.sort()
        |> Enum.with_index(1)
        |> Enum.map(fn {nombre, idx} -> "  #{idx}. #{nombre}" end)
        |> Enum.join("\n")

        mensaje = "\n👥 Usuarios conectados (#{map_size(clientes)}):\n#{lista}"
        send(pid_cliente, {:info, mensaje})
        bucle_servidor(clientes)

      # Cuando un cliente se desconecta
      {:desconectar, pid_cliente} ->
        case Map.get(clientes, pid_cliente) do
          nil ->
            bucle_servidor(clientes)

          nombre ->
            nuevos_clientes = Map.delete(clientes, pid_cliente)
            mensaje_salida = "🔴 #{nombre} ha salido del chat"
            broadcast(nuevos_clientes, mensaje_salida, :sistema)

            log_servidor("#{nombre} desconectado (#{map_size(nuevos_clientes)} usuarios)")
            bucle_servidor(nuevos_clientes)
        end

      # Manejo de caída de proceso (cliente se desconecta abruptamente)
      {:DOWN, _ref, :process, pid_cliente, _razon} ->
        case Map.get(clientes, pid_cliente) do
          nil ->
            bucle_servidor(clientes)

          nombre ->
            nuevos_clientes = Map.delete(clientes, pid_cliente)
            mensaje_salida = "🔴 #{nombre} se ha desconectado"
            broadcast(nuevos_clientes, mensaje_salida, :sistema)

            log_servidor("#{nombre} desconectado inesperadamente")
            bucle_servidor(nuevos_clientes)
        end

      _ ->
        bucle_servidor(clientes)
    end
  end

  # Envía un mensaje a todos los clientes conectados
  defp broadcast(clientes, mensaje, tipo, remitente_pid \\ nil) do
    Enum.each(clientes, fn {pid, _nombre} ->
      # No enviar el mensaje de vuelta al remitente
      if pid != remitente_pid do
        send(pid, {:mensaje_chat, mensaje, tipo})
      end
    end)
  end

  # Verifica si un nombre de usuario ya existe
  defp usuario_existe?(clientes, nombre) do
    clientes
    |> Map.values()
    |> Enum.member?(nombre)
  end

  # Obtiene timestamp formateado
  defp obtener_timestamp() do
    {{_year, _month, _day}, {hour, minute, second}} = :calendar.local_time()
    :io_lib.format("~2..0B:~2..0B:~2..0B", [hour, minute, second])
    |> IO.iodata_to_binary()
  end

  # Log del servidor
  defp log_servidor(mensaje) do
    timestamp = obtener_timestamp()
    IO.puts(IO.ANSI.yellow() <> "[SERVIDOR #{timestamp}] #{mensaje}" <> IO.ANSI.reset())
  end
end

ChatServidor.main()
