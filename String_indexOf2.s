// This function will find the first occurence of a character found within a string.
// The function should then return the index integer value of the first character occurence AFTER index specified.
// Parameters:
// X0 - Address of string to search for character
// X1 - Address of the byte character to search within the string
// X2 - Starting index value as an integer
//
// Returns: X0 - Index of the first occurence that the character is located. All registers preserved except X0
.data

.text
.global String_indexOf2
String_indexOf2:
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

	MOV X19, X0      // Moves the address of the string to check into X19

	MOV X0, X19      // Moves address of string into X0
	BL String_length // Calls function to get string length. Value is returned at X0
	MOV X21, X0      // Moves the string length value into X21 (sentinel value)

	MOV X22, #0      // Initializes counter/index

search_Loop:
	MOV X20, X1
	LDRB W20, [X20]
	LDRB W23, [X19, X2]  // Loads char byte from string into X23

	CMP X20, X23         // Compares the string's byte with the key character
	B.EQ found           // If they are equal, then we skip to the found section

	SUB X21, X21, #1     // Subtracts one from the string's length
	ADD X22, X22, #1     // Adds one to the counter
	ADD X2, X2, #1       // Adds one to the offset/starting index

	CMP X21, #0          // Compares the string's length with 0
	B.EQ notFound        // If string has reached 0, then we skipped to the not found section
	B search_Loop        // Loops is rebranched otherwise

notFound:
	MOV X0, #-1         // Returns -1 if there is no occurrence
	B end	            // Skips to the end of the program

found:
	MOV X0, X22	    // Moves the index into X0
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
