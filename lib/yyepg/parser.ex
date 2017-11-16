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
  @spec parse_structures1( YYLine.ts, YYResult.t) :: YYResult.t
  defp parse_structures1 yylines, yyresult
  
  defp parse_structures1( [], yyresult ), do: YYResult.finalize(yyresult, [])
  defp parse_structures1( yylines = [%YYText{line_nb: line_nb} | rest], yyresult ) do
    message = %YYMessage{severity: :warning, line_nb: line_nb, message: "Implicitly opening a default section \">\" before this line"}
    section = YYSection.from_numbered_line({">", line_nb})
    parse_section( yylines, %{yyresult | messages: [message]}, [section] )
  end
  defp parse_structures1( yylines = [%YYEndSection{line_nb: line_nb} | rest], yyresult, open_sections) do
    messages = [%YYMessage{severity: :fatal, line_nb: line_nb, message: "Closing a section at beginning of file, aborting..."}]
    %{yyresult | status: :error, messages: messages} 
  end
  defp parse_structures1( yylines = [begin_section | rest], yyresult) do
    section = YYSection.from_yyline( begin_section )
    parse_section( rest, yyresult, [section] )
  end

  @spec parse_section( YYLine.ts, YYResult.t, YYSection.ts ) :: YYResult
  defp parse_section yylines, yyresult, open_sections

  defp parse_section( yylines, yyresult, open_sections ), do: yyresult



end
