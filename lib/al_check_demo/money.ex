defmodule AlCheckDemo.Money do
  @moduledoc """
  Money math using integer cents to avoid floating-point errors.
  """

  @doc """
  Converts whole dollars to cents.

  ## Examples

      iex> AlCheckDemo.Money.to_cents(12)
      1200

  """
  @spec to_cents(integer()) :: integer()
  def to_cents(dollars) when is_integer(dollars), do: dollars * 100

  @doc """
  Adds two cent amounts.

  ## Examples

      iex> AlCheckDemo.Money.add(150, 250)
      400

  """
  @spec add(integer(), integer()) :: integer()
  def add(a, b) when is_integer(a) and is_integer(b), do: a + b

  @doc """
  Subtracts `b` cents from `a` cents.

  ## Examples

      iex> AlCheckDemo.Money.sub(500, 200)
      300

  """
  @spec sub(integer(), integer()) :: integer()
  def sub(a, b) when is_integer(a) and is_integer(b), do: a - b

  @doc """
  Formats a cent amount as `$X.YY`.

  ## Examples

      iex> AlCheckDemo.Money.format(1234)
      "$12.34"

      iex> AlCheckDemo.Money.format(-50)
      "-$0.50"

  """
  @spec format(integer()) :: String.t()
  def format(cents) when is_integer(cents) do
    sign = if cents < 0, do: "-", else: ""
    abs_cents = abs(cents)
    dollars = div(abs_cents, 100)
    rest = rem(abs_cents, 100)
    "#{sign}$#{dollars}.#{String.pad_leading("#{rest}", 2, "0")}"
  end
end
