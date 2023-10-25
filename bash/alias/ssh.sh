
shin_ip[dalek]="pi@192.168.0.198"
shin_ip[octopi]="pi@192.168.0.111" # was 199

shin_ip[centroid]="pi@10.8.0.39"
shin_ip[retropie]="pi@192.168.0.150"
shin_ip[tapa]="gr4viton@192.168.0.220"
# 164 = old rpi1
# 163 = rpi3b+

from_get () {
    # non functional
    dict=${1:?dict}
    key=${2:?key}
    value=${${dict}[$key]}
    echo $value
}

shin () {
	conf_shin_file="~/.config/shin.rc"
glom $conf_shin_file $key
    key=${1:?key shin_ip dict}
    user_ip=${shin_ip[$key]}
    glom
    echo ">>> connecting via ssh to $user_ip"
    ssh $user_ip
}


### gr4viton
alias dalek_me="shin dalek"
alias octopi_me="shin octopi"
alias centroid_me="shin centroid"
alias tapa_me="shin tapa"
# alias nas_ssh="shin tapa"


ssh_l5401 () {
    ssh -6 dd@fe80::65bd:f19:c882:8b95%enx00e04c41b085
}

mosh_rpi () {
	mosh pi@192.168.0.105
}
# alias retropie_me="shin retropie"

ssh_generate_github_key () {
  ssh-keygen -t ed25519 -C "${1}"
}

ssh_generate_github_key_dd () {
  ssh_generate_github_key "${ENV_DD_MY_EMAIL}"
}

ssh_add () {
  # adds your ssh key to ssh agent
  ssh-add ~/.ssh/id_rsa
  # start the agent
  eval `ssh-agent -s`
}
