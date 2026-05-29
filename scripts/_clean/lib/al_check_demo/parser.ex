defmodule AlCheckDemo.Parser do
  @moduledoc """
  Tiny `key=value,key=value` parser used as a fixture for the AlCheck tour.
  """

  @doc """
  Parses a `k=v,k=v` string into a map of trimmed key/value binaries.

  ## Examples

      iex> AlCheckDemo.Parser.parse("a=1,b=2")
      %{"a" => "1", "b" => "2"}

  """
  @spec parse(String.t()) :: %{optional(String.t()) => String.t()}
  def parse(input) when is_binary(input) do
    input
    |> String.split(",", trim: true)
    |> Enum.flat_map(&parse_pair/1)
    |> Map.new()
  end

  defp parse_pair(pair) do
    case String.split(pair, "=", parts: 2) do
      [k, v] ->
        key = String.trim(k)
        value = String.trim(v)
        if key == "" or value == "", do: [], else: [{key, value}]

      _ ->
        []
    end
  end
end
