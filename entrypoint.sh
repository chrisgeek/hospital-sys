#!/bin/bash
set -e

# REmove server.pid if it exists
rm -f /hospital-sys/tmp/pids/server.pid

# execute container's main process (CMD in docker file)
exec "$@"
