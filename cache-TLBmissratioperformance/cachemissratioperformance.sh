#!/bin/bash

# Compile the C program
gcc -o multiply multiply.c

# Declare an empty array to hold results
results=()

# Array of test sizes (1 to 100 for multiplication)
test_sizes=(1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 
            21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 
            41 42 43 44 45 46 47 48 49 50)

# Output file to store the results
output_file="performance_results.csv"

# Clear the output file before capturing data
echo "Num1,Num2,Product,Cache_Misses,Execution_Time" > $output_file

# Loop over each combination of test sizes
for size1 in "${test_sizes[@]}"; do
    for size2 in "${test_sizes[@]}"; do
        echo "Testing Multiplication: ${size1} * ${size2}  (This will take approximately one minute)"

        # Run the C program and use perf to gather metrics
        perf_output=$(perf stat -e L1-dcache-load-misses,L1-dcache-loads ./multiply $size1 $size2 2>&1)

        # Extract the product from the output of the C program
        product=$(./multiply $size1 $size2 | awk -F'=' '{print $2}' | xargs)

        # Parse the perf output for cache misses and execution time
        cache_misses=$(echo "$perf_output" | awk '/L1-dcache-load-misses/ {print $1}')
        execution_time=$(echo "$perf_output" | awk '/seconds time elapsed/ {print $1}')

        # Only store results if both cache misses and execution time are available
        if [[ -n "$cache_misses" && -n "$execution_time" ]]; then
            echo "${size1},${size2},${product},${cache_misses},${execution_time}" >> $output_file
        else
            echo "Skipping due to missing metrics."
        fi
    done
done

# Call the Python script to plot the data
python3 plot_ratiotoperformance.py --type cache
