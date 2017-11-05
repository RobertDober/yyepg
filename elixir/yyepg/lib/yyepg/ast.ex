defmodule YYepg.Ast do

  use YYepg.Types

  defstruct status: :ok, blocks: [], messages: []
  @type t :: %__MODULE__{status: status_t, blocks: block_ts, messages: message_ts}

  @spec reverse( t ) :: t
  def reverse(ast)
  def reverse(ast = %__MODULE__{blocks: blocks}) do
     %{ast | blocks: Enum.reverse(blocks)}
  end
end
