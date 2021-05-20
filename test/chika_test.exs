defmodule ChikaTest do
  use ExUnit.Case
  doctest Chika

  test "greets the world" do
    assert Chika.hello() == :world
  end
end
