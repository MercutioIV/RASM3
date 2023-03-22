// This function will return a character specified at an index which is passed as a parameter.
//
// Parameters:
// X0 - Address of the string to retrieve the character byte
// X1 - Index as an integer to retrieve char byte
//
// Returns: X0 has char byte and is printed on console. All registers preserved except X0
.data
szIndexOutOfBonds: .asciz "The index is out of bonds.\n\n"
chChar: .byte 0

.text
.global String_charAt
String_charAt:
	// Stores registers X19-X29 and link register LR on stack (AAPCS)
	STR X19, [SP, #-16]!
	STR X20, [SP, #-16]!
	STR X21, [SP, #-16]!
	STR X22, [SP, #-16]!
	STR X23, [SP, #-16]!
	STR X24, [SP, #-16]!
	STR X25, [SP, #-16]!
	STR X26, [SP, #-16]!
	STR X27, [SP, #-16]!
	STR X28, [SP, #-16]!
	STR X29, [SP, #-16]!
	STR LR, [SP, #-16]!

	MOV X29, SP // Sets stack frame

	MOV X19, X0 // Moves the address of the string into X19
	MOV X20, X1 // Moves the index value into X20

	MOV X0, X19 	    // Moves the address of the string into X0
	BL String_length    // Calls function to get the string's length and value is returned into X0
	MOV X21, X0         // Moves the string's length into X21

	CMP X20, X21        // Compares the index value with string's length
	B.GE Out_Of_Bonds   // If the index is greater or equal than the string's length, then it is out of bounds

	LDRB W0, [X19, X20] // Loads the char byte from string of index into X0
	B end		    // Branches to the end of the function

Out_Of_Bonds:
	LDR X0, =szIndexOutOfBonds // Loads address of the exception message
	BL putstring		   // Prints exception message

end:
// Restores preserved registers
	LDR LR, [SP], #16
	LDR X29, [SP], #16
	LDR X28, [SP], #16
	LDR X27, [SP], #16
	LDR X26, [SP], #16
	LDR X25, [SP], #16
	LDR X24, [SP], #16
	LDR X23, [SP], #16
	LDR X22, [SP], #16
	LDR X21, [SP], #16
	LDR X20, [SP], #16
	LDR X19, [SP], #16

	RET
