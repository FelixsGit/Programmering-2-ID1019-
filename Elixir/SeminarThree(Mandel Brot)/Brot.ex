defmodule Brot do

  def mandelbrot(c, m) do
    z0 = Cmplx.new(0,0)
    test(0, z0, c, m)
  end

  def test(counter, z, c, maxIterations) do
    if(Cmplx.abs(z) > 2) do
      counter
    else
      if(maxIterations == counter) do
        0
      else
        sq = Cmplx.sqr(z)
        newZ = Cmplx.add(sq, c)
        test(counter + 1, newZ, c, maxIterations)
      end
    end
  end

end
