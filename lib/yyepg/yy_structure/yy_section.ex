defmodule YYepg.YYStructure.YYSection do
  use YYepg.Types

  alias YYepg.YYLine

  @moduledoc """
    The structural represention of a section.
  """
  defstruct level: 1, name: "", content: "", line_numbers: {0, 0}, children: []

  @type t ::
  %__MODULE__{
    level: number(),
    name: binary(),
    content: binary(),
    line_numbers: line_numbers_t(),
    children: YYepg.YYStructure.ts}
  @type ts :: list(t)

  @doc """
  Given a parsed YYBeginSection line we construct a Section representation.
  N.B. that it is _open_ in the sense of the closing line number being `0`.

        iex> line = YYLine.new({"hello>> World", 42})
        ...> YYStructure.YYSection.from_yyline(line)
        %YYStructure.YYSection{level: 2, name: "hello", content: "hello>> World", line_numbers: {42, 0}}
  """
  @spec from_yyline(YYLine.YYBeginSection.t) :: t
  def from_yyline begin_section 

  def from_yyline begin_section do
    %__MODULE__{
      level: begin_section.section_level,
      name:  begin_section.section_name,
      content:  begin_section.content,
      line_numbers: {begin_section.line_nb, 0}
    }
  end

  @doc """
    Will be inserted if the first blank line is not a begin section line

          iex> default_section(43)
          %YYStructure.YYSection{level: 1, name: "", content: ">", line_numbers: {43, 0}}
  """
  @spec default_section( number() ) :: t
  def default_section line_nb

  def default_section line_nb do
    %__MODULE__{
      level: 1,
      name: "",
      content: ">",
      line_numbers: {line_nb, 0}
    }
  end

end
