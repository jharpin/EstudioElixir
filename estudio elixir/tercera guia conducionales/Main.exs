defmodule Main do
  def main()do
    #Util.pedir("ingrese su edad: ", :Integer)
    #|> condicional_if()
    #Util.pedir("ingrese su contraseña: ", :String)
    #|> condicional_unless()
    #Util.pedir("ingrese su nota", :float)
    #|> condicional_cond()
    Util.pedir("ingrese una vocal",:String)
    |> condicional_case()
    Util.pedir("ingrese un punto (x,y)", :tuple)
    |> condicional_guards()

  end

  def condicional_if(edad) do
    if edad > 17 do
      Util.mostrar_mensaje("Eres mayor de edad")
    else
      Util.mostrar_mensaje("Eres menor de edad")
    end
  end
  def condicional_unless(contraseña) do
    unless contraseña === "56567" do
      Util.mostrar_mensaje("Contraseña incorrecta")
    else
      Util.mostrar_mensaje("Contraseña correcta")
    end
  end
  def condicional_cond(nota)do
    cond do
      nota >=4.5 -> Util.mostrar_mensaje("Sobresaliente")
      nota >=3.0 -> Util.mostrar_mensaje("Notable")
      nota <3.0 -> Util.mostrar_mensaje("Insuficiente")
    end
  end
def condicional_case(vocal) do
  case vocal do
    "a" -> Util.mostrar_mensaje("Es una vocal")
    "e" -> Util.mostrar_mensaje("Es una vocal")
    "i" -> Util.mostrar_mensaje("Es una vocal")
    "o" -> Util.mostrar_mensaje("Es una vocal")
    "u" -> Util.mostrar_mensaje("Es una vocal")
    _   -> Util.mostrar_mensaje("No es una vocal")
  end
end

  def condicional_guards(puntos) do
    case puntos do
      {x,y} when x  === 0 and y === 0 -> Util.mostrar_mensaje("El valor es el punto origen")
      {x,_}when x === 0 -> Util.mostrar_mensaje("El valor esta sobre el eje Y")
      {_,y} when y === 0 -> Util.mostrar_mensaje("El valor esta sobre el eje X")
      {_,_} -> Util.mostrar_mensaje("El valor esta en el plano")
    end
  end
end
Main.main()
