# cache-memoryperformanceprofiling
the repository includes detailed experimental setup, code implementations, data analysis, and visualization of results. this project aims to provide valuable insights into the performance characteristics of modern computer systems and the factors that influence memory access efficiency.

## dependencies
- **perf**: for collecting data on system performance to reflect an approximation of real-time behavior
- **python**: for parsing and plotting data
  - matplotlib
  - pip
  - pandas

## experiment 1: zero queuing delay
to run this experiment, execute: `./test --part1`
which will generate a graph that will look like:
<p align="center">
  <img src="zeroqueingdelay/cachevsmainmemory.png" alt="cachevsmainmemory graph" />
</p>

### graph explanation
the graph displays the read and write latencies for cache and main memory when the queue length is zero (i.e., zero queuing delay). there are three vertical bars representing different latency measurements in cycles:

- **cache read**:
  - the latency for cache read operations is very low. this indicates that reading data from the cache is extremely fast.
  
- **cache write**:
  - the latency for cache write operations is also very low, slightly higher than the cache read latency. this shows that writing data to the cache is almost as fast as reading from it.
  
- **main memory read**:
  - the latency for main memory read operations is significantly higher. this highlights the difference in speed between accessing data from the cache versus accessing data from the main memory.

### key takeaways
- **cache efficiency**: the cache read and write latencies are very low, demonstrating the efficiency of the cache in providing quick access to frequently used data.
- **main memory latency**: the main memory read latency is much higher, indicating that accessing data from the main memory is slower compared to the cache.
- **performance optimization**: this graph underscores the importance of optimizing data access patterns to maximize the use of cache and minimize the need to access main memory, thereby improving overall system performance.

## experiment 2: maximum bandwidth
to run this experiment, execute: `./test --part2`
which will generate a graph that will look like:
<p align="center">
  <img src="maximumbandwidth/heatmap.png" alt="bandwidth data granularity heatmap" />
</p>

### heatmap visualization of maximum bandwidth
the heatmap visualizes the maximum bandwidth of the main memory under various conditions of data access granularity and read vswrite intensity ratio:

#### axes
- **x-axis (read/write ratios)**: the x-axis represents different read vs. write intensity ratios, including:
  - read-only
  - write-only
  - 70:30 ratio (70% reads, 30% writes)
  - 50:50 ratio (50% reads, 50% writes)

- **y-axis (block sizes)**: the y-axis shows different block sizes in bytes:
  - 64b
  - 256b
  - 1024b

#### color coding
each cell within the heatmap is color-coded to represent the level of bandwidth achieved:
- **darker colors** indicate higher bandwidths.
- **lighter colors** represent lower bandwidths.

#### numerical values
the numerical values within each cell specify the exact bandwidth measurement in gigabytes per second (gb/s).

#### interpretation
- **read-only vs. write-only**: the heatmap allows you to compare the bandwidth for read-only and write-only operations across different block sizes.
- **mixed ratios**: it also shows how the bandwidth changes when there is a mix of read and write operations (70:30 and 50:50 ratios).
- **block size impact**: by comparing the rows, you can see how the block size affects the maximum bandwidth for each read/write ratio.

#### key observations
- **higher bandwidth for larger blocks**: generally, larger block sizes (e.g., 1024b) tend to achieve higher bandwidths compared to smaller block sizes (e.g., 64b).
- **read vs. write**: the bandwidth can vary significantly between read-only and write-only operations, with mixed ratios falling somewhere in between.
- **optimal configurations**: the heatmap helps identify the optimal configurations for achieving maximum bandwidth under different conditions.

this visualization provides a clear comparison of how memory performance can vary based on block size and operation type, allowing for quick identification of optimal configurations for desired performance outcomes.

## experiment 3: latency trade-off
to run this experiment, execute: `./test --part3`
which will generate a graph that will look like:
<p align="center">
  <img src="latencytradeoff/latency_graph.png" alt="latency vs throughput data" />
</p>

## experiment 4: cache miss ratio performance
to run this experiment, execute: `./test --part4`
which will generate a graph that will look like:
<p align="center">
  <img src="cache-tlbmissratioperformance/cache_misses_vs_execution_time.png" alt="experiment 4 graph" />
</p>
the scatter plot shows the relationship between l1 dcache load misses and execution time (seconds). here’s a breakdown of what it represents:

- **horizontal axis (x-axis)**: l1 dcache load misses, ranging from 0 to 5000.
- **vertical axis (y-axis)**: execution time on a logarithmic scale, ranging from 10<sup>-2</sup> to 10<sup>2</sup> seconds.

### key observations
- **dense cluster**: there’s a dense cluster of data points at the lower end of both axes, indicating that most executions have fewer cache misses and shorter execution times.
- **scattered points**: as the number of cache misses increases, the execution time also tends to increase, but the data points become more scattered and less dense.

### interpretation
- **lower cache misses**: generally correlate with shorter execution times.
- **higher cache misses**: tend to result in longer execution times, but with more variability.

this graph demonstrates how cache performance impacts execution time in a computer system.

## experiment 5: tlb miss ratio performance
to run this experiment, execute: `./test --part5`
which will generate a graph that will look like:
<p align="center">
  <img src="cache-tlbmissratioperformance/tlb_misses_vs_execution_time.png" alt="experiment 5 graph" />
</p>
- **horizontal axis (x-axis)**: dtlb load misses, ranging from approximately 200 to 500.
- **vertical axis (y-axis)**: execution time on a logarithmic scale, ranging from 10<sup>-2</sup> to 10<sup>-1</sup> seconds.

### key observations
- **dense cluster**: most data points are densely clustered around the lower range of both dtlb load misses and execution time, indicating that many executions have fewer tlb misses and shorter execution times.
- **upward trend**: as the number of dtlb load misses increases, there is a slight upward trend in execution time, suggesting that higher tlb misses might correlate with longer execution times.

### interpretation
- **lower tlb misses**: generally correlate with shorter execution times.
- **higher tlb misses**: tend to result in longer execution times, but with more variability.

this graph illustrates how tlb performance impacts execution time in a computer system.
