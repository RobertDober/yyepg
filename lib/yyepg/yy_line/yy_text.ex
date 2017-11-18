defmodule YYepg.YYLine.YYText do

  use YYepg.Types
    @moduledoc """
    A structure describing a text line

    These are its fields:

    * `content`: The whole text of the line.
    * `line_nb`: Passed in if known used to represent the line number for purely documentatial purposes.

        iex> YYLine.new({"hello world", 42})
        %YYText{content: "hello world", line_nb: 42}

    """
    defstruct content: "", line_nb: 0
    @type t :: %__MODULE__{content: binary(), line_nb: number()}
  
end
