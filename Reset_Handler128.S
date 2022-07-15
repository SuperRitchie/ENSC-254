;@============================================================================
;@ Name         Reset_Handler.s
;@ Description  128-bit Fibonacci calculation
;@============================================================================

;@ Highly recommended in Edit > Configuration 
;@ Tabs set for 8 characters for ASM files

	.text		;@ "text" section for program. Stored in simulated ROM

Reset_Handler:
	.global Reset_Handler	;@ The entry point on reset
		
	;@ Pointers to the variables
Start:	ldr r0, =prev		;@ prev is 128-bit
	ldr r1, =curr		;@ curr is 128-bit
	
	;@ Load a 128-bit 0 into variable prev and 1 into curr
	mov r2, #0		;@ Constant used for initializing the variables
	
	;@ *** prev ***
	
	str r2, [r0, #0] ;@ first word
	str r2, [r0, #4] ;@ second word
	str r2, [r0, #8] ;@ third word
	str r2, [r0, #12] ;@ fourth word
	
	;@ *** curr ***
	;@ initialize r1 to 0 for first three words, using r2 as reference register 
	str r2, [r1, #0] ;@ first word
	str r2, [r1, #4] ;@ second word
	str r2, [r1, #8] ;@ third word
		

	mov r2, #1		;@ Constant used for initializing LSW of curr
	str r2, [r1, #12]
	
	;@ What Fibonacci subscript is variable curr holding?
	mov r4, #1

loop:	cmp	r4, #200		;@ We want to calculate F200
	beq	done		;@ We are finished!
	
	bl 	add128		;@ Perform a 128-bit add

			;@ *** If our variable curr did not overflow… ***
	
	addCC r4, r4, #1 ;@ should be addCC r4, r4, #1
	bCC loop
	
;@	<??????????>		;@ *** Increment the subscript (in r4), and ***
;@	<??????????>	 	;@ ***     branch back to "loop" ***
				
overfl:	b 	overfl		;@ Oops, the add overflowed!  Fib number in prev.

done:	b 	done		;@ Program done! Loop forever. Fib number in curr.
	
;@ Subroutine to add 128-bit unsigned variables and move one of them. 
;@	curr at r1 moved to prev at r0 and sum put in curr.   
;@ 	Carry flag set if unsigned overflow did occur.
;@	Does not modify r0 or r1.
add128:	nop		;@ Do nothing (NO OPeration)
;@	<??????????>	;@ *** May need to do something here to help to return ***
	mov r5, lr 

;@ We clear the carry flag to begin with.
;@ Start with the least significant word (word 0 at offset 12).
;@ We add all words using a carry.
;@ We set the status flags for subsequent operations.
	
	adds 	r0, r0, #0	;@ Clear the carry flag

	mov 	r2, #12
	bl 	doPart
	
	mov 	r2, #8
	bl 	doPart
	
	mov 	r2, #4
	bl 	doPart
	
	mov 	r2, #0
	bl 	doPart
	
;@ *** Complete the 128-bit addition algorithm ***
	
;@ *** What issue do/might we have returning from subroutine? How can we fix it? --> branch-link have a memory of 1 step
;@	<??????????>		;@ *** Return from subroutine ***
	mov pc, r5

;@ Subroutine to load parts of operands, do a 32-bit add, 
;@ 	move curr part into prev part and store
;@ 	the result of the add in place of curr part.
;@	r0 points to the beginning of prev
;@	r1 points to the beginning of curr
;@	<??> is <what ???>
;@ 	Does not modify r0, r1, or <??>.

;@ *** Update this subroutine to take another argument so it can
;@     be reused for processing all four words ***
doPart:	ldr 	r3, [r0, r2]	;@ Load a value from prev
	ldr 	r12, [r1, r2]	;@ Load a value from curr	
	str	r12, [r0, r2]	;@    ... move into prev
	;@ 32-bit add
	adcs 	r3,  r3, r12	;@ Add words at r3 with carry, set status flags
	str 	r3,  [r1, r2]	;@ Store the result into curr
	mov	pc,  lr		;@ Return from subroutine

;@ *******************
	.data				;@ Store in simulated RAM			
;@ variables start at address 0x4000 0000

prev:	.space 16		;@ Previous Fibonacci value (128-bit) ***
curr:	.space 16		;@ Current Fibonacci value (128-bit) ***

	.end			;@ End of assembly in program file	
