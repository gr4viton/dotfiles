# __kubectl__ __kcl__ __kubernetes__ __k8s__
## alias kubectl to something sane
alias kcl='kubectl'
## alias to switch namespaces (kube switch namespace)
kcl_context_use_namespace () {
    namespace=$1
    kubectl config set-context --current --namespace=$namespace
}
## alias to switch context (kube switch context)
kcl_context_use () {
    context=$1
    set -x
    kubectl config use-context $context
    set +x
}
kcl_context_show_all () {
    kubectl config get-contexts
}

kcl_context_grep () {
    context_grep=$1
    kcl_context_show_all | grep $context_grep | awk '{print $2}'
}
kcl_context_use_grep () {
    kcl_context_use $(kcl_context_grep $@)
}

kcl_context_use_prod () {
    kcl_context_use_grep "prod-eu"

}
kcl_context_use_sandbox () {
    kcl_context_use_grep "sandbox-eu"

}

kcl_context_use_old_prod () {
    kcl_context_use_grep "autobooking-prod"
}

kcl_context_use_old_sandbox () {
    kcl_context_use_grep "autobooking-sandbox"
}

alias kcl_prod="kcl_context_use_prod"
alias kcl_sandbox="kcl_context_use_sandbox"

kcl_pod_grep () {
    kcl get pods --all-namespaces | grep $@
}
kcl_pod_all () {
    kcl get pods --all-namespaces
}

_kcl_pod_command_default="/bin/bash"

kcl_pod_exec_first () {
    name=$1
    command="${2:-$_kcl_pod_command_default}"
    pod_row=$(kcl_pod_grep $name | head -1)
    pod_namespace=$(echo $pod_row | awk '{print $1}')
    pod_name=$(echo $pod_row | awk '{print $2}')
    set -x
    kcl exec -it $pod_name -n $pod_namespace "$command"
    set +x
}

kcl_pod_get_first () {
    name=$1
    pod_row=$(kcl_pod_grep $name | head -1)
    pod_namespace=$(echo $pod_row | awk '{print $1}')
    pod_name=$(echo $pod_row | awk '{print $2}')
    echo "-it $pod_name -n $pod_namespace"
}


kcl_pod_exec_exact () {
    pod_name=$1
    kcl exec -it $pod_name $_kcl_pod_command
}
alias kcl_pod_exec="kcl_pod_exec_first"

kcl_sh_cmd () {
    pod_name=$1  # eg black-box-7f6dc5956c-2fzmd
    shift
    kcl exec $(kcl_pod_get_first $pod_name) -- /bin/sh -c "$@"
}

kcl_bash () {
    pod_name=$1  # eg black-box-7f6dc5956c-2fzmd
    kcl exec $(kcl_pod_get_first $pod_name) -- /bin/bash
}

kcl_sh () {
    pod_name=$1  # eg black-box-7f6dc5956c-2fzmd
    set -x
    kcl exec $(kcl_pod_get_first $pod_name) -- /bin/sh
    set +x
}


kcl_black_cmd () {
    kcl_sh_cmd black-box "$@"
}

kcl_modules_staging () {
    # todo add git branch current as default
    branch="${1:-branch-dashed-name-first-9-letters}"
    cmd="/bin/sh"
    kcl_pod_exec "modules-staging-$branch"
}

kcl_gds_in_gcp () {
    kcl_pod_exec dd-gds-gc
}

kcl_pod_exec_namespace () {
    pod_name=$1  # eg black-box-7f6dc5956c-2fzmd
    name_space=$2  # eg black-box
    kcl exec -it $pod_name -n $name_space
}

kcl_pod_platform_id () {
    pod_name=$1
    cmd="sed -E 's/^(\d+)\.(\d+)\.(\d+)$/linux_alpine\1_\2_x86_64/' /etc/alpine-release"
    # cmd="cat /etc/alpine-release;"
    kcl_sh_cmd $pod_name "$cmd"
}


# kubernetes deployments

kcl_rollout_restart_deploy () {
    name=$1
    pod_row=$(kcl_pod_grep $name | head -1)
    pod_namespace=$(echo $pod_row | awk '{print $1}')
    set -x
    kcl rollout restart deploy $name -n $pod_namespace
    set +x
}

kcl_redeploy () {
    kcl_rollout_restart_deploy $@
}

kcl_deploy_configuru_re () {
    kcl_rollout_restart_deploy configuru
}

kcl_deploy_configuru_undo () {
    name=configuru
    pod_row=$(kcl_pod_grep $name | head -1)
    pod_namespace=$(echo $pod_row | awk '{print $1}')
    set -x
    kcl_deploy_undo configuru
    set +x
}

kcl_redeploy_all_gds () {
    projects=( black-box schedule-changer configuru refundopedia gds-viewer gds-queue-handler refunderino faust )
    for var in "${projects[@]}"
    do
      echo "redeploy for: ${var}"
      kcl_redeploy ${var}
    done
}

kcl_redeploy_all_modules_x_stagings () {
    for var in $(
        kubectl get deployments --no-headers  --all-namespaces  | grep -E '^modules-staging|^modules-chrome-staging' | awk '{print $2}'
    )
    do
      echo "redeploy for: ${var}"
      kcl_redeploy ${var}
    done
}

kcl_deployments () {
    kubectl get deployment -A
}

kcl_deploy_undo () {
    name=$1
    namespace=$name
    kcl rollout undo deployment $name --namespace=$namespace
}

kcl_deployment_history () {
    name=$1
    namespace=$name
    kcl rollout history deployment $name --namespace=$namespace
}

kcl_deployment_status () {
    name=$1
    kcl rollout status -w deployment $name --namespace=$namespace
}

kcl_deploy_revision () {
    name=$1
    namespace=$name
    revision_number="${2?revision number}"
    kcl rollout undo deployment $name --to-revision=$revision_number --namespace=$namespace
}

source <(kubectl completion bash)
