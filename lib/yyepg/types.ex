defmodule YYepg.Types do

  defmacro __using__( _options \\ [] ) do
    quote do

      @type numbered_line_t  :: {binary(), number()}
      @type line_numbers_t   :: {number(), number()}

      # Metatypes
      @type maybe(t) :: t | nil
    end
  end
  
end
