#!/bin/sh
set -e

# Substitute all environment variables in prom.yml template
# This approach scales to any number of variables
awk '{
  while(match($0, /\$[A-Z_][A-Z0-9_]*/)) {
    var = substr($0, RSTART+1, RLENGTH-1)
    gsub("\\$"var, ENVIRON[var])
  }
  print
}' /etc/prometheus/prom.yml.template > /etc/prometheus/prom.yml

# Execute Prometheus
exec /bin/prometheus "$@"
