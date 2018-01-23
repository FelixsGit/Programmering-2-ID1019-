defmodule Exercies do

  #This function return the sum of all element in a listLength
  def addElementsInList(list) do
      calculateSumOfElements(list,0)
  end

  def calculateSumOfElements(list, sum) do
    if(list == []) do
      IO.puts "The sum off all elemnts are #{sum}"
    else
      [head | list] = list
      calculateSumOfElements(list, sum + head)
    end
  end

end
