#include <stdio.h>
#include <stdlib.h>
#include <unistd.h> // Include for sysconf

size_t get_cache_size() {
    // Get L1 cache size using sysconf
    long size = sysconf(_SC_LEVEL1_DCACHE_SIZE);
    
    if (size == -1) {
        perror("Failed to determine L1 cache size");
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
    // Get L1 cache size dynamically
    size_t l1_size = get_cache_size();  // No need for cache_type parameter
    //printf("%zu \n", l1_size);

    if (l1_size == 0) {
        printf("Failed to determine L1 cache size.\n");
        return 1;
    }

    printf("L1 Cache Size: %zu bytes\n", l1_size);

    int* array_l1 = malloc(l1_size);  // Allocate data size that fits in L1 cache

    if (array_l1 == NULL) {
        perror("Memory allocation failed");
        return 1;
    }

    // Access data (this will trigger cache reads)
    access_memory(array_l1, l1_size / sizeof(int));  // Access data from L1

    // Write data (this will trigger cache writes)
    write_memory(array_l1, l1_size / sizeof(int));  // Write data to L1

    // Free memory
    free(array_l1);

    return 0;
}
