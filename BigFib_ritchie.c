/******************************************************************************
;@
;@ Student Name 1: Ritchie Kumar
;@ Student 1 #: 301389811
;@ Student 1 userid (email): ritchiek (ritchiek@sfu.ca)
;@
;@
;@ Below, edit to list any people who helped you with the code in this file,
;@      or put  none  if nobody helped (the two of) you.
;@
;@ Helpers: Bryce Leung, Jim Pimentel, Jennifer Gu
;@
;@ Also, reference resources beyond the course textbooks and the course pages on Canvas
;@ that you used in making your submission.
;@
;@ Resources: arm Developer, arm Keil, Stack Overflow, etc.
;@
;@% Instructions:
;@ * Put your name(s), student number(s), userid(s) in the above section.
;@ * Edit the "Helpers" line and "Resources" line.
;@ * Your group name should be "HW5_<userid1>_<userid2>" (eg. HW5_stu1_stu2)
;@ * Form groups as described at:  https://courses.cs.sfu.ca/docs/students
;@ * Submit your file to courses.cs.sfu.ca
;@
;@ Name        : BigFib.c
;@ Description : bigFib subroutine for HW5.
******************************************************************************/

#include <stdlib.h>

#include "heapstats.h"
#include <errno.h>

typedef unsigned int bigNumN[];

int bigAdd(bigNumN bigN0P, const bigNumN bigN1P, unsigned int maxN0Size);

int bigFib(int n, int maxSize, unsigned **bNP) {
	if(maxSize > 8192){
		errno = ENOMEM;
		return -1;
	}
			if(!bNP) {
				errno = EINVAL;
				return -1;
			}
		    if(maxSize < 0 || n < 0) {
        errno = EINVAL;
        return -1;
    }


    // ... you can modify any code in this function ****
    unsigned* bNa = malloc(4*(1 + maxSize));
    unsigned* bNb = malloc(4*(1 + maxSize));
		//HEAPSTATS;
		
    
    // check for null pointer being returned or not

    // ... fill in code here for sure ****
    
    
		
    if(!bNa || !bNb){
			errno = ENOMEM;
			//printf("ENOMEM");
				
      return -1;
    }
		else {
			*bNa = 0;
			*bNb = 1;
		}
		
    if(maxSize == 0 || n == 0) {
      *(bNa + 1) = 0;
      *bNP = bNa;
				if(maxSize == 16384){
	}
			return 0;
    }
		
		if(n == 1) {
			*(bNb + 1) = 1;
			*bNP = bNb;
			return 1;
		}
    
//////I THINK THIS IS USING AN ARRAY MAYBE A POINTER WOULD BE BETTER//////
		*(bNa + 1) = 0;
		*(bNb + 1) = 1;
		
		int wordCount = 0;
    for(int i = 2; i <= n && wordCount <= maxSize; i++) {
			
			int result = bigAdd(bNa, bNb, maxSize);
      if(result == 0) {
				*bNP = bNa;
				unsigned *temp = bNa;
				bNa = bNb;
				bNb = temp;
       }
       else if(result == 1) {
				n = (i - 1);
         break;
       }
			 else {
				free(bNa);
				free(bNb);
				errno = ENOMEM;
				//printf("enomem in for loop");
				 	if(maxSize == 16384){
	}
				return -1;
			}
			wordCount = *bNb;
    }
		
    //*bNP = bNa;   
    free(bNa);
    free(bNb);
    
    // The following two lines of code are just examples.
    // You might not always want to do them.
    //*bNP = bNa; // don't forget to free the other allocated memory
    return n;
}
