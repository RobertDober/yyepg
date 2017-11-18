defmodule YYepg.YYMessage do

  alias YYepg.YYStructure.YYSection

  defstruct severity: :error, message: "", line_nb: 0

  # Semantic meaning
  #                   +----------------------------------------- no error but the user shall be informed by something, e.g.
  #                   |                                              - a better way to write the input
  #                   |                                              - deprecation of a feature
  #                   |       +--------------------------------- the parsed element does notcomply to specification but a default/guess was assumed
  #                   |       |                                     following blocks shall be parsed correctly
  #                   |       |          +---------------------- the concerned element's representaion will be faulty, the rest of the parsed input
  #                   |       |          |                          might be corrupted
  #                   |       |          |        +------------- an unrecoverable error occured or too many errors occured, the output has no meaning
  #                   |       |          |        |        +---- should not occur in released library code, purely for dev purpose
  #                   |       |          |        |        |
  #                   v       v          v        v        v
  @type severity_t :: :info | :warning | :error | :fatal | :debug

  @type t :: %__MODULE__{severity: severity_t, message: binary(), line_nb: number()}
  @type ts :: list(t)

  @doc """
  A message is constructed from `message_tuple` and prepended to `messsages`

        iex> messages = [%YYMessage{}]
        ...> add(messages, {:warning, "oh nooo", 44})
        [%YYMessage{severity: :warning, message: "oh nooo", line_nb: 44}, %YYMessage{}]

  """
  @spec add( ts, {severity_t, binary(), number()} ) :: ts
  def add messages, message_tuple

  def add messages, {severity, message, line_nb} do
    [%__MODULE__{severity: severity, message: message, line_nb: line_nb} | messages]
  end
  #---------------------------------------------------------------------------------


  @doc """
  Adds warnings for sections left open, as indicated in `open_sections` to the given `messages`

        iex> section = %YYSection{ level: 3, name: "alpha", content: "alpha>>>", line_numbers: {44, 0}}
        ...> sections = [ YYSection.default_section(7), section ]
        ...> add_warnings_for_open_sections([], sections) 
        [ %YYMessage{severity: :warning, line_nb: 44, message: ~s{section "alpha>>>" implicitly closed at end of input}},
          %YYMessage{severity: :warning, line_nb: 7, message: ~s{section ">" implicitly closed at end of input}}]
    
  """
  @spec add_warnings_for_open_sections( ts, YYSection.ts ) :: ts
  def add_warnings_for_open_sections messages, open_sections

  def add_warnings_for_open_sections messages, [] do
    messages
  end
  def add_warnings_for_open_sections messages, [open_section | rest] do
    add_warnings_for_open_sections(
      add_warning_for_open_section(messages, open_section), rest)
  end

  defp add_warning_for_open_section messages, %{content: content, line_numbers: {lnb_beg, lnb_end}} do
    [ %__MODULE__{
        severity: :warning,
        line_nb: lnb_end,
        message: "Implicitly closing section #{inspect(content)} starting in line #{lnb_beg}"
      } | messages]
  end
end
