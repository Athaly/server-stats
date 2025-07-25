#!/bin/bash

{
echo " ===== Server perfomance status ====="
echo " "

#cpu
cpu_usage=$(top -bn1 | grep "%Cpu(s)" | awk '{print 100 - $8"%"}')
echo "Cpu usage: $cpu_usage"

#ram
ram_usage=$(free -m | awk '/Mem:/ {used=$3; total=$2; printf "%dMB / %dMB (%2.f%%)", used, total, used/total*100}')
echo "Ram usage: $ram_usage"

#disk
disk_usage=$(df -h / | awk 'NR==2 {print $3 " / " $2 " (" $5 " used)"}')
echo "Disk usage (root): $disk_usage"

#top 5 cpu
echo " "
echo "Top 5 processes by CPU usage:"
ps -eo pid,comm:20,%cpu --sort=%cpu | head -n 6

#top 5 ram
echo " "
echo " Top 5 processes by RAM usage:"
ps -eo pid,comm:20,%mem --sort=%mem | head -n 6

#extras
echo " "
echo "Extra info:"
echo "OS: $(uname -srv)"
echo "Uptime: $(uptime -p)"
echo "Load average $(uptime | awk -F 'load average:' '{print $2}')"
echo "Logged in users: $(who | wc -l)"

echo " "
echo "=================================="
} 

