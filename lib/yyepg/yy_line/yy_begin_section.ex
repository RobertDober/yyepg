defmodule YYepg.YYLine.YYBeginSection do
  use YYepg.Types

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
