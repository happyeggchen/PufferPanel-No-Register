#!/usr/bin/env sh

systemctl daemon-reload

if [ -f "/var/lib/pufferpanel/database-RESTORE.db" ]; then
  mv /var/lib/pufferpanel/database-RESTORE.db /var/lib/pufferpanel/database.db
fi

if [ ! -f "/var/lib/pufferpanel/database.db" ]; then
  touch /var/lib/pufferpanel/database.db
fi

chown -R pufferpanel:pufferpanel /etc/pufferpanel /var/log/pufferpanel /var/lib/pufferpanel /var/www/pufferpanel

systemctl is-active --quiet pufferpanel && systemctl restart pufferpanel
exitCode=$?
[ $exitCode -eq 0 ] || [ $exitCode -eq 3 ] || exit $exitCode
