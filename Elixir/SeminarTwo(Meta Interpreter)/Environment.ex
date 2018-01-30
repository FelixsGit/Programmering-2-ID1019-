defmodule Env do

  def test() do
    env = add(:x, 5, new())
    env = add(:y, 12, env)
    env = add(:z, 6, env)
    env = remove([:x], env)
  end

  def new() do
    []
  end

  def add(id, str, env) do
    [{id, str} | env]
  end

  def lookup(_, []) do
    nil
  end

  def lookup(id, [{var, str} | rest]) do
    if(id == var) do
      {id , str}
    else
      lookup(id, rest)
    end
  end

  def remove([], env) do
    env
  end

  def remove([head | tail], environment) do
    newEnvironment = remove(head, environment)
    remove(tail , newEnvironment)
  end

  def remove(var, environment) do
    List.keydelete(environment, var, 0)
  end
end
