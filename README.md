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

## Experiment 2: Maximum Bandwidth
To run this experiment, execute: `./test --part2`
which will generate a graph that will look like:
<p align="center">
  <img src="maximumbandwidth/heatmap.png" alt="Bandwidth Data granularity heatmap" />
</p>

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
The scatter plot you provided shows the relationship between L1 DCache Load Misses and Execution Time (seconds). Here’s a breakdown of what it represents:

- **Horizontal Axis (X-axis)**: L1 DCache Load Misses, ranging from 0 to 5000.
- **Vertical Axis (Y-axis)**: Execution Time on a logarithmic scale, ranging from 10<sup>-2</sup> to 10<sup>2</sup> seconds.

**Key Observations**:
- **Dense Cluster**: There’s a dense cluster of data points at the lower end of both axes, indicating that most executions have fewer cache misses and shorter execution times.
- **Scattered Points**: As the number of cache misses increases, the execution time also tends to increase, but the data points become more scattered and less dense.

**Interpretation**:
- Lower Cache Misses: Generally correlate with shorter execution times.
- Higher Cache Misses: Tend to result in longer execution times, but with more variability.

This graph demonstrates how cache performance impacts execution time in a computer system.

## Experiment 5: TLB Miss Ratio Performance
To run this experiment, execute: `./test --part5`
which will generate a graph that will look like:
<p align="center">
  <img src="cache-TLBmissratioperformance/tlb_misses_vs_execution_time.png" alt="experiment 5 graph" />
</p>
- **Horizontal Axis (X-axis)**: dTLB Load Misses, ranging from approximately 200 to 500.
- **Vertical Axis (Y-axis)**: Execution Time on a logarithmic scale, ranging from 10<sup>-2</sup> to 10<sup>-1</sup> seconds.

**Key Observations**:
- **Dense Cluster**: Most data points are densely clustered around the lower range of both dTLB Load Misses and execution time, indicating that many executions have fewer TLB misses and shorter execution times.
- **Upward Trend**: As the number of dTLB Load Misses increases, there is a slight upward trend in execution time, suggesting that higher TLB misses might correlate with longer execution times.

**Interpretation**:
- Lower TLB Misses: Generally correlate with shorter execution times.
- Higher TLB Misses: Tend to result in longer execution times, but with more variability.

This graph illistrates how TLB performance impacts execution time in a computer system.
