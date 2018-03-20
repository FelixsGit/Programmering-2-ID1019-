defmodule Env do

  def test() do
    seq = [{:match, {:var, :x}, {:atm,:a}},
    {:match, {:var, :y}, {:cons, {:var, :x}, {:atm, :b}}},
    {:match, {:cons, :ignore, {:var, :z}}, {:var, :y}},
    {:var, :z}]
    Eager.eval_seq(seq, [])
  end

  def new do
    []
  end

  def add(id, str, env) do
    [{id, str} | env]
  end

  def lookup( _id, []) do nil end

  def lookup(id, [{id, str} | rest]) do
    {id, str}
  end

  def lookup(id, [{var, str} | rest]) do
    lookup(id, rest)
  end

  def remove([head | tail], env) do
    newEnvironment = remove(head, env)
    remove(tail, newEnvironment)
  end

  def remove(var, env) do
    List.keydelete(env, var, 0)
  end

end
