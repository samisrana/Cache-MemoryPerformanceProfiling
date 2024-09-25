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
output_file="performance_results_tlb.csv"

# Clear the output file before capturing data
echo "Num1,Num2,Product,TLB_Misses,Execution_Time" > $output_file

# Loop over each combination of test sizes
for size1 in "${test_sizes[@]}"; do
    for size2 in "${test_sizes[@]}"; do
        echo "Testing Multiplication: ${size1} * ${size2}  (This will take approximately one minute)"

        # Run the C program and use perf to gather TLB metrics
        perf_output=$(perf stat -e dTLB-load-misses,dTLB-store-misses ./multiply $size1 $size2 2>&1)

        # Extract the product from the output of the C program
        product=$(./multiply $size1 $size2 | awk -F'=' '{print $2}' | xargs)

        # Parse the perf output for TLB misses and execution time
        tlb_misses=$(echo "$perf_output" | awk '/dTLB-load-misses/ {print $1}')
        execution_time=$(echo "$perf_output" | awk '/seconds time elapsed/ {print $1}')

        # Only store results if both TLB misses and execution time are available
        if [[ -n "$tlb_misses" && -n "$execution_time" ]]; then
            echo "${size1},${size2},${product},${tlb_misses},${execution_time}" >> $output_file
        else
            echo "Skipping due to missing metrics."
        fi
    done
done

# Call the Python script to plot the data
python3 plot_ratiotoperformance.py --type tlb
