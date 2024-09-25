#!/bin/bash

# Compile the C program
gcc -o mainmem_write mainmem_write.c

# Array of throughput sizes (in bytes)
throughput_sizes=(64 128 256 512 1024 2048 4096 8192 16384 32768 65536 )

# Output file to store the results
output_file="latency_results.csv"

# Clear the output file before capturing data
echo "Throughput_Size,Latency" > $output_file

# Loop over each throughput size
for size in "${throughput_sizes[@]}"; do
    echo "Testing Throughput Size: ${size}B"

    # Run the C program and run perf for specific statistics we can use for understanding the latency and graphing our data
    # specifically, grab the cycles
    perf stat -e cycles ./mainmem_write $size 2>&1 | awk '/cycles/ {print $1}' > perf_output.txt

    # grab latency from perf output file
    latency=$(cat perf_output.txt)

    # send the throughput size and latency to the CSV output file
    echo "${size},${latency}" >> $output_file
done

python3 plot_tradeoff.py
