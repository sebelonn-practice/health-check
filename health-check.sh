#!/bin/bash
echo "=== Health Check Report ==="
echo "Date: $(date)"
echo "Uptime: $(uptime -p)"
echo "Disk Usage:"
df -h --output=target,pcent | grep -v Mounted
echo "Memory Usage:"
free -h
echo "=== Health Check Completed ==="
