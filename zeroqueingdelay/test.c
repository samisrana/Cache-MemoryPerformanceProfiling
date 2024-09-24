#include <stdio.h>
#include <unistd.h>

int main() {
    long l1_size = sysconf(_SC_LEVEL1_DCACHE_SIZE);

    if (l1_size == -1) {
        printf("Unable to determine L1 cache size.\n");
    } else {
        printf("L1 Cache Size: %ld bytes\n", l1_size);
    }

    return 0;
}
