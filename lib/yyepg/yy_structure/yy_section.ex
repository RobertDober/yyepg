defmodule YYepg.YYStructure.YYSection do
  # use YYepg.Types

  # alias YYepg.YYLine

  # defstruct level: 1, name: "", content: "", line_numbers: {0, 0}, children: []

  # @type t ::
  # %__MODULE__{
  #   level: number(),
  #   name: binary(),
  #   content: binary(),
  #   line_numbers: line_numbers_t(),
  #   children: YYepg.YYStructure.ts}
  # @type ts :: list(t)

  # @spec from_yyline( YYLine.YYBeginSection ) :: t
  # def from_yyline begin_section 

  # def from_yyline begin_section do
  #   %__MODULE__{
  #     level: begin_section.section_level,
  #     name:  begin_section.section_name,
  #     line_numbers: {begin_section.line_nb, 0}
  #   }
  # end

  # @spec from_numbered_line( numbered_line_t() ) :: t
  # def from_numbered_line numbered_line

  # def from_numbered_line numbered_line do
  #   case YYLine.new( numbered_line ) do 
  #     begin_section = %YYLine.YYBeginSection{} -> from_yyline( begin_section )
  #     _                                      -> raise ArgumentError, "must not pass in line that does not open a section"
  #   end
  # end


end
