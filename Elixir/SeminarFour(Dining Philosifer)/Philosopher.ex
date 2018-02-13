defmodule Philosopher do

  @eating 1000
  @sleeping 5000
  @waiting 1000
  @timeout 3000

  def start(hunger, right, left, name, ctrl) do
    spawn_link(fn -> dream(hunger, right, left, name, ctrl) end)
  end

  def dream(hunger,right, left, name, ctrl) do
    sleep(@sleeping)
    eat(hunger, right, left, name, ctrl)
  end

  def wait(hunger, right, left, name , ctrl) do
    IO.puts "#{name} FAILED TO EAT"
    sleep(@waiting)
    eat(hunger, right, left, name, ctrl)
  end

  def eat(hunger, right, left, name , ctrl) do
    if(hunger > 0) do
      case Chopstick.request(right, @timeout) do
        :processHaveStick ->
          IO.puts "#{name} received right chopstick"
        :no -> wait(hunger, right, left, name , ctrl)
      end
      sleep(4000)
      case Chopstick.request(left, @timeout) do
        :processHaveStick ->
          IO.puts "#{name} received left chopstick"
        :no -> send(right, :return)
          wait(hunger, right, left, name , ctrl)
      end
      sleep(@eating)
      send(right, :return)
      IO.puts "#{name} is done eating"
      IO.puts "#{name} returned right chopstick"
      send(left, :return)
      IO.puts "#{name} returned left chopstick"
      hunger = hunger - 1
      if(hunger < 1) do
        IO.puts "#{name} belly is ful!"
        send(ctrl, :quit)
      else
        dream(hunger,right, left, name, ctrl)
      end
    else
      IO.puts "#{name} belly is full!"
      send(ctrl, :quit)
    end
  end

  defp sleep(t) do
    :timer.sleep(:rand.uniform(t))
  end

end
