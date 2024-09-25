#!/bin/bash

#Sets script to exit on any error, treat unset variables as errors, and return exit status
set -euo pipefail

# compile code
gcc -g cpu2cache.c -o cache_test

# data file
output_file="perf_data.csv"

# Set CPU governor to performance globally (fallback to userspace if performance is unavailable)
#sudo modprobe cpufreq_userspace

# Function to run perf and extract main memory stats
run_main_memory_test() {
    echo "Running main memory test..."
    
    # perf command for gathering data of neccessary properties to calculate latency
    result=$(perf stat -e L1-dcache-loads,L1-dcache-stores,l2_rqsts.miss,cpu-cycles ./main_memory_test 2>&1)
    
    # Extract data from perf command
    l1_loads=$(echo "$result" | grep 'L1-dcache-loads' | awk '{print $1}')
    l1_stores=$(echo "$result" | grep 'L1-dcache-stores' | awk '{print $1}')
    l2_misses=$(echo "$result" | grep 'l2_rqsts.miss' | awk '{print $1}')
    cpu_cycles=$(echo "$result" | grep 'cpu-cycles' | awk '{print $1}')
    
    # send data to CSV
    echo "main_memory,$l1_loads,$l1_stores,$l2_misses,NA,$cpu_cycles" >> $output_file
}

# Function to run perf and extract cache stats
run_cache_test() {
    echo "Running cache test..."
    # run perf and put stats in a result variable
    result=$(sudo perf stat -e L1-dcache-loads,L1-dcache-stores,cpu-cycles -C 0 ./cache_test 2>&1)
    
    # Extract relevant data from perf result
    l1_loads=$(echo "$result" | grep 'L1-dcache-loads' | awk '{print $1}')
    l1_stores=$(echo "$result" | grep 'L1-dcache-stores' | awk '{print $1}')
    cpu_cycles=$(echo "$result" | grep 'cpu-cycles' | awk '{print $1}')
    
    # Write data to CSV
    echo "cache,$l1_loads,$l1_stores,,,$cpu_cycles" >> $output_file
}

echo "Running performance tests and saving data to $output_file..."
> $output_file
echo "test_type,L1_dcache_loads,L1_dcache_stores,l2_rqsts_miss,NA,cpu_cycles" > $output_file

# Run tests
run_main_memory_test
run_cache_test

# Restore CPU governor to default (ondemand)
#sudo cpufreq-set -g ondemand

echo "Performance tests completed. Data saved to $output_file."

echo "Plotting data"
python3 plot_latency.py
