# apt

# https://askubuntu.com/questions/5980/how-do-i-free-up-disk-space
alias apt_list_biggest_packages="dpkg-query -W --showformat='\$\{Installed-Size\} \$\{Package\}\n' | sort -nr | less"
alias apt_list_biggest_packages='dpkg-query -W --showformat="${Installed-Size} ${Package}\n" | sort -nr | less'


apt_search () {
    # search for package via its name in apt repos
    apt-cache search $@
}


apt_installed () {
    apt list --installed 2>/dev/null | grep $1
}

