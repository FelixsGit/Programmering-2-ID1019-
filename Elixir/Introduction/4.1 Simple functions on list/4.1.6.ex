defmodule Exercies  do

  #This function will remove all elements that match the entered element in
  #a list.
  def delete(list, element) do
    deleteAllElementFromList(element, list)
  end

  def deleteAllElementFromList( _,[]) do
    []
  end

  def deleteAllElementFromList(element, list) do
    [head | tail] = list
    if(element == head) do
      list -- [element]
      delete(tail,element)
    else
    [head | deleteAllElementFromList(element, tail)]
    end
  end


end
