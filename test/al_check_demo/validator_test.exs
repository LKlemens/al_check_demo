defmodule AlCheckDemo.ValidatorTest do
  use ExUnit.Case, async: true

  alias AlCheckDemo.Validator

  doctest Validator

  describe "non_empty?/1" do
    test "returns true for non-empty binaries" do
      assert Validator.non_empty?("hello")
    end

    test "returns false for an empty binary" do
      refute Validator.non_empty?("")
    end

    test "returns false for non-binary input" do
      refute Validator.non_empty?(nil)
      refute Validator.non_empty?(123)
    end
  end

  describe "clamp/3" do
    test "returns the value when in range" do
      assert Validator.clamp(5, 1, 10) == 5
    end

    test "clamps to the upper bound" do
      assert Validator.clamp(100, 1, 10) == 10
    end

    test "clamps to the lower bound" do
      assert Validator.clamp(-5, 1, 10) == 1
    end
  end
end
