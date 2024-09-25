#!/bin/bash

# Sets script to exit on any error, treat unset variables as errors, and return exit status
set -euo pipefail

# Function to display usage
usage() {
    echo "Usage: $0 [--part1] [--part2] [--part3] [--part4] [--part5]"
    exit 1
}

# Check for at least one argument
if [ $# -eq 0 ]; then
    usage
fi

# Parse flags
run_part1=false
run_part2=false
run_part3=false
run_part4=false
run_part5=false

while [[ $# -gt 0 ]]; do
    case "$1" in
        --part1) run_part1=true ;;
        --part2) run_part2=true ;;
        --part3) run_part3=true ;;
        --part4) run_part4=true ;;
        --part5) run_part5=true ;;
        *) usage ;;
    esac
    shift
done

# Run parts based on flags
if [ "$run_part1" = true ]; then
    echo "Running Part 1..."
    cd zeroqueingdelay && ./latencytest.sh
    cd ..
fi

if [ "$run_part2" = true ]; then
    echo "Running Part 2..."
    cd maximumbandwidth && ./memorybandwidth_test.sh
    cd ..
fi

if [ "$run_part3" = true ]; then
    echo "Running Part 3..."
    cd latencytradeoff && ./tradeoff.sh
    cd ..
fi

if [ "$run_part4" = true ]; then
    echo "Running Part 4..."
    cd cache-TLBmissratioperformance && ./cachemissratioperformance.sh
    cd ..
fi

if [ "$run_part5" = true ]; then
    echo "Running Part 5..."
    cd cache-TLBmissratioperformance && ./TLBmissratioperformance.sh
    cd ..
fi
