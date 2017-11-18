defmodule YYepg.Types do

  defmacro __using__( _options \\ [] ) do
    quote do

      import YYepg.Types.Macros

      # Metatypes
      @type maybe(t) :: t | nil
      @type numbered(t) :: {t, number()}

      @type either(t) :: {:ok, t} | {:error, binary()}

      # Ordinary Types
      @type numbered_line_t  :: numbered(binary())
      @type numbered_lines_t :: list(numbered_line_t)

      @type line_numbers_t   :: numbered(number())
    end
  end


  
end
