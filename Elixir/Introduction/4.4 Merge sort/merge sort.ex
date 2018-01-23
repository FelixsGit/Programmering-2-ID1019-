defmodule Sort do


  def msort([]) do
    []
  end
  def msort([x]) do
    [x]
  end
  def msort(list) do
    {listOne, listTwo} = split(list, [], [])
    merge(msort(listOne), msort(listTwo))
  end

  def split([], listOne, listTwo) do
    {listOne, listTwo}
  end

  def split([x | tail], listOne, listTwo) do
    split(tail, [x | listTwo], listOne)
  end

  def merge(listOne, []) do
    listOne
  end
  def merge([], listTwo) do
    listTwo
  end
  #merges put no swap(right element is smaller than left)
  def merge([x1 | listOne], [x2 | _] = listTwo) when x1 < x2 do
    [x1 | merge(listOne, listTwo)]
  end
  #merges and swap(left element is smaller than right)
  def merge(listOne, [x2 | listTwo]) do
    [x2 | merge(listOne, listTwo)]
  end

  #kfnjakjkjdasdasdklnakdlnsjdnakjdn
end
