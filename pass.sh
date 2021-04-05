#!/bin/bash
password=$1
function pass () {
  GREEN=$'\e[0;32m'
  RED=$'\e[0;31m'
  NC=$'\e[0m'
  len_pass=$(echo $password | wc -m)
  #echo $len_pass
  if [[ $len_pass -gt 10 ]]; then
    if  [[ $password =~ [0-9] ]] && [[ $password =~ [a-z] ]] || [[ $password =~ [A-Z] ]]; then
      echo Well Done Good Password! ${GREEN} $password ${NC}
      return 0
    else
      echo combine alfa with number ${RED} $password ${NC}
      return 1
    fi
  else
    echo type minimum 10 charecters ${RED} $password ${NC}
    return 1
  fi
}
pass $1
echo $?
