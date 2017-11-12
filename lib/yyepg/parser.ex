defmodule YYepg.Parser do

  use YYepg.Types

  alias YYepg.YYResult
  alias YYepg.YYStructure
  alias YYepg.YYMessage
  alias YYepg.YYLine

  @spec parse( binary() ) :: YYResult.t
  def parse string
  def parse string do
    string
    |> String.split(~r{\n\r?}) 
    |> Enum.with_index()
    |> Enum.map(&YYLine.new/1)
    |> parse_structures()
  end

  @empty_line     ~r{\A\s*\z}
  @section_opener ~r{\A(\w*)(>+)(?!\S)(.*)}
  @section_closer ~r{\A(\w*)(>+)(?!\S)(.*)}
  

  @spec parse_structures( YYLine.ts ) :: YYResult.t
  def parse_structures numbered_lines

  def parse_structures( [] ), do: %YYResult{}
  def parse_structures( [numbered_line | rest] ) do
    with {text, _} <- numbered_line do
      if Regex.match?(@empty_line, text),
        do: parse_structures(rest),
        else: parse_structures1(rest, %YYResult{})
    end
  end

  # First line is not empty anymore
  @spec parse_structures1( YYLine.ts, YYResult.t ) :: YYResult.t
  defp parse_structures1 numbered_lines, yyresult
  
  defp parse_structures1( [], yyresult ), do: YYResult.finalize(yyresult)
  defp parse_structures1( numbered_lines = [numbered_line | rest], yyresult ) do
    with {text, lnb} <- numbered_line do
      {rest1, yyresult1} = 
        cond do
          matches = Regex.run(@section_opener, text) ->
            parse_rest_of_section(matches, numbered_lines, yyresult)
          matches = Regex.run(@section_closer, text) ->
            parse_close_section(matches, numbered_lines, yyresult)
          true ->
            parse_content_of_section(numbered_lines, yyresult)
        end
      parse_structures1(rest1, yyresult1)
    end
  end


  @spec parse_rest_of_section( list(binary()), YYLine.ts, YYResult.t ) :: YYResult.partial_t
  defp parse_rest_of_section matches, numbered_lines, yyresult

  defp parse_rest_of_section _matches, numbered_lines, yyresult do 
    {numbered_lines, yyresult}
  end

  @spec parse_close_section( list(binary()), YYLine.ts, YYResult.t ) :: YYResult.partial_t
  defp parse_close_section matches, numbered_lines, yyresult

  defp parse_close_section _matches, numbered_lines, yyresult do 
    {numbered_lines, yyresult}
  end

  @spec parse_content_of_section( YYLine.ts, YYResult.t ) :: YYResult.partial_t
  defp parse_content_of_section numbered_lines, yyresult

  defp parse_content_of_section numbered_lines=[{_,lnb}|_], yyresult=%{current_yystructure: nil} do
    with new_yystructure <- YYStructure.make_implicit(yyresult.yystructures) do
      parse_content_of_section(
        numbered_lines,
        %{yyresult |
           messages: 
             YYMessage.add(yyresult.messages, {:warning, "Made an implicit structure #{new_yystructure}", lnb}),
           current_yystructure: new_yystructure})
    end
  end
  defp parse_content_of_section numbered_lines, yyresult do 
    {numbered_lines, yyresult}
  end
end
