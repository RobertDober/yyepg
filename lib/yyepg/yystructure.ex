defmodule YYepg.YYStructure do

  defstruct yytype: :yysection, yycontent: "", yyatts: %{}, yychildren: []
  @type t ::
    %__MODULE__{
      yytype: atom(),
      yycontent: binary(),
      yyatts: map(),
      yychildren: ts}
  @type ts :: list( t )

end
