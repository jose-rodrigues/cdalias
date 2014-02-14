CDALIAS_DIR=$(dirname $0)

touch $CDALIAS_DIR/.cdalias
source $CDALIAS_DIR/.cdalias

function _check_args() {
  nb_args=$1 && shift
  error_msg=$1 && shift

  if [ "$#" -ne "$nb_args" ]
  then
    echo "USAGE: cdalias $error_msg"
    return 1
  fi
  return 0
}

function _alias_exist() {
  grep "alias cd$1=" $CDALIAS_DIR/.cdalias > /dev/null || return 1
  return 0
}

function _new() {
  _check_args 2 "new aliasname directory" $* || return 1

  _alias_exist $1
  if [ "$?" -eq 0 ]
  then
    echo "ERROR: $1 already exists. Use cdalias update"
    return 1
  elif [ -d "$(realpath $2)" ]
  then
    echo "alias cd$1='cd $(realpath $2)'" >> $CDALIAS_DIR/.cdalias
    echo "Great, now type cd$1 to go to [$(realpath $2)]."
    source $CDALIAS_DIR/.cdalias
  else
    echo "ERROR: $2 is not a directory"
    return 1
  fi
  return 0
}

function _update() {
  _check_args 2 "update aliasname directory" $* || return 1
  _delete $1 || return 1
  _new $1 $2 || return 1
  return 0
}

function _delete() {
  _check_args 1 "delete aliasname" $* || return 1
  _alias_exist $1
  if [ "$?" -eq 0 ]
  then
    cat $CDALIAS_DIR/.cdalias | grep -v "alias cd$1=" > $CDALIAS_DIR/.tmp
    mv $CDALIAS_DIR/.tmp $CDALIAS_DIR/.cdalias
    source $CDALIAS_DIR/.cdalias
  else
    echo "ERROR: alias $1 do not exist"
    return 1
  fi
  return 0
}

function _show() {
  cat $CDALIAS_DIR/.cdalias | sed -e 's/alias\ //g'
}

function cdalias() {
  if [ "$#" -ge 1 ]
  then
    cmd=$1
    shift
    case $cmd in
      new)
        _new $* || return 1
        ;;
      update)
        _update $* || return 1
        ;;
      delete)
        _delete $* || return 1
        ;;
      show)
        _show $* || return 1
        ;;
    esac
  else
    echo "cdalias [new|update|delete|show] ..."
  fi
}


