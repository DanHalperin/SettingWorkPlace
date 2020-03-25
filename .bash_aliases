alias BKC='cat /etc/issue.Intel.Linux1'
alias currC="./dev/wcd_pytm-tests/run_tests.sh run -p wifi_tests/linux/p2p/concurrency/ -O config_overlays/qnj_cycle.yaml"
alias bkc=BKC
alias cdfw='cd /home/tester/dev/wcd_fw-dev'
alias cdfwb='cd /home/tester/dev/wcd_fw-dev/build'
alias cdpy='cd /home/tester/dev/wcd_pytm-tests'
alias cdd='cd /home/tester/dev/iwlwifi-stack-dev'
alias cddriver='cd /home/tester/dev/iwlwifi-stack-dev'
alias sb='source ~/.bashrc'
alias st='tmux source-file ~/.tmux.conf'
alias sv='source ~/.vimrc'
alias bashrc='vim ~/.bashrc'
alias aliases='vim ~/.bash_aliases'
alias skynet='cd ~/skynet_config'
alias vimrc="vim ~/.vimrc"
alias tmuxconf="vim ~/.tmux.conf"
alias run="~/dev/wcd_pytm-tests/run_tests.sh run -p"
alias Tmux="python ~/tmuxInit/tmuxInit.py"
alias ex="chmod +x"  # Don't forget the name of the file you want to exucute.
alias autoRev='~/dev/wcd_fw-dev/scripts/jenkins-cr.py HEAD'
alias checkautoreviewerrors="vim /tmp/checkpatch.log"
alias emr="enter make run"
alias calias="cat ~/.bash_aliases"
alias fs="grep -r -n -w . -e"
alias newCtags="ctags -R -o tags"
alias ctR="ctags -R"
alias devicesYaml="vim ~/devices.yaml"
alias windowsYaml="vim ~/windows.yaml"
alias linuxYaml="vim ~/linux.yaml"
alias howmuhspace="du -h --max-depth=1"
alias buildConfig="ll ~/dev/wcd_fw-dev/configs"
alias tmux="tmux -2"

look() {
    find . -type f -name "*$1*"
}

lookDir() {
	find . -type d -name "*$1*"
}

# Compile the driver (iwlwifi-stack-dev)
compileDriver() {
    cd ~/dev/iwlwifi-stack-dev
    make defconfig-iwlwifi
    make -j8
    cd -
}


# Compile fw for the desired NIC
compileFW() {
  reviewErrors
  cdfw
  mkdir build
  cdfwb
  read -p "Use default NIC (cyclone-a0-hrp-b0-upload.cmake)? if yes, press Enter. Otherwise, give me any input: " B
  NIC=cyclone-a0-hrp-b0-upload.cmake
  if [ "${#B}" -eq 1 ]; then
    echo "Please choose the desired NIC:"
    buildConfig
    read -p "Chosen NIC: " NIC
  fi
  echo ""
  enter cmake -C ../configs/"$NIC" ..
  enter ninja
  cd -
}


# Remove all files from wcd_fw-dev/build dir
buildRM() {

  rm -rf ~/dev/wcd_fw-dev/build/*
  rm ~/dev/wcd_fw-dev/build/.ninja_deps ~/dev/wcd_fw-dev/build/.ninja_log

}

# Use gdb debug tool:
DGB() {

  while [ -z "$(ls -A ~/dev/dumps)" ]; do
    echo "~/dev/dumps is empty!!!!!!"
    read -p "Put the proper 'dump' file in ~/dev/dumps. Then, press ENTER!"
  done
}

grepp() {
  grep -r "$1" .
}

testUsim() {
  enter make
  enter Debug/quasarz-a0-hrp-b0-protocol-umac-upload/umacSimTwtUTest --test=0 --case=1
  grepp "danhal"
}

# Review syntax mistakes!
reviewErrors(){
  autoRev
  cat /tmp/checkpatch.log
}


# Replace a string with another string throughout the entire project!
# replace file1 file2
replace() {
  str='s/'"$1"'/'"$2"'/g'
  find ./ -type f -exec sed -i -e "$str" {} \;
}
replaceInFile() {
    sed -i 's/"$1"/"$2"/g' "$3"
    str='s/'"$1"'/'"$2"'/g'
    sed -i -e "$str" "$3" 
}

seeold() {

  git show HEAD^:"$1" > oldfile
  vim oldfile
}


# Cscope
alias csR="cscope -R"
csrb() {
	sb
	cscope -Rb
}


# Git aliases:
alias gs="git status"
alias gsh="git show"
alias gadd="git add"
alias gb="git branch"
alias gnewbranch="git checkout -b"
alias gcheck='git checkout'
alias gtrack='git branch --set-upstream-to=origin/master'
alias gg="git grep -n -i"
alias gpullr="git pull -r"
alias gc="git commit -s"
alias gam="git commit --amend"
alias gai="git add -i"
alias ga="git add"
alias gri="git rebase -i"
alias grc="git rebase --continue"
alias greset="git checkout HEAD"
alias gconfig="vim ~/.git/config"
alias glogline="git log --oneline"
alias gsubmodule="git submodule"

function gpusho
{
  if (($# == 0)); then
    git push origin HEAD:refs/for/master
  elif (($# == 1)); then
    git push origin "$1":refs/for/master
  fi
}

function gpushd {

  if (($# == 0)); then
    git push origin HEAD:refs/drafts/master
  elif (($# == 1)); then
    git push origin "$1":refs/drafts/master
  fi
}

gblame() {
  git log -u -L "$1","$2":"$3"
}

gpullrr() {
    git pull -r --recurse-submodules
    git submodule update
}

ggsubstrings() {
    # Look for all LOC which hold both substrings "$1" and $"2"
    git grep -e "$1" --and -e "$2"    
}

gremoveChanges() {
	
	git checkout origin/master -- "$1"
	git reset -- "$1"
}
