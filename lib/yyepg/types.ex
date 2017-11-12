defmodule YYepg.Types do

  defmacro __using__( _options \\ [] ) do
    quote do

      @type numbered_line_t  :: {binary(), number()}

      # Metatypes
      @type maybe(t) :: t | nil
    end
  end
  
end
