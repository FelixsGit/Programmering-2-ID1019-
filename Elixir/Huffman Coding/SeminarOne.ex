defmodule Huffman do

  def my_test(numberOfChars) do
    msg = read('kallocain.txt', numberOfChars)
    startTime = getTimeInMillis()
    tree = huffman_tree(freq(msg))
    table = encode_table(tree)
    bitsequence = encode(msg, table)
    decode(bitsequence, table)
    doneTime = (getTimeInMillis() - startTime)/1000
    IO.puts 'runtime = #{doneTime} s'
  end

  def getTimeInMillis() do
    :os.system_time(:millisecond)
  end

  def extractFreq ({c, f}) do
    f
  end

  def freq(msg) do
    Enum.sort(freq(msg, []), fn ({_, f1}, {_, f2}) -> f1 <= f2 end)
  end
  def freq([], freqList) do
    freqList
  end
  def freq([char | rest], freqList) do
      freq(rest, update(freqList, char))
  end

  # Returns element x if it is in the list, otherwise false
  def update([], char) do [{char, 1}] end
  def update([{char, f} | rest], char) do
    [{char, f+1} | rest]
  end
  def update([tuple | rest], char) do
    [tuple | update(rest, char)]
  end

  def huffman_tree([{tree, _}]) do tree end
  def huffman_tree([{c1, f1}, {c2, f2} | rest]) do
    huffman_tree(insert({{c1, c2}, f1 + f2}, rest))
  end

  def insert({c, f}, []) do [{c, f}] end
  def insert({c, f}, [{ch, fh} | t]) when f <= fh do
      [{c, f}, {ch, fh} | t]
  end
  def insert({c, f}, [h | t]) do
    [h | insert({c, f}, t)]
  end

  def encode_table(tree) do
    tree_to_table(tree, [], [])
  end

  def tree_to_table({}, path, acc) do acc end
  def tree_to_table({left, right}, path, acc) do
    tree_to_table(left, path ++ [0], acc) ++ tree_to_table(right, path ++ [1], acc) ++ acc
  end
  def tree_to_table(char, path, _) do
    [{char, path}]
  end

  # Complexity: O(tableSize * msgSize)
 def encode([], _) do [] end
 def encode([char | rest], table) do
   encode_char(char, table) ++ encode(rest, table)
 end

 # Complexity: O(tableSize)
 def encode_char(char, [{char, path} | _]) do
   path
 end
 def encode_char(char, [{_, _} | rest]) do
   encode_char(char, rest)
 end

  def decode([], _), do: []
  def decode(seq, table) do
    {char, rest} = decode_char(seq, 1, table)
    [char | decode(rest, table)]
  end
  def decode_char(seq, n, table) do
    {code, rest} = Enum.split(seq, n)
    case List.keyfind(table, code, 1) do
      {char,_} -> {char, rest}
      nil ->
        decode_char(seq, n + 1, table)
    end
  end

  def read(file, n) do
    {:ok, file} = File.open(file, [:read])
    binary = IO.read(file, n)
    File.close(file)
    case :unicode.characters_to_list(binary, :utf8) do
      {:incomplete, list, _} ->
        list;
        list ->
          list
    end
  end

end
