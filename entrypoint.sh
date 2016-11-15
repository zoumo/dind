#!/bin/sh
set -e

/usr/bin/supervisord -c /etc/supervisor.conf &

sleep 5

exec "$@"