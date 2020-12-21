

# Docker
# docker stores its containers inside a directory
# default is /var/lib/docker
# you have two options to change it
# - create symlink from /var/lib/docker
#    - i used it: /var/lib/docker is a symlink to /srv/docker
# - edit /etc/default/docker (debian path)

do_build () {
    set -x
    time docker-compose -f $1 build ${@:2}
    set +x
}
do_up () {
    set -x
    docker-compose -f $1 up
    set +x
}

docker_get_container_id() {
    image_name=$1
    docker ps | grep $image_name | awk '{print $1}'
}

docker_get_container_name() {
    image_name=$1
    docker ps | grep $image_name | awk '{print $2}'
}

do_run () {
    image_name=$1
    container_id=$(docker_get_container_id $1)
    container_name=$(docker_get_container_name $1)
    docker ps
    echo ">>> execing in docker $container_name -id = $container_id"
    set -x
    # docker exec -it ${@:3} $container_id "$command"
    docker exec -it  $container_id ${@:2}
    set +x
}

do_run_sh () {
    do_run $1 /bin/sh
}
do_run_redis_flush () {
    do_run redis '/usr/local/bin/redis-cli FLUSHALL'
}

# do_run_root () {
#     docker_bash_in $1 "" -u root ${@:2}
# }

docker_attach () {
    image_name=$1
    container_id=$(docker_get_container_id $1)
    docker attach $container_id ${@:2}
}


# alias docker_attach_bag="docker attach `docker_get_container_id autobaggage_app`"
# fucking apostrophes :I
docker_attach_bag() { docker attach $(docker ps | grep dev_app | awk '{print $1}'); }
docker_inspect_bag() { docker inspect $(docker ps | grep dev_app | awk '{print $1}'); }
docker_inspect_bag_ip() { docker inspect $(docker ps | grep dev_app | awk '{print $1}') | grep -i ip; }
docker_attach_bag_old() { docker attach $(docker ps | grep autobaggage_app | awk '{print $1}'); }
docker_inspect_bag_old() { docker inspect $(docker ps | grep autobaggage_app | awk '{print $1}'); }

alias docker_ps="ps -aux | grep 'docker' --color=always | sort -k10"
alias docker_ps2='docker ps'

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

do_compose_yml_from_regex () {
    txt="${1:?regex in docker-compose file}"
    path="${2:-$PWD}"
    fnames=$(ag -g "/docker-compose$txt\.ya?ml$" $path)  # with dir selection ($path) echoes full paths
    for f in $fnames; do
        echo $f
        break
    done
}


do_regex_dev=".*dev"
do_regex_pudb=".*pudb"
do_regex_debug=".*debug"
do_regex_local=".*local"
do_regex_local_dev=".*local.*dev"
do_regex_dev_local=".*dev.*local"
do_regex_prod="((?!dev))"  # negative lookahead = does not contain dev

do_regex_from_category () {
    category="${1?category: dev, pudb, prod, dev_local}"
    if [[ $category == "dev" ]]; then
        echo $do_regex_dev
    elif [[ $category == "debug" ]]; then
        echo $do_regex_debug
    elif [[ $category == "pudb" ]]; then
        echo $do_regex_pudb
    elif [[ $category == "dev_local" ]]; then
        echo $do_regex_dev_local
    elif [[ $category == "local_dev" ]]; then
        echo $do_regex_local_dev
    elif [[ $category == "local" ]]; then
        echo $do_regex_local
    elif [[ $category == "prod" ]]; then
        echo $do_regex_prod
    fi
}

# do_compose_yml_dev () { do_compose_yml_from_regex $do_regex_dev $@; }
# do_compose_yml_pudb () { do_compose_yml_from_regex $do_regex_pudb $@; }
# do_compose_yml_dev_local () { do_compose_yml_from_regex $do_regex_dev_local $@; }
# do_compose_yml_prod () { do_compose_yml_from_regex $do_regex_prod $@; }

do_compose_yml_all () {
    echo $(do_compose_yml_dev $@)
    echo $(do_compose_yml_pudb $@)
    echo $(do_compose_yml_debug $@)
    echo $(do_compose_yml_dev_local $@)
    echo $(do_compose_yml_prod $@)
}

do_cat_compose () {
    category="${1?category: dev, pudb, debug, prod, dev_local}"
    regex=$(do_regex_from_category $category)
    file=$(do_compose_yml_from_regex $regex ${@:2})
    echo $file
}
vido_cat_compose () {
    file=$(do_cat_compose $@)
    vim $file
}

vido_compose_yml_all () {
    vimo $(do_compose_yml_all $@)
}

# do_build__from_regex () {
#     txt="${1:?regex in docker-compose file}"
#     file=$(do_compose_yml_from_regex $1 $@)
#     do_build $file
# }

# do_build_cat () {
#     category="${1?category: dev, pudb, prod, dev_local}"
#     regex=$(do_regex_from_category $category)
#     do_build__from_regex $regex ${@:2}
# }

# do_up__from_regex () {
#     txt="${1:?regex in docker-compose file}"
#     file=$(do_compose_yml_from_regex $1 $@)
#     echo $file
#     do_up $file
# }

do_cat_up () {
    category="${1?category: dev, pudb, debug, prod, dev_local}"
    echo "category: \"$category\""
    regex=$(do_regex_from_category $category)
    echo "category inner regex: \"$regex\""
    file=$(do_compose_yml_from_regex $regex)
    echo "file selected: \"$file\""
    do_up $file ${@:2}
}

do_cat_up_sh () {
    dc_option=shell do_cat_up $@
}

do_cat_build () {
    category="${1?category: dev, pudb, debug, prod, dev_local}"
    echo "category: \"$category\""
    regex=$(do_regex_from_category $category)
    echo "category inner regex: \"$regex\""
    file=$(do_compose_yml_from_regex $regex)
    echo "file selected: \"$file\""
    do_build $file ${@:2}
}

do_redis_cli () {
    image_name=redis
    container_id=$(docker_get_container_id $image_name)
    docker exec -it $container_id redis-cli "$@"
}


do_redis_flush_all () {
    do_redis_cli FLUSHALL
}

do_redis_keys () {
    do_redis_cli "KEYS *"
}


docker_fix_on_install () {
	# on new ubuntu install
	# https://stackoverflow.com/questions/37227349/unable-to-start-docker-service-in-ubuntu-16-04/37640824
sudo systemctl unmask docker.service
sudo systemctl unmask docker.socket
sudo systemctl start docker.service
sudo systemctl status docker
}
