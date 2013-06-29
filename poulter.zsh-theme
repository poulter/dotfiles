if [ -e ~/.rvm/bin/rvm-prompt ]; then
  PROMPT_RVM="[$(~/.rvm/bin/rvm-prompt i v g)]"
else
  if which rbenv &> /dev/null; then
    PROMPT_RVM="[$(rbenv version | sed -e 's/ (set.*$//' -e 's/^ruby-//')]"
  fi
fi

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[green]%}["
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[red]%}✗%{$fg[green]%}]%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[green]%}✓%{$fg[green]%}]%{$reset_color%}"

RPROMPT='%{$fg[cyan]%}[%/]%{$fg[red]%}$PROMPT_RVM%{$fg[yellow]%}[%@]%{$reset_color%} '
PROMPT='$(git_prompt_info)%(?.%{$fg[green]%}.%{$fg_bold[red]%})>%b '
