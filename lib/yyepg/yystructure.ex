defmodule YYepg.YYStructure do

  defstruct yytype: :yysection, yycontent: "", yyatts: %{}, yychildren: []
  @type t ::
    %__MODULE__{
      yytype: atom(),
      yycontent: binary(),
      yyatts: map(),
      yychildren: ts}
  @type ts :: list( t )

  @spec make_implicit( ts ) :: t
  def make_implicit structures

  def make_implicit [] do
    %__MODULE__{yyatts: %{level: 1}}
  end

end
