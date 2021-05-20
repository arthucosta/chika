defmodule Chika.Utils.Args do
  def parse(content) do
    content
    |> String.split(" ")
    |> tl
  end
end
