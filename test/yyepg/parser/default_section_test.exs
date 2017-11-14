defmodule Yyepg.Parser.DefaultSectionTest do
  use ExUnit.Case

  import YYepg.Parser, only: [parse: 1]
  alias YYepg.YYStructure, as: S
  alias YYepg.YYResult, as: R
  import Support.Result

  describe "default section" do
    test "implicit, with warning" do
      text = %S{yytype: :_text, yycontent: "alpha"}
      structure = [%S{yytype: :yysection, yyatts: %{level: 1}, yychildren: [text]}]
      assert parse("alpha") == warn_result(structure, "A default section of level 1 is assumed around your text")
    end

    test "explicit, warning about missing <" do
      text = %S{yytype: :_text, yycontent: "alpha"}
      structure = [%S{yytype: :yysection, yyatts: %{level: 1}, yychildren: [text]}]
      assert parse(">\nalpha") ==
        warn_result(structure, "An implicit section of level 1(<) is assumed after this line", 2)
    end

    test "explicit, without warning" do
      raw_line = %S.RawLines{lines: [{"alpha", 2}]}
      section  = %S.Section{level: 1, name: "", content: ">", line_numbers: {1, 3}, children: [raw_line]}
      result   = %R{yystructures: [section]}
      assert parse(">\nalpha\n<") == result
    end
  end
end
