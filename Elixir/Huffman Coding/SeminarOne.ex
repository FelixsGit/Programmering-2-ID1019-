defmodule Huffman do

  def sample do
    "the quick brown fox jumps over the lazy dog
    this is a sample text that we will use when we build
    up a table we will only handle lower case letters and
    no punctuation symbols the frequency will of course not
    represent english but it is probably not that far off"
  end

  def text do
    "this is something that we should encode"
  end

  def test do
    sample = sample()
    tree = tree(sample)
    encode = encode_table(tree)
    decode = decode_table(tree)
    text = text()
    seq = encode(text, encode)
    decode(seq, decode)
  end

  def tree({tree, _}) do
    tree
  end
  def tree([{char1, freq1}, {char2, freq2} | rest]) do
    tree(insert({{char1, char2} freq1 + freq2}), rest))
  end

  def encode_table(tree) do
    # To implement...
  end

  def decode_table(tree) do
    # To implement...
  end

  def encode(text, table) do
    # To implement...
  end

  def decode(seq, tree) do
    # To implement...
  end


  def freq(sample) do
    freq(sample, [])
  end
  def freq([], freqList) do
    tree(freqList)
  end
  def freq([char | rest], freqList) do
    freq(rest, update(freqList, char))
  end

  def update([], char) do
    [{char, 1}]
  end
  def update([{char, f} | rest], char) do
    [{char, f + 1} | rest]
  end
  def update([tuple | rest], char) do
    [tuple | update(rest, char)]
  end

end
