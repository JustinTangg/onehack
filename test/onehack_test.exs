defmodule OneHackTest do
  use ExUnit.Case
  doctest OneHack

  test "greets the world" do
    assert OneHack.hello() == :world
  end
end
