defmodule Recurso do
  defstruct codigo: nil, nombre: nil, cupos: 0
end

defmodule Reserva do
  defstruct id: nil, recurso: nil, usuario: nil, cantidad: 0, cupos_restantes: nil
end
