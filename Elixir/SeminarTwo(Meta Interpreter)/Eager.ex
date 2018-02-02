defmodule Eager do

  def test() do
    seq = [{:match, {:var, :x}, {:atm,:a}},
    {:match, {:var, :y}, {:cons, {:var, :x}, {:atm, :b}}},
    {:match, {:cons, :ignore, {:var, :z}}, {:var, :y}},
    {:var, :z}]
    """
    env = add(:x, 5, new())
    env = add(:y, 12, env)
    env = add(:z, 6, env)
    """
    #eval_expr({:cons, {:var, :y}, {:atm, :p}}, env)
    #eval_match({:atm, :a}, :a, [])
    #eval_match({:var, :x}, :a, [])
    #eval_match({:var, :x}, :a, [])
    #eval_match({:var, :x}, :y, env)
    #eval_match({:cons, {:var, :x}, {:var, :x}}, {:cons, {:atm, :a}, {:atm, :b}}, [])
    eval_seq(seq, [])
  end

  def eval_match(:ignore, ..., ...) do
    {:ok, ...}
  end
  def eval_match({:atm, a}, :a, []) do
    {:ok, []}
  end
  def eval_match({:var, x}, :a, []) do
    {:ok, add(x, :a, [])}
  end
  def eval_match({:var, id}, str, env) do
    case lookup(id, env) do
      nil ->{:ok, add(id, str, env)}
      {_, ^str} ->{:ok, env}
      {_, _} ->:fail
    end
  end
  def eval_match({:cons, hp, tp}, {:cons , {_, str1}, {_, str2}}, env) do
    case eval_match(hp, str1, env) do
      :fail ->:fail
      {:ok, newEnv} ->eval_match(tp, str2, newEnv)
    end
  end
  def eval_match(_, _, _) do
    :fail
  end

  def eval_seq([exp], env) do
    eval_expr(exp, env)
  end
  def eval_seq([{:match, lhs, rhs} | rest], env) do
    case eval_expr(lhs, env) do
      :error->
        {:ok, newEnv} =
          case rhs do
            {:cons, _, _} -> eval_match(lhs, rhs, env)
            {_, str} -> eval_match(lhs, str, env)
          end
        eval_seq(rest, newEnv)
      {:ok, str} -> IO.inspect env
    end
  end

  def eval_expr({:var, id}, env) do
    case lookup(id, env) do
      nil ->:error
      { _, str} ->{:ok, id}
    end
  end
  def eval_expr({:cons, {:var, id1 }, {:atm, id2}}, env) do
    case eval_expr({:atm, id2}, env) do
      :error ->:error
      {:ok, id2} ->
        case eval_expr({:var, id1}, env) do
          :error ->:error
          {:ok, ts} ->{ts, id2}
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
      {var , str}
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
