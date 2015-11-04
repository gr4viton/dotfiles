::python.exe main.py

Echo %date%_%time%
::ssh-agent -s
::ssh-add C:\Users\gr4viton\.ssh\bitbucket_priv.ppk
::git.exe config --global remote.origin.receivepack "git receive-pack"
::git config --global push.default simple
::C:\PROG\dev\Git\bin\sh.exe --login -i _gr4log_git_update.sh
::C:\PROG\dev\Git\bin\sh.exe _gr4log_git_update.sh

::git config --global credential.helper 'cache --timeout=28800'

git add .
git commit -m "%date% %time%"
git pull -v --no-rebase --progress "origin"
git commit -m "%date% %time% after pull"
git.exe push origin master
::exit()
python -c "print('\7')" :: BEEP


