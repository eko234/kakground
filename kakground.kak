declare-option str kakground_background_cmd "xargs -n 1 -I {} feh -z --bg-max {}"

define-command set-background -hidden -params 1 %{
  nop %sh{ {
    echo "$1" | $kak_opt_kakground_background_cmd  &
  } > /dev/null 2>&1 < /dev/null & }
}

define-command -hidden kakground-select %{
  try %{
    execute-keys '<a-:><a-h><a-l>_: set-background %reg{dot}<ret>'
  } }

hook -group kakground-pick global WinSetOption filetype=kakground-pick %{
  hook -group kakground-pick window NormalKey '[jk%]|<esc>' kakground-select
  hook -once -always window WinSetOption filetype=.* %{
    remove-hooks window kakground-pick
  }
}

hook global WinSetOption filetype=kakground-pick %{
  map window normal <ret> '<a-:><a-h><a-l>_: set-background %reg{dot}<ret>'
}

define-command kakground -file-completion -params 1 %{
  e -scratch *kakground*
  exec "%%d! find %arg{1} <ret>gg"
  kakground-select
  set window filetype kakground-pick
}
