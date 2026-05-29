defmodule AlCheckDemo.Calculator do
  @moduledoc """
  Tiny arithmetic helpers used as a fixture for the AlCheck tour.
  """

  @doc """
  Returns the sum of two integers.

  ## Examples

      iex> AlCheckDemo.Calculator.add(2, 3)
      5

  """
  @spec add(integer(), integer()) :: integer()
  def add(a, b), do: a + b

  @doc """
  Returns the difference of two integers.

  ## Examples

      iex> AlCheckDemo.Calculator.sub(5, 2)
      3

  """
  @spec sub(integer(), integer()) :: integer()
  def sub(a, b), do: a - b

  @doc """
  Returns the product of two integers.

  ## Examples

      iex> AlCheckDemo.Calculator.mul(4, 3)
      12

  """
  @spec mul(integer(), integer()) :: integer()
  def mul(a, b), do: a * b

  @doc """
  Integer division. Returns `{:error, :division_by_zero}` for a zero divisor.

  ## Examples

      iex> AlCheckDemo.Calculator.divide(10, 2)
      {:ok, 5}

      iex> AlCheckDemo.Calculator.divide(1, 0)
      {:error, :division_by_zero}

  """
  @spec divide(integer(), integer()) :: {:ok, integer()} | {:error, :division_by_zero}
  def divide(_a, 0), do: {:error, :division_by_zero}
  def divide(a, b), do: {:ok, div(a, b)}
end
