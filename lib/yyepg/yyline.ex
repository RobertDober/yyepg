defmodule YYepg.YYLine do

  use YYepg.Types

  alias YYepg.YYLine.YYText

  @moduledoc """
    A parent type for subtypes which describe the different type of lines recognized by `YYepg.YYParser`.
  """

  defmodule YYText do
    @moduledoc """
    A structure describing a text line

    These are its fields:

    * `content`: The whole text of the line.
    * `line_nb`: Passed in if known used to represent the line number for purely documentatial purposes.

        iex> YYLine.new({"hello world", 42})
        %YYText{content: "hello world", line_nb: 42}

    """
    defstruct content: "", line_nb: 0
    @type t :: %__MODULE__{content: binary(), line_nb: number()}
  end

  defmodule YYBeginSection do
    @moduledoc """
    A structure describing a line opening a section.

    These are its voyages:
    * `content`: The whole text of the line.
    * `line_nb`: Passed in if known used to represent the line number for purely documentatial purposes.
    * `section_name`: A, potentially empty, string describing the name of the section.
    * `section_level`: A positive number, describing the level of the section as defined by the number of `>`s at the end of the section_name.

    Such lines match the regular expression `YYepg.YYLine.begin_section_rgx` meaning the first non whitespace characters in
    the line are a, potentially empty, name, followed by a positive number of `>`s.

        iex> YYepg.YYLine.new({"  chapter>>", 41})
        %YYepg.YYLine.YYBeginSection{content: "  chapter>>", line_nb: 41, section_name: "chapter", section_level: 2}
    """
    defstruct content: "",
              line_nb: 0,
              section_name: "",
              section_level: 0
    @type t :: %__MODULE__{content: binary(), line_nb: number(), section_name: binary(), section_level: number()}
  end

  defmodule YYEndSection do
    @moduledoc """
    A structure describing a line closing a section.
    Not very surprisingly this has the exact same structure as `YYBeginSection`

    These are its voyages:
    * `content`: The whole text of the line.
    * `line_nb`: Passed in if known used to represent the line number for purely documentatial purposes.
    * `section_name`: A, potentially empty, string describing the name of the section.
    * `section_level`: A positive number, describing the level of the section as defined by the number of `<`s at the begin of the section_name.

    Such lines match the regular expression `YYepg.YYLine.end_section_rgx` meaning the first non whitespace characters in
    the line are a, potentially empty, name, followed by a positive number of `>`s.

        iex> YYepg.YYLine.new({"  <<<chapter", 40})
        %YYepg.YYLine.YYEndSection{content: "  <<<chapter", line_nb: 40, section_name: "chapter", section_level: 3}
    """
    defstruct content: "",
              line_nb: 0,
              section_name: "",
              section_level: 0
    @type t :: %__MODULE__{content: binary(), line_nb: number(), section_name: binary(), section_level: number()}
  end

  @type t :: __MODULE__.YYText.t | __MODULE__.YYBeginSection.t | __MODULE__.YYEndSection.t
  @type ts :: list(t)


  @doc """
  A convenient constructur from a tuple

        iex> YYepg.YYLine.new({"a", 1})
        %YYepg.YYLine.YYText{content: "a", line_nb: 1}
  """
  @spec new( numbered_line_t ) :: t
  def new numbered_line

  def new {text, line_nb} do
    cond do
      matches =  Regex.run(begin_section_rgx, text) -> _make_begin_section(matches, line_nb)
      matches =  Regex.run(end_section_rgx, text)   -> _make_end_section(matches, line_nb)
      true                                          -> %YYText{content: text, line_nb: line_nb}
    end
  end

  @begin_section_rgx ~r{\A\s*(\w*)(>+)}
  @doc """
  Exporting the syntax of what starts a section.
  """
  @spec begin_section_rgx() :: Regex.t 
  def begin_section_rgx
  def begin_section_rgx, do: @begin_section_rgx 

  @end_section_rgx ~r{\A\s*(<+)(\w*)}
  @doc """
  Exporting the syntax of what ends a section.
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
