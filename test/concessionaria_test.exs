defmodule ConcessionariaTest do
  use ExUnit.Case
  doctest Concessionaria

  @tag :pending
  test "greets the world" do
    assert Concessionaria.hello() == :world
  end
end
