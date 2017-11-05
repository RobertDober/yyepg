defmodule YYepg.Parser.HeaderTest do
  use ExUnit.Case

  import YYepg.Parser, only: [parse: 1] 

  describe "Missing header text" do 
    test "minimal case" do
      assert parse("#\n") == {:error, [], [{:error, "Missing text for header \"#\"", 1}]
    end
  end
  
  describe "Header with no content" do 
    
  end

  describe "Header with text" do

  end

  describe "Header with header" do 
    
  end

  describe "List of headers" do 
    
  end
end
