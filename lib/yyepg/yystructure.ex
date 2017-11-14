defmodule YYepg.YYStructure do

  use YYepg.Types

  defmodule YYSection do
    use YYepg.Types
    defstruct level: 1, name: "", content: "", line_numbers: {0, 0}, children: []
    @type t ::
      %__MODULE__{
        level: number(),
        name: binary(),
        content: binary(),
        line_numbers: line_numbers_t(),
        children: YYepg.YYStructure.ts}
    @type ts :: list(t)
  end

  defmodule YYRawLines do
    use YYepg.Types
    defstruct lines: []
    @type t :: %__MODULE__{lines: numbered_lines_t}
  end

  @type t :: __MODULE__.YYSection.t | __MODULE__.YYRawLines.t
  @type ts :: list( t )

end
