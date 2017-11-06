defmodule YYepg.YYResult do

  use YYepg.Types
  alias YYepg.YYStructure

  defstruct status: :ok, yystructures: [], messages: []
  @type t :: %__MODULE__{status: status_t, yystructures: YYStructure.ts, messages: message_ts}

  @type partial_t :: { numbered_line_ts, t }


  @doc """
  Just reverse the yystructures list
  """
  @spec finalize( t ) :: t
  def finalize yyresult

  def finalize yyresult = %__MODULE__{yystructures: yystructures} do 
    %{yyresult | yystructures: Enum.reverse( yystructures )}
  end
end
