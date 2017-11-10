defmodule YYepg.YYStructure.Protocols do

  alias YYepg.YYStructure

  defimpl String.Chars, for: YYStructure do
    @spec to_string( YYStructure.t ) :: String.t
    def to_string yystructure

    def to_string %{yytype: yytype, yycontent: yycontent, yyatts: %{level: level}} do
      ~s<%YYStructure{yytype: #{yytype}, yycontent: #{yycontent}, yyatts: %{level: #{level}, ...}}>
    end
    def to_string %{yytype: yytype, yycontent: yycontent} do
      ~s<%YYStructure{yytype: #{yytype}, yycontent: #{yycontent}, yyatts: %{...}}}>
    end
    
  end

end
