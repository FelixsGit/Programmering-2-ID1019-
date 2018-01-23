defmodule Exercies do

  #This functions adds an element to the list if the list dosn't already
  #contain that element
  def add(element, list) do
    list2 = list
    checkIfElementInList(element,list,list2)
  end

  def checkIfElementInList(element,list,list2) do
    [head | tail] = list
    if(head == element) do
      "Element #{element} is already in the list"
    else
      if(tail == []) do
        list2 ++ [element]
      else
        checkIfElementInList(element,tail,list2)
      end
    end
  end

end
