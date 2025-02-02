# __apt__
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


ubuntu_version () {
    set -x
    lsb_release -a
    set +x
}

apt_history_full () {
    tac /var/log/apt/history.log
}

apt_history () {
    lines="${1:-100}"
    txt=$(apt_history_full) | grep Install
    if [[ ! -z $lines ]]; then
        echo "$txt" | head --lines=$lines
    else
        echo "$txt"
    fi
}

apt_free_up_space_via_purge () {
    sudo apt autoremove --purge
}

apt_kernel_del () {
  ls /boot
  echo "# from https://www.cyberciti.biz/faq/debian-ubuntu-linux-delete-old-kernel-images-command/"
  echo "apt-get --purge remove linux-image-5.15.0*-generic"
  echo "sudo apt --purge autoremove"
  ls /boot
}

