defmodule YYepg.YYStructure.YYRawLines do

    use YYepg.Types

    defstruct lines: []
    @type t :: %__MODULE__{lines: numbered_lines_t}
  
end
