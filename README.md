# Cache-MemoryPerformanceProfiling
The repository includes detailed experimental setup, code implementations, data analysis, and visualization of results. This project aims to provide valuable insights into the performance characteristics of modern computer systems and the factors that influence memory access efficiency.

## Dependencies
- **perf**: for collecting data on system performance to reflect an approximation of real-time behavior
- **Python**: for parsing and plotting data
  - matplotlib
  - pip
  - pandas

## Experiment 1: Zero Queuing Delay
To run this experiment, execute: `./test --part1`
which will generate a graph that will look like:
<p align="center">
  <img src="zeroqueingdelay/CacheVsMainMemory.png" alt="CacheVsMainMemory graph" />
</p>

### Graph Explanation
The graph displays the read and write latencies for cache and main memory when the queue length is zero (i.e., zero queuing delay). There are three vertical bars representing different latency measurements in cycles:

- **Cache Read**:
  - The latency for cache read operations is very low. This indicates that reading data from the cache is extremely fast.
  
- **Cache Write**:
  - The latency for cache write operations is also very low, slightly higher than the cache read latency. This shows that writing data to the cache is almost as fast as reading from it.
  
- **Main Memory Read**:
  - The latency for main memory read operations is significantly higher. This highlights the difference in speed between accessing data from the cache versus accessing data from the main memory.

### Key Takeaways
- **Cache Efficiency**: The cache read and write latencies are very low, demonstrating the efficiency of the cache in providing quick access to frequently used data.
- **Main Memory Latency**: The main memory read latency is much higher, indicating that accessing data from the main memory is slower compared to the cache.
- **Performance Optimization**: This graph underscores the importance of optimizing data access patterns to maximize the use of cache and minimize the need to access main memory, thereby improving overall system performance.

## Experiment 2: Maximum Bandwidth
To run this experiment, execute: `./test --part2`
which will generate a graph that will look like:
<p align="center">
  <img src="maximumbandwidth/heatmap.png" alt="Bandwidth Data granularity heatmap" />
</p>

### Heatmap Visualization of Maximum Bandwidth
The heatmap visualizes the maximum bandwidth of the main memory under various conditions of data access granularity and read vswrite intensity ratio:

#### Axes
- **X-Axis (Read/Write Ratios)**: The x-axis represents different read vs. write intensity ratios, including:
  - Read-only
  - Write-only
  - 70:30 ratio (70% reads, 30% writes)
  - 50:50 ratio (50% reads, 50% writes)

- **Y-Axis (Block Sizes)**: The y-axis shows different block sizes in bytes:
  - 64B
  - 256B
  - 1024B

#### Color Coding
Each cell within the heatmap is color-coded to represent the level of bandwidth achieved:
- **Darker colors** indicate higher bandwidths.
- **Lighter colors** represent lower bandwidths.

#### Numerical Values
The numerical values within each cell specify the exact bandwidth measurement in gigabytes per second (GB/s).

#### Interpretation
- **Read-Only vs. Write-Only**: The heatmap allows you to compare the bandwidth for read-only and write-only operations across different block sizes.
- **Mixed Ratios**: It also shows how the bandwidth changes when there is a mix of read and write operations (70:30 and 50:50 ratios).
- **Block Size Impact**: By comparing the rows, you can see how the block size affects the maximum bandwidth for each read/write ratio.

#### Key Observations
- **Higher Bandwidth for Larger Blocks**: Generally, larger block sizes (e.g., 1024B) tend to achieve higher bandwidths compared to smaller block sizes (e.g., 64B).
- **Read vs. Write**: The bandwidth can vary significantly between read-only and write-only operations, with mixed ratios falling somewhere in between.
- **Optimal Configurations**: The heatmap helps identify the optimal configurations for achieving maximum bandwidth under different conditions.

This visualization provides a clear comparison of how memory performance can vary based on block size and operation type, allowing for quick identification of optimal configurations for desired performance outcomes.

## Experiment 3: Latency Trade-off
To run this experiment, execute: `./test --part3`
which will generate a graph that will look like:
<p align="center">
  <img src="latencytradeoff/latency_graph.png" alt="latency vs throughput data" />
</p>

## Experiment 4: Cache Miss Ratio Performance
To run this experiment, execute: `./test --part4`
which will generate a graph that will look like:
<p align="center">
  <img src="cache-TLBmissratioperformance/cache_misses_vs_execution_time.png" alt="experiment 4 graph" />
</p>
The scatter plot shows the relationship between L1 DCache Load Misses and Execution Time (seconds). Here’s a breakdown of what it represents:

- **Horizontal Axis (X-axis)**: L1 DCache Load Misses, ranging from 0 to 5000.
- **Vertical Axis (Y-axis)**: Execution Time on a logarithmic scale, ranging from 10<sup>-2</sup> to 10<sup>2</sup> seconds.

### Key Observations
- **Dense Cluster**: There’s a dense cluster of data points at the lower end of both axes, indicating that most executions have fewer cache misses and shorter execution times.
- **Scattered Points**: As the number of cache misses increases, the execution time also tends to increase, but the data points become more scattered and less dense.

### Interpretation
- **Lower Cache Misses**: Generally correlate with shorter execution times.
- **Higher Cache Misses**: Tend to result in longer execution times, but with more variability.

This graph demonstrates how cache performance impacts execution time in a computer system.

## Experiment 5: TLB Miss Ratio Performance
To run this experiment, execute: `./test --part5`
which will generate a graph that will look like:
<p align="center">
  <img src="cache-TLBmissratioperformance/tlb_misses_vs_execution_time.png" alt="experiment 5 graph" />
</p>
- **Horizontal Axis (X-axis)**: dTLB Load Misses, ranging from approximately 200 to 500.
- **Vertical Axis (Y-axis)**: Execution Time on a logarithmic scale, ranging from 10<sup>-2</sup> to 10<sup>-1</sup> seconds.

### Key Observations
- **Dense Cluster**: Most data points are densely clustered around the lower range of both dTLB Load Misses and execution time, indicating that many executions have fewer TLB misses and shorter execution times.
- **Upward Trend**: As the number of dTLB Load Misses increases, there is a slight upward trend in execution time, suggesting that higher TLB misses might correlate with longer execution times.

### Interpretation
- **Lower TLB Misses**: Generally correlate with shorter execution times.
- **Higher TLB Misses**: Tend to result in longer execution times, but with more variability.

This graph illustrates how TLB performance impacts execution time in a computer system.
