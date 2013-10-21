if [ -e ~/.rvm/bin/rvm-prompt ]; then
  PROMPT_RVM="[$(~/.rvm/bin/rvm-prompt i v g)]"
else
  if which rbenv &> /dev/null; then
    PROMPT_RVM="[$(rbenv version | sed -e 's/ (set.*$//' -e 's/^ruby-//')]"
  fi
fi

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[green]%}["
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$fg[green]%}]%{$reset_color%}"

if [ ! $(git config --get oh-my-zsh.hide-status 2> /dev/null) ]; then
  ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[red]%}✗%{$reset_color%}"
  ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[green]%}✓%}%{$reset_color%}"
fi

RPROMPT='%{$fg[cyan]%}[%/]%{$fg[red]%}$PROMPT_RVM%{$fg[yellow]%}[%@]%{$reset_color%} '
PROMPT='$(git_prompt_info)%(?.%{$fg[green]%}.%{$fg_bold[red]%})>%b '
