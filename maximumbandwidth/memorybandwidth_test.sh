#!/bin/bash

#Sets script to exit on any error, treat unset variables as errors, and return exit status
set -euo pipefail

# Compile C program
gcc -o mainmem_readwrite_ratio mainmem_readwrite_ratio.c

# Array of block sizes (in bytes)
block_sizes=(64 256 1024)

# Array of read/write ratios
ratios=(1.0 0.0 0.7 0.3 0.5)

# Output file to store the results
output_file="bandwidth_results.txt"

# Clear the output file before bandwidth test
echo "" > $output_file

# Loop over each block size (64B, 256B, 1024B) 
for block_size in "${block_sizes[@]}"; do
    # Loop over each read/write ratio
    for ratio in "${ratios[@]}"; do
        echo "Testing Block Size: ${block_size}B, Read Ratio: ${ratio}" | tee -a $output_file
        
        # Run the C program with perf and capture the output
        perf_output=$(perf stat -e page-faults,cycles,instructions,cache-references,cache-misses ./mainmem_readwrite_ratio $block_size $ratio 2>&1)
        
        # Append perf output to the results file
        echo "$perf_output" | tee -a $output_file
        
        # Extract the relevant metrics from the perf output
        cache_references=$(echo "$perf_output" | grep "cache-references" | awk '{print $1}')
        time_elapsed=$(echo "$perf_output" | grep "seconds time elapsed" | awk '{print $1}')
        
        # Calculate total data transferred (in bytes)
        total_data_transferred=$((cache_references * block_size))
        
        # Calculate bandwidth (in bytes per second)
        if (( $(echo "$time_elapsed > 0" | bc -l) )); then
            bandwidth=$(echo "scale=2; $total_data_transferred / $time_elapsed" | bc)
            echo "Block Size: ${block_size}B, Read Ratio: ${ratio} -> Bandwidth: ${bandwidth} B/s" | tee -a $output_file
        else
            echo "Block Size: ${block_size}B, Read Ratio: ${ratio} -> Time elapsed was 0 seconds, cannot calculate bandwidth." | tee -a $output_file
        fi
        
        echo "" >> $output_file
    done
done

# Call the Python script to generate the graph
python3 plot_data.py
