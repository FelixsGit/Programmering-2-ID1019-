defmodule Eager do

  def test() do
    env = add(:x, 5, new())
    env = add(:y, 12, env)
    env = add(:z, 6, env)
    eval_expr({:cons, {:var, :y}, {:atm, :z}}, env)
  end

  def eval_expr({:atm, id}, _ ) do
    {:ok, id}
  end

  def eval_expr({:var, id}, env) do
    case lookup(id, env) do
      nil ->
        :error
        { _, str} ->
          {:ok, id}
        end
  end

  def eval_expr({:cons, {:var, id1 }, {:atm, id2}}, env) do
    case eval_expr({:atm, id2}, env) do
      :error ->
        :error
        {:ok, id2} ->
          case eval_expr({:var, id1}, env) do
            :error ->
              :error
              {:ok, ts} ->
                {ts, id2}
          end
      end
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
