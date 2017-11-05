defmodule YYepg.Lexer do
  
  use YYepg.Types

  @spec lex( binary() ) :: token_ts
  def lex string do
    with {:ok, tokens, _} <- 
      string
      |> to_charlist()
      |> :lexer.string() do
        elixirize_tokens(tokens,[])
        |> Enum.reverse()
      end
  end

  defp elixirize_tokens(tokens, rest)
  defp elixirize_tokens([], result), do: result
  defp elixirize_tokens([{token, text, lnb}|rest], result), do: elixirize_tokens(rest, [{token,to_string(text), lnb}|result])
end
