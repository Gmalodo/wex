#!/usr/bin/env bash

ftpUserAddArgs() {
  _ARGUMENTS=(
    [0]='ftp_username u "FTP Username" true'
    [1]='password p "Password" true'
    [2]='directory d "Directory related to site root (ex : project/files)" true'
    [3]='save s "Push changes in site repository" true'
  )
}

ftpUserAdd() {
  # Load site name.
  . ${WEX_WEXAMPLE_SITE_CONFIG}

  local PASS_LOCATION=/etc/pure-ftpd/passwd/${SITE_NAME}.passwd

  docker exec -ti wex_ftp touch ${PASS_LOCATION}
  # Exec into container
  docker exec -ti wex_ftp /bin/bash -c "(echo ${PASSWORD}; echo ${PASSWORD}) |  pure-pw useradd ${FTP_USERNAME} -f ${PASS_LOCATION} -m -u ftpuser -d /var/www/${SITE_NAME}/${DIRECTORY}"

  if [ "${SAVE}" == true ];then
    wex ftp/save
  fi
}
