defmodule Yyepg.Lexer.TokensTest do
  use ExUnit.Case

  import YYepg.Lexer, only: [lex: 1]

  describe "single tokens" do
    [
      { "#", {:header, "#"}}
    ] |> Enum.each( fn {str, {expected_token, expected_parsed}} ->
     test "string " <> str <> " lexes as " <> to_string(expected_parsed) do
       {act_token, act_parsed, _} = lex(unquote(str)) |> hd()
       assert act_token == unquote(expected_token)
       assert act_parsed == unquote(expected_parsed)
     end
    end)

  end

end
