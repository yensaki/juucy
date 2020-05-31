#!/bin/sh

RAILS_PORT=3000
if [ -n "$PORT"]; then
  RAILS_PORT=$PORT
fi

bin/rails server -p $RAILS_PORT -b 0.0.0.0
