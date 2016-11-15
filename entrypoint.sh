#!/bin/sh
set -e

/usr/bin/supervisord -c /etc/supervisor.conf

exec "$@"

