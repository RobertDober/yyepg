defmodule Yyepg.YYMessage do

  defstruct severity: :error, message: "", line_number: 0

  # Semantic meaning
  #                   +----------------------------------------- no error but the user shall be informed by something, e.g.
  #                   |                                              - a better way to write the input
  #                   |                                              - deprecation of a feature
  #                   |       +--------------------------------- the parsed element does notcomply to specification but a default/guess was assumed
  #                   |       |                                     following blocks shall be parsed correctly
  #                   |       |          +---------------------- the concerned element's representaion will be faulty, the rest of the parsed input
  #                   |       |          |                          might be corrupted
  #                   |       |          |        +------------- an unrecoverable error occured or too many errors occured, the output has no meaning
  #                   |       |          |        |        +---- should not occur in released library code, purely for dev purpose
  #                   |       |          |        |        |
  #                   v       v          v        v        v
  @type severity_t :: :info | :warning | :error | :fatal | :debug

  @type t :: %__MODULE__{severity: severity_t, message: binary(), line_number: number()}
  @type ts :: list(t)

  @spec add( ts, {severity_t, binary(), number()} ) :: ts
  def add messages, message_tuple

  def add messages, {severity, message, line_number} do
    [%__MODULE__{severity: severity, message: message, line_number: line_number} | messages]
  end
end
