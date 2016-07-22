#!/bin/bash
# Files
_SERVICES=`ls *.service`
_RULES=`ls *.rules`
_SCRIPTS=`ls wakelock`

# Dirs
_SRVDIR=/etc/systemd/system
_RULDIR=/etc/udev/rules.d
_SHDIR=/usr/local/bin

function _install() {
  cp $_SERVICES $_SRVDIR
  cp $_RULES $_RULDIR
  cp $_SCRIPTS $_SHDIR
  udevadm control -R
  systemctl daemon-reload
  chmod +x $_SHDIR/$_SCRIPTS
  chcon -t bin_t $_SHDIR/$_SCRIPTS
  echo "Installed successfuly"
}


function _uninstall() {
  #echo $_SRVDIR/$_SERVICES
  for i in $_SERVICES
  do
    rm $_SRVDIR/$i
  done
  rm $_SHDIR/$_SCRIPTS
  rm $_RULDIR/$_RULES
  echo "Uninstalled successfuly"
}

if test `whoami` != "root"
then
  sudo $0 $1
else
  case "$1" in
    i|install)
      _install
      ;;
    u|uninstall)
      _uninstall
      ;;
    h|help)
      echo "Usage: $(basename $0) [i|u|h]"
      echo "Need root!!11"
      ;;
  esac
fi
exit 0
