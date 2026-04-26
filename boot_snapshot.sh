#!/bin/bash

OUT="/tmp/boot_snapshot.txt"

{
  echo "BOOT SNAPSHOT - $(date)"
  echo

  echo "[ Interfaces ]"
  ip -br a
  echo

  echo "[ Routes ]"
  ip route
  echo

  echo "[ DNS ]"
  (resolvectl status 2>/dev/null || cat /etc/resolv.conf)
  echo

  echo "[ Services ]"
  systemctl list-units --type=service --state=running 2>/dev/null
  echo

  echo "[ Users ]"
  who
  echo

} > "$OUT"
