#include <stdio.h>
#include <stdlib.h>

int main(int argc, char *argv[]) {
    int a, b, product;
    if (argc != 3) {
        printf("Usage: %s <number 1> <number 2>\n", argv[0]); 
        return 1;
    }
    a = atoi(argv[1]);
    b = atoi(argv[2]);

    // Calculating product
    product = a * b;

    // %.2lf displays number up to 2 decimal point
    printf("Product = %.2d \n", product);
    
    return 0;
}
