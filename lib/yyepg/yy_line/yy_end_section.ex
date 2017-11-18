defmodule YYepg.YYLine.YYEndSection do
  use YYepg.Types
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
