

# Docker
# docker stores its containers inside a directory
# default is /var/lib/docker
# you have two options to change it
# - create symlink from /var/lib/docker
#    - i used it: /var/lib/docker is a symlink to /srv/docker
# - edit /etc/default/docker (debian path) 

docker_get_container_id() {
    image_name=$1
    docker ps | grep $image_name | awk '{print $1}'
}

# alias docker_attach_bag="docker attach `docker_get_container_id autobaggage_app`"
# fucking apostrophes :I
docker_attach_bag() { docker attach $(docker ps | grep dev_app | awk '{print $1}'); }
docker_inspect_bag() { docker inspect $(docker ps | grep dev_app | awk '{print $1}'); }
docker_inspect_bag_ip() { docker inspect $(docker ps | grep dev_app | awk '{print $1}') | grep -i ip; }
docker_attach_bag_old() { docker attach $(docker ps | grep autobaggage_app | awk '{print $1}'); }
docker_inspect_bag_old() { docker inspect $(docker ps | grep autobaggage_app | awk '{print $1}'); }

alias psdocker="ps -aux | grep 'docker' --color=always | sort -k10"
alias psdocker2='docker ps'

alias _docker_stop='sudo service docker stop'
alias docker_stop='echo "After pwd input the docker will stop - may take dozen seconds or so... WAIT!"; _docker_stop'
alias docker_start='sudo service docker start; sudo docker info'
alias docker_restart='docker_stop; docker_start'

alias docker_ip='docker ps; docker inspect '
# alias docker_ip="docker ps; docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' "

alias docker_space='sudo du -csh /srv/docker/'
alias docker_containers_remove_stopped="docker ps -aq --no-trunc | xargs docker rm"
alias docker_containers_remove_dangling="docker images -q --filter dangling=true | xargs docker rmi"

_docker_containers_remove_all() {
    docker network prune -f;
    docker rm -f $(docker ps -a -q);
    docker rmi -f $(docker images -a -q);
    docker volume prune -f;
}

# Remove stopped containers
# This command will not remove running containers, only an error message will be printed out for each of them.
