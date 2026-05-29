defmodule AlCheckDemo.Validator do
  @moduledoc """
  Input validation helpers used as a fixture for the AlCheck tour.
  """

  @doc """
  Returns `true` when the argument is a non-empty binary.

  ## Examples

      iex> AlCheckDemo.Validator.non_empty?("hi")
      true

      iex> AlCheckDemo.Validator.non_empty?("")
      false

  """
  @spec non_empty?(term()) :: boolean()
  def non_empty?(str) when is_binary(str), do: byte_size(str) > 0
  def non_empty?(_), do: false

  @doc """
  Clamps `value` into `[min, max]`. Returns the value itself when in range,
  otherwise the nearest bound.

  ## Examples

      iex> AlCheckDemo.Validator.clamp(5, 1, 10)
      5

      iex> AlCheckDemo.Validator.clamp(100, 1, 10)
      10

  """
  @spec clamp(integer(), integer(), integer()) :: integer()
  def clamp(value, min, _max) when value < min, do: min
  def clamp(value, _min, max) when value > max, do: max
  def clamp(value, _min, _max), do: value
end
