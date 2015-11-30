set GREP_OPTIONS ""
set -x NIXPKGS /home/mvc/nixpkgs
set -x EDITOR "emacsclient -t -a ''"

alias em $EDITOR
alias task taskgit
alias mosh-remote 'mosh remote --server=.nix-profile/bin/mosh-server'
alias getMail "mbsync -a and notmuch new"

. $HOME/.nix-profile/share/doc/task/scripts/fish/task.fish
. $HOME/.nix-profile/share/autojump/autojump.fish

set -x PATH /usr/bin /bin $PATH /home/mvc/.bin  /home/mvc/.bin/nanopb-0.3.4-linux-x86/generator-bin
