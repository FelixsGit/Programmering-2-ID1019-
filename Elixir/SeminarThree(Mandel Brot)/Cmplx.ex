defmodule Cmplx do

  def new(r, i) do
    {r, i}
  end

  def add({realA , imaA}, {realB, imaB}) do
    {realA + realB, imaA + imaB}
  end

  def sqr({real, ima}) do
    {real*real - ima*ima , 2*real*ima}
  end

  def abs({real, ima}) do
    result = :math.sqrt(real*real + ima*ima)
    result
  end

end
