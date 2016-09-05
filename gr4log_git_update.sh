#!/bin/sh
#git config --global credential.helper 'cache --timeout=28800'

cd ~/gr4log/
git add .
git commit -m "%date% %time% from xubuntu"
echo $SSH_AUTH_SOCK
git pull -v --no-rebase --progress "origin"
git commit -m "%date% %time% from xubuntu after pull"
git push origin master

# beep
python -c "print('\7')" 


#exit()
