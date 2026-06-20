#!/bin/bash
# linux will always use bash to run it
# bin/bash is the location of the bash program on computer

echo "-- server stats dashboard --"

#1. CPU USAGE
# it calculates this by checking how much time CPU was idle and then subtracting that from 100 gives us usage percentage


IDLE_CPU=$(top -bn1 | grep "Cpu(s)" | awk '{print $8}')
# 'top -bn1' takes a single snapshot of system performance
# 'grep' finds the line with CPU stats
# 'awk '{print $8}'' grabs the 8th word on the line which is idle number

# fix commas, some linux systems use 92,3 instead of 92.3. ---AI told me this
IDLE_CPU=${IDLE_CPU//,/.}

# 100 - IDLE = total usage
CPU_USAGE=$(awk "BEGIN {print 100 - $IDLE_CPU}")

echo "Total CPU Usage: ${CPU_USAGE}%"

# spaces matter a lot in bash
# ❌ This breaks in Bash:
#IDLE_CPU = $(top -bn1 ...)

#  This is correct:
#IDLE_CPU=$(top -bn1 ...)



echo "----------------"
echo "Memory Usage"
# Total memory usage (Free vs Used including percentage)
free -m | awk 'NR==2 {   
    total=$2;
    used=$3
    free_mem=$4
    percentage=(used*100)/total;
    printf "Used Memory: %d MB\nFree Memory: %d MB\nPercentage Used: %.2f%%\n", used, free_mem, percentage
}'

#NR==2 means second row, whcih is memory. total=$2 means second column, similarly third for used and 4th for free mem



echo "----------------"
echo "--Disk Usage--"
# Total disk usage (Free vs Used including percentage)
df -h / | awk 'NR==2{
    used=$3;
    free_disk=$4;
    percentage=$5;
    printf "Used Disk Space: %s\nFree Disk Space: %s\nPercentage Used: %s\n", used, free_disk, percentage
}'
# df means disk free and -h for human readable, / is for root. it goes on line 2. column 3 shows used space, column 4 shows avil space, column 5 shows percentage

