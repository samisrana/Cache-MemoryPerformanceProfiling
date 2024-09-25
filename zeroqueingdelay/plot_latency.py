import csv
import matplotlib.pyplot as plt

# Variables for storing results
main_memory_read_latency = main_memory_write_latency = None
cache_read_latency = cache_write_latency = None

# Read the CSV file
with open('perf_data.csv', 'r') as file:
    reader = csv.DictReader(file)
    
    for row in reader:
        test_type = row['test_type']
        
        if test_type == 'main_memory':
            # Extract values for main memory
            l1_loads = int(row['L1_dcache_loads'])
            l1_stores = int(row['L1_dcache_stores'])  # Using L1 stores for write latency
            l2_misses = int(row['l2_rqsts_miss'])  # L2 misses used for read latency
            cpu_cycles = int(row['cpu_cycles'])
            
            # Calculate main memory read latency (based on L2 misses)
            main_memory_read_latency = cpu_cycles / l2_misses
            print(f"Main Memory Read Latency: {main_memory_read_latency} cycles")
            
            # Calculate main memory write latency (based on L1 stores as a proxy), L1 stores correspond to memory writes that reach main memory
            main_memory_write_latency = cpu_cycles / l1_stores
            print(f"Main Memory Write Latency: {main_memory_write_latency} cycles")
        
        elif test_type == 'cache':
            # Extract values for cache
            l1_loads = int(row['L1_dcache_loads'])
            l1_stores = int(row['L1_dcache_stores'])
            cpu_cycles = int(row['cpu_cycles'])
            
            # Calculate cache read latency
            cache_read_latency = cpu_cycles / l1_loads
            print(f"Cache Read Latency: {cache_read_latency} cycles")
            
            # Calculate cache write latency
            cache_write_latency = cpu_cycles / l1_stores
            print(f"Cache Write Latency: {cache_write_latency} cycles")

# Check if any latency values are ok 
if None in [cache_read_latency, cache_write_latency, main_memory_read_latency, main_memory_write_latency]:
    print("Some latency values could not be calculated due to missing data.")
else:
    # Bar graph for latencies
    labels = ['Cache Read', 'Cache Write', 'Main Memory Read']
    latencies = [cache_read_latency, cache_write_latency, main_memory_read_latency]

    plt.bar(labels, latencies, color=['blue', 'green', 'orange'])
    plt.ylabel('Latency (cycles)')
    plt.title('Cache vs Main Memory Latency')
    plt.show()
