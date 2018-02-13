defmodule Chopstick do

  def start() do
    spawn_link(fn -> available() end)
  end

  def available() do
    receive do
      {:request, from} -> send(from, :chopstickTaken)
        #IO.puts "Chopstick with id #{inspect self()} was taken"
        gone()
      :quit -> :ok
    end
  end

  def gone() do
    receive do
      :return -> #IO.puts "Chopstick with id #{inspect self()} is now available"
        available()
      :quit -> :ok
    end
  end

  def request(stick, timeout) do
    send(stick, {:request, self()})
    receive do
      :chopstickTaken -> :processHaveStick
    after timeout -> :no
    end
  end

end
