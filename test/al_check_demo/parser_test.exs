defmodule AlCheckDemo.ParserTest do
  use ExUnit.Case, async: true

  alias AlCheckDemo.Parser

  doctest Parser

  describe "parse/1" do
    test "parses a single k=v pair" do
      assert Parser.parse("name=alice") == %{"name" => "alice"}
    end

    test "parses multiple comma-separated pairs" do
      assert Parser.parse("a=1,b=2,c=3") == %{"a" => "1", "b" => "2", "c" => "3"}
    end

    test "trims whitespace around keys and values" do
      assert Parser.parse(" k = v ") == %{"k" => "v"}
    end

    test "skips entries with empty keys" do
      assert Parser.parse("=v") == %{}
    end

    test "skips entries with empty values" do
      assert Parser.parse("k=") == %{}
    end

    test "skips entries with no equals sign" do
      assert Parser.parse("nokey") == %{}
    end

    test "returns an empty map for an empty input" do
      assert Parser.parse("") == %{}
    end
  end
end
