defmodule Exercies do

  #This function outputs a list where all entered elements are duplicated
  def duplicate([]) do
    []
  end

  def duplicate(list) do
    [head | tail] = list
    [head, head | duplicate(tail)]
  end

end
