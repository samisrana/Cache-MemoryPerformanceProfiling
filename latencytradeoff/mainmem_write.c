#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <pthread.h>

// Function for determinig total size of main memory in bytes using, sysconf, system calls
size_t get_main_memory_size() {
    long size = sysconf(_SC_PHYS_PAGES) * sysconf(_SC_PAGE_SIZE);
    
    if (size == -1) {
        perror("flailed to determine main memory size");
        return 0;
    }
    return (size_t)size; // Return size in bytes
}

// Function for writing to main memory at a certain memory location
void write_memory(int* array, size_t size) {
    for (size_t i = 0; i < size; i++) {
        array[i] = i;  // Write data
    }
}

// struct for storing thread data
typedef struct {
    size_t throughput;
    int thread_id;
} thread_data_t;

// Function for allocating, writing, and clearing memory for each thread
void* thread_function(void* arg) {
    thread_data_t* data = (thread_data_t*)arg;
    size_t throughput = data->throughput;

    // Allocate memory for this thread's writing operation
    int* array_main_memory = malloc(throughput);
    if (array_main_memory == NULL) {
        perror("Memory allocation failed");
        return NULL;
    }

    // Write data to main memory
    write_memory(array_main_memory, throughput / sizeof(int));

    // Free memory
    free(array_main_memory);
    return NULL;
}

int main(int argc, char* argv[]) {
    if (argc != 2) {
        fprintf(stderr, "Usage: %s <throughput_in_bytes>\n", argv[0]);
        return 1;
    }

    size_t throughput = strtoull(argv[1], NULL, 10); // Throughput size in bytes
    size_t main_memory_size = get_main_memory_size(); 

    if (main_memory_size == 0) {
        printf("Failed to determine main memory size.\n");
        return 1;
    }

    printf("Main Memory Size: %zu bytes\n", main_memory_size);

    // Check if throughput exceeds available memory
    if (throughput > main_memory_size) {
        printf("Requested throughput size exceeds available main memory.\n");
        return 1;
    }

    // Get the maximum number of CPU cores, could vary from PC to PC
    int num_threads = sysconf(_SC_NPROCESSORS_ONLN);
    printf("Using %d threads (available CPU cores)\n", num_threads);

    pthread_t* threads = malloc(num_threads * sizeof(pthread_t));
    thread_data_t* thread_data = malloc(num_threads * sizeof(thread_data_t));

    // Create the threads
    for (int i = 0; i < num_threads; i++) {
        thread_data[i].throughput = throughput;
        thread_data[i].thread_id = i;
        if (pthread_create(&threads[i], NULL, thread_function, (void*)&thread_data[i]) != 0) {
            perror("Failed to create thread");
            return 1;
        }
    }

    // Join the threads
    for (int i = 0; i < num_threads; i++) {
        pthread_join(threads[i], NULL);
    }

    // Clean everything up
    free(threads);
    free(thread_data);

    return 0;
}
