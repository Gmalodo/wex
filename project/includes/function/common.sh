#!/usr/bin/env bash

# Data storage access performance.
_wexLoadVariables() {
  local STORAGE=${WEX_TMP_GLOBAL_VAR}

  if [ -f "${STORAGE}" ];then
    . "${STORAGE}";
  fi
}

_wexLocalScriptPath() {
  echo "${WEX_RUNNER_PATH_WEX}bash/${1}.sh"
}

_wexFindScriptFile() {
  local WEX_SCRIPT_CALL_NAME
  local WEX_SCRIPT_FILE

  # Given args is a file.
  if [ -f "${WEX_SCRIPT_CALL_NAME}" ];then
    echo "${WEX_SCRIPT_FILE}"
    return
  fi

  WEX_SCRIPT_CALL_NAME="${1}"
  WEX_SCRIPT_FILE=$(_wexLocalScriptPath "${WEX_SCRIPT_CALL_NAME}")

  if [ -f "${WEX_SCRIPT_FILE}" ];then
    echo "${WEX_SCRIPT_FILE}"
    return
  fi

  WEX_SCRIPT_FILE=${WEX_DIR_BASH}${WEX_SCRIPT_CALL_NAME}.sh

  if [ -f "${WEX_SCRIPT_FILE}" ];then
    echo "${WEX_SCRIPT_FILE}"
    return
  fi
}

_wexMethodName() {
  local SPLIT=(${1//// })
  echo "${SPLIT[0]}$(_wexUpperCaseFirstLetter "${SPLIT[1]}")"
}

_wexMethodNameArgs() {
  echo "$(_wexMethodName "${1}")Args"
}

_wexTruncate() {
  local MAX_MIDTH
  MAX_WIDTH=$(("${WEX_SCREEN_WIDTH}" - "${WEX_TRUCATE_SPACE}" - ${2}))

  if [ "${#1}" -gt "${MAX_WIDTH}" ];then
    echo "$(echo "${1}" | cut -c -"${MAX_WIDTH}")${WEX_COLOR_GRAY}...${WEX_COLOR_RESET} "
  else
    echo "${1}"
  fi
}

_wexUpperCaseFirstLetter() {
  echo $(tr '[:lower:]' '[:upper:]' <<< ${1:0:1})${1:1}
}

_wexUserIsSudo() {
  if [ "$EUID" -ne 0 ];then
    echo "false"
  else
    echo "true"
  fi
}