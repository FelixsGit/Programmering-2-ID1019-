defmodule TicTacToe do

  """
  def start() do
    spawn_link(fn->first() end)
  end
  """

  def first do
    receive do
      :tic -> second()
      whatever -> IO.puts "Thats not correct!"
        first()
    end
  end

  def second do
    receive do
      :tac -> third()
      whatever -> IO.puts "Wrong, now you have to start over!"
        first()
    end
  end

  def third do
    receive do
      :toe -> done()
      whatever -> "Wrong, now you have to start over!"
        first()
    end
  end

  def done() do
    IO.puts "TIC TAC TOE!"
  end

end
