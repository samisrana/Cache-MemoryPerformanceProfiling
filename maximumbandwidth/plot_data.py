import matplotlib.pyplot as plt
import numpy as np

# Function to read results from any .txt file
def read_bandwidth_results(filename):
    results = {}
    with open(filename, 'r') as file:
        for line in file:
            if "Block Size" in line and "Bandwidth" in line:
                parts = line.split('->')
                header = parts[0].strip()
                bandwidth_info = parts[1].strip()
                
                # Extract block size and ratio
                block_size_ratio = header.split(", ")
                block_size = int(block_size_ratio[0].split(": ")[1][:-1])  # Get the block size
                ratio = float(block_size_ratio[1].split(": ")[1])
                
                # Extract bandwidth
                bandwidth = float(bandwidth_info.split(": ")[1].split(" ")[0])
                
                # Store results
                if (block_size, ratio) not in results:
                    results[(block_size, ratio)] = bandwidth
    return results

# Function to plot the results
def plot_bandwidth(results):
    block_sizes = sorted(set(k[0] for k in results.keys()))
    ratios = sorted(set(k[1] for k in results.keys()))
    
    # Prepare a matrix for the plot
    bandwidth_matrix = np.zeros((len(block_sizes), len(ratios)))
    
    for (block_size, ratio), bandwidth in results.items():
        block_index = block_sizes.index(block_size)
        ratio_index = ratios.index(ratio)
        bandwidth_matrix[block_index, ratio_index] = bandwidth

    # Create a heatmap of bandwidth data to illistrate the memory bandwidth in GB/s across different data access granularities and read/write ratios
    plt.figure(figsize=(10, 6))
    plt.imshow(bandwidth_matrix, aspect='auto', cmap='viridis', interpolation='nearest')
    plt.colorbar(label='Bandwidth (B/s)')
    
    plt.xticks(np.arange(len(ratios)), [f'{r:.2f}' for r in ratios])
    plt.yticks(np.arange(len(block_sizes)), block_sizes)
    
    plt.xlabel('Read/Write Ratios')
    plt.ylabel('Block Sizes (Bytes)')
    plt.title('Memory Bandwidth by Block Size and Read/Write Ratio')
    plt.grid(False)
    
    # Add text annotations
    for i in range(len(block_sizes)):
        for j in range(len(ratios)):
            plt.text(j, i, f'{bandwidth_matrix[i, j]:.0f}', ha='center', va='center', color='white')
    
    plt.show()

# Main function
if __name__ == "__main__":
    filename = "bandwidth_results.txt"  # Path to the results file
    results = read_bandwidth_results(filename) #Read bandwidth_results.txt, the file with the bandwidth test data
    plot_bandwidth(results) #plot the results
