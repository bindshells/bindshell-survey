#!/bin/bash

echo "==============================="
echo " SESSION RECONSTRUCTION"
echo "==============================="
echo

echo "[ Logins ]"
last -a | head -n 20
echo

echo "[ Current Users ]"
who
echo

echo "[ Recent system events (journalctl) ]"
journalctl -n 50 --no-pager 2>/dev/null || echo "journalctl unavailable"
echo

echo "[ Running processes snapshot ]"
ps -eo pid,ppid,user,cmd --sort=-%cpu | head -n 25
echo

echo "[ Network state ]"
ss -tulnp | head -n 30
echo

echo "[ System uptime baseline ]"
uptime
echo
