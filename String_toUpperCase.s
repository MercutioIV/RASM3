//
// String_toUpperCase written by Dylan Werelius
//
// This function will return the ADDRESS of a dynamically
// allocated string of bytes. This address will hold a
// string that is all upper case letters
// All registers preserved except X0
//
// Parameters:
// X0 - Address of the string to convert to uppercase
//
// Reminder: X0 will hold an ADDRESS of a dynamically allocated string
//

.data

szUpperCase:	.quad	0	// Allocated string

.text
.global String_toUpperCase
String_toUpperCase:
	// Stores registers x19-x29 and link registe LR on stack (AAPCS)
	str	x19, [SP, #-16]!
	str	x20, [SP, #-16]!
	str	x21, [SP, #-16]!
	str	x22, [SP, #-16]!
	str	x23, [SP, #-16]!
	str	x24, [SP, #-16]!
	str	x25, [SP, #-16]!
	str	x26, [SP, #-16]!
	str	x27, [SP, #-16]!
	str	x28, [SP, #-16]!
	str	x29, [SP, #-16]!
	str	lr, [SP, #-16]!

	// dynamically allocate a string
	str	x0, [SP, #-16]!

	// Malloc
	mov	x0, #15
	bl 	malloc

	// Store newly allocated string in x20
	ldr	x20, =szUpperCase
	str	x0, [x20]

	// Pop
	ldr	x0, [SP], #16

	mov	x29, SP	// Sets the stack frame

	// move address of string into x19
	mov	x19, x0

	// Load address of szUpperCase into x20
	ldr	x20, =szUpperCase

loop:
	// Load character and increment pointer
	ldrb	w25, [x19], #1

	// If w25 > 'z' then go to cont
	cmp	w25, #'z'
	bgt	cont

	// If w25 < 'a' then go to cont
	cmp	w25, #'a'
	blt	cont

	// CONVERT THE LETTER
	sub	w25, w25, #('a' - 'A')

cont:	// end if

	// Store the character in a string
	strb	w25, [x20], #1

	// Check for if end of string
	cmp	w25, #0
	bne	loop

	// Print the string
	ldr	x0, =szUpperCase

end:
// Restore the registers
	ldr	lr, [SP], #16
	ldr	x29, [SP], #16
	ldr	x28, [SP], #16
	ldr	x27, [SP], #16
	ldr	x26, [SP], #16
	ldr	x25, [SP], #16
	ldr	x24, [SP], #16
	ldr	x23, [SP], #16
	ldr	x22, [SP], #16
	ldr	x21, [SP], #16
	ldr	x20, [SP], #16
	ldr	x19, [SP], #16

	ret


