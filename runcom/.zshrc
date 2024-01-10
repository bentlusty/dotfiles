# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

plugins=(git npm node brew macos z)
export ZSH="/Users/ben_tlutsy/.oh-my-zsh"
DOTFILES_DIR="$HOME/dotfiles"
ZSH_THEME="powerlevel10k/powerlevel10k"


source $ZSH/oh-my-zsh.sh
source $DOTFILES_DIR/.functions
source $DOTFILES_DIR/.aliases
source $HOME/.forterrc

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

gozer () {
  ssh -F /Users/ben_tlutsy/.ssh/gozer $1
}
ec2instances () {
  readonly service=${1:?"The service name must be provided"}
  echo '========================'
  echo ${service} 'Instances:'
  echo '========================'
  filter='Name=tag:Name,Values=prod-'
  filter+="${service}"
  filter+='-*'
  aws --region us-east-1 ec2 describe-instances --filters ${filter} --output text --query 'Reservations[].Instances[].[ [Tags[?Key==`Name`].Value][0][0],LaunchTime,PrivateIpAddress,InstanceId ]' | sort -n -k 2
}
alias lzd='lazydocker'

source /Users/ben_tlutsy/.forterrc

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# fnm
export PATH="/Users/ben_tlutsy/Library/Application Support/fnm:$PATH"
eval "`fnm env`"
eval "$(fnm env --use-on-cd)"
