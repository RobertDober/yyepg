defmodule YYepg.YYResult do

#   use YYepg.Types
#   alias YYepg.YYStructure
#   alias YYepg.YYMessage
#   alias YYepg.YYLine

#   defstruct status: :ok, yystructures: [], messages: []

#   @type status_t :: :ok | :error
#   @type t :: %__MODULE__{status: status_t, yystructures: YYStructure.ts, messages: YYMessage.ts}

#   @type partial_t :: { YYLine.ts , t }


#   @doc """
#   Just reverse the yystructures list
#   """
#   @spec finalize( t, YYStructure.ts ) :: t
#   def finalize yyresult, open_sections

#   def finalize yyresult = %{yystructures: yystructures}, [] do 
#     %{yyresult | yystructures: Enum.reverse( yystructures )}
#   end
#   def finalize yyresult = %{messages: messages}, open_sections do
#     with messages <- YYMessage.add_warnings_for_open_sections(messages, open_sections) do
#       finalize %{yyresult | messages: messages}, []
#     end
#   end
end
