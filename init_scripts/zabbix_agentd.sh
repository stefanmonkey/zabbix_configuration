#!/bin/sh
#chkconfig: 345 95 95
#description:Zabbix agent
# Zabbix
# Copyright (C) 2001-2013 Zabbix SIA
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301, USA.


# Start/Stop the Zabbix agent daemon.
# Place a startup script in /sbin/init.d, and link to it from /sbin/rc[023].d


SERVICE="Zabbix agent"
BASEDIR=/usr/local/monitor_tools/app/zabbix_agent
DAEMON=${BASEDIR}/sbin/zabbix_agentd
PIDFILE=${BASEDIR}/log/zabbix_agentd.pid
ZABBIX_AGENTD=$BASEDIR/sbin/zabbix_agentd


case $1 in
'start')
	if [ -x ${DAEMON} ]
		then
		$DAEMON
	# Error checking here would be good...
		echo "${SERVICE} started."
	else
		echo "Can't find file ${DAEMON}."
		echo "${SERVICE} NOT started."
	fi
;;
'stop')
	if [ -s ${PIDFILE} ]
		then
		if kill `cat ${PIDFILE}` >/dev/null 2>&1
			then
			echo "${SERVICE} terminated."
			rm -f ${PIDFILE}
		fi
	fi
;;
'restart')
	$0 stop
	sleep 10
	$0 start
;;
*)
	echo "Usage: $0 start|stop|restart"
;;
esac