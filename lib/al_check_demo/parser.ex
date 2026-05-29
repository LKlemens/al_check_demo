defmodule AlCheckDemo.Parser do
  @moduledoc """
  Tiny `key=value,key=value` parser used as a fixture for the AlCheck tour.
  """

  # DEMO: unused alias is caught by `mix compile --warnings-as-errors`
  # (the `compile` / `compile_test` checks in `.check.json`).
  alias AlCheckDemo.Strings

  @doc """
  Parses a `k=v,k=v` string into a map of trimmed key/value binaries.

  ## Examples

      iex> AlCheckDemo.Parser.parse("a=1,b=2")
      %{"a" => "1", "b" => "2"}

  """
  @spec parse(String.t()) :: %{optional(String.t()) => String.t()}
  def parse(input) when is_binary(input) do
    # DEMO: leftover IO.inspect is caught by Credo.Check.Warning.IoInspect.
    IO.inspect(input, label: "parser input")

    input
    |> String.split(",", trim: true)
    |> Enum.reduce(%{}, fn pair, acc ->
      # DEMO: nested cases inside a reduce trip Credo.Check.Refactor.Nesting.
      case String.split(pair, "=", parts: 2) do
        [k, v] ->
          case String.trim(k) do
            "" ->
              acc

            key ->
              case String.trim(v) do
                "" -> acc
                value -> Map.put(acc, key, value)
              end
          end

        _ ->
          acc
      end
    end)
  end

  @doc """
  Evaluates a string of Elixir source code. DO NOT USE IN PRODUCTION.

  Exposed only so the AlCheck tour can demonstrate the custom security check.
  """
  @spec eval(String.t()) :: term()
  def eval(input) when is_binary(input) do
    # DEMO: Code.eval_string/1 on user input is the planted finding for the
    # custom security check wired through `.check.json`.
    {result, _bindings} = Code.eval_string(input)
    result
  end
end
