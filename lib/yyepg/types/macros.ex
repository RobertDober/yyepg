defmodule YYepg.Types.Macros do

  defmacro left(expression) do
    quote do
      {:ok, unquote(expression)}
    end
  end

  defmacro right(message) do
    quote do
      {:error, unquote(message)}
    end
  end
  
end
