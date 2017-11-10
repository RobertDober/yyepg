defmodule YYepg.YYResult do

  use YYepg.Types
  alias YYepg.YYStructure
  alias YYepg.YYMessage

  defstruct status: :ok, yystructures: [], messages: [], current_yystructure: nil

  @type status_t :: :ok | :error
  @type t :: %__MODULE__{status: status_t, yystructures: YYStructure.ts, messages: YYMessage.ts, current_yystructure: maybe(YYStructure.t)}

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
