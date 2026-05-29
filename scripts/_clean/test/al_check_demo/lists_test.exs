defmodule AlCheckDemo.ListsTest do
  use ExUnit.Case, async: true

  alias AlCheckDemo.Lists

  doctest Lists

  describe "sum_list/1" do
    test "sums integers" do
      assert Lists.sum_list([1, 2, 3, 4]) == 10
    end

    test "returns 0 for an empty list" do
      assert Lists.sum_list([]) == 0
    end
  end

  describe "max_element/1" do
    test "returns the largest integer" do
      assert Lists.max_element([3, 1, 4, 1, 5, 9, 2]) == 9
    end

    test "returns nil for an empty list" do
      assert Lists.max_element([]) == nil
    end
  end

  describe "chunk_pairs/1" do
    test "chunks into pairs" do
      assert Lists.chunk_pairs([1, 2, 3, 4]) == [[1, 2], [3, 4]]
    end

    test "leaves an odd element in its own chunk" do
      assert Lists.chunk_pairs([1, 2, 3]) == [[1, 2], [3]]
    end
  end

  describe "uniq/1" do
    test "removes duplicates while preserving order" do
      assert Lists.uniq([1, 2, 1, 3, 2, 4]) == [1, 2, 3, 4]
    end
  end
end
