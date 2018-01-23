defmodule Exercies do

  #This function reverses to order of elements in the entered list
  def reverse(list) do
    addElementToNewList(list,[])
  end

  def addElementToNewList([], newList) do
    newList
  end

  def addElementToNewList([head | list] , newList) do
    addElementToNewList(list,[head | newList])
  end
end
