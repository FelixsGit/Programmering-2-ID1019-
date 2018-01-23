defmodule Exercies do

  #This function removes duplicated elements in a entered deleteAllElementFromList
  def unique(list) do
    findUniqueElements(list)
  end

  def findUniqueElements([]) do
    []
  end

  def findUniqueElements(list) do
    [head | tail] = list
    [head | unique(delete(tail,head))]
  end
  

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
