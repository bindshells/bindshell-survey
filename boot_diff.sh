#!/bin/bash
#@reboot /usr/local/bin/boot_snapshot.sh
#*/5 * * * * /usr/local/bin/boot_diff.sh
#every 5 mins writes to $DIFF displaying system changes from bootup baseline

BASE="/tmp/boot_snapshot.txt"
NOW="/tmp/current_snapshot.txt"
DIFF="/tmp/boot_diff.txt"

if [ ! -f "$BASE" ]; then
    echo "Boot baseline missing"
    exit 1
fi

{
  echo "CURRENT STATE - $(date)"
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
} > "$NOW"

diff "$BASE" "$NOW" > "$DIFF"

echo "Diff written to $DIFF"
