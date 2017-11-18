defmodule YYepg.YYLine do

  use YYepg.Types

  alias YYepg.YYLine.YYText
  alias YYepg.YYLine.YYBeginSection
  alias YYepg.YYLine.YYEndSection

  @moduledoc """
    A parent type for subtypes which describe the different type of lines recognized by `YYepg.YYParser`.
  """


  @type t :: __MODULE__.YYText.t | __MODULE__.YYBeginSection.t | __MODULE__.YYEndSection.t
  @type ts :: list(t)


  @doc """
  A convenient constructur from a tuple

        iex> YYepg.YYLine.new({"a", 1})
        %YYepg.YYLine.YYText{content: "a", line_nb: 1}

  Which can make other types too

        iex> new({"alpha>", 4})
        %YYepg.YYLine.YYBeginSection{content: "alpha>", line_nb: 4, section_name: "alpha", section_level: 1}

        iex> new({" <<<omega with title", 8})
        %YYepg.YYLine.YYEndSection{content: " <<<omega with title", line_nb: 8, section_name: "omega", section_level: 3}
  """
  @spec new( numbered_line_t ) :: t
  def new numbered_line

  def new {text, line_nb} do
    cond do
      matches =  Regex.run(begin_section_rgx(), text) -> _make_begin_section(matches, line_nb)
      matches =  Regex.run(end_section_rgx(), text)   -> _make_end_section(matches, line_nb)
      true                                            -> %YYText{content: text, line_nb: line_nb}
    end
  end

  @begin_section_rgx ~r{\A\s*(\w*)(>+).*}
  @doc """
  Exporting the syntax of what starts a section.
        iex> Regex.match?(begin_section_rgx(), " hello>>>")
        true
  """
  @spec begin_section_rgx() :: Regex.t 
  def begin_section_rgx
  def begin_section_rgx, do: @begin_section_rgx 

  @end_section_rgx ~r{\A\s*(<+)(\w*).*}
  @doc """
  Exporting the syntax of what ends a section.
        iex> Regex.match?(end_section_rgx(), "<hello")
        true
  """
  @spec end_section_rgx() :: Regex.t 
  def end_section_rgx
  def end_section_rgx, do: @end_section_rgx 

  @typep binary_triple_t ::  list(binary())
  @spec _make_begin_section( binary_triple_t, number() ) :: YYBeginSection.t
  defp _make_begin_section matches, line_nb
  defp _make_begin_section [content, name, opener], line_nb do
    %YYBeginSection{ content: content, line_nb: line_nb, section_name: name, section_level: String.length(opener) }
  end

  @spec _make_end_section( binary_triple_t, number() ) :: YYEndSection.t
  defp _make_end_section matches, line_nb
  defp _make_end_section [content, closer, name], line_nb do
    %YYEndSection{ content: content, line_nb: line_nb, section_name: name, section_level: String.length(closer) }
  end
end
