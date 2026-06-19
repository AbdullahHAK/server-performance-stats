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