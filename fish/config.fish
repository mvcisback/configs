set fish_path $HOME/.oh-my-fish

. $fish_path/oh-my-fish.fish

Theme 'l'
Plugin 'theme'
Plugin 'getopts'
Plugin 'tiny'

set GREP_OPTIONS ""
set -x NIXPKGS /home/mvc/nixpkgs
set -x EDITOR "emacsclient -c -a ''"

alias em $EDITOR
alias t 'task'
alias tmux 'tmux'
alias mux 'env TERM=xterm-256color mux'
alias mosh-remote 'mosh remote --server=.nix-profile/bin/mosh-server'

source $HOME/.nix-profile/share/doc/task/scripts/fish/task.fish
source $HOME/.nix-profile/share/autojump/autojump.fish