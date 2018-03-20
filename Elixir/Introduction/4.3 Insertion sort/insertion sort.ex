defmodule Sort do

  def isort(list) do
    isort(list, [])
  end
  def isort([], sortedList) do
    beterReverse(sortedList)
  end
  def isort([head | tail], sortedList) do
    isort(tail, insert(head, sortedList))
  end

  #If the sortedList is empty..
  def insert(x,[]) do
    [x]
  end
  #no swap and printout
  def insert(x, [head | tail]) when x > head do
    [x, head | tail]
  end
  #swap and no printout in correct order
  def insert(x, [head | tail]) do
    [head | insert(x, tail)]
  end

  def beterReverse(list) do
    op = fn(h, t)->[h | t] end
    List.foldl(list, [], op)
  end
end
