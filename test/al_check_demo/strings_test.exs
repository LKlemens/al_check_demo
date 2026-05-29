defmodule AlCheckDemo.StringsTest do
  use ExUnit.Case, async: true

  alias AlCheckDemo.Strings

  doctest Strings

  describe "reverse/1" do
    test "reverses a binary" do
      assert Strings.reverse("abc") == "cba"
    end

    test "is its own inverse" do
      assert "hello" |> Strings.reverse() |> Strings.reverse() == "hello"
    end
  end

  describe "word_count/1" do
    test "counts space-separated words" do
      assert Strings.word_count("one two three") == 3
    end

    test "treats runs of whitespace as one separator" do
      assert Strings.word_count("a   b\tc\n d") == 4
    end

    test "returns 0 for an empty or whitespace-only string" do
      assert Strings.word_count("") == 0
      assert Strings.word_count("   ") == 0
    end
  end

  describe "truncate/2" do
    test "leaves short strings untouched" do
      assert Strings.truncate("hi", 5) == "hi"
    end

    test "cuts long strings down to size" do
      assert Strings.truncate("hello world", 5) == "hello"
    end
  end
end
