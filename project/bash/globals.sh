#!/usr/bin/env bash

WEX_BASHRC_PATH=~/.bashrc
WEX_DIR_BASH="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"/
WEX_DIR_ROOT=$(dirname "${WEX_DIR_BASH}")"/"
WEX_DIR_INSTALL=$(dirname "${WEX_DIR_ROOT}")"/"
WEX_DIR_TMP=${WEX_DIR_ROOT}tmp/
WEX_NAMESPACE_DEFAULT="default"
WEX_SCREEN_WIDTH=$([ "${TERM}" != "unknown" ] && tput cols || echo 100)

WEX_ARGUMENT_DEFAULTS=(
  'non_interactive non_i "Non interactive mode, use default value in place to ask user\n\t\tIf an argument is missing to not automatically ask for it, but exit." false'
  'help help "Display this help manual" false'
  'debug debug "Show extra debug information, depending of method features" false'
  'source source "Show script source instead to execute it" false'
  'quiet quiet "Hide logs and errors" false'
)

. "${WEX_DIR_BASH}/includes/common.sh"
. "${WEX_DIR_BASH}/includes/message-default.sh"
. "${WEX_DIR_BASH}/colors.sh"

# Get the username of the original user
if [ "$(_wexUserIsSudo)" = "false" ];then
  WEX_RUNNER_USERNAME=$(whoami)
  WEX_RUNNER_BASHRC_PATH=${WEX_BASHRC_PATH}
fi

WEX_SWITCH_SUDO_COMMAND="sudo WEX_RUNNER_USERNAME=${WEX_RUNNER_USERNAME} WEX_RUNNER_BASHRC_PATH=${WEX_RUNNER_BASHRC_PATH}"

export WEX_BASHRC_PATH
export WEX_CORE_VERSION=4.0.0
export WEX_DIR_BASH
export WEX_DIR_INSTALL
export WEX_DIR_ROOT
export WEX_DIR_TMP
export WEX_SCREEN_WIDTH
export WEX_NAMESPACE_APP=app
export WEX_NAMESPACE_DEFAULT
export WEX_RUNNER_BASHRC_PATH
export WEX_RUNNER_USERNAME
export WEX_SWITCH_SUDO_COMMAND
