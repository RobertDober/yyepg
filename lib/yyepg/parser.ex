defmodule YYepg.Parser do

  use YYepg.Types

  alias YYepg.YYResult
  alias YYepg.YYStructure

  @spec parse( binary() ) :: YYResult.t
  def parse string
  def parse string do
    string
    |> String.split(~r{\n\r?}) 
    |> Enum.with_index()
    |> parse_structures( %YYResult{} )
  end


  @spec parse_structures( numbered_line_ts, YYResult.t ) :: YYResult.t
  def parse_structures numbered_lines, yyresult
  
  def parse_structures( _, yyresult), do: yyresult



end
