#include <stdio.h>
#include <stdlib.h>
#include <time.h>

#define LARGE_SIZE 1000000  // Size large enough to exceed cache

int main() {
    int* large_array = malloc(LARGE_SIZE * sizeof(int));
    if (large_array == NULL) {
        printf("Memory allocation failed\n");
        return 1;
    }
    
    // Write to force memory allocation
    for (int i = 0; i < LARGE_SIZE; i++) {
        large_array[i] = i;
    }
    
    // Read from a random location, likely to miss cache
    int random_index = rand() % LARGE_SIZE;
    volatile int* p = &large_array[random_index];
    
    clock_t start = clock();
    
    // This read operation is likely to be served from main memory
    int read_data = *p;
    
    clock_t end = clock();
    
    double cpu_time_used = ((double) (end - start)) / CLOCKS_PER_SEC;
  //  printf("Time taken: %f seconds\n", cpu_time_used);
    
    free(large_array);
    return 0;
}
