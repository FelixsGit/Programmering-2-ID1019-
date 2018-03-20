defmodule Eager do

  def eval_expr({:atm, id}, _ ) do
    {:ok, id}
  end

  def eval_expr({:var, id}, env) do
    case Env.lookup(id, env) do
      nil -> :error
      { _, str} -> {:ok, str}
    end
  end

  def eval_expr({:cons, {:var, str1}, {:atm, str2}}, env) do
    case eval_expr({:var, str1}, env) do
      :error -> :error
      {:ok, str1} ->
        case eval_expr({:atm, str2}, env) do
          :error -> :error
          {:ok, str2} -> {:ok,{str1, str2}}
        end
    end
  end

  def eval_match(:ignore, _ , env) do
    {:ok, env}
  end

  def eval_match({:atm, id}, id, env) do
    {:ok, env}
  end

  def eval_match({:var, id}, str, env) do
    case Env.lookup(id, env) do
      nil -> {:ok, Env.add(id, str, env)}
      {_, ^str} -> {:ok, env}
      {_, _} -> :fail
    end
  end

  def eval_match({:cons, hp, tp}, {str1 ,str2}, env) do
    case eval_match(hp, str1, env) do
      :fail -> :fail
      {:ok, env} ->
        eval_match(tp, str2, env)
    end
  end

  def eval_match(_, _, _) do
    :fail
  end


  def eval_seq([exp], env) do
    eval_expr(exp, env)
  end

  def eval_seq([{:match, pattern, expr} | rest], env) do
    case eval_expr(expr, env) do
      :error -> :error
      {:ok, str} ->
        vars = extract_vars(pattern)
        env = Env.remove(vars, env)
        case eval_match(pattern, str , env) do
            :fail -> :error
            {:ok, env} -> eval_seq(rest, env)
        end
    end
  end

  def extract_vars(pattern) do
    extract_vars(pattern, [])
  end

  def extract_vars({:atm, _}, variables) do
    variables
  end

  def extract_vars(:ignore, variables) do
    variables
  end

  def extract_vars({:var, var}, variables) do
    [var | variables]
  end

  def extract_vars({:cons, head, tail}, variables) do
    extract_vars(tail, extract_vars(head, variables))
  end

end
