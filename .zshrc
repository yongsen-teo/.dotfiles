# Enable P10K instant prompt. Should stay close to the top of ~/.zshrc.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# PATH defaults
export PATH=$HOME/bin:/usr/local/bin:$PATH
export PATH=$PATH:~/google-cloud-sdk/bin
export LS_COLORS="$(vivid generate catppuccin-mocha)"
export EDITOR='nvim'
export VISUAL='nvim'
export EZA_CONFIG_DIR="$HOME/.config/eva"
export DYLD_LIBRARY_PATH="$(brew --prefix)/lib:$DYLD_LIBRARY_PATH"

# Ensure completion directory exists
if [[ ! -d /opt/homebrew/share/zsh/site-functions ]]; then
  mkdir -p /opt/homebrew/share/zsh/site-functions
fi

# Load and initialise completion system
autoload -Uz compinit && compinit
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"

# Bash comp
autoload bashcompinit && bashcompinit
CASE_SENSITIVE="true"

# ZSH Highlighting
plugins=(git zsh-autosuggestions zsh-syntax-highlighting)
source $ZSH/oh-my-zsh.sh

# UTF-8 Encoding
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# --------- ALIAS COMMANDS --------- #
alias cl='clear'
alias ll='ls -a'
alias lsf='ls -D'

# Python Operations
alias jj='python main.py'
alias st='streamlit run app.py'
alias nb='jupyter notebook'
alias pt='pytest -vv'
alias in='touch __init__.py'
alias nt='conda activate ~/miniconda3/envs/new_test'
alias da='conda deactivate && conda deactivate && conda deactivate'
alias change='conda deactivate && conda deactivate && conda deactivate && source .venv/bin/activate'

# Reload zshrc and nvim config
alias cfg='vim ~/.zshrc'
alias reload='source ~/.zshrc'
alias vcfg='vim ~/.config/nvim && vim .'

alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'

# Desktop and other folders navigation
alias dl='cd ~/Downloads && nvim .'
alias cdd='cd ~/Desktop'
alias blog='cd ~/Desktop/blog/yongsen-teo.github.io | vim ~/Desktop/blog/yongsen-teo.github.io'

# Work specific folders navigation
alias nec='cd ~/Desktop/nec && conda deactivate && conda deactivate && conda deactivate && source ~/Desktop/nec/.venv/bin/activate && cd lex_bedrock'
alias llm='cd ~/Desktop/nec && conda deactivate && conda deactivate && conda deactivate && source ~/Desktop/nec/.venv/bin/activate && cd lex_bedrock/llm-assistant-latest'
alias uem='cd ~/Desktop/nec && conda deactivate && conda deactivate && conda deactivate && source ~/Desktop/nec/.venv/bin/activate && cd lex_bedrock/llm-assistant-uem-latest'

# AWS Lambda CLI operations
alias live='./live-lambda-cloudwatch.sh'
alias down='./download-lambda.sh'
alias up='./update-lambda.sh'


# P10k stuff
source ~/powerlevel10k/powerlevel10k.zsh-theme
source /opt/homebrew/opt/chruby/share/chruby/chruby.sh
source /opt/homebrew/opt/chruby/share/chruby/auto.sh
chruby ruby-3.1.3
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/Users/yongsenteo/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/yongsenteo/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/Users/yongsenteo/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/Users/yongsenteo/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup

export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

export PATH="/Users/yongsenteo/Applications/miniconda3/bin:$PATH"
source ~/.bash_profile
export PATH="/opt/homebrew/opt/postgresql@15/bin:$PATH"

# . "$(brew --prefix asdf)"/libexec/asdf.sh

# Load Catppuccin theme for zsh-syntax-highlighting
source ~/.zsh/catppuccin_macchiato-zsh-syntax-highlighting.zsh
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

. "$HOME/.cargo/env"

## Eza and Zoxide (better ls)
eval "$(zoxide init zsh)"
alias cd="z"
alias ls='eza --icons=always --oneline --ignore-glob=".DS_Store|*.pyc|__pycache__|.pytest_cache|.git|pyproject.toml|uv.lock"'

eval "$(uv generate-shell-completion zsh)"

function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}

## -- Google Cloud SDK -- ##
# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/yongsenteo/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/yongsenteo/google-cloud-sdk/path.zsh.inc'; fi
# The next line enables shell command completion for gcloud.
if [ -f '/Users/yongsenteo/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/yongsenteo/google-cloud-sdk/completion.zsh.inc'; fi


# bun completions
[ -s "/Users/yongsenteo/.bun/_bun" ] && source "/Users/yongsenteo/.bun/_bun"
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# UV Tab to complete
_uv_run_mod() {
    if [[ "$words[2]" == "run" && "$words[CURRENT]" != -* ]]; then
        _arguments '*:filename:_files'
    else
        _uv "$@"
    fi
}
compdef _uv_run_mod uv

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

alias claude="/Users/yongsenteo/.claude/local/claude"

# Load local settings and secrets if the file exists
if [ -f ~/.zshrc.local ]; then
    source ~/.zshrc.local
fi
