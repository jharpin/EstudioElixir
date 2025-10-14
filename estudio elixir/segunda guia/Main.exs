defmodule Main do
  def main()do
    Util.obtener_dato("ingresa tu nombre")
    |> Util.mostrar_mensaje()

  end

end

Main.main()
