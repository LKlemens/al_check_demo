# DEMO: missing `@moduledoc` is caught by `mix credo --strict --only readability`.
defmodule AlCheckDemo.Lists do
  @doc """
  Sums a list of integers.

  ## Examples

      iex> AlCheckDemo.Lists.sumList([1, 2, 3])
      6

  """
  # DEMO: non-idiomatic camelCase name `sumList` (should be `sum_list`) trips
  # Credo.Check.Readability.FunctionNames.
  @spec sumList(list(integer())) :: integer()
  def sumList(list), do: Enum.sum(list)

  @doc """
  Returns the maximum element of a list, or `nil` when empty.

  ## Examples

      iex> AlCheckDemo.Lists.max_element([3, 1, 4, 1, 5])
      5

      iex> AlCheckDemo.Lists.max_element([])
      nil

  """
  @spec max_element(list(integer())) :: integer() | nil
  def max_element([]), do: nil
  def max_element(list), do: Enum.max(list)

  @doc """
  Chunks a list into pairs (last chunk may be a singleton).

  ## Examples

      iex> AlCheckDemo.Lists.chunk_pairs([1, 2, 3, 4])
      [[1, 2], [3, 4]]

  """
  @spec chunk_pairs(list(term())) :: list(list(term()))
  def chunk_pairs(list), do: Enum.chunk_every(list, 2)

  @doc """
  Returns the unique elements of a list, preserving order.

  ## Examples

      iex> AlCheckDemo.Lists.uniq([1, 2, 1, 3, 2])
      [1, 2, 3]

  """
  @spec uniq(list(term())) :: list(term())
  def uniq(list), do: Enum.uniq(list)
end
