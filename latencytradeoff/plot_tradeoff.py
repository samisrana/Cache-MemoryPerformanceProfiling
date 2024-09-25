import matplotlib.pyplot as plt
import pandas as pd

# read the CSV data
data = pd.read_csv("latency_results.csv")

# take throughput sizes and latency
throughput_sizes = data['Throughput_Size']
latencies = data['Latency']

# plot the data extracted
plt.plot(throughput_sizes, latencies, marker='o')
plt.title("Latency vs Throughput Size")
plt.xlabel("Throughput Size (bytes)")
plt.ylabel("Latency (cycles)")
plt.grid()
plt.savefig("latency_graph.png")
plt.show()
