defmodule Exercies do

  #This functions returns the number of elements in the list..
  def listLength(list) do
    calculateListLength(list, 0)
  end

  def calculateListLength(list, count) do
    if(list == []) do
      count
    else
      [head | tail] = list
      calculateListLength(tail,count+1)
    end
  end

end
