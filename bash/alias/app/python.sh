# __python__ __pip__

# language python
## python
## pip
## pipenv
## twine - pypi
## pudb

## PYPI pypi uploads

pypi_generate_dist () {
    python3 setup.py sdist bdist_wheel
    ll dist/
}

pypi_upload_all () {
    twine upload dist/*
}

pypi_upload () {
    twine upload $@
}
pypi_upload_test_all () {
    twine upload --repository-url https://test.pypi.org/legacy/ dist/*
}
pypi_upload_test () {
    twine upload --repository-url https://test.pypi.org/legacy/ $@
}


pip_unused_packages () {
    cat *requirements.in | grep --color=none "^[^#-][^][~=<># ]\+" -o | uniq | tr '-' '_' | xargs -I{} bash -c '! git --no-pager grep -w -q -i {} "*.py" && echo "{} not found in Python files"'
}


alias py2="python"
alias py="python3"

alias ipy2="ipython"
alias ipy="ipython3"



alias pie="pipenv"
alias pier="pie run"
alias piep="pie run python"
alias pies="pie shell"
alias pie3="pie --three"


alias pyc_remove_recursively='sudo find . -name "*.pyc" -exec rm -f {} \;'
alias pyorig_remove_recursively='sudo find . -name "*.py.orig" -exec rm -f {} \;'

function pudb_connect () {
    port="${1-6900}"

    telnet 127.0.0.1 $port
}

pudb_loop () {
    _seconds=2
    while true;
    do
        term_clear
        dat=$(date +'%Y-%m-%d_%H:%M:%S')
        echo ">>> Trying to connect to remote pudb every $_seconds seconds [$dat]"
        pudb_connect
        last=$!
        echo "last output = $last"
        if [[ "$last" == "0" ]]; then
            break
        fi
        sleep $_seconds
    done
}


alias pipenv="python3 -m pipenv"


# alias pip_compile_basic='pip-compile --no-index --output-file requirements.txt requirements.in'
# alias pip_compile_test='pip-compile --no-index -r requirements.txt --output-file ./test-requirements.txt ./test-requirements.in'

# alias pip_compile_both='pip_compile; pip_compile_test'


#make_python_venv () {
#    python3.6 -m venv $1
#}

venvadd () {
    local PYTHON="${1:-python3}"
    $PYTHON -m venv .venv
}
venvjo () {
    source .venv/bin/activate
}
venvno () {
    deactivate
}

poetry_bump_in_venv () {
    venvjo
    set -x
    poetry lock --no-update
    set +x
    venvno
}


export PYTHONDONTWRITEBYTECODE=1  # do not write pyc files when running python



# https://stackoverflow.com/questions/1583219/awk-sed-how-to-do-a-recursive-find-replace-of-a-string
#
alias all_md='find . -type f -regextype sed -regex ".*\.md" -print0'


regex_all_markdown () {
    find . -type f -regextype sed -regex ".*\.mdx*" -print0 | xargs -0 sed -i "$1"
}
regex_all_md () {
    echo "Do you want to execute this regex:"
    echo "$1"
    echo "On all the *.md files in this directory and subdirectories?:"
    all_md

    echo ""
    read -p "Do you really?" yn

    select yn in "Yes" "No"; do
        case $yn in
            Yes) $(all_md) | xargs -0 sed -i "$1"; break;;
            No) exit;;
        esac
        echo ">>$yn<<"
    done
}

alias all_py='find . -type f -regextype sed -regex ".*\.py" -print0'

regex_all_py () {
    echo "Example of cmd: 's/\(def prefix_.*\)/\1 #  comment/g'"
    echo "Do you want to execute this regex:";
    echo "$1";
    echo "On all the *.py files in this directory and subdirectories?:";
    files=$(all_py);
    echo "$files"

    echo "";
    # echo "Do you really wanna? [y]es / [n]o";
    printf 'Do you really wanna (y/n)? ';
    read answer;

    if [ "$answer" != "${answer#[Yy]}" ] ;
    then # this grammar (the #[] operator) means that the variable $answer where any Y or y in 1st position will be dropped if they exist.
        set -x;
        # echo "$files" | xargs -0 sed -i "${1}";

        # sed = only single-line regex
        find . -type f -regextype sed -regex ".*\.py" -print0 | xargs -0 sed -i "$1"

        # perl = multi-line regex? somehow it works
        # find . -type f -regextype sed -regex ".*\.py" -print0 | xargs -0 perl -i -pe "$1"
        set +x;
    else
        echo No;
    fi

    # select yn in "y" "n"; do
    #     case $yn in
    #         y) all_py | xargs -0 sed -i "$1"; break;;
    #         n) exit;;
    #     esac
    # done
}

regexit () {
  # Usage:
  #   regexit '<match_regex>' '<replacement_with_\1_\2...>'
  # Example:
  #   regexit 'modules([./])clients[./]peakwork' 'modules\1peakwork'

  local match_re="$1"
  local repl="$2"

  if [ -z "$match_re" ] || [ -z "$repl" ]; then
    echo "Usage: regexit '<match_regex>' '<replacement_with_\\1_\\2...>'"
    return 2
  fi
  command -v ag >/dev/null 2>&1 || { echo "ag not found"; return 127; }

  echo "Match regex (ag + sed -E):"
  echo "  $match_re"
  echo "Replacement:"
  echo "  $repl"
  echo

  mapfile -t files < <(ag -l --nocolor "$match_re" . 2>/dev/null)

  ((${#files[@]} == 0)) && { echo "No files matched."; return 0; }

  echo "Files containing the pattern:"
  printf '  %s\n' "${files[@]}"
  echo

  printf 'Run replacement (y/n)? '
  read -r answer
  [[ "$answer" =~ ^[Yy]$ ]] || { echo "No."; return 0; }

  # Build the sed substitution automatically.
  # Use a delimiter unlikely to appear in paths/regex.
  local delim='|'
  local sed_expr="s${delim}${match_re}${delim}${repl}${delim}g"

  local f sed_failed=0
  for f in "${files[@]}"; do
    if ! sed -E -i "$sed_expr" "$f"; then
      echo "ERROR: sed failed for: $f" >&2
      sed_failed=1
    fi
  done
  if ((sed_failed)); then
    return 1
  fi
  return 0
}

regexpath () {
  # Usage:
  #   regexpath "modules clients peakwork" "modules peakwork"
  #
  # Turns space-separated path segments into a regex that matches either "/" or "."
  # between segments, capturing the first separator so it can be reused in output.
  #
  # Example:
  #   regexpath "modules clients peakwork" "modules peakwork"
  # -> regexit "modules([./])clients[./]peakwork" "modules\1peakwork"

  local from="$1"
  local to="$2"

  if [ -z "$from" ] || [ -z "$to" ]; then
    echo 'Usage: regexpath "seg1 seg2 ..." "seg1 seg2 ..."'
    return 2
  fi

  # Split on spaces (intentionally simple: segments must not contain spaces)
  local -a A B
  read -r -a A <<< "$from"
  read -r -a B <<< "$to"

  ((${#A[@]} >= 2)) || { echo "regexpath: FROM needs at least 2 segments"; return 2; }
  ((${#B[@]} >= 1)) || { echo "regexpath: TO needs at least 1 segment"; return 2; }

  # Build match regex:
  #   seg1([./])seg2[./]seg3[./]...segN
  local match="${A[0]}([./])${A[1]}"
  local i
  for ((i=2; i<${#A[@]}; i++)); do
    match+="[./]${A[i]}"
  done

  # Build replacement:
  #   seg1\1seg2\1seg3...
  # (uses the captured separator from the match)
  local repl="${B[0]}"
  for ((i=1; i<${#B[@]}; i++)); do
    repl+="\\1${B[i]}"
  done

  regexit "$match" "$repl"
}



# echo_py

echo_py_src () {
    # echo python script output while the script is defined in the bash via EOF
    # usage
    # echo_py_src 'print("HI")' "first_arg" "second_arg"
    PYSRC="${1:?python source text}"
    shift  # skip the first arg = $PYSRC
    result="$(/usr/bin/python3 -c "$PYSRC" "$@")"
    echo "$result"
}

echo_py_example () {
    # echoes the first argument + does not accept others
    # $ echo_py_example 'ahoj'
    PYSRC=$(cat <<EOF
import click

@click.command()
@click.argument("arg1")
def main(**kwargs):
    print(kwargs["arg1"])

main()
EOF
)
    echo_py_src "$PYSRC" $@
}


alias vircpudb="vim ~/.config/pudb/pudb.cfg"


# BLACK

alias black120="black -l 120"
alias black120_str="black -l 120 -S"

alias blacks="black120_str"

ruffix (){
    ruff format $@
}
ruffix_imports (){
    ruff check --select=I fix $@
}

_pip_parse_versions () {
    # get stderr out from pip install versions (with legacy-resolver
    # and output only the package versions one per line
    PYSRC=$(cat <<EOF
import click

@click.command()
@click.argument("out")
@click.argument("last_count", type=int, required=False)
def main(out, last_count):
    lines = out.splitlines()
    version_line = None
    txt = "Could not find a version"
    for line in lines:
        if txt in line:
            version_line = line
            break
    txt = "(from versions: "
    # remove trailing ")"
    versions_txt = version_line[version_line.index(txt)+len(txt):-1]
    versions = versions_txt.split(", ")
    if last_count:
        versions = versions[-last_count:]
    for ver in versions:
        print(ver)

main()
EOF
)
    echo_py_src "$PYSRC" "$@"
}

pip_search_versions () {
    extra_index_url=$1
    package=$2
    last_count="${3:-0}"
    # output versions of a project one per line
    # the pip search is broken :(
    pip_stderr=$(pip install $package==BAD_PIP --use-deprecated=legacy-resolver --extra-index-url $extra_index_url 2>& 1 > /dev/null)
    _pip_parse_versions "$pip_stderr" $last_count
}


regex_all_fix_multiline_docs_end_dot () {
    regex_all_py 's/"""\(.*\w$\)/"""\1./g'
}
regex_all_fix_singleline_docs_end_dot () {
    regex_all_py 's/"""\(.*\w\)"""$/"""\1."""/g'; git diff
}
regex_all_fix_docs_end_dot () {
    regex_all_fix_multiline_docs_end_dot
    regex_all_fix_singleline_docs_end_dot
}

alias py3=python3
alias py=python3

uv_sync () {
  uv sync --all-extras "$@"
}
uv_add () {
    uv add "$@"
}
uv_lock () {
    uv lock "$@"
}

uv_refresh_dispatcher () {
   uv sync --refresh-package kw-dispatcher
}
