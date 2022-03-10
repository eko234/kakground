define-command set-background -hidden -params 1 %{
  nop %sh{ {
    feh -z --bg-fill "$1" &
  } > /dev/null 2>&1 < /dev/null & }
}

define-command -hidden kakground-select %{
  try %{
    execute-keys '<a-:><a-x>_: set-background %val{selection}<ret>'
  }
}

hook -group kakground-pick global WinSetOption filetype=kakground-pick %{
  hook -group kakground-pick window NormalKey '[jk%]|<esc>' kakground-select
  hook -once -always window WinSetOption filetype=.* %{
    remove-hooks window kakground-pick
  }
}

hook global WinSetOption filetype=kakground-pick %{
  map window normal <ret> '<a-:><a-x>_: set-background %val{selection}<ret>'
}

define-command kakground -file-completion -params 1 %{
  e -scratch *kakground*
  exec "%%d! find %arg{1} <ret>gg"
  kakground-select
  set window filetype kakground-pick
}
