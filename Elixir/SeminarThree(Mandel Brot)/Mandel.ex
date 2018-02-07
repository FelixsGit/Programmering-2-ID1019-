defmodule Mandel do

  def mandelbrot(width, height, x, y, k, depth) do
    trans = fn(w, h) -> Cmplx.new(x + k * (w - 1), y - k * (h - 1)) end
    rows(width, height, trans, depth, [])
  end

  def rows(_, 0, _, _, rows) do
    rows
  end

  def rows(width, height, trans, depth, rows) do
    row = row(width, height, trans, depth, [])
    rows(width, height - 1, trans , depth, [ row | rows])
  end

  def row(0, _, _, _, row) do
    row
  end

  def row(width, height, trans, maxIterations, row) do
    imaC = trans.(width, height)
    result = Brot.mandelbrot(imaC, maxIterations)
    color = Color.convert(result, maxIterations)
    row(width - 1, height, trans, maxIterations, [color | row])
  end

end
