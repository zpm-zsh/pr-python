#!/usr/bin/env zsh

: ${PR_PYTHON_SYMBOL:=''}

typeset -g pr_python

VIRTUAL_ENV_DISABLE_PROMPT=1

if [[ -n "$VIRTUAL_ENV" ]]; then
  source "$VIRTUAL_ENV/bin/activate"
fi

if (( $+commands[python] )); then
  function _pr_python() {
    pr_python=''

    if [[ -n "$VIRTUAL_ENV" ]]; then
      pr_python=' '

      pyver=$(python --version)
      pyver=${pyver#'Python '}

      pr_python+="%{${c[blue]}${c[bold]}%}${PR_PYTHON_SYMBOL}%{${c[reset]}%} %{${c[blue]}${c[bold]}%}$pyver%{${c[reset]}%}"
    fi
  }

  autoload -Uz add-zsh-hook
  add-zsh-hook chpwd _pr_python
  _pr_python
fi
