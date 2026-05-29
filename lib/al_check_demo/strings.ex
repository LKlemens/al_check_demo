defmodule AlCheckDemo.Strings do
  @moduledoc """
  String helpers used as a fixture for the AlCheck tour.
  """

  @doc """
  Reverses a string.

  ## Examples

      iex> AlCheckDemo.Strings.reverse("hello")
      "olleh"

  """
  @spec reverse(String.t()) :: String.t()
  def reverse(str) do
       # DEMO: bad indentation + trailing whitespace below trigger `mix format --check-formatted`.
       String.reverse(str)   
  end

  @doc """
  Counts whitespace-separated words.

  ## Examples

      iex> AlCheckDemo.Strings.word_count("the quick brown fox")
      4

  """
  @spec word_count(String.t()) :: non_neg_integer()
  def word_count(str) do
    str
    |> String.split(~r/\s+/, trim: true)
    |> length()
  end

  @doc """
  Truncates a string to at most `max` bytes.

  ## Examples

      iex> AlCheckDemo.Strings.truncate("hello world", 5)
      "hello"

  """
  @spec truncate(String.t(), pos_integer()) :: String.t()
  def truncate(str, max) when byte_size(str) <= max, do: str
  def truncate(str, max), do: String.slice(str, 0, max)
end
