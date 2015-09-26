#!/bin/bash

# Simple mysqld start script for containers
# We do not use mysqld_safe

# Variables

MYSQLD=mysqld
LOG_MESSAGE="Docker startscript: "
wsrep_recover_position=
OPT="$@"

# Do we want to check for programms?

which $MYSQLD || exit 1

# Check for mysql.* schema
# If it does not exists we got to create it

test -d /var/lib/mysql/mysql
if [ $? != 0 ]; then
  mysql_install_db --user=mysql
  if [ $? != 0 ]; then
    echo "${LOG_MESSAGE} Tried to install mysql.* schema because /var/lib/mysql seemed empty"
    echo "${LOG_MESSAGE} it failed :("
  fi
fi

# Start mysqld

exec $MYSQLD $OPT #--wsrep_start_position=$wsrep_start_position

# We should never end in here

echo "${LOG_MESSAGE} Uhh thats evil! How are you able to see this in your log?!"
exit 1
