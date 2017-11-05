defmodule YYepg.Parser do

  use YYepg.Types

  import YYepg.Lexer, only: [lex: 1]
  import YYepg.Ast

  @spec parse( binary() ) :: Ast.t
  def parse string do
    with tokens <- lex(string) do
      parse_blocks(tokens, []) |> Ast.reverse()
    end
  end

  @spec parse_blocks(token_ts, Ast.t) :: Ast.t 
  defp parse_blocks(tokens, ast)
  defp parse_blocks([], ast), do: ast
  defp paese_blocks([{:nl,_,_}], ast), do: ast
  defp parse_blocks([{:header,level,_} | rest], ast) do
    with ast1 <- parse_header(skip_ws(rest))
  end
  defp paese_blocks([_|t], ast) do
    parse_blocks(t, ast)
  end
  
  @spec parse_header( token_ts, Ast.t ) :: Ast.t
  defp parse_header(tokens, ast)
  defp parse_header([{:header, header, lnb}, {:nl, _, _} | rest], ast) do
    parse_blocks(rest, Ast.add_error(ast, {:error, "Missing text for header #{inspect(header)}", lnb}))  
  end

  @spec skip_ws( token_ts ) :: token_ts
  defp skip_ws(tokens)
  defp skip_ws([{:ws, _, _} | rest]), do: skip_ws(rest)
  defp skip_ws(tokens),       do: tokens
end
