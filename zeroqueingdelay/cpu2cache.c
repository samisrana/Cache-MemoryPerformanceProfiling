#include <stdio.h>
#include <time.h>

int main() {
    int data = 42;  // Data to be "sent" to cache
    volatile int* p = &data;  // Volatile to prevent optimization
    
    clock_t start = clock();
    
    // This read operation is likely to be served from cache
    int read_data = *p;
    
    clock_t end = clock();
    
    double cpu_time_used = ((double) (end - start)) / CLOCKS_PER_SEC;
    //printf("Time taken: %f seconds\n", cpu_time_used);
    
    return 0;
}
