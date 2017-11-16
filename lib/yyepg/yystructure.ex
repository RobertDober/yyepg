defmodule YYepg.YYStructure do

  use YYepg.Types


  @type t :: __MODULE__.YYSection.t | __MODULE__.YYRawLines.t
  @type ts :: list( t )

end
