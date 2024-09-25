import pandas as pd
import matplotlib.pyplot as plt
import argparse

# argument parsing
parser = argparse.ArgumentParser(description="Plot performance against Cache or TLB misses.")
parser.add_argument("--type", choices=["cache", "tlb"], required=True, help="Specify whether to plot 'cache' or 'tlb' metrics.")
args = parser.parse_args()

# Read the CSV data
#data = pd.read_csv("performance_results.csv")

# Determine which columns, TLB misses or cache misses, to plot
if args.type == "cache":
    data = pd.read_csv("performance_results.csv") # Read the CSV data
    misses = data['Cache_Misses'].astype(float)
    execution_time = data['Execution_Time'].astype(float)
    plot_title = "Cache Misses vs Execution Time"
    x_label = "L1 DCache Load Misses"
    output_file = "cache_misses_vs_execution_time.png"
elif args.type == "tlb":
    data = pd.read_csv("performance_results_tlb.csv") # Read the CSV data
    misses = data['TLB_Misses'].astype(float)
    execution_time = data['Execution_Time'].astype(float)
    plot_title = "TLB Misses vs Execution Time"
    x_label = "dTLB Load Misses"
    output_file = "tlb_misses_vs_execution_time.png"

# Create a scatter plot of Misses vs Execution Time
plt.figure(figsize=(10, 6))
plt.scatter(misses, execution_time, alpha=0.5, color='blue')
plt.title(plot_title)
plt.xlabel(x_label)
plt.ylabel("Execution Time (seconds)")
plt.xscale('log')  
plt.yscale('log')  
plt.grid(True)

# Save the plot as an image
plt.savefig(output_file)
plt.show()
