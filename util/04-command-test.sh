#!/bin/bash

# $1 Command to be tested
# $2 run case then
# $3 run case else
command_test() {
  if command -v $1 >/dev/null 2>&1; then
    $2
  else
    $3
  fi
}
