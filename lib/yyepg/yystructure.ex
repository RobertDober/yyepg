defmodule YYepg.YYStructure do

  use YYepg.Types

  defmodule YYSection do
    defstruct level: 1, name: "", content: "", line_numbers: {0, 0}, children: []
    @type t ::
      %__MODULE__{
        level: number(),
        name: binary(),
        content: binary(),
        line_numbers: line_numbers_t,
        children: ts}
  end

  defmodule YYRawLines do
    defstruct lines: [], line_numbers: {0, 0}
    @type t :: %__MODULE__{lines: list(binary()), line_numbers: line_numbers_t}
  end

  @type t :: __MODULE__.YYSection.t | __MODULE__.YYRawLines.t
  @type ts :: list( t )

end
