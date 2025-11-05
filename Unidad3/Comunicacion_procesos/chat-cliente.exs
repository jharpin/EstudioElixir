defmodule ChatCliente do
  # ═══════════════════════════════════════════════════════════
  # 🔧 CONFIGURACIÓN - Modifica solo estas líneas
  # ═══════════════════════════════════════════════════════════

  # Para LOCALHOST (misma computadora con --sname):
  @nombre_servicio_local :cliente_chat
  @servicio_local {@nombre_servicio_local, node()}  # Se construye automático
  @nodo_remoto :servidor  # Solo nombre, se construye el @hostname automático
  @servicio_remoto {:chat_servidor, @nodo_remoto}

  # Para RED (diferentes computadoras con --name):
  # Descomentar y modificar estas líneas:
  # @nombre_servicio_local :cliente_chat
  # @servicio_local {@nombre_servicio_local, :"nodocliente1@192.168.1.91"}
  # @nodo_remoto :"nodoservidor@192.168.1.94"
  # @servicio_remoto {:chat_servidor, @nodo_remoto}

  # ═══════════════════════════════════════════════════════════
  # No modificar debajo de esta línea
  # ═══════════════════════════════════════════════════════════

  def main() do
    mostrar_banner()

    # Para --sname, construir el nodo completo
    nodo_servidor_completo = construir_nodo_servidor()

    IO.puts(IO.ANSI.yellow() <> "📡 Conectando a: #{nodo_servidor_completo}" <> IO.ANSI.reset())

    nombre = solicitar_nombre()

    registrar_servicio()
    |> establecer_conexion(nombre, nodo_servidor_completo)
    |> iniciar_chat(nombre, nodo_servidor_completo)
  end

  defp construir_nodo_servidor() do
    # Si @nodo_remoto no tiene @, construirlo automáticamente
    nodo_str = Atom.to_string(@nodo_remoto)

    if String.contains?(nodo_str, "@") do
      @nodo_remoto
    else
      # Obtener hostname del nodo actual
      mi_hostname = node() |> Atom.to_string() |> String.split("@") |> List.last()
      String.to_atom("#{nodo_str}@#{mi_hostname}")
    end
  end

  defp mostrar_banner() do
    IO.puts("\n" <> IO.ANSI.cyan())
    IO.puts("╔═══════════════════════════════════════╗")
    IO.puts("║       💬 CHAT EN TIEMPO REAL 💬      ║")
    IO.puts("╚═══════════════════════════════════════╝")
    IO.puts(IO.ANSI.reset())
  end

  defp solicitar_nombre() do
    IO.gets("\n👤 Ingresa tu nombre: ")
    |> String.trim()
    |> validar_nombre()
  end

  defp validar_nombre(""), do: solicitar_nombre()
  defp validar_nombre(nombre) when byte_size(nombre) > 20 do
    IO.puts(IO.ANSI.red() <> "✗ Nombre muy largo (máximo 20 caracteres)" <> IO.ANSI.reset())
    solicitar_nombre()
  end
  defp validar_nombre(nombre), do: nombre

  defp registrar_servicio() do
    Process.register(self(), @nombre_servicio_local)
    :ok
  end

  defp establecer_conexion(:ok, nombre, nodo_servidor) do
    case Node.connect(nodo_servidor) do
      true ->
        servicio = {:chat_servidor, nodo_servidor}
        send(servicio, {:conectar, self(), nombre})
        esperar_confirmacion(nombre)
      false ->
        {:error, "No se pudo conectar al servidor"}
      :ignored ->
        {:error, "Nodo ya conectado"}
    end
  end

  defp esperar_confirmacion(nombre) do
    receive do
      {:conectado, ^nombre} -> :ok
      {:error, razon} -> {:error, razon}
    after
      5000 -> {:error, "Timeout: el servidor no respondió"}
    end
  end

  defp iniciar_chat(:ok, nombre, nodo_servidor) do
    IO.puts(IO.ANSI.green() <> "\n✓ Conectado exitosamente como '#{nombre}'" <> IO.ANSI.reset())
    mostrar_ayuda()

    spawn(fn -> bucle_lectura(nombre, nodo_servidor) end)
    bucle_receptor()
  end

  defp iniciar_chat({:error, razon}, _nombre, _nodo) do
    IO.puts(IO.ANSI.red() <> "\n✗ Error: #{razon}" <> IO.ANSI.reset())
    IO.puts("Intenta de nuevo.\n")
  end

  defp mostrar_ayuda() do
    IO.puts("\n" <> IO.ANSI.blue() <> "━━━ Comandos disponibles ━━━")
    IO.puts("  /usuarios  - Ver usuarios conectados")
    IO.puts("  /ayuda     - Mostrar esta ayuda")
    IO.puts("  /salir     - Salir del chat")
    IO.puts("  Cualquier otro texto será enviado como mensaje")
    IO.puts("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" <> IO.ANSI.reset() <> "\n")
  end

  defp bucle_lectura(nombre, nodo_servidor) do
    entrada = IO.gets("") |> String.trim()

    case procesar_entrada(entrada, nodo_servidor) do
      :continuar -> bucle_lectura(nombre, nodo_servidor)
      :salir ->
        send(self_registered(), :salir)
        :ok
    end
  end

  defp bucle_receptor() do
    receive do
      {:mensaje_chat, mensaje, :sistema} ->
        IO.puts(IO.ANSI.yellow() <> mensaje <> IO.ANSI.reset())
        bucle_receptor()

      {:mensaje_chat, mensaje, _tipo} ->
        IO.puts(mensaje)
        bucle_receptor()

      {:info, info} ->
        IO.puts(IO.ANSI.cyan() <> info <> IO.ANSI.reset())
        bucle_receptor()

      :salir ->
        IO.puts(IO.ANSI.green() <> "✓ Desconectado. ¡Hasta pronto!" <> IO.ANSI.reset() <> "\n")
        :ok

      _ ->
        bucle_receptor()
    end
  end

  defp self_registered() do
    Process.whereis(@nombre_servicio_local)
  end

  defp procesar_entrada("", _nodo), do: :continuar

  defp procesar_entrada("/salir", nodo_servidor) do
    IO.puts(IO.ANSI.yellow() <> "\n👋 Saliendo del chat..." <> IO.ANSI.reset())
    servicio = {:chat_servidor, nodo_servidor}
    send(servicio, {:desconectar, self_registered()})
    Process.sleep(300)
    :salir
  end

  defp procesar_entrada("/usuarios", nodo_servidor) do
    servicio = {:chat_servidor, nodo_servidor}
    send(servicio, {:listar_usuarios, self_registered()})
    :continuar
  end

  defp procesar_entrada("/ayuda", _nodo) do
    mostrar_ayuda()
    :continuar
  end

  defp procesar_entrada(texto, nodo_servidor) do
    servicio = {:chat_servidor, nodo_servidor}
    send(servicio, {:mensaje, self_registered(), texto})
    :continuar
  end
end

ChatCliente.main()
