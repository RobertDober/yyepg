defmodule YYepg.Parser do

  use YYepg.Types

  alias YYepg.YYResult
  alias YYepg.YYStructure.YYSection
  alias YYepg.YYMessage
  alias YYepg.YYLine
  alias YYepg.YYLine.YYBeginSection
  alias YYepg.YYLine.YYEndSection
  alias YYepg.YYLine.YYText


  @doc """
  A convienience function splitting a string into lines, parsing the lines and passing the parsed lines
  on to the structural parse funcion `parse_structures`.
  """
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
  

  @doc """
  Skips empty lines before parsing the rest of the lines with `parse_structures1`.
  """
  @spec parse_structures( YYLine.ts ) :: YYResult.t
  def parse_structures yylines

  def parse_structures( [] ), do: %YYResult{}
  def parse_structures( yylines = [%YYText{content: content} | rest] ) do
    if Regex.match?(@empty_line, content) do
      parse_structures(rest)
    else
      parse_structures1(yylines, %YYResult{})
    end
  end
  def parse_structures( yylines ) do
    parse_structures1(yylines, %YYResult{})
  end

  # First line is not empty anymore
  @spec parse_structures1( YYLine.ts, YYResult.t, YYSection.ts ) :: YYResult.t
  defp parse_structures1 yylines, yyresult, open_sections
  
  defp parse_structures1( [], yyresult, open_sections ), do: YYResult.finalize(yyresult, open_sections)
  defp parse_structures1( yylines = [%YYText{} | rest], yyresult, open_sections ) do
    # add error about adding default segment ">"
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
  end
  defp parse_content_of_section numbered_lines, yyresult do 
    {numbered_lines, yyresult}
  end
end
