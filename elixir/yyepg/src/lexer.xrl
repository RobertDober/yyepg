Definitions.

ESCAPED       = \\.|\\\n
HASH          = #
HEADER        = {HASH}+
UNDERSCORE     = _
EXCLAMATION   = [!]
OPEN_PAREN    = \(
CLOSE_PAREN   = \)
OPEN_BRACKET  = \[
CLOSE_BRACKET = \]
OPEN_TITLE    = \s+['"]
ANY_QUOTE     = ['"]
NL            = \n
WS            = \s+
ANY           = [^]\\"'()[\s\n]+

Rules.

{HEADER}        : {token, {header, TokenChars, TokenLine}}.
{ESCAPED}       : {token, {escaped, dismiss_backslash(TokenChars), TokenLine}}.
{EXCLAMATION}   : {token, {exclamation, TokenChars, TokenLine}}.
{UNDERSCORE}    : {token, {underscore, TokenChars, TokenLine}}.
{NL}            : {token, {nl, TokenChars, TokenLine}}.
{OPEN_PAREN}    : {token, {open_paren, TokenLine, TokenChars}}.
{CLOSE_PAREN}   : {token, {close_paren, TokenLine, TokenChars}}.
{OPEN_BRACKET}  : {token, {open_bracket, TokenLine, TokenChars}}.
{CLOSE_BRACKET} : {token, {close_bracket, TokenLine, TokenChars}}.
{OPEN_TITLE}    : {token, {open_title, TokenLine, TokenChars}}.
{ANY_QUOTE}     : {token, {any_quote, TokenLine, TokenChars}}.
{ESCAPE}        : {token, {verbatim, TokenLine, TokenChars}}.
{WS}            : {token, {ws, TokenChars, TokenLine}}.
{ANY}           : {token, {text, TokenChars, TokenLine}}.

Erlang code.

dismiss_backslash([$\\|Chars]) -> Chars.
