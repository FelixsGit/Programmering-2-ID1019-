defmodule Exercies do

  # Returns a list containing lists of equal elements.
  def pack([]) do [] end
  def pack([head | tail]) do
    {all, rest} = match(head, tail, [], [])
    [all | pack(rest)]
  end

  #Returns a tuple of containing two lists , one lit with all elements
  #matching x and one list with all the elements not matching x.
  def match( x, [], all, rest) do
    all = all ++ [x]
    {all, rest}
  end

  #if the entered value is equal to the current value in the list, add it
  #to the list all
  def match(x,[x | tail], all, rest) do
    match(x, tail, [x | all], rest)
  end

  #if the entered value is not equal to the current value in the list,
  #add it to the list rest
  def match(x, [y | tail], all, rest) do
    match(x, tail, all, [y | rest])
  end

end
