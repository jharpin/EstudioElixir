#spawn -> crea un proceso, retorna un PID

#spawn/1-> spawn(fn-> ... end)

# resp = spawn(fn  ->
#   IO.puts("Hola desde spawn/1")
#   "Hola desde un proceso spawn/1"
#  end)
# IO.puts("PID: #{inspect(resp)}")

#spawn/3 -> spawn(Modulo, :funcion, [arg1, arg2])
defmodule Test do
 def saludar(msg) do
   IO.puts(msg)
 end
end
#resp2 = spawn(Test, :saludar, ["Carlos"])
#IO.puts("PID: #{inspect(resp2)}")


#Task.async-> crea un proceso que retorna una struckt %Task{}
#Task.async/1-> Task.async(fn-> ... end)
# task = Task.async(fn ->
#   "Hola desde Task.async/1"
# end)
# IO.puts("Task: #{inspect(task)}")
#Task.async/3 -> Task.async(Modulo, :funcion, [arg1, arg2])
tarea = Task.async(Test, :saludar, ["Hola desde Task.async/3"])

#Task.await -> espera a que el proceso termine y retorna el resultado
#Task.await/2 -> Task.await(task, timeout//50000)
# return = Task.await(task)
# IO.puts("Return: #{return}")

return2 = Task.await(tarea)
IO.puts("Return: #{return2}")
