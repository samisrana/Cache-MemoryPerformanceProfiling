#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MAINMEMBUF 1024 * 1024 * 64  // buffer size to ensure main memory access (64 MB)

void readwrite_datagran(int block_size, float read_ratio) {
    char *buffer = malloc(MAINMEMBUF);  // Allocate a buffer larger than the cache size

    if (buffer == NULL) {
        perror("memory allocation failed ;( ");
        return;
    }

    int read_count = (int)(MAINMEMBUF / block_size * read_ratio);  // Number of reads
    int write_count = (int)(MAINMEMBUF / block_size * (1 - read_ratio));  // Number of writes

    // create random access pattern to simulate real-world scenarios where data is accessed in a non-sequentially
    int *accessPattern = malloc((read_count + write_count) * sizeof(int));
    for (int i = 0; i < read_count + write_count; ++i) {
        accessPattern[i] = rand() % (MAINMEMBUF / block_size);
    }


    // Perform reads
    for (int i = 0; i < read_count; ++i) {
        memcpy(buffer + (accessPattern[i] * block_size), buffer + (accessPattern[i] * block_size), block_size);  // Random read
    }

    // Perform writes
    for (int i = 0; i < write_count; ++i) {
        memset(buffer + (accessPattern[i] * block_size), 1, block_size);  // Random write
    }

    free(accessPattern);
    free(buffer);
}

int main(int argc, char *argv[]) {
    // arguement condition check, must call with data access granularity size arguement and read-write ratio arguement
    if (argc != 3) {
        printf("Usage: %s <block_size> <read_ratio>\n", argv[0]); 
        return 1;
    }

    int block_size = atoi(argv[1]);  // Get block size from argument
    float read_ratio = atof(argv[2]);  // Get read-write ratio from argument

    readwrite_datagran(block_size, read_ratio); //call function for arbritrary arguements

    return 0;
}
