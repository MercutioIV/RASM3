//
// String_toUpperCase written by Dylan Werelius
//
// This function will return the ADDRESS of a dynamically
// allocated string of bytes. This address will hold a
// string that is all lower case letters
// All registers preserved except X0
//
// Parameters:
// X0 - Address of the string to convert to lowercase
//
// Reminder: X0 will hold an ADDRESS of a dynamically allocated string
//

.data

szLowerCase:	.quad	0

.text
.global String_toLowerCase
String_toLowerCase:
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

	// Save x0 before malloc
	str	x0, [SP, #-16]!

	// Malloc
	mov 	x0, #15
	bl	malloc

	// Store the newly allocated string
	ldr	x20, =szLowerCase
	str	x0, [x20]

	// Pop
	ldr	x0, [SP], #16

	mov	x29, SP	// Sets the stack frame

	// Move the address of the string into x19
	mov	x19, x0

	// Load address of szUpperCase into x20
	ldr	x20, =szLowerCase

loop:
	// Load character and increment pointer
	ldrb	w25, [x19], #1

	// If w25 > 'Z' then go to cont
	cmp	w25, #'Z'
	bgt	cont

	// If w25 < 'A' then go to cont
	cmp	w25, #'A'
	blt	cont

	// CONVERT THE LETTER
	add	w25, w25, #('a' - 'A')

cont:	// end if

	// Store the character in a string
	strb	w25, [x20], #1

	// Check for if end of string
	cmp	w25, #0
	bne	loop

	// Print the string
	ldr	x0, =szLowerCase

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


