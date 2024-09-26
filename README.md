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
<p align="center">
  <img src="zeroqueingdelay/CacheVsMainMemory.png" alt="CacheVsMainMemory graph" />
</p>

## Experiment 2: Maximum Bandwidth
To run this experiment, execute: `./test --part2`

<p align="center">
  <img src="maximumbandwidth/heatmap.png" alt="Bandwidth Data granularity heatmap" />
</p>

## Experiment 3: Latency Trade-off
To run this experiment, execute: `./test --part3`

<p align="center">
  <img src="latencytradeoff/latency_graph.png" alt="latency vs throughput data" />
</p>

## Experiment 4: Cache Miss Ratio Performance
To run this experiment, execute: `./test --part4`
<p align="center">
  <img src="cache-TLBmissratioperformance/cache_misses_vs_execution_time.png" alt="experiment 4 graph" />
</p>

## Experiment 5: TLB Miss Ratio Performance
To run this experiment, execute: `./test --part5`

<p align="center">
  <img src="cache-TLBmissratioperformance/tlb_misses_vs_execution_time.png" alt="experiment 5 graph" />
</p>

