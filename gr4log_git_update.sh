#!/bin/sh
#git config --global credential.helper 'cache --timeout=28800'

cd ~/gr4log/
git add .

date=$(date '+%d/%m/%Y %H:%M:%S')
commit_msg="$date: from $os_name $distribution_name"
git commit -m "$commit_msg"
echo $SSH_AUTH_SOCK
git pull -v --no-rebase --progress "origin"
git commit -m "%date% %time% from xubuntu after pull"
git push origin master

# beep
python -c "print('\7')" 


#exit()
