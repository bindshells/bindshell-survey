#!/bin/bash

OUT="/tmp/$(date +%F_%H%M%S)"

{
  echo "==== SYSTEM SURVEY ===="
  date
  echo

  echo "== HOST =="
  hostname
  uname -a
  echo

  echo "== CPU / MEM =="
  free -h
  echo

  echo "== NETWORK =="
  ip -br a
  ss -tulnp
  ip route
  resolvectl dns
  echo

  echo "== USERS =="
  who
  echo

  echo "== PROCESSES =="
  ps aux --sort=-%cpu | head -n 15

} > "$OUT"
