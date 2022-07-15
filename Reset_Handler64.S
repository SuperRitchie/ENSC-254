;@============================================================================
;@ Name         Reset_Handler.s
;@ Description  64-bit Fibonacci calculation
;@============================================================================

;@ Highly recommended in Edit > Configuration 
;@ Set "Auto Indent" to "None"
;@ Tabs set for 8 characters for ASM files


	.text		;@ "text" section for program. Stored in simulated ROM

Reset_Handler:
	.global Reset_Handler	;@ The entry point on reset
		
Start:		
	;@ Pointers to the variables
	ldr r0, =prev
	ldr r1, =curr
	
	;@ Load a 64-bit 0 into variable prev and 1 into curr
	mov r2, #0		;@ Constant used for initializing the variables
	str r2, [r0, #0]	;@ Set the value of prev
	str r2, [r0, #4]
	
	str r2, [r1, #0]	;@ Set the value of curr
	mov r2, #1		;@ Constant used for initializing LSW of curr
	str r2, [r1, #4]
	
	;@ What Fibonacci subscript is variable curr holding?
	mov r4, #1

loop:	cmp	r4, #90		;@ We want to calculate F90 
	
	bEQ done
;@	<??????????> done		;@ *** Branch to "done" if we are finished ***
	
	;@ Add the least-significant word (LSW) from each variable
	ldr 	r3, [r0, #4]	;@ Load the LSW of prev	
	ldr 	r12, [r1, #4]	;@ Load the LSW of curr
	str 	r12, [r0, #4]	;@ Move the LSW of curr into the LSW of prev

	;@ We add the two words without carry for the LSW.
	;@ We set the status flags for subsequent operation
	adds 	r3, r3, r12	;@ Add LSWs, set status flags

	str 	r3, [r1, #4]	;@ Store LSW of result into the LSW of curr

	;@ Add the most significant word (MSW) from each variable, with carry.
	ldr 	r3, [r0, #0]	;@ Load the MSW of prev	
	ldr 	r12, [r1, #0]	;@ Load the MSW of curr
	str 	r12, [r0, #0]	;@ Move the MSW of curr into the MSW of prev

	;@ We add the MSWs words using a carry.
	;@ We set the status flags for detecting overflow
	adcs 	r3, r3, r12	;@ Add MSWs using carry bit, set status flags
	;@ ??? did it carry out (unsigned overflow)? 
	
	str 	r3, [r1, #0]	;@ Store MSW of result into the MSW of curr
	
	add r4, r4, #1
	b loop
	
;@	<??????????> first operand, destination, second operand		;@ *** Increment the subscript (r4) ***
;@	<??????????>		;@ *** Branch to "loop" ***

done:	b 	done		;@ Program done! Loop forever.

	
;@ for variables
;@ variables start at address 0x4000 0000
	.data			;@ Store in simulated RAM
				
prev:	.space 	8		;@ Previous Fibonacci value (64-bit)
curr:	.space 	8		;@ Current Fibonacci value (64-bit)

	.end			;@ End of assembly-language in program file	
