defmodule Math do
  def sum_n(0), do: 0
  def sum_n(n),do: n + sum_n(n - 1)
end
IO.puts(Math.sum_n(5))
