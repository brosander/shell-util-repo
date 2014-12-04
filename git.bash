alias gss='git status -s'
alias gpo='git status | grep "On branch " | awk "{print \$NF}" | xargs git push origin'
alias gum='git checkout master && git fetch upstream && git merge upstream/master && git push origin master'
