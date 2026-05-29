defmodule AlCheckDemo.CalculatorTest do
  use ExUnit.Case, async: true

  alias AlCheckDemo.Calculator

  doctest Calculator

  describe "add/2" do
    test "sums two positive integers" do
      # DEMO: intentional wrong expectation — this is the single failing test
      # that `check --failed` will re-run on its own.
      assert Calculator.add(2, 3) == 6
    end

    test "handles negative numbers" do
      assert Calculator.add(-4, 1) == -3
    end
  end

  describe "sub/2" do
    test "subtracts the second from the first" do
      assert Calculator.sub(10, 4) == 6
    end
  end

  describe "mul/2" do
    test "multiplies two integers" do
      assert Calculator.mul(6, 7) == 42
    end

    test "returns zero when either side is zero" do
      assert Calculator.mul(0, 99) == 0
      assert Calculator.mul(99, 0) == 0
    end
  end

  describe "divide/2" do
    test "returns {:ok, quotient} for non-zero divisor" do
      assert {:ok, 5} = Calculator.divide(10, 2)
    end

    test "returns {:error, :division_by_zero} for zero divisor" do
      assert {:error, :division_by_zero} = Calculator.divide(1, 0)
    end
  end
end
