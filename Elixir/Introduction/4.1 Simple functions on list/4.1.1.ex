defmodule Exercise do

  #This functions outputs the n'th element in a list
  def nth(index, list) do
    [head | tail] = list
    if(tail == []) do
      "Index outside of list"
    else
      if(index == 0) do
        head
      else
        nth(index-1, tail)
      end
    end
  end

end
