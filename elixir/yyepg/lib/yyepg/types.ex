defmodule YYepg.Types do

  defmacro __using__( options \\ [] ) do
    quote do
      @type token_t  :: {atom(), binary(), number()}
      @type token_ts :: list(token_t)

      @type block_t  :: {atom(), binary(), map(), block_ts}
      @type block_ts :: list(block_t)

      @type status_t :: :ok | :error

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

      @type message_t  :: {severity_t, binary(), number()}
      @type message_ts :: list(message_t)
    end
  end
  
end
