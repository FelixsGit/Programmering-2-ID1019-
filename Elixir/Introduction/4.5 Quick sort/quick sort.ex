defmodule Sort do

  def qsort([]) do
    []
  end
  def qsort([p | tail]) do
    {listOne, listTwo} = qsplit(p, tail, [], [])
    small = qsort(listOne)
    large = qsort(listTwo)
    small ++ [p] ++ large
  end

  def qsplit(p, [] , small, large) do
    {small, large}
  end
  def qsplit(p, [x | tail], small, large) do
    if(x <= p) do
      qsplit(p, tail, [x | small], large)
    else
      qsplit(p, tail, small, [x | large])
    end
  end

end
