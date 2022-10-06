#!/bin/bash
. ./colors.sh

match_remote() {
  branch_name=$(git remote -v | grep "deploy.*fetch)")
  if [[ -z $branch_name ]]; then
    red "One remote with a "
    yellow "deploy name"
    red " is required, in the local git repository"
    exit 1
  fi
}

match_remote

ssh_user_ip=$(git remote -v | grep "deploy.*fetch)" | sed "s|deploy\tssh://||g" | sed "s|/.*$||g" | sed "s|:[0-9]*||g")
ssh_user_port=$(git remote -v | grep "deploy.*fetch)" | sed "s|deploy\tssh://||g" | sed "s|/.*$||g" | sed "s|$ssh_user_ip:||g")
ssh_path_the_project=$(git remote -v | grep "deploy.*fetch)" | sed "s|deploy\tssh://||g" | sed "s|$ssh_user_ip:$ssh_user_port||g" | sed "s| (fetch)||g")
ssh_path_work_tree=$(echo $ssh_path_the_project | sed "s|\.git||g")

echo $ssh_user_ip
echo $ssh_user_port
echo $ssh_path_the_project
echo $ssh_path_work_tree

warning_branch() {
  branchs=$(git branch | sed -E "s/\*| //g")
  red "One parameter is required in deploy.sh, which can be ("
  for b in $branchs; do
    yellow "$b"
    red ", "
  done
  red "\033[2D)!\n"
  exit 1
}

match_branch() {
  branch_name=$(git branch | sed -E "s/\*| //g" | grep -P "^$1$")
  [[ -n $branch_name ]] && $2 || $3
}

match_branch "$1" "" "warning_branch"

printf "#!/bin/bash\n" >clean_server.sh
write_clean_server() {
  printf "$1\n" >>clean_server.sh
}
write_clean_server "rm -r $ssh_path_work_tree"
write_clean_server "mkdir -p $ssh_path_the_project"
write_clean_server "cd $ssh_path_the_project"
write_clean_server "git init --bare"

cat "./clean_server.sh" | ssh ${ssh_user_ip} -p ${ssh_user_port} "/bin/bash "

printf "#!/bin/bash\n" >post-receive
write_post_receive() {
  printf "$1\n" >>post-receive
}

write_post_receive "git --work-tree=$ssh_path_work_tree --git-dir=$ssh_path_the_project checkout -f branch_name"

install_post_receive() {
  cat "./post-receive" | sed -E "s/branch_name/$branch_name/g" |
    ssh ${ssh_user_ip} -p ${ssh_user_port} \
      "cat >>$ssh_path_the_project/hooks/post-receive &&
      chmod +x $ssh_path_the_project/hooks/post-receive"
}

# install_post_receive

git push deploy $1
ssh ${ssh_user_ip} -p ${ssh_user_port} "cd $ssh_path_work_tree && git init && git checkout $branch_name"
