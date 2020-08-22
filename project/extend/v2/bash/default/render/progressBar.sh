#!/usr/bin/env bash

renderProgressBarArgs() {
  _ARGUMENTS=(
    'percentage p "Percentage" true'
    'width w "Width" false 30'
    'description d "Description" false'
    'status s "Status" false'
    'new_line nl "New line at end" false'
  )
}

# See : https://stackoverflow.com/questions/18362837/how-to-display-and-refresh-multiple-lines-in-bash
# See : https://www.fileformat.info/info/unicode/char/25a0/index.htm
renderProgressBar() {
  local MESSAGE="    ${WEX_COLOR_RESET}["
  local PRECISION=100;

  # Manage cursor position
  if [ "${NEW_LINE}" != "true" ];then
    local PROGRESS_BAR_RUNNING=$(wex var/localGet -n=PROGRESS_BAR_RUNNING -d=false)

    if [ "${PROGRESS_BAR_RUNNING}" = true ];then
      printf "\033[1A"
    fi

    wex var/localSet -n=PROGRESS_BAR_RUNNING -v=true
  fi

  if [ "${DESCRIPTION}" != "" ];then
    MESSAGE=${DESCRIPTION}"\n"${MESSAGE}
  fi

  # TODO Use default value then remove
  if [ "${WIDTH}" = "" ];then
    WIDTH=30
  fi

  # Compute progress position
  for ((i=0;i<=${WIDTH};i++));
  do
     I_CALC=$(expr ${i} \* ${PRECISION})
     I_CALC=$(expr ${I_CALC} / ${WIDTH})
     I_CALC=$(expr ${I_CALC} \* 100)
     I_CALC=$(expr ${I_CALC} / ${PRECISION})

     if [ ${I_CALC} -lt ${PERCENTAGE} ] || [ ${I_CALC} = ${PERCENTAGE} ];then
       MESSAGE+="${WEX_COLOR_CYAN}"
     else
       MESSAGE+="${WEX_COLOR_GRAY}"
     fi

     MESSAGE+='■'
  done

  MESSAGE+="${WEX_COLOR_RESET}] "${PERCENTAGE}'%'"\n"

  if [ "${STATUS}" != "" ];then
    MESSAGE+="     ${WEX_COLOR_GRAY}> ${WEX_COLOR_CYAN}${STATUS}${WEX_COLOR_RESET}"
  fi

  printf "%b          \r" "${MESSAGE}"

  # Complete
  if [ "${PERCENTAGE}" = "100" ];then
    echo ""
    echo ""

    if [ "${NEW_LINE}" != "true" ];then
      wex var/localSet -n=PROGRESS_BAR_RUNNING -v=false
    fi
  fi
}
