#include <stdio.h>
#include <stdlib.h>
#include <unistd.h> // Include for sysconf

size_t get_main_memory_size() {
    // You can use sysconf to get the total size of physical memory
    long size = sysconf(_SC_PHYS_PAGES) * sysconf(_SC_PAGE_SIZE);
    
    if (size == -1) {
        perror("Failed to determine main memory size");
        return 0;
    }

    return (size_t)size; // Return size in bytes
}

void access_memory(int* array, size_t size) {
    volatile int sum = 0;  // Use volatile to prevent optimization
    for (size_t i = 0; i < size; i++) {
        sum += array[i];  // Read data
    }
}

void write_memory(int* array, size_t size) {
    for (size_t i = 0; i < size; i++) {
        array[i] = i;  // Write data
    }
}

int main() {
    // Get total main memory size dynamically
    size_t main_memory_size = get_main_memory_size();  // Get size of main memory

    if (main_memory_size == 0) {
        printf("Failed to determine main memory size.\n");
        return 1;
    }

    printf("Main Memory Size: %zu bytes\n", main_memory_size);

    // Allocate a large memory size that exceeds L1 cache size
    // Let's allocate 2 times the size of L1 cache for this example
    size_t allocation_size = 2 * (main_memory_size / 10);  // Adjust size as needed
    int* array_main_memory = malloc(allocation_size);  // Allocate data that resides in main memory

    if (array_main_memory == NULL) {
        perror("Memory allocation failed");
        return 1;
    }

    // Access data (this will trigger reads from main memory)
    access_memory(array_main_memory, allocation_size / sizeof(int));  // Access data from main memory

    // Write data (this will trigger writes to main memory)
    write_memory(array_main_memory, allocation_size / sizeof(int));  // Write data to main memory

    // Free memory
    free(array_main_memory);

    return 0;
}
