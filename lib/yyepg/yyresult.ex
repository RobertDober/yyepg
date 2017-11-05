defmodule YYepg.YYResult do

  use YYepg.Types
  alias YYepg.YYStructure

  defstruct status: :ok, yystructures: [], messages: []
  @type t :: %__MODULE__{status: status_t, yystructures: YYStructure.ts, messages: message_ts}

end
