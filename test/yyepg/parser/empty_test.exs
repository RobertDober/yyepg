defmodule YYepg.Parser.EmptyTest do
  use ExUnit.Case
  
  import YYepg.Parser, only: [parse: 1]

  describe "empty" do
    assert parse("") == {:ok, [], []}
  end
end
