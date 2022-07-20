//============================================================================
//
// Name        : fib.c
// Description : asuFibonacci
//============================================================================

#include <stdlib.h>

#include "BigFib.h"

#define MIN(x, y) (((x) < (y)) ? (x) : (y))
#define MAX_SIZE_TEST 4000

typedef unsigned int bigNumTest[1 + MAX_SIZE_TEST];
typedef unsigned int bigNumN[];

int fib_main(int max_size) {
	max_size = MIN(max_size, MAX_SIZE_TEST);
	unsigned *fibResP = NULL;
	int i = bigFib(1000000, max_size, &fibResP);
	unsigned j = *((fibResP)+1);
	j += 0; // avoid a warning
	free(fibResP);
	return i;
}