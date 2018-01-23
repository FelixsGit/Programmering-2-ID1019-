defmodule M do
  def main do
    data_stuff()
  end

  def data_stuff do
    my_string = "My Sentence"

    #outputs the length of variable my_string
    IO.puts "Length : #{String.length(my_string)}"

    #appends "is longer" to the variable my_string and stores the
    # - result in variable longer_string
    longer_string = my_string <> " " <> "is longer"

    #checks if my_string contains "My" and outputs result
    IO.puts "My ? #{String.contains?(my_string, "My")}"

    #outputs first char in the varaibe my_string
    IO.puts "First : #{String.first(my_string)}"

    #outputs the char at index 4 in the varaibe my_string
    IO.puts "Index 4 : #{String.at(my_string, 4)}"

    #outputs the substring created when slicing my_string
    #- at char position 3 and continuing for another 8 chars.
    IO.puts "Substring : #{String.slice(my_string, 3, 8)}"

    4 * 10 |> IO.puts

    #check if the person is old enough to drink and purchase alcohol
    age = 21
    IO.puts "Person can drink and buy alochol: #{(age >= 18) and (age >= 21)}"
  end
end
