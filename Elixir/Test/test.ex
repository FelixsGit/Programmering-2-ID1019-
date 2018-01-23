defmodule Test do

  def sumOfElements(list) do
    sum(list, 0)
  end
  def sum([], sum) do
    sum
  end
  def sum(list, sum) do
    [head | tail] = list
    sum(tail, sum + head)
  end

  def reverse([]) do
    IO.puts "End"
  end
  def reverse(list) do
    [head | tail] = list
    x = reverse(tail)
    x ++ [head]
  end

end
