defmodule YYepg.Lexer.LexLinesTest do
  use ExUnit.Case

  import YYepg.Lexer, only: [lex: 1]

  describe "lexing lines" do 
    @multi """
    # h
    text  _
    """
    test "correct line numbers" do 
      tokens = lex(@multi)
      expected = [{:header,"#",1},{:ws," ",1},{:text,"h",1},{:nl,"\n",1},{:text,"text",2},{:ws,"  ",2},{:underscore,"_",2},{:nl,"\n",2}]
      assert tokens == expected
    end

    @leading_nl """

    \\
    """
    test "still correct line numbers" do
      tokens = lex(@leading_nl)
      expected = [{:nl,"\n",1}, {:escaped,"\n",2}]
      assert tokens == expected
    end

    test "empty" do 
      assert lex("") == []
    end
  end
  
end
