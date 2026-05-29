defmodule AlCheckDemo.MoneyTest do
  use ExUnit.Case, async: true

  alias AlCheckDemo.Money

  doctest Money

  describe "to_cents/1" do
    test "converts whole dollars" do
      assert Money.to_cents(7) == 700
    end

    test "handles zero" do
      assert Money.to_cents(0) == 0
    end
  end

  describe "add/2" do
    test "sums cent amounts" do
      assert Money.add(199, 301) == 500
    end
  end

  describe "sub/2" do
    test "subtracts cent amounts" do
      assert Money.sub(1000, 250) == 750
    end

    test "allows negative results" do
      assert Money.sub(100, 250) == -150
    end
  end

  describe "format/1" do
    test "formats whole dollars" do
      assert Money.format(500) == "$5.00"
    end

    test "pads cents below ten" do
      assert Money.format(1205) == "$12.05"
    end

    test "formats negative amounts with a leading minus" do
      assert Money.format(-50) == "-$0.50"
    end
  end
end
