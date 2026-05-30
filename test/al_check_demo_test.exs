defmodule AlCheckDemoTest do
  use ExUnit.Case, async: true

  doctest AlCheckDemo

  test "name/0 returns the library name" do
    assert AlCheckDemo.name() == "al_check_demo"
  end
end
